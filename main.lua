-- ==========================================
-- AXELBLADIS HUB - DA HOOD ULTIMATE (SKIDO STYLE)
-- ==========================================

-- Limpieza de GUIs antiguas para que no se encimen
if game.CoreGui:FindFirstChild("Orion") then game.CoreGui:FindFirstChild("Orion"):Destroy() end

local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()

local Window = OrionLib:MakeWindow({
    Name = "AXELBLADIS HUB | DA HOOD", 
    HidePremium = false, 
    SaveConfig = true, 
    ConfigFolder = "AxelConfig",
    IntroText = "AxelBladis Hub Cargando..."
})

-- PESTAÑA: COMBATE
local Tab1 = Window:MakeTab({
	Name = "Combat",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

Tab1:AddToggle({
	Name = "Aimlock / Silent Aim",
	Default = false,
	Callback = function(Value)
		_G.AimEnabled = Value
        OrionLib:MakeNotification({
            Name = "Status",
            Content = "Aimlock: " .. tostring(Value),
            Duration = 3
        })
	end    
})

-- PESTAÑA: MOVIMIENTO (WALKSPEED)
local Tab2 = Window:MakeTab({
	Name = "Movement",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

Tab2:AddSlider({
	Name = "WalkSpeed",
	Min = 16,
	Max = 200,
	Default = 16,
	Color = Color3.fromRGB(255,0,0),
	Increment = 1,
	ValueName = "Speed",
	Callback = function(Value)
		game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
	end    
})

Tab2:AddButton({
	Name = "Fly (Press L to Toggle Hub)",
	Callback = function()
        print("Sistema de vuelo listo")
  	end    
})

-- PESTAÑA: TELEPORTES (DA HOOD)
local Tab3 = Window:MakeTab({
	Name = "Teleports",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

Tab3:AddButton({
	Name = "Bank",
	Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-402, 21, -356)
  	end    
})

Tab3:AddButton({
	Name = "Gun Shop",
	Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-581, 7, -736)
  	end    
})

OrionLib:Init()
