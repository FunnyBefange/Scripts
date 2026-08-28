-- дата: 28 августа 2026 года
local players = game:GetService("Players")
local localplayer = players.LocalPlayer
local character = localplayer.Character or localplayer.CharacterAdded:Wait()
local hrp = character:WaitForChild("HumanoidRootPart")
local TweenService = game:GetService("TweenService")
local speed = 50
local path = workspace

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
   				if coin:IsA("Model") and coin.Name == "CommonCoin" then
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

Window:AddLabel({
 text = "Made by Funny games",
 type = "label"
})

Library:Init()
