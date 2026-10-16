-- дата: 11 октября 2026 года
-- made by Funny_games/сделано мной
-- script only on russian/скрипт только на русском

if game:GetService("CoreGui"):FindFirstChild("ToraScript") then
    game:GetService("CoreGui").ToraScript:Destroy()
end
local Players = game:GetService("Players")
local LP = Players.LocalPlayer
local RunService = game:GetService("RunService")
local Noclip = nil
local copy = setclipboard or toclipboard or setrbxclipboard or set_clipboard or to_clipboard or set_rbx_clipboard or (Clipboard and Clipboard.set) or writeclipboard or write_clipboard or nil
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/FunnyBefange/Library/refs/heads/main/library.lua", true))()
local Window = Library:CreateWindow("Universal")
local Scripts = Window:AddFolder("Scripts")
        Scripts:AddButton({
        text = "Инф елд",
        flag = "button",
        callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
        end
    })

    Scripts:AddButton({
        text = "Дэкс",
        flag = "button",
        callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/infyiff/backup/main/dex.lua"))()
        end
    })

    Scripts:AddButton({
        text = "Дэкс ++",
        flag = "button",
        callback = function()
        loadstring(game:HttpGet("https://github.com/AZYsGithub/DexPlusPlus/releases/latest/download/out.lua"))()
        end
    })
    
    Scripts:AddButton({
        text = "Кобальт",
        flag = "button",
        callback = function()
        loadstring(game:HttpGet("https://gitlab.com/upio/cobalt/-/releases/permalink/latest/downloads/Cobalt.luau"))()
        end
    })

    Scripts:AddButton({
        text = "Виверн",
        flag = "button",
        callback = function()
        loadstring(Game:HttpGet("https://raw.githubusercontent.com/Games1799/Scripts/refs/heads/main/Wevorn.lua"))()
        end
    })
local PlayerFolder = Window:AddFolder("Player")
PlayerFolder:AddToggle({
    text = "Noclip",
    flag = "toggle",
    callback = function(state)
    if state then
        local function NoclipLoop()
            local character = LP.Character
            if character then
                for _, child in pairs(character:GetDescendants()) do
                    if child:IsA("BasePart") and child.CanCollide == true then
                        child.CanCollide = false
                    end
                end
            end
        end
    Noclipping = RunService.Stepped:Connect(NoclipLoop)
    else
        if Noclipping then
            Noclipping:Disconnect()
            Noclipping = nil
            end
    end
end
})
    Window:AddLabel({
        text = "Made by Funny games (me)",
        type = "label"
    })
    
    Library:Init()
