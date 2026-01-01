-- AXEL HUB PRO V2026 - TRACER & FORCEHIT REFORZADO 
local LocalPlayer = game:GetService("Players").LocalPlayer [cite: 1]
local RunService = game:GetService("RunService") [cite: 1]
local UserInputService = game:GetService("UserInputService") [cite: 1]
local Camera = workspace.CurrentCamera [cite: 1]

-- INTERFAZ
local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 220, 0, 280)
MainFrame.Position = UDim2.new(0.05, 0, 0.4, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(25 MainFrame.Active = true
MainFrame.Draggable = true

local Status = Instance.new("TextLabel", MainFrame)
Status.Size = UDim2.new(1, 0, 0, 50)
Status.Position = UDim2.new(0, 0, 0.8, 0)
Status.TextColor3 = Color3.new(1, 1, 1)
Status.Text = "Target: Ninguno\nForceHit: OFF"

-- ELEMENTOS VISUALES (Basado en lógica de dibujo) 
local Tracer = Drawing.new("Line")
Tracer.Color = Color3.fromRGB(255, 0, 0)
Tracer.Thickness = 1.5
Tracer.Visible = false

-- VARIABLES DE CONTROL
local Locking = false
local ForceHitEnabled = false
local Target = nil
local Prediction = 0.142 -- Ajuste para Da Hood/Hood Customs 

-- TECLAS
local CamlockKey = Enum.KeyCode.Q
local ForceHitKey = Enum.KeyCode.Z

-- FUNCIÓN PARA OBTENER OBJETIVO (Cercano al centro de pantalla) 
local function GetClosest()
    local Nearest = nil
    local LastDist = math.huge
    for _, v in pairs(game.Players:GetPlayers()) do
        if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
            local Pos, Visible = Camera:WorldToViewportPoint(v.Character.HumanoidRootPart.Position)
            if Visible then
                local Dist = (Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2) - Vector2.new(Pos.X, Pos.Y)).Magnitude
                if Dist < LastDist then
                    LastDist = Dist
                    Nearest = v
                end
            end
        end
    end
    return Nearest
end

-- DETECCIÓN DE TECLAS 
UserInputService.InputBegan:Connect(function(input, processed)
    if processed then return end
    
    -- Manejo Camlock (Q)
    if input.KeyCode == CamlockKey then
        Locking = not Locking
        if Locking then
            Target = GetClosest()
        else
            Target = nil
            Tracer.Visible = false
        end
    end

    -- Manejo ForceHit (Z)
    if input.KeyCode == ForceHitKey then
        ForceHitEnabled = not ForceHitEnabled
        -- Actualizar UI instantáneamente
        Status.Text = "Target: " .. (Target and Target.Name or "Ninguno") .. "\nForceHit: " .. (ForceHitEnabled and "ON" or "OFF")
    end
end)

-- RENDERIZADO (Cada Frame) 
RunService.RenderStepped:Connect(function()
    if Locking and Target and Target.Character and Target.Character:FindFirstChild("HumanoidRootPart") then
        local Root = Target.Character.HumanoidRootPart
        local PredPos = Root.Position + (Root.Velocity * Prediction) [cite: 1]
        local ScreenPos, OnScreen = Camera:WorldToViewportPoint(PredPos)

        -- Actualizar Status
        Status.Text = "Target: " .. Target.Name .. "\nForceHit: " .. (ForceHitEnabled and "ON" or "OFF")

        -- Dibujar Tracer
        if OnScreen then
            Tracer.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
            Tracer.To = Vector2.new(ScreenPos.X, ScreenPos.Y)
            Tracer.Visible = true
        else
            Tracer.Visible = false
        end

        -- Aplicar ForceHit (CFrame Lerp) 
        if ForceHitEnabled then
            Camera.CFrame = Camera.CFrame:Lerp(CFrame.new(Camera.CFrame.Position, PredPos), 0.4)
        end
    else
        Tracer.Visible = false
        Status.Text = "Target: Ninguno\nForceHit: " .. (ForceHitEnabled and "ON" or "OFF")
    end
end)
