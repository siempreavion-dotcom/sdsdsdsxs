-- AXEL HUB V2026 - CAMLOCK REFORZADO
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
MainFrame.Size = UDim2.new(0, 180, 0, 150)
MainFrame.Active = true
MainFrame.Draggable = true

Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Text = "AXEL HUB V2026"
Title.TextColor3 = Color3.new(1, 0, 0)
Title.BackgroundColor3 = Color3.fromRGB(20, 20, 20)

CamlockBtn.Parent = MainFrame
CamlockBtn.Position = UDim2.new(0.1, 0, 0.3, 0)
CamlockBtn.Size = UDim2.new(0.8, 0, 0, 40)
CamlockBtn.Text = "Camlock (OFF) [Q]"
CamlockBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
CamlockBtn.TextColor3 = Color3.new(1, 1, 1)

Status.Parent = MainFrame
Status.Position = UDim2.new(0, 0, 0.8, 0)
Status.Size = UDim2.new(1, 0, 0, 20)
Status.Text = "Presiona Q para Lockear"
Status.TextColor3 = Color3.new(1, 1, 1)
Status.TextScaled = true

-- LÓGICA DE CAMLOCK REFORZADA
local Locking = false
local Target = nil
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera

local function getClosestPlayer()
    local closestPlayer = nil
    local shortestDistance = math.huge
    for _, v in pairs(game.Players:GetPlayers()) do
        if v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild("Head") then
            local pos, onScreen = Camera:WorldToViewportPoint(v.Character.Head.Position)
            if onScreen then
                local dist = (Vector2.new(pos.X, pos.Y) - Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)).Magnitude
                if dist < shortestDistance then
                    shortestDistance = dist
                    closestPlayer = v
                end
            end
        end
    end
    return closestPlayer
end

-- Detección de Tecla Q
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.Q then
        Locking = not Locking
        if Locking then
            Target = getClosestPlayer()
            if Target then
                CamlockBtn.Text = "Lock: " .. Target.Name
                CamlockBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
            end
        else
            Target = nil
            CamlockBtn.Text = "Camlock (OFF) [Q]"
            CamlockBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        end
    end
end)

-- Bucle de renderizado para forzar la cámara
RunService.RenderStepped:Connect(function()
    if Locking and Target and Target.Character and Target.Character:FindFirstChild("Head") then
        -- Forzamos el CFrame de la cámara para que mire al objetivo
        Camera.CFrame = CFrame.new(Camera.CFrame.Position, Target.Character.Head.Position)
    end
end)
