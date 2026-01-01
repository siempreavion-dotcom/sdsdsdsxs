-- AXEL HUB V2026 - ADVANCED CAMLOCK (FREEZY STYLE)
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local CamlockBtn = Instance.new("TextButton")
local Status = Instance.new("TextLabel")

ScreenGui.Name = "AxelBypass"
ScreenGui.Parent = game.CoreGui

MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.Position = UDim2.new(0.05, 0, 0.4, 0)
MainFrame.Size = UDim2.new(0, 180, 0, 180)
MainFrame.Active = true
MainFrame.Draggable = true

Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Text = "AXEL HUB PRO 2026"
Title.TextColor3 = Color3.new(1, 0, 0)
Title.BackgroundColor3 = Color3.fromRGB(20, 20, 20)

CamlockBtn.Parent = MainFrame
CamlockBtn.Position = UDim2.new(0.1, 0, 0.25, 0)
CamlockBtn.Size = UDim2.new(0.8, 0, 0, 40)
CamlockBtn.Text = "Camlock (OFF) [Q]"
CamlockBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
CamlockBtn.TextColor3 = Color3.new(1, 1, 1)

Status.Parent = MainFrame
Status.Position = UDim2.new(0, 0, 0.85, 0)
Status.Size = UDim2.new(1, 0, 0, 20)
Status.Text = "Locking: Ninguno"
Status.TextColor3 = Color3.new(1, 1, 1)
Status.TextScaled = true

-- CONFIGURACIÓN AVANZADA (Basada en Frezzy)
local Locking = false
local Target = nil
local PredictionVelocity = 0.142 -- Ajuste para Da Hood [cite: 64]
local SelectedPart = "HumanoidRootPart" -- Parte del cuerpo [cite: 59]
local Sensitivity = 0.5 -- Suavizado [cite: 64]

local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera
local LocalPlayer = game.Players.LocalPlayer

-- Función para encontrar al jugador más cercano al cursor (Lógica Frezzy) [cite: 60]
local function getClosestPlayerToCursor()
    local closestDist = math.huge
    local closestPlr = nil
    for _, v in ipairs(game.Players:GetPlayers()) do
        if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health > 0 then
            local screenPos, cameraVisible = Camera:WorldToViewportPoint(v.Character[SelectedPart].Position)
            if cameraVisible then
                local distToMouse = (Vector2.new(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y) - Vector2.new(screenPos.X, screenPos.Y)).Magnitude
                if distToMouse < closestDist then
                    closestPlr = v
                    closestDist = distToMouse
                end
            end
        end
    end
    return closestPlr
end

-- Detección de Tecla Q (Vínculo de Tecla)
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.Q then
        Locking = not Locking
        if Locking then
            Target = getClosestPlayerToCursor()
            if Target then
                CamlockBtn.Text = "LOCK: " .. Target.DisplayName
                CamlockBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
                Status.Text = "Objetivo: " .. Target.Name
            end
        else
            Target = nil
            CamlockBtn.Text = "Camlock (OFF) [Q]"
            CamlockBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            Status.Text = "Fijado Desactivado"
        end
    end
end)

-- Bucle de renderizado con PREDICCIÓN (Lógica Frezzy) 
RunService.RenderStepped:Connect(function()
    if Locking and Target and Target.Character and Target.Character:FindFirstChild(SelectedPart) then
        local part = Target.Character[SelectedPart]
        
        -- Verificación de K.O. (Para que no apunte a gente muerta) 
        local bodyEffects = Target.Character:FindFirstChild("BodyEffects")
        if bodyEffects and bodyEffects:FindFirstChild("K.O") and bodyEffects["K.O"].Value then
            Locking = false
            Target = nil
            return
        end

        -- Lógica de Predicción: Calcula dónde estará el enemigo según su velocidad 
        local predictionOffset = part.Velocity * PredictionVelocity
        local targetPos = part.Position + predictionOffset

        -- Suavizado (Lerp) para que la cámara no salte bruscamente 
        Camera.CFrame = Camera.CFrame:Lerp(CFrame.new(Camera.CFrame.Position, targetPos), Sensitivity)
    end
end)
