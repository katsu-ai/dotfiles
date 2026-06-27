#!/usr/bin/env bash
# Установка dotfiles — CachyOS + Hyprland + Caelestia
set -e

DOTFILES="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
CONFIG="$HOME/.config"

echo "==> Установка dotfiles из $DOTFILES"

# Функция создания симлинков
link() {
    local src="$DOTFILES/$1"
    local dst="$HOME/$1"
    mkdir -p "$(dirname "$dst")"
    if [ -e "$dst" ] && [ ! -L "$dst" ]; then
        echo "  Бэкап: $dst -> $dst.bak"
        mv "$dst" "$dst.bak"
    fi
    ln -sf "$src" "$dst"
    echo "  ✓ $1"
}

# Конфиги
link .config/hypr/hyprland.conf
link .config/caelestia/hypr-user.lua
link .config/caelestia/hypr-vars.lua
link .config/nwg-dock-hyprland/style.css
link .config/nwg-dock-hyprland/pinned

# -----------------------------------------------------------------------
# Браузер по умолчанию — Google Chrome
# -----------------------------------------------------------------------
echo "==> Установка Google Chrome как браузера по умолчанию"

# xdg-settings
if command -v xdg-settings &>/dev/null; then
    xdg-settings set default-web-browser google-chrome.desktop
    echo "  ✓ xdg-settings: google-chrome.desktop"
fi

# mimeapps.list
MIMEAPPS="$HOME/.config/mimeapps.list"
touch "$MIMEAPPS"

declare -a MIME_TYPES=(
    "text/html"
    "x-scheme-handler/http"
    "x-scheme-handler/https"
    "x-scheme-handler/ftp"
    "x-scheme-handler/about"
    "x-scheme-handler/unknown"
    "application/xhtml+xml"
    "application/x-extension-htm"
    "application/x-extension-html"
    "application/x-extension-shtml"
    "application/x-extension-xht"
    "application/x-extension-xhtml"
)

# Удалить старые записи браузеров
sed -i '/^text\/html=/d;/^x-scheme-handler\/http/d;/^x-scheme-handler\/ftp/d;/^x-scheme-handler\/about/d;/^x-scheme-handler\/unknown/d;/^application\/xhtml/d;/^application\/x-extension-ht/d' "$MIMEAPPS"

# Добавить блок [Default Applications] если нет
if ! grep -q '^\[Default Applications\]' "$MIMEAPPS"; then
    echo -e "\n[Default Applications]" >> "$MIMEAPPS"
fi

for mime in "${MIME_TYPES[@]}"; do
    echo "${mime}=google-chrome.desktop" >> "$MIMEAPPS"
done

echo "  ✓ mimeapps.list обновлён"

# -----------------------------------------------------------------------
# Обои: убедиться что swww-daemon запустится при логине
# -----------------------------------------------------------------------
WALLPAPER="/home/kurasako/devushka_gejmpad_gejmer_1313139_3840x2160.jpg"
if [ ! -f "$WALLPAPER" ]; then
    echo "  ⚠ Обои не найдены: $WALLPAPER"
    echo "    Поместите файл обоев по этому пути или измените путь в hyprland.conf"
fi

echo ""
echo "==> Готово! Перезапусти Hyprland: Super+Shift+E, затем войди снова."
