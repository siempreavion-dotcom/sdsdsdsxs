-- ==========================================
-- AXELBLADIS HUB V7 - FONT FIXED & FULL
-- ==========================================

local CoreGui = game:GetService("CoreGui")
local UIS = game:GetService("UserInputService")

-- 1. Limpieza total de versiones anteriores
for _, v in pairs(CoreGui:GetChildren()) do
    if v.Name == "AxelHub_v6" or v.Name == "AxelHub_v7" then
        v:Destroy()
    end
end

-- 2. Creación del contenedor principal
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AxelHub_v7"
ScreenGui.Parent = CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.Position = UDim2.new(0.5, -100, 0.5, -125)
MainFrame.Size = UDim2.new(0, 200, 0, 250)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.BorderSizePixel = 2
MainFrame.BorderColor3 = Color3.fromRGB(255, 0, 0)

Instance.new("UICorner", MainFrame)

-- 3. Título corregido (Usando GothamBold)
local Title = Instance.new("TextLabel")
Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 0, 50)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold -- Fuente estándar compatible
Title.Text = "AXELBLADIS HUB"
Title.TextColor3 = Color3.fromRGB(255, 0, 0)
Title.TextSize = 20
Title.ZIndex = 10

-- 4. Función de creación de botones
local function CreateButton(txt, pos, color, callback)
    local btn = Instance.new("TextButton")
    btn.Parent = MainFrame
    btn.Size = UDim2.new(0.8, 0, 0, 40)
    btn.Position = pos
    btn.BackgroundColor3 = color
    btn.Font = Enum.Font.GothamBold
    btn.Text = txt
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 14
    btn.ZIndex = 11
    
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    btn.MouseButton1Click:Connect(callback)
    return btn
end

-- 5. Botones con funciones
CreateButton("SUPER SPEED", UDim2.new(0.1, 0, 0.25, 0), Color3.fromRGB(40, 40, 40), function()
    if game.Players.LocalPlayer.Character then
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 100
    end
end)

CreateButton("FLY (CLICK)", UDim2.new(0.1, 0, 0.45, 0), Color3.fromRGB(40, 40, 40), function()
    local p = game.Players.LocalPlayer
    local hrp = p.Character:FindFirstChild("HumanoidRootPart")
    if hrp then
        local bv = Instance.new("BodyVelocity", hrp)
        bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
        bv.Name = "AxelFlyForce"
        task.spawn(function()
            while bv.Parent do
                bv.Velocity = workspace.CurrentCamera.CFrame.LookVector * 100
                task.wait()
            end
        end)
    end
end)

CreateButton("CLOSE", UDim2.new(0.1, 0, 0.7, 0), Color3.fromRGB(100, 0, 0), function()
    ScreenGui:Destroy()
end)

-- Tecla L para ocultar
UIS.InputBegan:Connect(function(input, gpe)
    if not gpe and input.KeyCode == Enum.KeyCode.L then
        MainFrame.Visible = not MainFrame.Visible
    end
end)
