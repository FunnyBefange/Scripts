local Players = game:GetService("Players")
local localplayer = Players.LocalPlayer
local character = localplayer.Character or localplayer.CharacterAdded:Wait()
local hrp = character:WaitForChild("HumanoidRootPart")
local EasyObby = workspace["Easy Entry"].Entry.TimerGui.Time
local MediumObby = workspace["Medium Entry"].Entry.TimerGui.Time
local HardObby = workspace["Hard Entry"].Entry.TimerGui.Time
local ImpossibleObby = workspace["Impossible Entry"].Entry.TimerGui.Time
local virtualUser = game:GetService("VirtualUser")

pcall(function()
if EasyObby.Text == "" then
    firetouchinterest(hrp, workspace.EasyWin, 0)
    task.wait(0.1)
    firetouchinterest(hrp, workspace.EasyWin, 1)
end
end)

pcall(function()
if MediumObby.Text == "" then
    firetouchinterest(hrp, workspace.MediumWin, 0)
    task.wait(0.1)
    firetouchinterest(hrp, workspace.MediumWin, 1)
end
end)

pcall(function()
if HardObby.Text == "" then
    firetouchinterest(hrp, workspace.HardWin, 0)
    task.wait(0.1)
    firetouchinterest(hrp, workspace.HardWin, 1)
end
end)

pcall(function()
if ImpossibleObby.Text == "" then
    firetouchinterest(hrp, workspace.ImpossibleWin, 0)
    task.wait(0.1)
    firetouchinterest(hrp, workspace.ImpossibleWin, 1)
end
end)

EasyObby:GetPropertyChangedSignal("Text"):Connect(function()
    pcall(function()
    if EasyObby.Text == "" then
        firetouchinterest(hrp, workspace.EasyWin, 0)
        task.wait(0.1)
        firetouchinterest(hrp, workspace.EasyWin, 1)
    end
    end)
end)

MediumObby:GetPropertyChangedSignal("Text"):Connect(function()
    pcall(function()
    if MediumObby.Text == "" then
        firetouchinterest(hrp, workspace.MediumWin, 0)
        task.wait(0.1)
        firetouchinterest(hrp, workspace.MediumWin, 1)
    end
    end)
end)

HardObby:GetPropertyChangedSignal("Text"):Connect(function()
    pcall(function()
    if HardObby.Text == "" then
        firetouchinterest(hrp, workspace.HardWin, 0)
        task.wait(0.1)
        firetouchinterest(hrp, workspace.HardWin, 1)
    end
    end)
end)

ImpossibleObby:GetPropertyChangedSignal("Text"):Connect(function()
    pcall(function()
    if ImpossibleObby.Text == "" then
        firetouchinterest(hrp, workspace.ImpossibleWin, 0)
        task.wait(0.1)
        firetouchinterest(hrp, workspace.ImpossibleWin, 1)
    end
    end)
end)

localplayer.Idled:Connect(function()
    virtualUser:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
    task.wait()
    virtualUser:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
end)
