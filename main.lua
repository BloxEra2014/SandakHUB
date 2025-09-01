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
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Robojini/Tuturial_UI_Library/main/UI_Template_1"))()
local plr = game.Players.LocalPlayer
local Window = Library.CreateLib("SANDAK Province | Сандак Хаб","RJTheme5")
local Teleport = Window:NewTab("Main | Главная")
local Tp = Teleport:NewSection("Main | Главная")
Tp:NewButton("Изменить скорость машины | CAR SPEED","Запускает скрипт на скорость", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Documantation12/Universal-Vehicle-Script/main/Main.lua"))()
end)
Tp:NewButton("Скоро будет больше функций!","!Не кнопка а надпись!", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Documantation12/Universal-Vehicle-Script/main/Main.lua"))()
end)
local Hacks = Window:NewTab("Телепорты")
local Hack = Hacks:NewSection("Телепорты")
Hack:NewButton("Больница", "Телепортирует в больницу", function()
    plr.Character.HumanoidRootPart.CFrame = CFrame.new (-3394.24463, 5.05000019, 263.195526, -0.173624277, 0, 0.984811902, 0, 1, 0, -0.984811902, 0, -0.173624277)
end)
Hack:NewButton("Церковь", "Телепортирует в церковь", function()
    plr.Character.HumanoidRootPart.CFrame = CFrame.new (-2659.02637, 2.55033565, -739.766541, 0.984812498, 0, 0.173621148, 0, 1, 0, -0.173621148, 0, 0.984812498)
end)
Hack:NewButton("Мвд", "Телепортирует в Мвд", function()
    plr.Character.HumanoidRootPart.CFrame = CFrame.new (-2852.2749, 18.6000004, 1110.59045, 0.173624337, 0, 0.984811902, 0, 1, 0, -0.984811902, 0, 0.173624337)
end)
Hack:NewButton("Мчс", "Телепортирует в Мчс", function()
    plr.Character.HumanoidRootPart.CFrame = CFrame.new (-1886.40942, 2.70004678, 297.478699, 0, 0, 1, 0, 1, -0, -1, 0, 0)
end)
Hack:NewButton("Гаражи", "Телепортирует в Гаражи", function()
    plr.Character.HumanoidRootPart.CFrame = CFrame.new (-3253.19141, 7.5912075, -544.405945, 0.438328028, 0.898815036, -4.10974026e-05, 4.10974026e-05, -6.58035278e-05, -1, -0.898815036, 0.438328028, -6.58035278e-05)
end)
Hack:NewButton("Разветка Украины", "Пасхалка", function()
    plr.Character.HumanoidRootPart.CFrame = CFrame.new (-2057.31274, -17.4150505, -272.960266, -0.573599219, 0, 0.81913656, 0, 1, 0, -0.81913656, 0, -0.573599219)
end)
Hack:NewButton("Деревня", "Телепортирует в Деревню", function()
    plr.Character.HumanoidRootPart.CFrame = CFrame.new (-2791.89429, 2.27600002, 2833.02954, -0.933587909, 0, -0.358349502, 0, 1, 0, 0.358349502, 0, -0.933587909)
end)
Hack:NewButton("Пятёрочка", "Телепортирует в Пятёрочку", function()
    plr.Character.HumanoidRootPart.CFrame = CFrame.new (-2406.3667, 7.48527145, 39.0829697, 0.173615217, 0.984813571, -5.48362732e-06, -5.48362732e-06, 6.55651093e-06, 1, 0.984813571, -0.173615217, 6.55651093e-06)
end)
local Creator = Window:NewTab("Создатели")
local Creators = Creator:NewSection("Создатели")
Creators:NewButton("Sandak", "Создатель скрипта", function()
    print("Sandak")
end)
Creators:NewButton("чепулых", "Тестинг", function()
    print("чепулых")
end)
Creators:NewButton("Oleg Mongol", "Вдохновление", function()
    print("Oleg Mongol")
end)
