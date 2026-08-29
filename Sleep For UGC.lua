-- дата: 28 августа 2026 года
if game:GetService("CoreGui"):FindFirstChild("ToraScript") then
	game:GetService("CoreGui").ToraScript:Destroy()
end
local players = game:GetService("Players")
local localplayer = players.LocalPlayer
local character = localplayer.Character or localplayer.CharacterAdded:Wait()
local hrp = character:WaitForChild("HumanoidRootPart")
local TweenService = game:GetService("TweenService")
local speed = 50
local path = workspace
local virtualUser = game:GetService("VirtualUser")
local StarterGui = game:GetService("StarterGui")
local playerGui = localplayer:WaitForChild("PlayerGui", 15)

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/FunnyBefange/Library/refs/heads/main/library.lua", true))()

local Window = Library:CreateWindow("Sleep for UGC")
getgenv().farm = false
Window:AddToggle({
 text = "Auto collect coins",
 flag = "toggle",
 callback = function(state)
   getgenv().farm = state
   if state then
   	task.spawn(function()
   		while getgenv().farm do
   			for _, coin in pairs(path:GetChildren()) do
   				if not getgenv().farm then break end
   				if coin:IsA("Model") and string.find(coin.Name, "Coin") then
   					local coinCFrame = coin:GetPivot()
                    local distance = (hrp.Position - coinCFrame.Position).Magnitude
                    local duration = distance / speed
                    if duration < 0.01 then
                    	duration = 0.01
                    end
                    local tween = TweenService:Create(
                        hrp,
                        TweenInfo.new(duration, Enum.EasingStyle.Linear),
                        {CFrame = coinCFrame}
                        )
                        tween:Play()
                        tween.Completed:Wait()
                        end
                        end
                        task.wait(0.5)
                        end
                        end)
                        end
 end
})

Window:AddSlider({
 text = "Change speed",
 min = 10,
 max = 170,
 dual = true,
 type = "slider",
 callback = function(v)
  speed = v
end
})

Window:AddButton({
 text = "Check Coins",
 flag = "button",
 callback = function()
 local coins = playerGui:WaitForChild("CoinsGUI"):WaitForChild("CurrencyFrame"):WaitForChild("CoinsFrame"):WaitForChild("CoinsHandler")
 StarterGui:SetCore("SendNotification", {
        Title = "Check Coins",
        Text = tostring(coins.Text),
        Duration = 3
    })
end
})

Window:AddButton({
 text = "Anti AFK",
 flag = "button",
 callback = function()
 localplayer.Idled:Connect(function()
    virtualUser:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
    task.wait()
    virtualUser:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
end)
end
})

Window:AddLabel({
 text = "Made by Funny games",
 type = "label"
})

Library:Init()
