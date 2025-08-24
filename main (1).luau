-- ⚠️ UWAGA: Używasz na własne ryzyko, możliwy ban ⚠️
-- Blox Fruits Hub (Redz Hub Style + Auto Quest Farm)
-- main.luau

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Blox Fruits Hub", "DarkTheme")

-- 🌌 AUTO FARM
local farmTab = Window:NewTab("Auto Farm")
local farmSec = farmTab:NewSection("Farming")

farmSec:NewToggle("Auto Quest Farm", "Automatyczne questy + moby", function(state)
    getgenv().AutoQuestFarm = state
    while getgenv().AutoQuestFarm do
        task.wait(1)
        local player = game.Players.LocalPlayer
        local char = player.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")

        -- Przykladowe questy (dopasuj do wyspy na której jesteś)
        local quests = {
            {npc="BanditQuest1", quest="Bandit", pos=Vector3.new(1060, 16, 1548)},
            {npc="JungleQuest", quest="Monkey", pos=Vector3.new(-1600, 36, 150)},
        }

        for _,q in ipairs(quests) do
            if hrp then
                -- Bierze questa
                game.ReplicatedStorage.Remotes.CommF_:InvokeServer("StartQuest", q.npc, q.quest)
                task.wait(0.5)

                -- Szuka mobów pod questa
                for _,mob in pairs(workspace.Enemies:GetChildren()) do
                    if mob.Name:find(q.quest) and mob:FindFirstChild("HumanoidRootPart") and mob.Humanoid.Health > 0 then
                        hrp.CFrame = mob.HumanoidRootPart.CFrame * CFrame.new(0,0,3)
                        game:GetService("VirtualUser"):ClickButton1(Vector2.new())
                        repeat
                            task.wait()
                            hrp.CFrame = mob.HumanoidRootPart.CFrame * CFrame.new(0,0,3)
                        until not mob.Parent or mob.Humanoid.Health <= 0 or not getgenv().AutoQuestFarm
                    end
                end
            end
        end
    end
end)

-- 🌍 TELEPORTY
local tpTab = Window:NewTab("Teleporty")
local tpSec = tpTab:NewSection("Wyspy")

local locations = {
    ["Spawn"] = Vector3.new(-1423, 15, 7),
    ["Pirate Village"] = Vector3.new(-1163, 45, 3841),
    ["Desert"] = Vector3.new(1095, 15, 4325),
    ["Sky Island"] = Vector3.new(-4981, 717, -2637),
    ["Marineford"] = Vector3.new(-4505, 20, 4260)
}

for name,pos in pairs(locations) do
    tpSec:NewButton(name, "Teleport do "..name, function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(pos)
    end)
end

-- 👀 ESP
local espTab = Window:NewTab("ESP")
local espSec = espTab:NewSection("Podświetlanie")

espSec:NewToggle("ESP Owoce", "Pokazuje owoce na mapie", function(state)
    getgenv().FruitESP = state
    while getgenv().FruitESP do
        task.wait(2)
        for _,v in pairs(workspace:GetChildren()) do
            if v:IsA("Tool") and v:FindFirstChild("Handle") then
                if not v:FindFirstChild("Highlight") then
                    local highlight = Instance.new("Highlight", v)
                    highlight.FillColor = Color3.fromRGB(255, 0, 0)
                end
            end
        end
    end
end)

espSec:NewToggle("ESP Skrzynki", "Pokazuje skrzynki", function(state)
    getgenv().ChestESP = state
    while getgenv().ChestESP do
        task.wait(2)
        for _,v in pairs(workspace:GetChildren()) do
            if v.Name:lower():find("chest") and v:IsA("Model") then
                if not v:FindFirstChild("Highlight") then
                    local highlight = Instance.new("Highlight", v)
                    highlight.FillColor = Color3.fromRGB(0, 255, 0)
                end
            end
        end
    end
end)

-- 🗝️ INNE
local miscTab = Window:NewTab("Misc")
local miscSec = miscTab:NewSection("Dodatki")

miscSec:NewButton("Auto Buso", "Włącza haki co chwilę", function()
    while task.wait(10) do
        game.ReplicatedStorage.Remotes.CommF_:InvokeServer("Buso")
    end
end)
