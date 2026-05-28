_G.AutoFarmActive = false
_G.FlySpeed = 100

-- โหลด Library Kavo UI แบบเดิมที่พี่ชอบ
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("★ PREMIUM CYBER HUB v11 ★", "BloodTheme")

local MainTab = Window:NewTab("FARMING")
local MainSection = MainTab:NewSection("Main Functions")

local TweenService = game:GetService("TweenService")
local LocalPlayer = game:GetService("Players").LocalPlayer

local function StartPremiumFarm()
    -- จุดแวะพักเพื่อให้เกมโหลดแมพทัน ลดอาการทะลุ/วนกลับฐาน
    local Points = {
        Vector3.new(0, 0, -200),
        Vector3.new(0, 0, -1000),
        Vector3.new(0, 0, -3000),
        Vector3.new(0, 0, -9000)
    }
    
    while _G.AutoFarmActive do
        local Root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if Root then
            for _, pos in pairs(Points) do
                if not _G.AutoFarmActive then break end
                local dist = (Root.Position - pos).Magnitude
                local tween = TweenService:Create(Root, TweenInfo.new(dist / _G.FlySpeed, Enum.EasingStyle.Linear), {CFrame = CFrame.new(pos)})
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

MainSection:NewToggle("SYSTEM: AUTO FARM", "ฟาร์มแบบ Waypoints", function(state)
    _G.AutoFarmActive = state
    if state then task.spawn(StartPremiumFarm) end
end)

MainSection:NewSlider("SPEED", "ความเร็วการฟาร์ม", 500, 50, function(v) 
    _G.FlySpeed = v 
end)
