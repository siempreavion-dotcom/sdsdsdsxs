-- ==========================================
-- AXELBLADIS HUB V8 - RAYFIELD EDITION (PRO)
-- ==========================================

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "AXELBLADIS HUB | XENO EDITION",
   LoadingTitle = "Cargando AxelBladis Hub...",
   LoadingSubtitle = "by AxelBladis",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "AxelHub",
      FileName = "Config"
   },
   KeySystem = false -- Puedes ponerle true si quieres que tenga password
})

-- PESTAÑA PRINCIPAL
local MainTab = Window:CreateTab("Combat & Movement", 4483362458) -- Icono de espada

local Section = MainTab:CreateSection("Movement Functions")

MainTab:CreateButton({
   Name = "Super Speed (100)",
   Callback = function()
       game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 100
   end,
})

MainTab:CreateButton({
   Name = "Infinite Jump",
   Callback = function()
       game:GetService("UserInputService").JumpRequest:Connect(function()
           game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
       end)
   end,
})

-- SECCIÓN DE COMBATE
local CombatSection = MainTab:CreateSection("Combat Support")

MainTab:CreateToggle({
   Name = "NPC Aimlock",
   CurrentValue = false,
   Flag = "Toggle1", 
   Callback = function(Value)
       _G.Aimlock = Value
       while _G.Aimlock do
           local cam = workspace.CurrentCamera
           local target = nil
           local dist = math.huge
           for _, v in pairs(workspace:GetChildren()) do
               if v:IsA("Model") and v:FindFirstChild("Humanoid") and v ~= game.Players.LocalPlayer.Character then
                   local head = v:FindFirstChild("Head")
                   if head then
                       local pos, vis = cam:WorldToScreenPoint(head.Position)
                       if vis then
                           local mag = (Vector2.new(pos.X, pos.Y) - Vector2.new(cam.ViewportSize.X/2, cam.ViewportSize.Y/2)).Magnitude
                           if mag < dist then
                               dist = mag
                               target = head
                           end
                       end
                   end
               end
           end
           if target then
               cam.CFrame = CFrame.new(cam.CFrame.Position, target.Position)
           end
           task.wait()
       end
   end,
})

-- PESTAÑA DE CRÉDITOS
local MiscTab = Window:CreateTab("Misc", 4483362458)
MiscTab:CreateLabel("Script creado por AxelBladis")
MiscTab:CreateLabel("Compatible con Xeno Executor")

Rayfield:Notify({
   Title = "EJECUTADO!",
   Content = "Bienvenido a AxelBladis Hub V8",
   Duration = 5,
   Image = 4483362458,
   Actions = {
      Ignore = {
         Name = "Entendido!",
         Callback = function() print("AxelBladis Hub Listo") end
      },
   },
})
