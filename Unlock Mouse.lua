local StarterGui = cloneref(game:GetService("StarterGui"))
local UIS = cloneref(game:GetService("UserInputService"))
local RunService = cloneref(game:GetService("RunService"))
local connect
local mouse = false

local function UnlockMouse()
    connect = RunService.RenderStepped:Connect(function()
        if UIS.MouseBehavior == Enum.MouseBehavior.LockCenter then
            UIS.MouseBehavior = Enum.MouseBehavior.Default
        end
        if UIS.MouseIconEnabled == false then
            UIS.MouseIconEnabled = true
        end
    end)
end

local function LockMouse()
    if connect then
        connect:Disconnect()
        connect = nil
        UIS.MouseBehavior = Enum.MouseBehavior.LockCenter
    end
end

UIS.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end 

    if input.KeyCode == Enum.KeyCode.RightControl then
        mouse = not mouse
        
        if mouse then
            UnlockMouse()
        else
            LockMouse()
        end
        end
end)

StarterGui:SetCore("SendNotification", {
    Text = " курсор и обратно",
    Title = "Нажми на правый Ctrl, чтобы разблокировать",
    Duration = 10,
})
