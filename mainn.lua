local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("AXELBLADIS HUB | DA HOOD", "Midnight") -- Tema oscuro profesional

-- PESTAÑAS (Tabs)
local Main = Window:NewTab("Main")
local MainSection = Main:NewSection("Combat & Movement")

local Player = Window:NewTab("Player")
local PlayerSection = Player:NewSection("Character Settings")

local Teleports = Window:NewTab("Teleports")
local TPSection = Teleports:NewSection("Da Hood Locations")

-- FUNCIONES DE MOVIMIENTO
MainSection:NewSlider("WalkSpeed", "Ajusta tu velocidad", 250, 16, function(s)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = s
end)

MainSection:NewButton("Infinite Jump", "Salto infinito activado", function()
    game:GetService("UserInputService").JumpRequest:Connect(function()
        game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
    end)
end)

-- TELEPORTS (Igual que en los menús grandes)
TPSection:NewButton("Bank", "Ir al Banco", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-402, 21, -356)
end)

TPSection:NewButton("Gun Shop", "Ir a la tienda de armas", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-581, 7, -736)
end)

-- CONFIGURACIÓN DE TECLA
local Config = Window:NewTab("Config")
local ConfigSection = Config:NewSection("Ajustes")

ConfigSection:NewKeybind("Abrir/Cerrar Menú", "Presiona la tecla para ocultar", Enum.KeyCode.L, function()
	Library:ToggleUI()
end)
