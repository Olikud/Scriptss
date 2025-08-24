--// ZenoHUB - Example Hub in style of RedzHub
--// Autor: Twój własny AI Asystent 🚀

if not game:IsLoaded() then
    game.Loaded:Wait()
end

-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

-- UI Library (basic style like RedzHub)
local Library = {}
Library.__index = Library

function Library:CreateWindow(title)
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "ZenoHUB"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.Parent = game.CoreGui

    local MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0, 500, 0, 300)
    MainFrame.Position = UDim2.new(0.5, -250, 0.5, -150)
    MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    MainFrame.BorderSizePixel = 0
    MainFrame.Active = true
    MainFrame.Draggable = true
    MainFrame.Parent = ScreenGui

    local UICorner = Instance.new("UICorner", MainFrame)
    UICorner.CornerRadius = UDim.new(0, 12)

    local TitleBar = Instance.new("TextLabel")
    TitleBar.Size = UDim2.new(1, 0, 0, 40)
    TitleBar.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    TitleBar.Text = title or "ZenoHUB"
    TitleBar.TextColor3 = Color3.fromRGB(255, 255, 255)
    TitleBar.Font = Enum.Font.GothamBold
    TitleBar.TextSize = 20
    TitleBar.Parent = MainFrame

    local TabFolder = Instance.new("Folder", MainFrame)
    TabFolder.Name = "Tabs"

    return setmetatable({
        ScreenGui = ScreenGui,
        MainFrame = MainFrame,
        TabFolder = TabFolder
    }, Library)
end

function Library:CreateTab(name)
    local Tab = Instance.new("Frame")
    Tab.Name = name
    Tab.Size = UDim2.new(1, 0, 1, -40)
    Tab.Position = UDim2.new(0, 0, 0, 40)
    Tab.BackgroundTransparency = 1
    Tab.Visible = false
    Tab.Parent = self.TabFolder

    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(0, 100, 0, 30)
    Button.Position = UDim2.new(0, (#self.TabFolder:GetChildren()-1) * 105, 0, 5)
    Button.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    Button.Text = name
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.Parent = self.MainFrame

    local function ShowTab()
        for _, v in pairs(self.TabFolder:GetChildren()) do
            v.Visible = false
        end
        Tab.Visible = true
    end
    Button.MouseButton1Click:Connect(ShowTab)

    if #self.TabFolder:GetChildren() == 1 then
        Tab.Visible = true
    end

    return Tab
end

-- Example Features
local Window = Library:CreateWindow("ZenoHUB")

local Tab1 = Window:CreateTab("AutoFarm")
local Tab2 = Window:CreateTab("Player")
local Tab3 = Window:CreateTab("Visuals")

-- Example button in AutoFarm
local AutoFarmBtn = Instance.new("TextButton")
AutoFarmBtn.Size = UDim2.new(0, 200, 0, 40)
AutoFarmBtn.Position = UDim2.new(0, 20, 0, 20)
AutoFarmBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
AutoFarmBtn.Text = "Toggle AutoFarm"
AutoFarmBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
AutoFarmBtn.Parent = Tab1

local autofarmEnabled = false

AutoFarmBtn.MouseButton1Click:Connect(function()
    autofarmEnabled = not autofarmEnabled
    AutoFarmBtn.Text = autofarmEnabled and "AutoFarm: ON" or "AutoFarm: OFF"

    if autofarmEnabled then
        task.spawn(function()
            while autofarmEnabled do
                -- Example logic: teleport to closest mob
                local char = LocalPlayer.Character
                if char and char:FindFirstChild("HumanoidRootPart") then
                    local closest, dist = nil, math.huge
                    for _, mob in pairs(workspace:GetDescendants()) do
                        if mob:FindFirstChild("Humanoid") and mob:FindFirstChild("HumanoidRootPart") then
                            local d = (mob.HumanoidRootPart.Position - char.HumanoidRootPart.Position).Magnitude
                            if d < dist and mob.Humanoid.Health > 0 then
                                closest, dist = mob, d
                            end
                        end
                    end
                    if closest then
                        char.HumanoidRootPart.CFrame = closest.HumanoidRootPart.CFrame * CFrame.new(0, 5, -15)
                        task.wait(0.2)
                        mouse1click()
                    end
                end
                task.wait(0.5)
            end
        end)
    end
end)
