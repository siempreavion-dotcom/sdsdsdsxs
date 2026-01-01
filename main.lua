-- AXELBLADIS HUB | CUSTOM KEYBIND EDITION
if game.CoreGui:FindFirstChild("Orion") then game.CoreGui:FindFirstChild("Orion"):Destroy() end

local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local Window = OrionLib:MakeWindow({
    Name = "AXELBLADIS HUB | DA HOOD", 
    HidePremium = false, 
    SaveConfig = true, 
    ConfigFolder = "AxelDH",
    IntroText = "Cargando Configuración de Teclas..."
})

-- VARIABLES DE CONTROL
local CamlockEnabled = false
local TargetPart = "Head"
local TargetPlayer = nil

-- LÓGICA DEL CAMLOCK
game:GetService("RunService").RenderStepped:Connect(function()
    if CamlockEnabled and TargetPlayer and TargetPlayer.Character and TargetPlayer.Character:FindFirstChild(TargetPart) then
        local CurrentCamera = workspace.CurrentCamera
        CurrentCamera.CFrame = CFrame.new(CurrentCamera.CFrame.Position, TargetPlayer.Character[TargetPart].Position)
    end
end)

-- PESTAÑA COMBATE
local Tab1 = Window:MakeTab({Name = "Combat", Icon = "rbxassetid://4483345998"})

Tab1:AddToggle({
    Name = "Camlock",
    Default = false,
    Callback = function(v)
        CamlockEnabled = v
        if v then
            local closestPlayer = nil
            local shortestDistance = math.huge
            for _, player in pairs(game.Players:GetPlayers()) do
                if player ~= game.Players.LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    local distance = (player.Character.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                    if distance < shortestDistance then
                        closestPlayer = player
                        shortestDistance = distance
                    end
                end
            end
            TargetPlayer = closestPlayer
        else
            TargetPlayer = nil
        end
    end    
})

-- PESTAÑA CONFIGURACIÓN (AQUÍ CAMBIAS LA TECLA)
local TabSet = Window:MakeTab({Name = "Settings", Icon = "rbxassetid://4483345998"})

TabSet:AddBind({
	Name = "Abrir/Cerrar Menú",
	Default = Enum.KeyCode.L, -- Tecla por defecto
	Hold = false,
	Callback = function()
		-- Esta función alterna la visibilidad del menú
        local gui = game.CoreGui:FindFirstChild("Orion")
        if gui then
            gui.Enabled = not gui.Enabled
        end
	end    
})

TabSet:AddButton({
	Name = "Destruir Script",
	Callback = function()
        OrionLib:Destroy()
	end    
})

-- PESTAÑA DEFENSA
local Tab2 = Window:MakeTab({Name = "Defense", Icon = "rbxassetid://4483345998"})

Tab2:AddToggle({
    Name = "Anti-Stomp",
    Default = false,
    Callback = function(v)
        _G.AntiStomp = v
        while _G.AntiStomp do task.wait()
            if game.Players.LocalPlayer.Character.Humanoid.Health <= 5 then
                game.Players.LocalPlayer.Character:BreakJoints()
            end
        end
    end    
})

OrionLib:Init()
