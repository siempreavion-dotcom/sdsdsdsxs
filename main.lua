-- AXELBLADIS HUB | DA HOOD ULTIMATE V10
local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()

local Window = OrionLib:MakeWindow({
    Name = "AXELBLADIS HUB | DA HOOD", 
    HidePremium = false, 
    SaveConfig = true, 
    ConfigFolder = "AxelHub",
    IntroText = "AxelBladis System Loading..."
})

-- PESTAÑA: COMBAT (ANTISTOMP & DESYNC)
local CombatTab = Window:MakeTab({
	Name = "Combat",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

CombatTab:AddToggle({
	Name = "Anti-Stomp",
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
	Name = "Velocity Desync",
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

-- PESTAÑA: WORLD (CASH AURA)
local WorldTab = Window:MakeTab({
	Name = "World",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

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

-- PESTAÑA: PLAYER (FLY & SPEED)
local PlayerTab = Window:MakeTab({
	Name = "Player",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

PlayerTab:AddSlider({
	Name = "WalkSpeed",
	Min = 16,
	Max = 300,
	Default = 16,
	Color = Color3.fromRGB(255,0,0),
	Increment = 1,
	ValueName = "Speed",
	Callback = function(Value)
		game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
	end    
})

PlayerTab:AddButton({
	Name = "Enable Pro Fly (X)",
	Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/LibreHub/LibreHub/main/Fly.lua"))()
	end    
})

-- PESTAÑA: TOXIC (LOOPKILL)
local ToxicTab = Window:MakeTab({
	Name = "Toxic",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

ToxicTab:AddTextbox({
	Name = "Target Name",
	Default = "",
	TextDisappear = false,
	Callback = function(Value)
		_G.Target = Value
	end
})

ToxicTab:AddToggle({
	Name = "Loopkill Target",
	Default = false,
	Callback = function(Value)
		_G.LoopKill = Value
        while _G.LoopKill do
            task.wait()
            local targetPlayer = game.Players:FindFirstChild(_G.Target)
            if targetPlayer and targetPlayer.Character then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = targetPlayer.Character.HumanoidRootPart.CFrame
            end
        end
	end    
})

OrionLib:Init()
