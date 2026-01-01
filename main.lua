-- ==========================================
-- AXELBLADIS HUB V3 - PRO EDITION
-- ==========================================

local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local SpeedBtn = Instance.new("TextButton")
local FlyBtn = Instance.new("TextButton")
local AimBtn = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")

-- Setup de la Interfaz
ScreenGui.Name = "AxelHub"
ScreenGui.Parent = game.CoreGui
ScreenGui.ResetOnSpawn = false

MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.Position = UDim2.new(0.5, -110, 0.5, -150)
MainFrame.Size = UDim2.new(0, 220, 0, 300)
MainFrame.Active = true
MainFrame.Draggable = true

UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = MainFrame

-- TÍTULO VISIBLE
Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 0, 60)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.Impact
Title.Text = "AXELBLADIS HUB"
Title.TextColor3 = Color3.fromRGB(255, 0, 0)
Title.TextSize = 28
Title.ZIndex = 2

-- FUNCIÓN PARA OCULTAR CON TECLA (L)
local UserInputService = game:GetService("UserInputService")
local visible = true

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.L then
        visible = not visible
        MainFrame.Visible = visible
    end
end)

-- ESTILO DE BOTONES (Función interna)
local function CreateButton(name, text, pos, color)
    local btn = Instance.new("TextButton")
    btn.Name = name
    btn.Parent = MainFrame
    btn.BackgroundColor3 = color
    btn.Position = pos
    btn.Size = UDim2.new(0.8, 0, 0, 45)
    btn.Font = Enum.Font.SourceSansBold
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 18
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 8)
    btnCorner.Parent = btn
    return btn
end

-- CREAR BOTONES
local SpeedBtn = CreateButton("SpeedBtn", "SUPER SPEED", UDim2.new(0.1, 0, 0.25, 0), Color3.fromRGB(40, 40, 40))
local FlyBtn = CreateButton("FlyBtn", "FLY SYSTEM", UDim2.new(0.1, 0, 0.45, 0), Color3.fromRGB(40, 40, 40))
local AimBtn = CreateButton("AimBtn", "NPC AIMLOCK", UDim2.new(0.1, 0, 0.65, 0), Color3.fromRGB(60, 20, 20))

-- LÓGICA: SUPER SPEED
SpeedBtn.MouseButton1Click:Connect(function()
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 120
end)

-- LÓGICA: FLY
local flying = false
FlyBtn.MouseButton1Click:Connect(function()
    flying = not flying
    local player = game.Players.LocalPlayer
    local char = player.Character or player.CharacterAdded:Wait()
    local root = char:WaitForChild("HumanoidRootPart")
    
    if flying then
        local bg = Instance.new("BodyGyro", root)
        bg.P = 9e4
        bg.maxTorque = Vector3.new(9e9, 9e9, 9e9)
        bg.cframe = root.CFrame
        bg.Name = "AxelGyro"
        
        local bv = Instance.new("BodyVelocity", root)
        bv.velocity = Vector3.new(0, 0.1, 0)
        bv.maxForce = Vector3.new(9e9, 9e9, 9e9)
        bv.Name = "AxelVel"
        
        task.spawn(function()
            while flying do
                bv.velocity = game.Workspace.CurrentCamera.CFrame.LookVector * 100
                bg.cframe = game.Workspace.CurrentCamera.CFrame
                task.wait()
            end
            bg:Destroy()
            bv:Destroy()
        end)
    end
end)

-- LÓGICA: NPC AIMLOCK (Básico)
AimBtn.MouseButton1Click:Connect(function()
    local cam = game.Workspace.CurrentCamera
    local player = game.Players.LocalPlayer
    
    local function getClosestNPC()
        local closest = nil
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
                            closest = head
                        end
                    end
                end
            end
        end
        return closest
    end

    game:GetService("RunService").RenderStepped:Connect(function()
        if visible then -- Solo apunta si el menú está activo o podrías poner otra condición
            local target = getClosestNPC()
            if target then
                cam.CFrame = CFrame.new(cam.CFrame.Position, target.Position)
            end
        end
    end)
end)

print("AxelBladis Hub V3 Cargado! Presiona 'L' para ocultar.")
