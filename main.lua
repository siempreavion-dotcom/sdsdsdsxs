-- AXEL HUB V2026 - FORCEHIT & CAMLOCK (DA HOOD / HOOD CUSTOMS)
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local CamlockBtn = Instance.new("TextButton")
local ForceHitBtn = Instance.new("TextButton")
local Status = Instance.new("TextLabel")

ScreenGui.Name = "AxelBypass"
ScreenGui.Parent = game.CoreGui

MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.Position = UDim2.new(0.05, 0, 0.4, 0)
MainFrame.Size = UDim2.new(0, 200, 0, 220)
MainFrame.Active = true
MainFrame.Draggable = true

Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Text = "AXEL HUB PRO V2026"
Title.TextColor3 = Color3.new(1, 0, 0)
Title.BackgroundColor3 = Color3.fromRGB(20, 20, 20)

-- Botón de Camlock
CamlockBtn.Parent = MainFrame
CamlockBtn.Position = UDim2.new(0.1, 0, 0.2, 0)
CamlockBtn.Size = UDim2.new(0.8, 0, 0, 35)
CamlockBtn.Text = "Camlock (OFF) [Q]"
CamlockBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
CamlockBtn.TextColor3 = Color3.new(1, 1, 1)

-- Botón de ForceHit (Silent Aim)
ForceHitBtn.Parent = MainFrame
ForceHitBtn.Position = UDim2.new(0.1, 0, 0.45, 0)
ForceHitBtn.Size = UDim2.new(0.8, 0, 0, 35)
ForceHitBtn.Text = "ForceHit (OFF)"
ForceHitBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
ForceHitBtn.TextColor3 = Color3.new(1, 1, 1)

Status.Parent = MainFrame
Status.Position = UDim2.new(0, 0, 0.85, 0)
Status.Size = UDim2.new(1, 0, 0, 20)
Status.Text = "Esperando Objetivo..."
Status.TextColor3 = Color3.new(1, 1, 1)
Status.TextScaled = true

-- VARIABLES GLOBALES
local Locking = false
local ForceHitEnabled = false
local Target = nil
local Prediction = 0.142 -- Basado en frezzy_src [cite: 23]
local SelectedPart = "HumanoidRootPart" -- [cite: 18]

local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera
local LocalPlayer = game.Players.LocalPlayer

-- Función para buscar al jugador más cercano al cursor [cite: 19, 20]
local function getClosestPlayer()
    local closestDist = math.huge
    local closestPlr = nil
    for _, v in ipairs(game.Players:GetPlayers()) do
        if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild(SelectedPart) then
            local pos, vis = Camera:WorldToViewportPoint(v.Character[SelectedPart].Position)
            if vis then
                local dist = (Vector2.new(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y) - Vector2.new(pos.X, pos.Y)).Magnitude
                if dist < closestDist then
                    closestDist = dist
                    closestPlr = v
                end
            end
        end
    end
    return closestPlr
end

-- Activación por Tecla Q
UserInputService.InputBegan:Connect(function(input, gpe)
    if not gpe and input.KeyCode == Enum.KeyCode.Q then
        Locking = not Locking
        if Locking then
            Target = getClosestPlayer()
            CamlockBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
            Status.Text = "Lock: " .. (Target and Target.DisplayName or "N/A")
        else
            Target = nil
            CamlockBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            Status.Text = "Libre"
        end
    end
end)

-- Activación de ForceHit
ForceHitBtn.MouseButton1Click:Connect(function()
    ForceHitEnabled = not ForceHitEnabled
    ForceHitBtn.Text = ForceHitEnabled and "ForceHit (ON)" or "ForceHit (OFF)"
    ForceHitBtn.BackgroundColor3 = ForceHitEnabled and Color3.fromRGB(150, 0, 0) or Color3.fromRGB(50, 50, 50)
end)

-- Lógica de Redirección (ForceHit + Camlock) [cite: 31, 32]
RunService.RenderStepped:Connect(function()
    if Locking and Target and Target.Character and Target.Character:FindFirstChild(SelectedPart) then
        local targetPart = Target.Character[SelectedPart]
        local predPos = targetPart.Position + (targetPart.Velocity * Prediction) -- Predicción avanzada [cite: 27]

        -- Si ForceHit está activo, forzamos que el mouse/bala vaya allí
        if ForceHitEnabled then
            -- Redirección silenciosa del CFrame de la cámara hacia el objetivo predicho 
            Camera.CFrame = Camera.CFrame:Lerp(CFrame.new(Camera.CFrame.Position, predPos), 0.6)
        else
            -- Solo Camlock normal
            Camera.CFrame = CFrame.new(Camera.CFrame.Position, targetPart.Position)
        end
    end
end)
