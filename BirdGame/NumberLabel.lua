local function SetOffset(Label: ImageLabel, Number: number)
    Label.ImageRectOffset = Vector2.new(16 * math.clamp(Number or 0, 0, 9), 0)
end

local NumberLabel = {}
NumberLabel.__index = NumberLabel

export type NumberLabel = typeof(setmetatable({} :: {
   Frame: Frame,
   Digits: {ImageLabel},
}, NumberLabel))

function NumberLabel.new(Digits: number): NumberLabel
    local self = setmetatable({
        Frame = Instance.new("Frame"),
        Digits = {}
    }, NumberLabel)

    local Frame = self.Frame
    Frame.BackgroundTransparency = 1
    local Layout = Instance.new("UIListLayout")
    Layout.FillDirection = Enum.FillDirection.Horizontal
    Layout.SortOrder = Enum.SortOrder.LayoutOrder
    Layout.HorizontalAlignment = Enum.HorizontalAlignment.Left
    Layout.Padding = UDim.new(0.05, 0)
    Layout.VerticalAlignment = Enum.VerticalAlignment.Center
    Layout.HorizontalFlex = Enum.UIFlexAlignment.Fill
    Layout.Parent = Frame

    for i = 1, Digits or 3 do
        local Digit = Instance.new("ImageLabel")
        Digit.Image = "rbxassetid://99344985316108"
        Digit.ImageRectSize = Vector2.new(16, 16)
        Digit.ResampleMode = Enum.ResamplerMode.Pixelated
        Digit.LayoutOrder = i
        Digit.ScaleType = Enum.ScaleType.Fit
        Digit.Size = UDim2.fromScale(1 / 3, 1)
        Digit.BackgroundTransparency = 1
        Digit.Parent = Frame
        table.insert(self.Digits, Digit)
    end

    return self
end

function NumberLabel.SetValue(self: NumberLabel, val: number)
   local str = tostring(val):split("")
   while #str < #self.Digits do
      table.insert(str, 1, "0")
   end
   for i, Label in self.Digits do
      local Digit = tonumber(str[Label.LayoutOrder] or 0)
      SetOffset(Label, Digit)
   end
end

function NumberLabel.Destroy(self: NumberLabel)
    self.Frame:Destroy()
end

return NumberLabel
