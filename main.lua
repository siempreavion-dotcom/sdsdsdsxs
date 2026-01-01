-- AXELBLADIS HUB | DA HOOD BYPASS V12
if game.CoreGui:FindFirstChild("Orion") then game.CoreGui:FindFirstChild("Orion"):Destroy() end

local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()

local Window = OrionLib:MakeWindow({
    Name = "AXELBLADIS HUB | DA HOOD", 
    HidePremium = false, 
    SaveConfig = true, 
    ConfigFolder = "AxelDH",
    IntroText = "Bypassing Anticheat..."
})

-- PESTAÑA COMBATE (ANTISTOMP & DESYNC)
local Tab1 = Window:MakeTab({Name = "Combat", Icon = "rbxassetid://4483345998"})

Tab1:AddToggle({
    Name = "Anti-Stomp (God Mode)",
    Default = false,
    Callback = function(v)
        _G.AntiStomp = v
        while _G.AntiStomp do task.wait()
            if game.Players.LocalPlayer.Character.Humanoid.Health <= 5 then
                game.Players.LocalPlayer.Character:BreakJoints()
            end
        end
    end    
})

Tab1:AddToggle({
    Name = "Velocity Desync (Anti-Aim)",
    Default = false,
    Callback = function(v)
        _G.Desync = v
        game:GetService("RunService").Heartbeat:Connect(function()
            if _G.Desync then
                game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(math.random(-500,500), 0, math.random(-500,500))
            end
        end)
    end    
})

-- PESTAÑA AUTO-BUY (ARMOR)
local Tab2 = Window:MakeTab({Name = "Auto-Buy", Icon = "rbxassetid://4483345998"})

Tab2:AddToggle({
    Name = "Auto-Armor",
    Default = false,
    Callback = function(v)
        _G.AutoArmor = v
        while _G.AutoArmor do task.wait(1)
            if game.Players.LocalPlayer.Character.BodyEffects.Armor.Value < 10 then
                local old = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-607, 7, -788)
                task.wait(0.5)
                fireclickdetector(workspace.Ignored.Shop["[Armor] - $529"].ClickDetector)
                task.wait(0.5)
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = old
            end
        end
    end    
})

-- PESTAÑA WORLD & TOXIC
local Tab3 = Window:MakeTab({Name = "World & Toxic", Icon = "rbxassetid://4483345998"})

Tab3:AddToggle({
    Name = "Cash Aura",
    Default = false,
    Callback = function(v)
        _G.CashAura = v
        while _G.CashAura do task.wait(0.1)
            for _, x in pairs(workspace.Ignored.Drop:GetChildren()) do
                if x.Name == "MoneyDrop" and (x.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 15 then
                    fireclickdetector(x.ClickDetector)
                end
            end
        end
    end    
})

OrionLib:Init()
