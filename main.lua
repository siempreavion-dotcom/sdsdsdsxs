-- AXELBLADIS HUB 2026 | ANTI-DETECTION VERSION
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "AXELBLADIS HUB | DA HOOD 2026",
   LoadingTitle = "Iniciando Bypass 2026...",
   LoadingSubtitle = "by AxelBladis",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "AxelHub2026"
   },
   KeySystem = false
})

-- VARIABLES
local CamlockEnabled = false
local TargetPart = "Head"
local CamlockKey = Enum.KeyCode.Q -- Tecla para activar el fijado

-- LÓGICA DE CAMLOCK PROFESIONAL
game:GetService("RunService").RenderStepped:Connect(function()
    if CamlockEnabled then
        local Target = nil
        local MaxDist = math.huge
        for _, v in pairs(game.Players:GetPlayers()) do
            if v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild(TargetPart) then
                local Pos, OnScreen = workspace.CurrentCamera:WorldToViewportPoint(v.Character[TargetPart].Position)
                if OnScreen then
                    local Dist = (Vector2.new(Pos.X, Pos.Y) - Vector2.new(workspace.CurrentCamera.ViewportSize.X/2, workspace.CurrentCamera.ViewportSize.Y/2)).Magnitude
                    if Dist < MaxDist then
                        MaxDist = Dist
                        Target = v
                    end
                end
            end
        end
        if Target then
            workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, Target.Character[TargetPart].Position)
        end
    end
end)

-- PESTAÑA COMBATE
local CombatTab = Window:CreateTab("Combat", 4483362458)

CombatTab:CreateToggle({
   Name = "Camlock (Auto-Target)",
   CurrentValue = false,
   Callback = function(Value)
      CamlockEnabled = Value
   end,
})

CombatTab:CreateDropdown({
   Name = "Target Part",
   Options = {"Head", "UpperTorso", "HumanoidRootPart"},
   CurrentOption = "Head",
   Callback = function(Option)
      TargetPart = Option
   end,
})

-- PESTAÑA AJUSTES (AQUÍ CAMBIAS LA TECLA DEL MENÚ)
local SettingsTab = Window:CreateTab("Settings", 4483362458)

SettingsTab:CreateKeybind({
   Name = "Cerrar/Abrir Menú",
   CurrentKeybind = "L", -- Tecla inicial
   HoldToInteract = false,
   Callback = function(Keybind)
      Rayfield:ToggleUI() -- Esta función oculta o muestra el HUB
   end,
})

-- PESTAÑA DEFENSA (DA HOOD)
local DefenseTab = Window:CreateTab("Defense", 4483362458)

DefenseTab:CreateToggle({
   Name = "Anti-Stomp (Fast Mode)",
   CurrentValue = false,
   Callback = function(Value)
      _G.AntiStomp = Value
      while _G.AntiStomp do
          task.wait()
          if game.Players.LocalPlayer.Character.Humanoid.Health <= 5 then
              game.Players.LocalPlayer.Character:BreakJoints()
          end
      end
   end,
})

DefenseTab:CreateToggle({
   Name = "Auto-Armor 2026",
   CurrentValue = false,
   Callback = function(Value)
      _G.AutoArmor = Value
      while _G.AutoArmor do
          task.wait(1)
          if game.Players.LocalPlayer.Character.BodyEffects.Armor.Value < 10 then
              local oldPos = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
              game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-607, 7, -788)
              task.wait(0.5)
              fireclickdetector(workspace.Ignored.Shop["[Armor] - $529"].ClickDetector)
              task.wait(0.5)
              game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = oldPos
          end
      end
   end,
})
