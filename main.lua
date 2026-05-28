_G.AutoFarmActive = false
_G.FlySpeed = 85

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local colors = {
    SchemeColor = Color3.fromRGB(255, 0, 50),
    Background = Color3.fromRGB(15, 15, 20),
    Header = Color3.fromRGB(10, 10, 12),
    TextColor = Color3.fromRGB(255, 255, 255),
    ElementColor = Color3.fromRGB(25, 25, 30)
}

local Window = Library.CreateLib("★ PREMIUM CYBER HUB v4 ★", colors)

local MainTab = Window:NewTab("FARMING")
local MainSection = MainTab:NewSection("Main Functions")

local SettingTab = Window:NewTab("SETTINGS")
local SettingSection = SettingTab:NewSection("Speed Control")

local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local function StartPremiumFarm()
    local TargetPosition = Vector3.new(0, -15, -9000) 

    while _G.AutoFarmActive do
        local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        local RootPart = Character:WaitForChild("HumanoidRootPart", 10)
        local Humanoid = Character:WaitForChild("Humanoid", 10)

        if RootPart and Humanoid then
            Humanoid:ChangeState(Enum.HumanoidStateType.Physics)
            
            local CurrentPosition = RootPart.Position
            local Distance = (CurrentPosition - TargetPosition).Magnitude
            local TweenTime = Distance / _G.FlySpeed

            local Info = TweenInfo.new(TweenTime, Enum.EasingStyle.Linear)
            local Tween = TweenService:Create(RootPart, Info, {CFrame = CFrame.new(TargetPosition)})
            
            Tween:Play()

            while Tween.PlaybackState == Enum.PlaybackState.Playing do
                if not _G.AutoFarmActive then
                    Tween:Cancel()
                    break
                end
                task.wait(0.2)
            end

            if _G.AutoFarmActive then
                task.wait(7.5)
                if Character and Humanoid then
                    Humanoid.Health = 0
                end
                task.wait(3)
            end
        else
            task.wait(1)
        end
    end
end

MainSection:NewToggle("SYSTEM: AUTO FARM", "Start -> End -> GoldenChest", function(state)
    _G.AutoFarmActive = state
    if state then
        task.spawn(StartPremiumFarm)
    end
end)

SettingSection:NewSlider("BOOST SPEED", "Default is 85", 400, 50, function(value)
    _G.FlySpeed = value
end)
