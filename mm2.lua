local Players = game:GetService("Players")
local LP = Players.LocalPlayer
local chr = LP.Character or LP.CharacterAdded:Wait()
local hum = chr:WaitForChild("Humanoid")
local hrp = chr:WaitForChild("HumanoidRootPart")
LP.CharacterAdded:Connect(function(char)
    chr = char
    hum = chr:WaitForChild("Humanoid")
    hrp = chr:WaitForChild("HumanoidRootPart")
end)

local TweenService = game:GetService("TweenService")
local Time = workspace:WaitForChild("RoundTimerPart", 15)
local bag
getgenv().auto = false
getgenv().reset = false
local map
local speed = 20
local tween = nil
local bagCount = 0
local bagCapacity = 50
local bagFull = false
local resetRequested = false
local GC = getconnections or get_signal_cons
local StarterGui = game:GetService("StarterGui")

getgenv().AntiFling = false
local flingPartsMemory = {}
local safeFrameMemory = nil
local currentHeartbeatConnection = nil

local function RestorePlayersCollision()
    for part, originalValue in pairs(flingPartsMemory) do
        if part and part.Parent then
            pcall(function() part.CanCollide = originalValue end)
        end
    end
    table.clear(flingPartsMemory)
    safeFrameMemory = nil
end

local function ProcessAntiFling()
    if not getgenv().AntiFling then return end
    local currentChr = LP.Character
    local currentHum = currentChr and currentChr:FindFirstChildOfClass("Humanoid")
    local currentHrp = currentChr and currentChr:FindFirstChild("HumanoidRootPart")
    
    local seenParts = {}
    for _, otherPlayer in ipairs(Players:GetPlayers()) do
        if otherPlayer ~= LP and otherPlayer.Character then
            for _, part in ipairs(otherPlayer.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    seenParts[part] = true
                    if flingPartsMemory[part] == nil then 
                        flingPartsMemory[part] = part.CanCollide 
                    end
                    if part.CanCollide then 
                        part.CanCollide = false 
                    end
                end
            end
        end
    end
    
    for part, originalValue in pairs(flingPartsMemory) do
        if not seenParts[part] then
            if part and part.Parent then
                pcall(function() part.CanCollide = originalValue end)
            end
            flingPartsMemory[part] = nil
        end
    end
    
    if not currentHrp or not currentHum or currentHum.Health <= 0 or currentHrp.Anchored then 
        safeFrameMemory = nil 
        return 
    end
    
    local velocity = currentHrp.AssemblyLinearVelocity or Vector3.zero
    local spin = (currentHrp.AssemblyAngularVelocity or Vector3.zero).Magnitude
    local speedMagnitude = velocity.Magnitude
    local horizontalSpeed = Vector3.new(velocity.X, 0, velocity.Z).Magnitude
    
    if speedMagnitude ~= speedMagnitude or spin ~= spin or speedMagnitude == math.huge or spin == math.huge
        or horizontalSpeed > 180 or velocity.Y > 180 or spin > 100 then
        
        for _, part in ipairs(currentChr:GetDescendants()) do
            if part:IsA("BasePart") then
                part.AssemblyLinearVelocity = Vector3.zero
                part.AssemblyAngularVelocity = Vector3.zero
            end
        end
        if safeFrameMemory and safeFrameMemory.Character == currentChr then 
            currentHrp.CFrame = safeFrameMemory.Frame 
        end
    elseif speedMagnitude <= 80 and spin <= 50 then
        safeFrameMemory = {
            Character = currentChr, 
            Frame = currentHrp.CFrame
        }
    end
end

-- workspace.MilBase.CoinContainer:GetChildren()[2]

workspace.DescendantAdded:Connect(function(m)
    if m:IsA("Model") and m.Name == "CoinContainer" then
        map = m
        bag = LP:WaitForChild("PlayerGui"):WaitForChild("MainGUI"):WaitForChild("Game"):WaitForChild("CoinBags"):WaitForChild("Container"):WaitForChild("Candy"):WaitForChild("CurrencyFrame"):WaitForChild("Icon"):WaitForChild("Coins")
    end
end)


local function GetMap()
    for _, coinmap in pairs(workspace:GetDescendants()) do
        if coinmap:IsA("Model") and coinmap.Name == "CoinContainer" then
            bag = LP:WaitForChild("PlayerGui"):WaitForChild("MainGUI"):WaitForChild("Game"):WaitForChild("CoinBags"):WaitForChild("Container"):WaitForChild("Candy"):WaitForChild("CurrencyFrame"):WaitForChild("Icon"):WaitForChild("Coins")
            return coinmap
        end
    end
end

LP:WaitForChild("PlayerGui").ChildAdded:Connect(function(gui)
    if gui:IsA("Frame") and gui.Name == "MainGui" then
        bag = gui:WaitForChild("Game"):WaitForChild("CoinBags"):WaitForChild("Container"):WaitForChild("Candy"):WaitForChild("CurrencyFrame"):WaitForChild("Icon"):WaitForChild("Coins")
    end
end)

task.spawn(function()
    while task.wait(1) do
        if not map then
            map = GetMap()
        end
    end
end)
local tween = nil
local gameplay = game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Gameplay")
local coinCollectedRemote = gameplay:FindFirstChild("CoinCollected")

if coinCollectedRemote and coinCollectedRemote:IsA("RemoteEvent") then
    coinCollectedRemote.OnClientEvent:Connect(function(id, count, capacity)
        if id ~= "Candy" then return end
        bagCount = count
        if typeof(capacity) == "number" and capacity > 0 then 
            bagCapacity = capacity 
        end
        bagFull = bagCount >= bagCapacity
    end)
end

local coinsStartedRemote = gameplay:FindFirstChild("CoinsStarted")
if coinsStartedRemote and coinsStartedRemote:IsA("RemoteEvent") then
    coinsStartedRemote.OnClientEvent:Connect(function()
        bagCount = 0
        bagFull = false
        resetRequested = false
    end)
end


local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/FunnyBefange/Library/refs/heads/main/library.lua", true))()

local Window = Library:CreateWindow("Murder Mystery 2")

Window:AddToggle({
text = "Авто Фарм",
flag = "toggle",
callback = function(state)
getgenv().auto = state
if not state then
    local bv = hrp:FindFirstChild("FarmVelocity")
    local bg = hrp:FindFirstChild("FarmGyro")
    if bv then bv:Destroy() end
    if bg then bg:Destroy() end
    if tween then
        tween:Cancel()
    end
    return
end

task.spawn(function()
local bv = hrp:FindFirstChild("FarmVelocity") or Instance.new("BodyVelocity")
bv.Name = "FarmVelocity"
bv.Velocity = Vector3.new(0, 0, 0)
bv.MaxForce = Vector3.new(0, math.huge, 0)
bv.Parent = hrp


while getgenv().auto do
    if not map then
        task.wait(1)
        continue
    end
    if LP:GetAttribute("Alive") == true and Time and Time:GetAttribute("Time") > 0 then
    for _, coin in pairs(map:GetChildren()) do
        if not state then break end
        if coin:IsA("Part") and coin.Name == "Coin_Server" and coin:FindFirstChild("TouchInterest") and coin:FindFirstChild("CoinVisual") then
            local rass = (hrp.Position - coin.Position).Magnitude
            if rass <= 100 then
            local distance = (hrp.Position - coin.Position).Magnitude / speed
            tween = TweenService:Create(hrp, TweenInfo.new(distance, Enum.EasingStyle.Linear), {CFrame = coin.CFrame} )
            tween:Play()
            tween.Completed:Wait()
            task.wait(0.1)
            end
        end
        end
    end
task.wait(0.5)
end
end)
end
})

Window:AddSlider({
text = "Скорость фарма",
min = 1,
max = 26,
dual = true,
type = "slider",
callback = function(SPEED)
speed = tonumber(SPEED)
end
})

Window:AddToggle({
text = "Ресет при фул мешке",
flag = "toggle",
callback = function(v)
getgenv().reset = v
if not v then 
    resetRequested = false
    return 
end
task.spawn(function()
    while getgenv().reset do
        if bagFull and LP:GetAttribute("Alive") == true then
            local currentHum = LP.Character and LP.Character:FindFirstChildOfClass("Humanoid")
            if currentHum and currentHum.Health > 0 and not resetRequested then
                resetRequested = true
                if tween then tween:Cancel() end
                local hrp = LP.Character:FindFirstChild("HumanoidRootPart")
                local bv = hrp and hrp:FindFirstChild("FarmVelocity")
                if bv then bv:Destroy() end
                
                currentHum.Health = 0
                currentHum:ChangeState(Enum.HumanoidStateType.Dead)
            end
        end
        task.wait(0.5)
    end
end)
end
})


Window:AddToggle({
text = "Анти Флинг",
flag = "toggle",
callback = function(state)
    getgenv().AntiFling = state
    if not state then
        if currentHeartbeatConnection then
            currentHeartbeatConnection:Disconnect()
            currentHeartbeatConnection = nil
        end
        RestorePlayersCollision()
        return
    end
    if not currentHeartbeatConnection then
        currentHeartbeatConnection = game:GetService("RunService").PreSimulation:Connect(function()
            pcall(ProcessAntiFling)
        end)
    end
end
})


local idk = Window:AddLabel({
text = "Мешок: 0/50",
type = "label"
})

task.spawn(function()
while task.wait(0.3) do
    if LP:GetAttribute("Alive") == true and Time:GetAttribute("Time") > 0 then
        idk.Text = "Мешок: " .. tostring(bagCount) .. "/" .. tostring(bagCapacity) .. (bagFull and " FULL" or "")
    else
        idk.Text = "Мешок: 0/50"
    end
end
end)


Window:AddButton({
text = "Анти афк",
flag = "button",
callback = function()
if GC then
for _,v in pairs(GC(LP.Idled)) do
if v.Disable then v:Disable() elseif v.Disconnect then v:Disconnect() end
end
else
local VirtualUser = cloneref(game:GetService("VirtualUser"))
LP.Idled:Connect(function()
VirtualUser:CaptureController()
VirtualUser:ClickButton2(Vector2.new())
end)
end
StarterGui:SetCore("SendNotification", {
         Title = "Анти АФК включен!",
         Text = "",
         Duration = 5,
      })
end
})

Window:AddLabel({ text = "Made by Funny games" })

Library:Init()
