-- AXELBLADIS HUB | DA HOOD GOD MODE V9
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

-- PESTAÑA: COMBATE (ANTISTOMP & DESYNC)
local CombatTab = Window:CreateTab("Combat", 4483362458)
local CombatSection = CombatTab:CreateSection("Advanced Combat")

CombatTab:CreateToggle({
   Name = "Anti-Stomp",
   Info = "Evita que te maten cuando estás en el suelo",
   CurrentValue = false,
   Flag = "AntiStomp",
   Callback = function(Value)
       _G.AntiStomp = Value
       spawn(function()
           while _G.AntiStomp do
               task.wait()
               if game.Players.LocalPlayer.Character.Humanoid.Health <= 5 then
                   for _, v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
                       if v:IsA("BasePart") then v:Destroy() end
                   end
               end
           end
       end)
   end,
})

CombatTab:CreateToggle({
   Name = "Velocity Desync",
   Info = "Te hace difícil de apuntar para los que usan Aimlock",
   CurrentValue = false,
   Flag = "Desync",
   Callback = function(Value)
       _G.Desync = Value
       game:GetService("RunService").Heartbeat:Connect(function()
           if _G.Desync then
               local root = game.Players.LocalPlayer.Character.HumanoidRootPart
               root.Velocity = Vector3.new(math.random(-500,500), 0, math.random(-500,500))
           end
       end)
   end,
})

-- PESTAÑA: WORLD (CASH AURA)
local WorldTab = Window:CreateTab("World", 4483362458)

WorldTab:CreateToggle({
   Name = "Cash Aura",
   Info = "Recoge dinero automáticamente cerca de ti",
   CurrentValue = false,
   Flag = "CashAura",
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
   end,
})

-- PESTAÑA: MOVEMENT (FLY)
local MoveTab = Window:CreateTab("Movement", 4483362458)

MoveTab:CreateSlider({
   Name = "WalkSpeed",
   Range = {16, 300},
   Increment = 1,
   Suffix = "Speed",
   CurrentValue = 16,
   Flag = "Speed",
   Callback = function(Value)
       game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
   end,
})

MoveTab:CreateButton({
   Name = "Enable Pro Fly (Press X)",
   Callback = function()
       loadstring(game:HttpGet("https://raw.githubusercontent.com/LibreHub/LibreHub/main/Fly.lua"))()
   end,
})

-- PESTAÑA: TOXIC (LOOPKILL)
local ToxicTab = Window:NewTab("Toxic")
ToxicTab:CreateInput({
   Name = "Target Name",
   PlaceholderText = "Nombre del jugador",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
       _G.Target = Text
   end,
})

ToxicTab:CreateToggle({
   Name = "Loopkill Target",
   CurrentValue = false,
   Flag = "Loopkill",
   Callback = function(Value)
       _G.Loopkill = Value
       while _G.Loopkill do
           task.wait()
           local targetPlayer = game.Players:FindFirstChild(_G.Target)
           if targetPlayer and targetPlayer.Character then
               game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = targetPlayer.Character.HumanoidRootPart.CFrame
           end
       end
   end,
})
