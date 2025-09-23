local NumberLabel = require("./NumberLabel")

local Gui = {}
Gui.__index = Gui

type Gui = typeof(setmetatable({} :: {
   Canvas: Frame?,
   Menu: {
      Container: Frame,
      Background: ImageLabel,
      Logo: ImageLabel,
      PlayButton: ImageLabel,
      ScoreLabel: NumberLabel.NumberLabel
   }
}, Gui))

function Gui.new(Canvas): Gui
   local self = setmetatable({
      Canvas = Canvas,
      Menu = {
         Container = Instance.new("Frame"),
         Background = Instance.new("ImageLabel"),
         Logo = Instance.new("ImageLabel"),
         PlayButton = Instance.new("ImageLabel"),
         ScoreLabel = NumberLabel.new(3)
      }
   }, Gui)

   local Menu = self.Menu

   local Container = Menu.Container
   Container.Size = UDim2.fromScale(1, 1)
   Container.BackgroundTransparency = 1
   Container.Visible = false
   Container.Parent = Canvas

   local Logo = Menu.Logo
   Logo.AnchorPoint = Vector2.new(0.5, 0)
   Logo.ResampleMode = Enum.ResamplerMode.Pixelated
   Logo.BackgroundTransparency = 1
   Logo.Image = "rbxassetid://135353986238221"
   Logo.Size = UDim2.fromScale(0.66, 0.178)
   Logo.Position = UDim2.fromScale(0.5, 0.264)
   Logo.ZIndex = 1
   Logo.Parent = Container

   local PlayButton = Menu.PlayButton
   PlayButton.AnchorPoint = Vector2.new(0.5, 0)
   PlayButton.ResampleMode = Enum.ResamplerMode.Pixelated
   PlayButton.BackgroundTransparency = 1
   PlayButton.Image = "rbxassetid://92637228175954"
   PlayButton.Size = UDim2.fromScale(0.449, 0.251)
   PlayButton.Position = UDim2.fromScale(0.5, 0.473)
   PlayButton.ZIndex = 1
   PlayButton.Parent = Container

   local Background = Menu.Background
   Background.ResampleMode = Enum.ResamplerMode.Pixelated
   Background.Image = "rbxassetid://79739641355792"
   Background.Size = UDim2.fromScale(1, 1)
   Background.ZIndex = 0
   Background.Parent = Canvas

   local ScoreLabel = Menu.ScoreLabel
   local Frame = ScoreLabel.Frame
   Frame.AnchorPoint = Vector2.new(0.5, 0)
   Frame.Size = UDim2.fromScale(0.3, 0.1)
   Frame.Position = UDim2.fromScale(0.5, 0)
   Frame.ZIndex = 2
   Frame.Parent = Background

   self:SetScore(0)

   return self
end

function Gui.SetScore(self: Gui, Score: number)
   self.Menu.ScoreLabel:SetValue(Score)
end

function Gui.SetMenuVisibility(self: Gui, Visible: boolean?)
   self.Menu.Container.Visible = Visible or false
end

return Gui
