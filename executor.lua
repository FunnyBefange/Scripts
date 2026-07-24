-- made by AI Gemini
local player = game:GetService("Players").LocalPlayer  
local gui = Instance.new("ScreenGui")   
gui.Name = "Executor"   
gui.IgnoreGuiInset = true   
gui.ResetOnSpawn = false   
gui.Parent = game:GetService("CoreGui")

local Frame = Instance.new("Frame")  
Frame.Size = UDim2.fromOffset(500, 275)  
Frame.Position = UDim2.fromScale(0.5, 0.5)  
Frame.AnchorPoint = Vector2.new(0.5, 0.5)  
Frame.Active = true  
Frame.BorderSizePixel = 0  
Frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)  
Frame.ClipsDescendants = true  
Frame.Parent = gui

local TopBar = Instance.new("Frame")
TopBar.Parent = Frame
TopBar.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
TopBar.BorderSizePixel = 0
TopBar.Size = UDim2.new(1, 0, 0, 40)

local TextLabel = Instance.new("TextLabel")
TextLabel.Parent = TopBar
TextLabel.Size = UDim2.new(1, -50, 1, 0)
TextLabel.Font = Enum.Font.Code
TextLabel.Text = "Executor"
TextLabel.TextColor3 = Color3.fromRGB(248, 248, 255)
TextLabel.TextSize = 16
TextLabel.BackgroundTransparency = 1
TextLabel.TextXAlignment = Enum.TextXAlignment.Left

local UIPaddingText = Instance.new("UIPadding")
UIPaddingText.Parent = TextLabel
UIPaddingText.PaddingLeft = UDim.new(0, 10)

local ToggleButton = Instance.new("TextButton")
ToggleButton.Parent = TopBar
ToggleButton.Size = UDim2.new(0, 30, 0, 30)
ToggleButton.Position = UDim2.new(1, -35, 0, 5)
ToggleButton.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
ToggleButton.BorderSizePixel = 0
ToggleButton.Font = Enum.Font.SourceSansBold
ToggleButton.Text = "_"
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.TextSize = 18

local UICornerToggle = Instance.new("UICorner")
UICornerToggle.CornerRadius = UDim.new(0, 4)
UICornerToggle.Parent = ToggleButton

local EditFrame = Instance.new("Frame")
EditFrame.Parent = Frame
EditFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
EditFrame.BorderSizePixel = 0
EditFrame.Position = UDim2.fromOffset(0, 40) 
EditFrame.Size = UDim2.new(1, 0, 0, 195) 
EditFrame.ClipsDescendants = true

local ScrollingFrame = Instance.new("ScrollingFrame")
ScrollingFrame.Parent = EditFrame
ScrollingFrame.Size = UDim2.new(1, 0, 1, 0)
ScrollingFrame.BackgroundTransparency = 1
ScrollingFrame.BorderSizePixel = 0
ScrollingFrame.ScrollBarThickness = 8
ScrollingFrame.ScrollBarImageColor3 = Color3.fromRGB(255, 255, 255)
ScrollingFrame.ScrollingDirection = Enum.ScrollingDirection.Y
ScrollingFrame.ClipsDescendants = true
ScrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.None

local TextBox = Instance.new("TextBox")
TextBox.Parent = ScrollingFrame
TextBox.Size = UDim2.new(1, -10, 0, 195) 
TextBox.BackgroundTransparency = 1 
TextBox.Text = "-- Р’РІРµРґРёС‚Рµ РІР°С€ СЃРєСЂРёРїС‚ Р·РґРµСЃСЊ..."
TextBox.ClearTextOnFocus = false 
TextBox.MultiLine = true 
TextBox.Font = Enum.Font.Code 
TextBox.TextSize = 14
TextBox.TextColor3 = Color3.fromRGB(240, 240, 240)
TextBox.TextXAlignment = Enum.TextXAlignment.Left 
TextBox.TextYAlignment = Enum.TextYAlignment.Top 

local UIPadding = Instance.new("UIPadding")
UIPadding.Parent = TextBox
UIPadding.PaddingLeft = UDim.new(0, 10)
UIPadding.PaddingTop = UDim.new(0, 10)


local ScrollShield = Instance.new("TextButton")
ScrollShield.Parent = ScrollingFrame
ScrollShield.Size = TextBox.Size
ScrollShield.BackgroundTransparency = 1
ScrollShield.Text = ""
ScrollShield.ZIndex = TextBox.ZIndex + 1

local BottomBar = Instance.new("Frame")
BottomBar.Parent = Frame
BottomBar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
BottomBar.BorderSizePixel = 0
BottomBar.Position = UDim2.fromOffset(0, 235) 
BottomBar.Size = UDim2.new(1, 0, 0, 40)

local function createButton(text, xPosition, width)
    local button = Instance.new("TextButton")
    button.Parent = BottomBar
    button.Size = UDim2.new(width, -6, 1, -10) 
    button.Position = UDim2.new(xPosition, 3, 0, 5)
    button.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
    button.BorderSizePixel = 0
    button.Font = Enum.Font.SourceSansBold
    button.Text = text
    button.TextColor3 = Color3.fromRGB(255, 255, 255) 
    button.TextSize = 14
    
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 4)
    UICorner.Parent = button
    
    return button
end

local PasteButton = createButton("Paste", 0, 0.333)
local ClearButton = createButton("Clear", 0.333, 0.333)
local ExecuteButton = createButton("Execute", 0.666, 0.334)

PasteButton.MouseButton1Click:Connect(function()
    TextBox:CaptureFocus() 
    TextBox.SelectionStart = 1 
    TextBox.CursorPosition = #TextBox.Text + 1 
end)

ClearButton.MouseButton1Click:Connect(function()
    TextBox.Text = ""
end)

ExecuteButton.MouseButton1Click:Connect(function()
    pcall(function()
        local runCode = loadstring(TextBox.Text) 
        if runCode then runCode() end
    end)
end)

ScrollShield.MouseButton1Click:Connect(function()
    ScrollShield.Visible = false
    TextBox:CaptureFocus()
end)

-- РљР°Рє С‚РѕР»СЊРєРѕ РёРіСЂРѕРє СѓР±РёСЂР°РµС‚ РєР»Р°РІРёР°С‚СѓСЂСѓ РёР»Рё РЅР°Р¶РёРјР°РµС‚ "Р“РѕС‚РѕРІРѕ", С‰РёС‚ РІРѕР·РІСЂР°С‰Р°РµС‚СЃСЏ РЅР° РјРµСЃС‚Рѕ
TextBox.FocusLost:Connect(function()
    ScrollShield.Visible = true
end)


local isMinimized = false
ToggleButton.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    if isMinimized then
        Frame.Size = UDim2.fromOffset(500, 40) 
        ToggleButton.Text = "+"
    else
        Frame.Size = UDim2.fromOffset(500, 275) 
        ToggleButton.Text = "_"
    end
end)

local function updateSize()
    local textHeight = TextBox.TextBounds.Y + 20 
    local finalHeight = math.max(textHeight, 195)
    
    TextBox.Size = UDim2.new(1, -10, 0, finalHeight)
    ScrollShield.Size = UDim2.new(1, -10, 0, finalHeight)
    ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, finalHeight)
end

TextBox:GetPropertyChangedSignal("Text"):Connect(updateSize)
updateSize()

local dragToggle, dragStart, startPos
local UserInputService = game:GetService("UserInputService")

TopBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragToggle = true
        dragStart = input.Position
        startPos = Frame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragToggle = false
            end
        end)
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) and dragToggle then
        local delta = input.Position - dragStart
        Frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)