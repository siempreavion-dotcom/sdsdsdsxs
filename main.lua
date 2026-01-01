-- ==========================================
-- AXELBLADIS HUB - PRIVATE EDITION
-- ==========================================

local Library = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local Credit = Instance.new("TextLabel")
local Status = Instance.new("TextLabel")
local UICorner = Instance.new("UICorner")

-- Configuración de la Pantalla
Library.Name = "AxelHub"
Library.Parent = game.CoreGui
Library.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Marco Principal
MainFrame.Name = "MainFrame"
MainFrame.Parent = Library
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15) -- Negro Mate
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.5, -100, 0.5, -75)
MainFrame.Size = UDim2.new(0, 250, 0, 150)
MainFrame.Active = true
MainFrame.Draggable = true -- PUEDES MOVERLO CON EL MOUSE

UICorner.Parent = MainFrame

-- Título
Title.Parent = MainFrame
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(1, 0, 0, 50)
Title.Font = Enum.Font.Impact
Title.Text = "AXELBLADIS HUB"
Title.TextColor3 = Color3.fromRGB(255, 0, 0) -- ROJO
Title.TextSize = 24

-- Créditos
Credit.Parent = MainFrame
Credit.BackgroundTransparency = 1
Credit.Position = UDim2.new(0, 0, 0, 50)
Credit.Size = UDim2.new(1, 0, 0, 30)
Credit.Font = Enum.Font.SourceSansBold
Credit.Text = "Script Oficial de AxelBladis"
Credit.TextColor3 = Color3.fromRGB(255, 255, 255)
Credit.TextSize = 16

-- Estado
Status.Parent = MainFrame
Status.BackgroundTransparency = 1
Status.Position = UDim2.new(0, 0, 0, 100)
Status.Size = UDim2.new(1, 0, 0, 30)
Status.Font = Enum.Font.Code
Status.Text = "ESTADO: ACTIVO [v1.0]"
Status.TextColor3 = Color3.fromRGB(0, 255, 0) -- VERDE
Status.TextSize = 14

print("AxelBladis Hub ejecutado con exito!")

-- NOTIFICACIÓN DE BIENVENIDA
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "AXELBLADIS HUB",
    Text = "Cargado correctamente. ¡Disfruta!",
    Duration = 5
})
