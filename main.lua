-- AXELBLADIS HUB - BASEPLATE TEST
local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()

local Window = OrionLib:MakeWindow({
    Name = "AXELBLADIS HUB | PRO TEST", 
    HidePremium = false, 
    SaveConfig = true, 
    ConfigFolder = "AxelTest",
    IntroText = "Cargando AxelBladis..."
})

local Tab = Window:MakeTab({
	Name = "Movement",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

Tab:AddSlider({
	Name = "WalkSpeed",
	Min = 16,
	Max = 250,
	Default = 16,
	Color = Color3.fromRGB(255,0,0),
	Increment = 1,
	ValueName = "Speed",
	Callback = function(Value)
		game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
	end    
})

Tab:AddButton({
	Name = "Fly (Vuelo)",
	Callback = function()
        print("Vuelo activado")
  	end    
})

OrionLib:Init()
