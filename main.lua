-- AXELBLADIS HUB DA HOOD EDITION
local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()

local Window = OrionLib:MakeWindow({
    Name = "AXELBLADIS HUB | DA HOOD", 
    HidePremium = false, 
    SaveConfig = true, 
    ConfigFolder = "AxelConfig",
    IntroText = "Bienvenido AxelBladis"
})

-- PESTAÑA DE COMBATE
local Tab1 = Window:MakeTab({
    Name = "Combat",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

Tab1:AddToggle({
    Name = "Silent Aim / Aimlock",
    Default = false,
    Callback = function(Value)
        _G.AimEnabled = Value
    end    
})

-- PESTAÑA DE MOVIMIENTO
local Tab2 = Window:MakeTab({
    Name = "Movement",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

Tab2:AddSlider({
    Name = "Speed (Velocidad)",
    Min = 16,
    Max = 200,
    Default = 16,
    Color = Color3.fromRGB(255,0,0),
    Increment = 1,
    ValueName = "WalkSpeed",
    Callback = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
    end    
})

-- PESTAÑA DE TELEPORTS
local Tab3 = Window:MakeTab({
    Name = "Teleports",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

Tab3:AddButton({
    Name = "Teleport to Bank",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-402, 21, -356)
    end    
})

Tab3:AddButton({
    Name = "Teleport to Gun Shop",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-581, 7, -736)
    end    
})

OrionLib:Init()
