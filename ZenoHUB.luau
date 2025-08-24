-- ⚠️ Używasz na własne ryzyko ⚠️
-- ZenoHUB: Auto Farm, Teleporty, ESP, Auto Buso

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("ZenoHUB", "DarkTheme")

-- 🌌 AUTO FARM
local farmTab = Window:NewTab("Auto Farm")
local farmSec = farmTab:NewSection("Farming")

farmSec:NewToggle("Auto Farm Moby", "Automatyczne farmienie najbliższych mobów", function(state)
    getgenv().AutoFarm = state
    while getgenv().AutoFarm do
        task.wait()
        local player = game.Players.LocalPlayer
        local char = player.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        local tool = char and char:FindFirstChildOfClass("Tool") -- np. miecz

        if hrp and tool then
            for _, mob in pairs(workspace.Enemies:GetChildren()) do
                if mob:FindFirstChild("HumanoidRootPart") and mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 then
                    -- ustawiamy się nad mobem
                    hrp.CFrame = mob.HumanoidRootPart.CFrame * CFrame.new(0, 5, 0)

                    -- spam ataków
                    for i = 1,3 do
                        game:GetService("VirtualUser"):ClickButton1(Vector2.new())
                        task.wait(0.1)
                    end

                    break
                end
            end
        end
    end
end)

farmSec:NewToggle("Auto Farm Bossy", "Bije bossów automatycznie", function(state)
    getgenv().AutoBoss = state
    while getgenv().AutoBoss do
        task.wait()
        local bosses = {"Bobby","Yeti","Saber Expert","Magma Admiral"}
        local player = game.Players.LocalPlayer
        local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
        local tool = player.Character and player.Character:FindFirstChildOfClass("Tool")
        if hrp and tool then
            for _, mob in pairs(workspace.Enemies:GetChildren()) do
                if table.find(bosses, mob.Name) and mob:FindFirstChild("HumanoidRootPart") and mob.Humanoid.Health > 0 then
                    hrp.CFrame = mob.HumanoidRootPart.CFrame * CFrame.new(0, 5, 0)
                    for i = 1,3 do
                        game:GetService("VirtualUser"):ClickButton1(Vector2.new())
                        task.wait(0.1)
                    end
                    break
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

miscSec:NewButton("Auto Buso", "Włącza Haki co chwilę", function()
    while task.wait(10) do
        game.ReplicatedStorage.Remotes.CommF_:InvokeServer("Buso")
    end
end)
