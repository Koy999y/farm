_G.AutoFarmActive = false

-- ใช้ Library สีขาว-ฟ้า-นีออน
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/Library.lua"))()
local Window = Library:CreateWindow({Title = "★ NEON BLUE HUB ★", Center = true, AutoShow = true})

local MainTab = Window:AddTab("FARMING")
local MainBox = MainTab:AddLeftGroupbox("Auto Farm Settings")

-- ปรับสีเป็น ขาว-ฟ้านีออน
Library:SetTheme("Midnight") 
Library.AccentColor = Color3.fromRGB(0, 255, 255)

local TweenService = game:GetService("TweenService")
local LocalPlayer = game:GetService("Players").LocalPlayer

local function StartPremiumFarm()
    local Points = {Vector3.new(0, 0, -200), Vector3.new(0, 0, -1000), Vector3.new(0, 0, -9000)}
    
    while _G.AutoFarmActive do
        local Root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if Root then
            for _, pos in pairs(Points) do
                if not _G.AutoFarmActive then break end
                local tween = TweenService:Create(Root, TweenInfo.new(10, Enum.EasingStyle.Linear), {CFrame = CFrame.new(pos)})
                tween:Play()
                tween.Completed:Wait()
            end
            task.wait(2)
            LocalPlayer.Character.Humanoid.Health = 0
            task.wait(3)
        end
        task.wait(1)
    end
end

MainBox:AddToggle("FarmToggle", {Text = "START NEON FARM", Callback = function(s)
    _G.AutoFarmActive = s
    if s then task.spawn(StartPremiumFarm) end
end})

