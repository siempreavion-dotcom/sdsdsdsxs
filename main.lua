-- AXEL HUB PRO V2026 - CUSTOM KEYBINDS & TARGET VISUALS
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
MainFrame.Size = UDim2.new(0, 220, 0, 280)
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
local Prediction = 0.142 [cite: 23]
local SelectedPart = "HumanoidRootPart" [cite: 18]

-- TECLAS POR DEFECTO (Puedes cambiarlas haciendo clic en el script o editando aquí)
local CamlockKey = Enum.KeyCode.Q
local ForceHitKey = Enum.KeyCode.Z -- Tecla para el ForceHit

-- ELEMENTOS VISUALES (Copiado de la lógica de Freezy)
local TracerLine = Drawing.new("Line") [cite: 18]
TracerLine.Color = Color3.fromRGB(255, 0, 0)
TracerLine.Thickness = 2
TracerLine.Visible = false

-- BOTONES DE LA INTERFAZ
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
Status.Position = UDim2.new(0, 0, 0.8, 0)
Status.Size = UDim2.new(1, 0, 0, 40)
Status.Text = "Target: Ninguno\n[Q] Lock | [Z] Force"
Status.TextColor3 = Color3.new(1, 1, 1)
Status.TextScaled = true

-- LÓGICA DE DETECCIÓN Y VISUALES
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera
local LocalPlayer = game.Players.LocalPlayer

local function getClosestPlayer()
    local closestDist = math.huge
    local closestPlr = nil
    for _, v in ipairs(game.Players:GetPlayers()) do
        if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild(SelectedPart) then
            local pos, vis = Camera:WorldToViewportPoint(v.Character[SelectedPart].Position) [cite: 19]
            if vis then
                local dist = (Vector2.new(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y) - Vector2.new(pos.X, pos.Y)).Magnitude [cite: 20]
                if dist < closestDist then
                    closestDist = dist
                    closestPlr = v
                end
            end
        end
    end
    return closestPlr
end

-- MANEJO DE TECLAS PERSONALIZADAS
UserInputService.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    
    -- Activar Camlock
    if input.KeyCode == CamlockKey then
        Locking = not Locking
        if Locking then
            Target = getClosestPlayer()
            CamlockBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 255)
        else
            Target = nil
            CamlockBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            TracerLine.Visible = false
        end
    end

    -- Activar ForceHit
    if input.KeyCode == ForceHitKey then
        ForceHitEnabled = not ForceHitEnabled
        ForceHitBtn.BackgroundColor3 = ForceHitEnabled and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(50, 50, 50)
    end
end)

-- BUCLE PRINCIPAL (RENDERSTEPPED)
RunService.RenderStepped:Connect(function()
    if Locking and Target and Target.Character and Target.Character:FindFirstChild(SelectedPart) then
        local part = Target.Character[SelectedPart]
        local predPos = part.Position + (part.Velocity * Prediction) [cite: 27, 32]
        local screenPos, onScreen = Camera:WorldToViewportPoint(predPos) [cite: 33]

        -- Actualizar Status y Línea Tracer (Targeting Visual)
        Status.Text = "Target: " .. Target.DisplayName .. "\nForce: " .. (ForceHitEnabled and "ON" or "OFF")
        
        if onScreen then
            TracerLine.From = Vector2.new(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y) [cite: 33]
            TracerLine.To = Vector2.new(screenPos.X, screenPos.Y) [cite: 33]
            TracerLine.Visible = true [cite: 33]
        else
            TracerLine.Visible = false
        end

        -- Movimiento de Cámara
        if ForceHitEnabled then
            Camera.CFrame = Camera.CFrame:Lerp(CFrame.new(Camera.CFrame.Position, predPos), 0.5) [cite: 32]
        else
            Camera.CFrame = CFrame.new(Camera.CFrame.Position, part.Position) [cite: 32]
        end
    else
        TracerLine.Visible = false
        Status.Text = "Target: Ninguno\n[Q] Lock | [Z] Force"
    end
end)
