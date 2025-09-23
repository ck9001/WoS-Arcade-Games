local Defaults = require("./Defaults")

local Bird = {}
Bird.__index = Bird

type Bird = typeof(setmetatable({} :: {
   Sprite: ImageLabel,
   Velocity: number,
   Position: number,
   _AnimCycle: number,
   _AnimDB: number,
   _ct: number
}, Bird))

function Bird.new(Parent: Frame?): Bird
   local self = setmetatable({}, Bird)
   self.Sprite = Instance.new("ImageLabel")
   self.Sprite.BackgroundTransparency = 1
	self.Sprite.Image = "rbxassetid://115681505979622"
	self.Sprite.ImageRectSize = Vector2.new(17, 12)
	self.Sprite.Size = UDim2.fromScale(Defaults.Bird.Size, Defaults.Bird.Size / Defaults.Bird.AspectRatio)
	self.Sprite.ResampleMode = Enum.ResamplerMode.Pixelated
	self.Sprite.ZIndex = 1
   self.Sprite.Visible = false
	self.Sprite.Parent = Parent

   self.Velocity = 0
   self.Position = Defaults.Bird.StartPos
   self._AnimCycle = 1
   self._AnimDB = 0
   self._ct = 0

   return self
end

function Bird.Update(self: Bird, dt: number, IsJumping: boolean)
   self._ct += dt
   -- PHYSICS
   if IsJumping then -- Do jump physics
      self.Velocity = -Defaults.Bird.JumpPower
   else
      self.Velocity += Defaults.Bird.Gravity * dt
   end

   self:SetPosition(self.Position + self.Velocity) -- Update position

   -- ANIMATION
   self.Sprite.Rotation = self.Velocity * 1500 -- Make the bird tilt up or down depencing on the velocity

   if self.Velocity < 0 then -- Do fly animations
      if self._ct - self._AnimDB > Defaults.Bird.AnimCycleDelay then
         self._AnimDB = self._ct
         self:SetAnimState(self._AnimCycle)
         self._AnimCycle = self._AnimCycle % 3 + 1
      end
   else
      self:SetAnimState(2)
      self._AnimCycle = 2
   end
end

function Bird.SetMenuVisibility(self: Bird, Visible: boolean?)
   self.Sprite.Visible = Visible or false
end

function Bird.SetPosition(self: Bird, Position: number)
   local Min, Max = 0, 1 - self.Sprite.Size.Y.Scale
   local NewPosition = math.clamp(Position, Min, Max)
   if NewPosition == Min or NewPosition == Max then -- Prevents the bird from gaining velocity when on the ceiling or the floor
      self.Velocity = 0
   end
   self.Position = NewPosition
   self.Sprite.Position = UDim2.fromScale(Defaults.Bird.XPos, NewPosition)
end

function Bird.SetAnimState(self: Bird, State: number)
   self.Sprite.ImageRectOffset = Defaults.Bird.AnimOffsets[State] or Vector2.new(0, 0)
end

function Bird.Destroy(self: Bird)
   self.Sprite:Destroy()
end

return Bird