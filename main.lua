-- AXELBLADIS HUB | DA HOOD BYPASS V11
-- Limpieza de interfaces previas
if game.CoreGui:FindFirstChild("Orion") then game.CoreGui:FindFirstChild("Orion"):Destroy() end

local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()

local Window = OrionLib:MakeWindow({
    Name = "AXELBLADIS HUB | DA HOOD PRO", 
    HidePremium = false, 
    SaveConfig = true, 
    ConfigFolder = "AxelDH",
    IntroText = "Bypassing Da Hood..."
})

-- PESTAÑA: COMBATE (ANTISTOMP & DESYNC)
local CombatTab = Window:MakeTab({Name = "Combat", Icon = "rbxassetid://4483345998"})

CombatTab:AddToggle({
    Name = "Anti-Stomp (God Mode)",
    Default = false,
    Callback = function(Value)
        _G.AntiStomp = Value
        while _G.AntiStomp do
            task.wait()
            if game.Players.LocalPlayer.Character.Humanoid.Health <= 5 then
                for _, v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
                    if v:IsA("BasePart") then v:Destroy() end
                end
            end
        end
    end    
})

CombatTab:AddToggle({
    Name = "Velocity Desync (Anti-Aim)",
    Default = false,
    Callback = function(Value)
        _G.Desync = Value
        game:GetService("RunService").Heartbeat:Connect(function()
            if _G.Desync then
                local root = game.Players.LocalPlayer.Character.HumanoidRootPart
                root.Velocity = Vector3.new(math.random(-500,500), 0, math.random(-500,500))
            end
        end)
    end    
})

-- PESTAÑA: AUTO-BUY (ARMOR)
local ShopTab = Window:MakeTab({Name = "Auto-Buy", Icon = "rbxassetid://4483345998"})

ShopTab:AddToggle({
    Name = "Auto-Buy Armor (When Low)",
    Default = false,
    Callback = function(Value)
        _G.AutoArmor = Value
        while _G.AutoArmor do
            task.wait(1)
            if game.Players.LocalPlayer.Character.BodyEffects.Armor.Value < 10 then
                local oldPos = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-607, 7, -788) -- Posición Armor
                task.wait(0.5)
                fireclickdetector(workspace.Ignored.Shop["[Armor] - $529"].ClickDetector)
                task.wait(0.5)
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = oldPos
            end
        end
    end    
})

-- PESTAÑA: WORLD (CASH AURA)
local WorldTab = Window:MakeTab({Name = "World", Icon = "rbxassetid://4483345998"})

WorldTab:AddToggle({
    Name = "Cash Aura",
    Default = false,
    Callback = function(Value)
        _G.CashAura = Value
        while _G.CashAura do
            task.wait(0.1)
            for _, v in pairs(workspace.Ignored.Drop:GetChildren()) do
                if v.Name == "MoneyDrop" and (v.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 15 then
                    fireclickdetector(v.ClickDetector)
                end
            end
        end
    end    
})

OrionLib:Init()
