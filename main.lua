_G.AutoFarmActive = false

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("★ PREMIUM CYBER HUB v7 (RAINBOW) ★", "BloodTheme")

local MainTab = Window:NewTab("FARMING")
local MainSection = MainTab:NewSection("Auto Farm Options")

-- ฟังก์ชันไฟรุ้งวิ่งรอบกรอบเมนู
task.spawn(function()
    while true do
        for i = 0, 1, 0.005 do
            Window:ChangePresetColor(Color3.fromHSV(i, 1, 1))
            task.wait(0.05)
        end
    end
end)

local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local function StartPremiumFarm()
    local Waypoints = {
        Vector3.new(0, 0, 0),
        Vector3.new(0, 0, -200),
        Vector3.new(0, 0, -1000),
        Vector3.new(0, 0, -3000),
        Vector3.new(0, 0, -5000),
        Vector3.new(0, 0, -9000)
    }

    while _G.AutoFarmActive do
        local Character = LocalPlayer.Character
        local RootPart = Character and Character:FindFirstChild("HumanoidRootPart")
        
        if RootPart then
            for _, pos in pairs(Waypoints) do
                if not _G.AutoFarmActive then break end
                local Distance = (RootPart.Position - pos).Magnitude
                local Tween = TweenService:Create(RootPart, TweenInfo.new(Distance / 150, Enum.EasingStyle.Linear), {CFrame = CFrame.new(pos)})
                Tween:Play()
                Tween.Completed:Wait()
            end
            task.wait(2)
            if LocalPlayer.Character:FindFirstChild("Humanoid") then LocalPlayer.Character.Humanoid.Health = 0 end
            task.wait(3)
        else
            task.wait(1)
        end
    end
end

MainSection:NewToggle("START AUTO FARM", "ฟาร์มรุ้งตึงๆ", function(state)
    _G.AutoFarmActive = state
    if state then task.spawn(StartPremiumFarm) end
end)
