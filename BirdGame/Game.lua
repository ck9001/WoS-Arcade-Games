local Defaults = require("./Defaults")
local Bird = require("./Bird")
local Obstacle = require("./Obstacle")
local Gui = require("./Gui")

local Screen = assert(Network:GetPart("Screen"), "no connected screen")
local Port = assert(Network:GetPort(1), "no connected port with id of 1")

Screen:ClearElements()
local Canvas = Screen:GetCanvas()

local GameGui = Gui.new(Canvas)

local IsJumping = false
Port.Triggered:Connect(function()
   IsJumping = true
end)

while true do -- Game Loop
   GameGui:SetMenuVisibility(true)
   if IsJumping then
      IsJumping = false
      GameGui:SetMenuVisibility(false)
      local GameBird = Bird.new(GameGui.Menu.Background)
      GameBird.Sprite.Visible = true
      Obstacle.new(GameGui.Menu.Background)

      local CurrentScore = 0
      GameGui:SetScore(CurrentScore)
      local ObstacleSpawnDB = 0
      local ct = 0

      local Running = true
      while Running do
         local dt = task.wait()
         ct += dt
         ObstacleSpawnDB += dt

         GameBird:Update(dt, IsJumping)

         if ObstacleSpawnDB > Defaults.ObstacleSpawnRate then
            ObstacleSpawnDB = 0
            Obstacle.new(GameGui.Menu.Background)
         end

         for _, v in Obstacle.Pool do
            v:Update(dt, Defaults.ScrollSpeed)
            if v:IsColliding(GameBird.Sprite) then
               Running = false
               break
            end
            if not v.Cleared then
               local Cleared = v:CheckCleared(GameBird.Sprite)
               if Cleared then 
                  CurrentScore += 1 
                  GameGui:SetScore(CurrentScore)
               end
            end
         end

         if IsJumping then
            IsJumping = false
         end
      end
      -- Cleanup
      GameBird:Destroy()
      Obstacle.DestroyPool()
   end
   task.wait(0.1)
end