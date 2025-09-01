--// Adonis bypass (твоя часть)
local getinfo = getinfo or debug.getinfo
local DEBUG = false
local Hooked = {}

local Detected, Kill

setthreadidentity(2)

for i, v in getgc(true) do
    if typeof(v) == "table" then
        local DetectFunc = rawget(v, "Detected")
        local KillFunc = rawget(v, "Kill")

        if typeof(DetectFunc) == "function" and not Detected then
            Detected = DetectFunc

            local Old; Old = hookfunction(Detected, function(Action, Info, NoCrash)
                if Action ~= "_" then
                    if DEBUG then
                        warn(string.format("Adonis AntiCheat flagged\nMethod: %s\nInfo: %s", Action, Info))
                    end
                end

                return true
            end)

            table.insert(Hooked, Detected)
        end

        if rawget(v, "Variables") and rawget(v, "Process") and typeof(KillFunc) == "function" and not Kill then
            Kill = KillFunc
            local Old; Old = hookfunction(Kill, function(Info)
                if DEBUG then
                    warn(string.format("Adonis AntiCheat tried to kill (fallback): %s", Info))
                end
            end)

            table.insert(Hooked, Kill)
        end
    end
end

local Old; Old = hookfunction(getrenv().debug.info, newcclosure(function(...)
    local LevelOrFunc, Info = ...

    if Detected and LevelOrFunc == Detected then
        if DEBUG then
            warn("Adonis AntiCheat sanity check detected and broken")
        end

        return coroutine.yield(coroutine.running())
    end

    return Old(...)
end))

setthreadidentity(7)

--// Sandak Province Hub
local plr = game.Players.LocalPlayer
local PlayerGui = plr:WaitForChild("PlayerGui")

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SandakHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = PlayerGui

-- Главное окно
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 420, 0, 300)
MainFrame.Position = UDim2.new(0.5, -210, 0.5, -150)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true -- dragable
MainFrame.Parent = ScreenGui

-- Заголовок
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -100, 0, 40)
Title.BackgroundTransparency = 1
Title.Text = "SANDAK Province | Сандак Хаб"
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 20
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Position = UDim2.new(0, 10, 0, 0)
Title.Parent = MainFrame

-- Кнопка закрыть
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 40, 0, 40)
CloseBtn.Position = UDim2.new(1, -40, 0, 0)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
CloseBtn.Parent = MainFrame

-- Кнопка свернуть
local MinimizeBtn = Instance.new("TextButton")
MinimizeBtn.Size = UDim2.new(0, 40, 0, 40)
MinimizeBtn.Position = UDim2.new(1, -80, 0, 0)
MinimizeBtn.Text = "-"
MinimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
MinimizeBtn.Parent = MainFrame

-- Скроллинг для кнопок
local Scroll = Instance.new("ScrollingFrame")
Scroll.Size = UDim2.new(1, -20, 1, -60)
Scroll.Position = UDim2.new(0, 10, 0, 50)
Scroll.CanvasSize = UDim2.new(0,0,2,0) -- подгонится автоматом
Scroll.ScrollBarThickness = 6
Scroll.BackgroundTransparency = 1
Scroll.Parent = MainFrame

-- UIList для аккуратного списка
local UIList = Instance.new("UIListLayout")
UIList.Padding = UDim.new(0, 5)
UIList.FillDirection = Enum.FillDirection.Vertical
UIList.Parent = Scroll

-- Круглая кнопка (свёрнутое меню)
local MiniBtn = Instance.new("TextButton")
MiniBtn.Size = UDim2.new(0, 50, 0, 50)
MiniBtn.Position = UDim2.new(0, 20, 0.5, -25)
MiniBtn.Text = "≡"
MiniBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MiniBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
MiniBtn.Visible = false
MiniBtn.Parent = ScreenGui

-- Логика кнопок
CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

MinimizeBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    MiniBtn.Visible = true
end)

MiniBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = true
    MiniBtn.Visible = false
end)

-- Функция для кнопок
local function NewButton(name, desc, callback)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(1, -10, 0, 40)
    Btn.Text = name .. " | " .. desc
    Btn.Font = Enum.Font.SourceSans
    Btn.TextSize = 18
    Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    Btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    Btn.Parent = Scroll
    Btn.MouseButton1Click:Connect(callback)
end

-- Телепорты
NewButton("Изменить скорость машины","Запускает скрипт на скорость", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Documantation12/Universal-Vehicle-Script/main/Main.lua"))()
end)

NewButton("Больница","Телепортирует в больницу", function()
    plr.Character.HumanoidRootPart.CFrame = CFrame.new(-3394.24463, 5.05, 263.195526)
end)

NewButton("Церковь","Телепортирует в церковь", function()
    plr.Character.HumanoidRootPart.CFrame = CFrame.new(-2659.02637, 2.55, -739.766541)
end)

NewButton("МВД","Телепортирует в МВД", function()
    plr.Character.HumanoidRootPart.CFrame = CFrame.new(-2852.2749, 18.6, 1110.59045)
end)

NewButton("МЧС","Телепортирует в МЧС", function()
    plr.Character.HumanoidRootPart.CFrame = CFrame.new(-1886.40942, 2.7, 297.478699)
end)

NewButton("Гаражи","Телепортирует в Гаражи", function()
    plr.Character.HumanoidRootPart.CFrame = CFrame.new(-3253.19141, 7.59, -544.405945)
end)

NewButton("Разведка Украины","Пасхалка", function()
    plr.Character.HumanoidRootPart.CFrame = CFrame.new(-2057.31274, -17.41, -272.960266)
end)

NewButton("Деревня","Телепортирует в Деревню", function()
    plr.Character.HumanoidRootPart.CFrame = CFrame.new(-2791.89429, 2.27, 2833.02954)
end)

NewButton("Пятёрочка","Телепортирует в Пятёрочку", function()
    plr.Character.HumanoidRootPart.CFrame = CFrame.new(-2406.3667, 7.48, 39.0829697)
end)

NewButton("Изменить скорость машины","Запускает скрипт на скорость", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Documantation12/Universal-Vehicle-Script/main/Main.lua"))()
end)


-- Взломы
NewButton("Дюп","(тестовый) Включает быстрый prompt", function()
    for i,v in pairs(game.Workspace:GetDescendants()) do
        if v:IsA("ProximityPrompt") then
            v.Enabled = true
            v.HoldDuration = 0
        end
    end
end)
