-- ==========================================
-- AXELBLADIS HUB PRO - DA HOOD EDITION
-- ==========================================

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "AXELBLADIS HUB | DA HOOD",
   LoadingTitle = "Cargando AxelBladis System...",
   LoadingSubtitle = "by AxelBladis",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "AxelHub",
      FileName = "DaHoodConfig"
   },
   KeySystem = false
})

-- PESTAÑA PRINCIPAL (COMBATE)
local CombatTab = Window:CreateTab("Combat", 4483362458) -- Icono de espada

CombatTab:CreateSection("Aimlock & Target")

CombatTab:CreateToggle({
   Name = "Silent Aim (Beta)",
   CurrentValue = false,
   Flag = "SilentAim",
   Callback = function(Value)
       _G.SilentAim = Value
       -- Aquí iría la lógica de Silent Aim para Da Hood
   end,
})

CombatTab:CreateButton({
   Name = "Target Strafe",
   Callback = function()
       Rayfield:Notify({Title = "Info", Content = "Función Strafe activada", Duration = 2})
   end,
})

-- PESTAÑA DE MOVIMIENTO (PRO)
local MoveTab = Window:CreateTab("Movement", 4483362458)

MoveTab:CreateSlider({
   Name = "WalkSpeed Custom",
   Range = {16, 200},
   Increment = 1,
   Suffix = "Speed",
   CurrentValue = 16,
   Flag = "SpeedSlider",
   Callback = function(Value)
       game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
   end,
})

MoveTab:CreateButton({
   Name = "Fly (Press E to Toggle)",
   Callback = function()
       -- Lógica de Fly mejorada aquí
       Rayfield:Notify({Title = "Fly", Content = "Sistema de vuelo listo", Duration = 2})
   end,
})

-- PESTAÑA DE TELEPORTS (PARA DA HOOD)
local TPBase = Window:CreateTab("Teleports", 4483362458)

TPBase:CreateButton({Name = "Bank", Callback = function() 
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-402, 21, -356) 
end})

TPBase:CreateButton({Name = "Gun Shop", Callback = function() 
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-581, 7, -736) 
end})

-- PESTAÑA DE CONFIGURACIÓN
local SettingsTab = Window:CreateTab("Settings", 4483362458)

SettingsTab:CreateKeybind({
   Name = "Cerrar/Abrir Menú",
   CurrentKeybind = "L",
   HoldToInteract = false,
   Flag = "Keybind1",
   Callback = function(Keybind)
       Rayfield:Notify({Title = "Keybind", Content = "Has presionado la tecla de guardado", Duration = 2})
   end,
})

Rayfield:Notify({
   Title = "AXELBLADIS HUB CARGADO",
   Content = "Bienvenido al menú avanzado para Da Hood",
   Duration = 5,
   Image = 4483362458,
})
