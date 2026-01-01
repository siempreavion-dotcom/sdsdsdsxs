-- ==========================================
-- AXELBLADIS HUB V5 - FINAL BASEPLATE FIX
-- ==========================================

local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")

-- Eliminar versiones antiguas para evitar duplicados
if CoreGui:FindFirstChild("AxelHub_v5") then
    CoreGui:FindFirstChild("AxelHub_v5"):Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AxelHub_v5"
ScreenGui.Parent = CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20) -- Gris muy oscuro
MainFrame.Position = UDim2.new(0.5, -100, 0.5, -125)
MainFrame.Size = UDim2.new(0, 200, 0, 250)
MainFrame.Active = true
MainFrame.Draggable = true -- Movible con el mouse

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = MainFrame

-- TÍTULO ROJO
local Title = Instance.new("TextLabel")
Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 0, 50)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.Impact
Title.Text = "AXELBLADIS HUB"
Title.TextColor3 = Color3.fromRGB(255, 0, 0)
Title.TextSize = 24
Title.ZIndex = 2

-- FUNCIÓN CREAR BOTÓN VISIBLE
local function CreateButton(txt, pos, callback)
    local btn = Instance.new("TextButton")
    btn.Parent = MainFrame
    btn.Size = UDim2.new(0.8, 0, 0, 40)
    btn.Position = pos
    btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60) -- Gris claro para contraste
    btn.Font = Enum.Font.SourceSansBold
    btn.Text = txt
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 16
    btn.ZIndex = 3
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = btn
    
    btn.MouseButton1Click:Connect(callback)
    return btn
end

-- BOTONES
CreateButton("SUPER SPEED", UDim2.new(0.1, 0, 0.25, 0), function()
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 100
end)

CreateButton("FLY (MOUSE)", UDim2.new(0.1, 0, 0.45, 0), function()
    local p = game.Players.LocalPlayer
    local c = p.Character
    local hrp = c.HumanoidRootPart
    local bv = Instance.new("BodyVelocity", hrp)
    bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
    spawn(function()
        while wait() do
            bv.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * 100
        end
    end)
end)

CreateButton("NPC AIMLOCK", UDim2.new(0.1, 0, 0.65, 0), function()
    print("Aimlock activado")
    -- (Lógica de Aimlock aquí)
end)

-- TECLA "L" PARA OCULTAR
UserInputService.InputBegan:Connect(function(input, processed)
    if not processed and input.KeyCode == Enum.KeyCode.L then
        MainFrame.Visible = not MainFrame.Visible
    end
end)

print("AxelBladis Hub v5 cargado exitosamente.")
