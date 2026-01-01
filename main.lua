-- AXEL HUB PRO V2026 - FIX FORCEHIT & TRACERS
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local CamlockBtn = Instance.new("TextButton")
local ForceHitBtn = Instance.new("TextButton")
local Status = Instance.new("TextLabel")

-- Configuración de UI
ScreenGui.Name = "AxelBypass"
ScreenGui.Parent = game.CoreGui
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.Position = UDim2.new(0.05, 0, 0.4, 0)
MainFrame.Size = UDim2.new(0, 220, 0, 300)
MainFrame.Active = true
MainFrame.Draggable = true

Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Text = "AXEL HUB PRO V2026"
Title.TextColor3 = Color3.new(1, 0, 0)
Title.BackgroundColor3 = Color3.fromRGB(20, 20, 20)

-- VARIABLES DE TECLAS Y ESTADO
local Locking = false
local ForceHitEnabled = false
local Target = nil
local Prediction = 0.142 -- Basado en lógica de Freezy 
local SelectedPart = "HumanoidRootPart"

-- TECLAS PERSONALIZABLES
local CamlockKey = Enum.KeyCode.Q
local ForceHitKey = Enum.KeyCode.Z

-- DIBUJO DEL TRACER (LÍNEA)
local Tracer = Drawing.new("Line")
Tracer.Color = Color3.fromRGB(255, 0, 0)
Tracer.Thickness = 1.5
Tracer.Visible = false

-- BOTONES
CamlockBtn.Parent = MainFrame
CamlockBtn.Position = UDim2.new(0.1, 0, 0.2, 0)
CamlockBtn.Size = UDim2.new(0.8, 0, 0, 35)
CamlockBtn.Text = "Camlock Key: Q"
CamlockBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)

ForceHitBtn.Parent = MainFrame
ForceHitBtn.Position = UDim2.new(0.1, 0, 0.4, 0)
ForceHitBtn.Size = UDim2.new(0.8, 0, 0, 35)
ForceHitBtn.Text = "ForceHit Key: Z"
ForceHitBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)

Status.Parent = MainFrame
Status.Position = UDim2.new(0, 0, 0.75, 0)
Status.Size = UDim2.new(1, 0, 0, 60)
Status.Text = "Target: Ninguno\nForce: OFF"
Status.TextColor3 = Color3.new(1, 1, 1)
Status.TextSize = 18

local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera
local LocalPlayer = game.Players.LocalPlayer

-- Función para buscar al jugador más cercano
local function getClosest()
    local nearest = nil
    local lastDist = math.huge
    for _, v in pairs(game.Players:GetPlayers()) do
        if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild(SelectedPart) then
            local pos, vis = Camera:WorldToViewportPoint(v.Character[SelectedPart].Position)
            if vis then
                local dist = (Vector2.new(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y) - Vector2.new(pos.X, pos.Y)).Magnitude
                if dist < lastDist then
                    lastDist = dist
                    nearest = v
                end
            end
        end
    end
    return nearest
end

-- Manejo de Teclas
UserInputService.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    
    if input.KeyCode == CamlockKey then
        Locking = not Locking
        if Locking then
            Target = getClosest()
            CamlockBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 255)
        else
            Target = nil
            CamlockBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            Tracer.Visible = false
        end
    end

    if input.KeyCode == ForceHitKey then
        ForceHitEnabled = not ForceHitEnabled
        ForceHitBtn.BackgroundColor3 = ForceHitEnabled and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(50, 50, 50)
    end
end)

-- Bucle Principal (Fix de Visibilidad y Target)
RunService.RenderStepped:Connect(function()
    if Locking and Target and Target.Character and Target.Character:FindFirstChild(SelectedPart) then
        local root = Target.Character[SelectedPart]
        local predPos = root.Position + (root.Velocity * Prediction)
        local screenPos, onScreen = Camera:WorldToViewportPoint(predPos)

        -- Actualizar Status y Tracer
        Status.Text = "Targeting: " .. Target.Name .. "\nForce: " .. (ForceHitEnabled and "ON" or "OFF")
        
        if onScreen then
            Tracer.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
            Tracer.To = Vector2.new(screenPos.X, screenPos.Y)
            Tracer.Visible = true
        else
            Tracer.Visible = false
        end

        -- Lógica de Movimiento
        if ForceHitEnabled then
            -- Movimiento agresivo de cámara hacia la predicción 
            Camera.CFrame = Camera.CFrame:Lerp(CFrame.new(Camera.CFrame.Position, predPos), 0.4)
        else
            -- Seguimiento suave
            Camera.CFrame = CFrame.new(Camera.CFrame.Position, root.Position)
        end
    else
        Tracer.Visible = false
        Status.Text = "Target: Ninguno\nForce: " .. (ForceHitEnabled and "ON" or "OFF")
    end
end)
