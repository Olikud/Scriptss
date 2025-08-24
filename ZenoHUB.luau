-- ZenoHUB v1.0 - Full Blox Fruits Script (Redz Hub Style)
-- UI Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()

local Window = Library.CreateLib("ZenoHUB", "BloodTheme")

-- Tabs
local FarmTab = Window:NewTab("Auto Farm")
local EspTab = Window:NewTab("ESP")
local BossTab = Window:NewTab("Boss Farm")
local TpTab = Window:NewTab("Teleports")

-- Auto Farm Section
local FarmSection = FarmTab:NewSection("Mob Farm")
FarmSection:NewToggle("Auto Farm", "Automatically farm mobs", function(state)
    _G.AutoFarm = state
    while _G.AutoFarm do task.wait()
        pcall(function()
            local enemy = game:GetService("Workspace").Enemies:FindFirstChildWhichIsA("Model")
            if enemy and enemy:FindFirstChild("HumanoidRootPart") and enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0 then
                local player = game.Players.LocalPlayer.Character
                player.HumanoidRootPart.CFrame = enemy.HumanoidRootPart.CFrame * CFrame.new(0,15,0)
                task.wait(0.2)
                game:GetService("VirtualUser"):ClickButton1(Vector2.new())
            end
        end)
    end
end)

-- ESP Section
local EspSection = EspTab:NewSection("ESP")
EspSection:NewButton("ESP Fruits", "Highlights fruits on the map", function()
    for _,v in pairs(game.Workspace:GetChildren()) do
        if v:IsA("Tool") and string.find(v.Name, "Fruit") then
            local esp = Instance.new("BillboardGui", v)
            esp.Size = UDim2.new(0,200,0,50)
            esp.AlwaysOnTop = true
            esp.StudsOffset = Vector3.new(0,2,0)
            local label = Instance.new("TextLabel", esp)
            label.Size = UDim2.new(1,0,1,0)
            label.Text = v.Name
            label.TextColor3 = Color3.new(1,0,0)
            label.BackgroundTransparency = 1
        end
    end
end)

-- Boss Farm Section
local BossSection = BossTab:NewSection("Bosses")
BossSection:NewToggle("Auto Boss Farm", "Farms bosses automatically", function(state)
    _G.AutoBoss = state
    while _G.AutoBoss do task.wait()
        pcall(function()
            for _,mob in pairs(game.Workspace.Enemies:GetChildren()) do
                if mob:FindFirstChild("HumanoidRootPart") and mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 then
                    local player = game.Players.LocalPlayer.Character
                    player.HumanoidRootPart.CFrame = mob.HumanoidRootPart.CFrame * CFrame.new(0,15,0)
                    task.wait(0.2)
                    game:GetService("VirtualUser"):ClickButton1(Vector2.new())
                end
            end
        end)
    end
end)

-- Teleports Section
local TpSection = TpTab:NewSection("Teleport Locations")
TpSection:NewButton("Jungle", "TP to Jungle", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1245, 12, 345)
end)
TpSection:NewButton("Marine", "TP to Marine Base", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-2780, 15, 2100)
end)
TpSection:NewButton("Pirate Village", "TP to Pirate Village", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-650, 25, 1430)
end)
