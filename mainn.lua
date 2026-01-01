local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("AXELBLADIS HUB | DA HOOD GOD", "BloodTheme")

-- PESTAÑA PRINCIPAL (COMBATE)
local Combat = Window:NewTab("Combat")
local CombatSection = Combat:NewSection("Advanced Combat")

CombatSection:NewToggle("Anti-Stomp", "Evita que te rematen", function(state)
    _G.AntiStomp = state
    while _G.AntiStomp do
        wait()
        if game.Players.LocalPlayer.Character.Humanoid.Health <= 5 then
            for _,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
                if v:IsA("BasePart") then v:Destroy() end
            end
        end
    end
end)

CombatSection:NewToggle("Velocity Desync", "Te hace difícil de apuntar (Anti-Aim)", function(state)
    _G.Desync = state
    game:GetService("RunService").Heartbeat:Connect(function()
        if _G.Desync then
            local root = game.Players.LocalPlayer.Character.HumanoidRootPart
            local oldV = root.Velocity
            root.Velocity = Vector3.new(math.random(-500,500), math.random(-500,500), math.random(-500,500))
            game:GetService("RunService").RenderStepped:Wait()
            root.Velocity = oldV
        end
    end)
end)

-- PESTAÑA FARM & UTILS
local Farm = Window:NewTab("Farm & Misc")
local FarmSection = Farm:NewSection("Auto Features")

FarmSection:NewToggle("Cash Aura", "Recoge dinero automáticamente a tu alrededor", function(state)
    _G.CashAura = state
    while _G.CashAura do
        wait(0.1)
        for _,v in pairs(workspace.Ignored.Drop:GetChildren()) do
            if v.Name == "MoneyDrop" and (v.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 15 then
                fireclickdetector(v.ClickDetector)
            end
        end
    end
end)

-- PESTAÑA MOVIMIENTO
local Move = Window:NewTab("Movement")
local MoveSection = Move:NewSection("Pro Movement")

MoveSection:NewSlider("Fly Speed", "Velocidad de vuelo", 500, 50, function(s)
    _G.FlySpeed = s
end)

MoveSection:NewButton("Enable Fly (X)", "Presiona X para volar", function()
    -- Aquí se activa el sistema de vuelo con la tecla X
    loadstring(game:HttpGet("https://raw.githubusercontent.com/LibreHub/LibreHub/main/Fly.lua"))()
end)

-- PESTAÑA TARGET
local Target = Window:NewTab("Loop Kill")
local TargetSection = Target:NewSection("Toxic Features")

TargetSection:NewTextBox("Player Name", "Escribe el nombre para LoopKill", function(txt)
    _G.TargetPlayer = txt
end)

TargetSection:NewToggle("Loop Kill Target", "Mata al jugador una y otra vez", function(state)
    _G.LoopKill = state
    while _G.LoopKill do
        wait(1)
        local p2 = game.Players:FindFirstChild(_G.TargetPlayer)
        if p2 and p2.Character then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = p2.Character.HumanoidRootPart.CFrame
            -- Aquí iría el disparo automático si tienes arma
        end
    end
end)
