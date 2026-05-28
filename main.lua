_G.AutoFarmActive = false

-- ใช้ Library ตัวใหม่ที่ลื่นกว่าเดิมและแก้บั๊ก UI
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/Library.lua"))()

local Window = Library:CreateWindow({
    Title = "PREMIUM CYBER HUB v8 (NEON)",
    Center = true,
    AutoShow = true,
})

local MainTab = Window:AddTab("FARMING")
local MainBox = MainTab:AddLeftGroupbox("Auto Farm Options")

-- ปรับสี UI เป็น ขาว-ฟ้า-นีออน
Library:SetTheme("Dark")
Library.AccentColor = Color3.fromRGB(0, 255, 255) -- สีฟ้านีออน

local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local function StartPremiumFarm()
    local TargetPosition = Vector3.new(0, 0, -9000)
    while _G.AutoFarmActive do
        local Character = LocalPlayer.Character
        local RootPart = Character and Character:FindFirstChild("HumanoidRootPart")
        if RootPart then
            local Tween = TweenService:Create(RootPart, TweenInfo.new(30, Enum.EasingStyle.Linear), {CFrame = CFrame.new(TargetPosition)})
            Tween:Play()
            Tween.Completed:Wait()
            task.wait(5)
            LocalPlayer.Character.Humanoid.Health = 0
            task.wait(3)
        else
            task.wait(1)
        end
    end
end

MainBox:AddToggle("AutoFarm", {Text = "SYSTEM: AUTO FARM", Default = false, Callback = function(state)
    _G.AutoFarmActive = state
    if state then task.spawn(StartPremiumFarm) end
end})

Library:Notify("System Loaded: White/Neon Blue Theme Activated!")
