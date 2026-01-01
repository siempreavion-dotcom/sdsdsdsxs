-- ==========================================
-- AXELBLADIS HUB - DA HOOD SKIDO STYLE
-- ==========================================

-- 1. LIMPIEZA AUTOMÁTICA (Para que no salga el cuadro pequeño)
if game.CoreGui:FindFirstChild("Orion") then game.CoreGui:FindFirstChild("Orion"):Destroy() end
if game.CoreGui:FindFirstChild("AxelHub_v7") then game.CoreGui:FindFirstChild("AxelHub_v7"):Destroy() end

local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()

local Window = OrionLib:MakeWindow({
    Name = "AXELBLADIS HUB | DA HOOD", 
    HidePremium = false, 
    SaveConfig = true, 
    ConfigFolder = "AxelConfig",
    IntroText = "AxelBladis Hub Cargando..."
})

-- PESTAÑA DE COMBATE (AIMLOCK)
local CombatTab = Window:MakeTab({
	Name = "Combat",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

CombatTab:AddToggle({
	Name = "Silent Aim / Aimlock",
	Default = false,
	Callback = function(Value)
		_G.AimEnabled = Value
        print("Aimlock: " .. tostring(Value))
	end    
})

-- PESTAÑA DE MOVIMIENTO (DA HOOD)
local MoveTab = Window:MakeTab({
	Name = "Movement",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

MoveTab:AddSlider({
	Name = "WalkSpeed",
	Min = 16,
	Max = 250,
	Default = 16,
	Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	ValueName = "Speed",
	Callback = function(Value)
		game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
	end    
})

-- PESTAÑA DE TELEPORTS
local TPTab = Window:MakeTab({
	Name = "Teleports",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

TPTab:AddButton({
	Name = "Bank",
	Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-402, 21, -356)
  	end    
})

TPTab:AddButton({
	Name = "Gun Shop",
	Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-581, 7, -736)
  	end    
})

OrionLib:Init()
