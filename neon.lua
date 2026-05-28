_G.AutoFarmActive = false
_G.FarmSpeed = 80

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/Library.lua"))()
local Window = Library:CreateWindow({Title = "★ EXTREME CYBER HUB [UNLOCKED] ★", Center = true, AutoShow = true, Size = UDim2.fromOffset(450, 350)})

-- Tabs หลัก
local MainTab = Window:AddTab("FARMING")
local MiscTab = Window:AddTab("UTILITIES")

local MainBox = MainTab:AddLeftGroupbox("Auto Farm")
local MiscBox = MiscTab:AddLeftGroupbox("Player Settings")

Library.AccentColor = Color3.fromRGB(0, 255, 255)

local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- ฟังก์ชันฟาร์มระดับเทพ
local function StartPremiumFarm()
    local Points = {Vector3.new(0, 0, -200), Vector3.new(0, 0, -1000), Vector3.new(0, 0, -5000), Vector3.new(0, 0, -9000)}
    while _G.AutoFarmActive do
        local Root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if Root then
            for _, pos in pairs(Points) do
                if not _G.AutoFarmActive then break end
                local dist = (Root.Position - pos).Magnitude
                local tween = TweenService:Create(Root, TweenInfo.new(dist / _G.FarmSpeed, Enum.EasingStyle.Linear), {CFrame = CFrame.new(pos)})
                tween:Play()
                tween.Completed:Wait()
            end
            task.wait(2)
            if LocalPlayer.Character:FindFirstChild("Humanoid") then LocalPlayer.Character.Humanoid.Health = 0 end
            task.wait(3)
        end
        task.wait(1)
    end
end

-- เพิ่มฟังก์ชันในเมนู
MainBox:AddToggle("FarmToggle", {Text = "START AUTO FARM", Default = false, Callback = function(s)
    _G.AutoFarmActive = s
    if s then task.spawn(StartPremiumFarm) end
end})

MainBox:AddSlider("SpeedSlider", {Text = "Farm Speed", Min = 20, Max = 200, Default = 80, Rounding = 0, Callback = function(v) _G.FarmSpeed = v end})

-- ฟังก์ชันเสริม (Utilities)
MiscBox:AddToggle("WalkSpeed", {Text = "Enable Super Speed", Callback = function(s)
    LocalPlayer.Character.Humanoid.WalkSpeed = s and 50 or 16
end})

MiscBox:AddToggle("JumpPower", {Text = "Enable Super Jump", Callback = function(s)
    LocalPlayer.Character.Humanoid.JumpPower = s and 100 or 50
end})

Library:Notify("Extreme Hub Activated! No Restrictions.")
