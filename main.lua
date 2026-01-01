-- ==========================================
-- AXELBLADIS HUB V3 - FIXED & PRO
-- ==========================================

local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local SpeedBtn = Instance.new("TextButton")
local FlyBtn = Instance.new("TextButton")
local AimBtn = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")

-- Setup de la Interfaz (Cambiado a CoreGui para evitar errores)
ScreenGui.Name = "AxelHubSystem"
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ResetOnSpawn = false

-- Marco Principal
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.Position = UDim2.new(0.5, -110, 0.5, -150)
MainFrame.Size = UDim2.new(0, 220, 0, 300)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.ZIndex = 1

UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = MainFrame

-- TÍTULO FORZADO AL FRENTE (Color Blanco para que se vea sí o sí)
Title.Name = "AxelTitle"
Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 0, 60)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.Impact
Title.Text = "AXELBLADIS HUB"
Title.TextColor3 = Color3.fromRGB(255, 255, 255) -- Blanco brillante
Title.TextSize = 28
Title.ZIndex = 5 -- Esto lo pone al frente de todo

-- OCULTAR/MOSTRAR CON TECLA "L"
local UserInputService = game:GetService("UserInputService")
local isVisible = true

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.L then
        isVisible = not isVisible
        MainFrame.Visible = isVisible
    end
end)

-- FUNCIÓN PARA BOTONES PRO
local function CreateButton(name, text, pos)
    local btn = Instance.new("TextButton")
    btn.Name = name
    btn.Parent = MainFrame
    btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    btn.Position = pos
    btn.Size = UDim2.new(0.8, 0, 0, 45)
    btn.Font = Enum.Font.SourceSansBold
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 18
    btn.ZIndex = 3
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 8)
    btnCorner.Parent = btn
    return btn
end

-- CREAR BOTONES
local SpeedBtn = CreateButton("SpeedBtn", "SPEED (100)", UDim2.new(0.1, 0, 0.25, 0))
local FlyBtn = CreateButton("FlyBtn", "FLY (MOUSE)", UDim2.new(0.1, 0, 0.45, 0))
local AimBtn = CreateButton("AimBtn", "NPC AIMLOCK", UDim2.new(0.1, 0, 0.65, 0))

-- LÓGICA: SUPER SPEED
SpeedBtn.MouseButton1Click:Connect(function()
    if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 100
    end
end)

-- LÓGICA: FLY
local flying = false
FlyBtn.MouseButton1Click:Connect(function()
    flying = not flying
    local player = game.Players.LocalPlayer
    local char = player.Character or player.CharacterAdded:Wait()
    local root = char:WaitForChild("HumanoidRootPart")
    
    if flying then
        local bv = Instance.new("BodyVelocity", root)
        bv.velocity = Vector3.new(0, 0, 0)
        bv.maxForce = Vector3.new(9e9, 9e9, 9e9)
        bv.Name = "AxelVelocity"
        
        task.spawn(function()
            while flying do
                bv.velocity = game.Workspace.CurrentCamera.CFrame.LookVector * 100
                task.wait()
            end
            bv:Destroy()
        end)
    end
end)

-- LÓGICA: NPC AIMLOCK
AimBtn.MouseButton1Click:Connect(function()
    local cam = game.Workspace.CurrentCamera
    local player = game.Players.LocalPlayer
    
    game:GetService("RunService").RenderStepped:Connect(function()
        local target = nil
        local dist = math.huge
        
        for _, v in pairs(game.Workspace:GetChildren()) do
            if v:IsA("Model") and v:FindFirstChild("Humanoid") and v ~= player.Character then
                local head = v:FindFirstChild("Head")
                if head then
                    local pos, onScreen = cam:WorldToScreenPoint(head.Position)
                    if onScreen then
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
    end)
end)

print("AxelBladis Hub Cargado! Presiona L para cerrar.")
