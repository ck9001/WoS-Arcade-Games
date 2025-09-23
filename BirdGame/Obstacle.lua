local function GetRectBounds(GUI)
	local Position = GUI.AbsolutePosition
	local Size = GUI.AbsoluteSize

	local Left = Position.X
	local Right = Position.X + Size.X
	local Top = Position.Y
	local Bottom = Position.Y + Size.Y

	return Left, Right, Top, Bottom
end

local function AABBcoll(A, B)
	local AL, AR, AT, AB = GetRectBounds(A)
	local Bl, BR, BT, BB = GetRectBounds(B)

	return AR > Bl and BR > AL and AB > BT and BB > AT
end

local Obstacle = {}
Obstacle.Pool = {}
Obstacle.__index = Obstacle

type Obstacle = typeof(setmetatable({} :: {
   Top: ImageLabel,
   Bottom: ImageLabel,
   Cleared: boolean,
   Destroyed: boolean
}, Obstacle))

function Obstacle.new(Parent): Obstacle
   local self = setmetatable({}, Obstacle)
   local SectionPosition = math.random() * 0.4 + 0.3

   self.Top = Instance.new("ImageLabel")
	self.Bottom = Instance.new("ImageLabel")

	self.Top.Image = "rbxassetid://102293851027889"
	self.Bottom.Image = "rbxassetid://102452434254295"
	self.Top.AnchorPoint = Vector2.new(0, 1)

	self.Top.Position = UDim2.fromScale(1, SectionPosition - 0.27)
	self.Bottom.Position = UDim2.fromScale(1, SectionPosition + 0.27)

   self.Destroyed = false
   self.Cleared = false

   for _, Part in {self.Bottom, self.Top} do
      Part.Size = UDim2.fromScale(0.214, 1.231)
      Part.BackgroundTransparency = 1
      Part.ResampleMode = Enum.ResamplerMode.Pixelated
      Part.ZIndex = Parent.ZIndex + 1
      Part.Parent = Parent
   end

   table.insert(Obstacle.Pool, self)
   return self
end

function Obstacle.Update(self: Obstacle, dt, Speed)
   self.Top.Position -= UDim2.fromScale(Speed * dt, 0)
   self.Bottom.Position -= UDim2.fromScale(Speed * dt, 0)
   if self.Top.Position.X.Scale < -0.5 then
      self:Destroy()
   end
end

function Obstacle.IsColliding(self: Obstacle, Other: Frame): boolean
   return AABBcoll(self.Top, Other) or AABBcoll(self.Bottom, Other)
end

function Obstacle.CheckCleared(self: Obstacle, Other)
   if not self.Cleared then
      self.Cleared = Other.AbsolutePosition.X > (self.Top.AbsolutePosition.X + self.Top.AbsoluteSize.X)
   end
   return self.Cleared
end

function Obstacle.Destroy(self: Obstacle)
   self.Destroyed = true
   local i = table.find(Obstacle.Pool, self)
   table.remove(Obstacle.Pool, i)
   self.Top:Destroy()
   self.Bottom:Destroy()
end

function Obstacle.DestroyPool()
   for _, v in Obstacle.Pool do
      v:Destroy()
   end
end

return Obstacle