-- AXELBLADIS BYPASS 2026 - DA HOOD VERSION
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local CamlockBtn = Instance.new("TextButton")
local AntiStompBtn = Instance.new("TextButton")
local Status = Instance.new("TextLabel")

-- Configuración de UI Minimalista (Difícil de detectar)
ScreenGui.Name = "AxelBypass"
ScreenGui.Parent = game.CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.Position = UDim2.new(0.05, 0, 0.4, 0)
MainFrame.Size = UDim2.new(0, 180, 0, 220)
MainFrame.Active = true
MainFrame.Draggable = true

Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Text = "AXEL HUB V2026"
Title.TextColor3 = Color3.new(1, 0, 0)
Title.BackgroundColor3 = Color3.fromRGB(20, 20, 20)

-- FUNCIÓN CAMLOCK (Tecla Q para Lock)
local Locking = false
local Target = nil
CamlockBtn.Parent = MainFrame
CamlockBtn.Position = UDim2.new(0.1, 0, 0.25, 0)
CamlockBtn.Size = UDim2.new(0.8, 0, 0, 35)
CamlockBtn.Text = "Camlock (OFF)"
CamlockBtn.Callback = function() end -- Placeholder

CamlockBtn.MouseButton1Click:Connect(function()
    Locking = not Locking
    CamlockBtn.Text = Locking and "Camlock (ON)" or "Camlock (OFF)"
end)

game:GetService("RunService").RenderStepped:Connect(function()
    if Locking then
        local shortestDistance = math.huge
        for _, v in pairs(game.Players:GetPlayers()) do
            if v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild("Head") then
                local pos = workspace.CurrentCamera:WorldToViewportPoint(v.Character.Head.Position)
                local dist = (Vector2.new(pos.X, pos.Y) - Vector2.new(workspace.CurrentCamera.ViewportSize.X/2, workspace.CurrentCamera.ViewportSize.Y/2)).Magnitude
                if dist < shortestDistance then
                    shortestDistance = dist
                    Target = v
                end
            end
        end
        if Target and Target.Character then
            workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, Target.Character.Head.Position)
        end
    end
end)

-- FUNCIÓN ANTISTOMP
local AntiStomp = false
AntiStompBtn.Parent = MainFrame
AntiStompBtn.Position = UDim2.new(0.1, 0, 0.5, 0)
AntiStompBtn.Size = UDim2.new(0.8, 0, 0, 35)
AntiStompBtn.Text = "Anti-Stomp"
AntiStompBtn.MouseButton1Click:Connect(function()
    AntiStomp = not AntiStomp
    Status.Text = AntiStomp and "Anti-Stomp: Activado" or "Anti-Stomp: Desactivado"
    while AntiStomp do
        task.wait()
        if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
            if game.Players.LocalPlayer.Character.Humanoid.Health <= 5 then
                game.Players.LocalPlayer.Character:BreakJoints()
            end
        end
    end
end)

-- SISTEMA DE TECLA (KEYBIND PARA CERRAR)
local OpenCloseKey = Enum.KeyCode.L
game:GetService("UserInputService").InputBegan:Connect(function(input, gpe)
    if not gpe and input.KeyCode == OpenCloseKey then
        MainFrame.Visible = not MainFrame.Visible
    end
end)

Status.Parent = MainFrame
Status.Position = UDim2.new(0, 0, 0.85, 0)
Status.Size = UDim2.new(1, 0, 0, 20)
Status.Text = "Presiona L para Ocultar"
Status.TextColor3 = Color3.new(1, 1, 1)
Status.TextScaled = true
