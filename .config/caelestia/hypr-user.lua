-- Caelestia user keybindings / overrides
-- Этот файл загружается поверх дефолтных биндов Caelestia

local hyprland = require("hyprland")   -- Caelestia Hyprland binding helper (если есть)
-- Если модуль называется иначе, раскомментируй нужный:
-- local hy = Hyprland  (глобальный объект в некоторых версиях Caelestia)

-- ============================================================
-- Сворачивание окон в special workspace (аналог minimize)
-- ============================================================
-- Super+M  → переместить текущее окно в special:minimized (скрыть)
-- Super+N  → показать/скрыть special workspace с минималками

-- Способ 1: через hyprctl (работает в любой версии Caelestia)
local function minimize()
    os.execute("hyprctl dispatch movetoworkspacesilent special:minimized")
end

local function toggleMinimized()
    os.execute("hyprctl dispatch togglespecialworkspace minimized")
end

-- Регистрация биндов через Caelestia API
-- (Caelestia qs использует QML/JS bindings; Lua-хуки ниже для hypr-user.lua формата)

-- Если hypr-user.lua использует формат возврата таблицы биндов:
return {
    -- Minimize / unminimize
    { mods = {"Super"},       key = "M", action = minimize,        desc = "Minimize window to special" },
    { mods = {"Super"},       key = "N", action = toggleMinimized, desc = "Toggle minimized workspace" },

    -- Перезапуск Caelestia без перезапуска Hyprland
    { mods = {"Super","Shift"}, key = "C", action = function()
        os.execute("pkill -f 'qs -c caelestia' ; sleep 0.5 ; qs -c caelestia &")
    end, desc = "Restart Caelestia shell" },

    -- Перезапуск обоев (awww / swww)
    { mods = {"Super","Alt"}, key = "W", action = function()
        local wp = "/home/kurasako/devushka_gejmpad_gejmer_1313139_3840x2160.jpg"
        os.execute("swww img " .. wp .. " --transition-type fade --transition-duration 1")
    end, desc = "Reload wallpaper" },
}
