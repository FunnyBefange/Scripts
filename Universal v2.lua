-- дата: 11 октября 2026 года
-- made by Funny_games/сделано мной
-- script only on russian/скрипт только на русском

if game:GetService("CoreGui"):FindFirstChild("ToraScript") then
    game:GetService("CoreGui").ToraScript:Destroy()
end

local copy = setclipboard or toclipboard or setrbxclipboard or set_clipboard or to_clipboard or set_rbx_clipboard or (Clipboard and Clipboard.set) or writeclipboard or write_clipboard or nil
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/FunnyBefange/Library/refs/heads/main/library.lua", true))()
local Window = Library:CreateWindow("Universal")
        Window:AddButton({
        text = "Инф елд",
        flag = "button",
        callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
        end
    })

    Window:AddButton({
        text = "Дэкс",
        flag = "button",
        callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/infyiff/backup/main/dex.lua"))()
        end
    })

    Window:AddButton({
        text = "Дэкс ++",
        flag = "button",
        callback = function()
        loadstring(game:HttpGet("https://github.com/AZYsGithub/DexPlusPlus/releases/latest/download/out.lua"))()
        end
    })
    
    Window:AddButton({
        text = "Кобальт",
        flag = "button",
        callback = function()
        loadstring(game:HttpGet("https://gitlab.com/upio/cobalt/-/releases/permalink/latest/downloads/Cobalt.luau"))()
        end
    })

    Window:AddButton({
        text = "Виверн",
        flag = "button",
        callback = function()
        loadstring(Game:HttpGet("https://raw.githubusercontent.com/Games1799/Scripts/refs/heads/main/Wevorn.lua"))()
        end
    })
    
    Window:AddLabel({
        text = "Made by Funny games (me)",
        type = "label"
    })
    
    Library:Init()
