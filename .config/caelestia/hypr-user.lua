hl.config({
    input = {
        kb_layout  = "us,ru",
        kb_options = "grp:alt_shift_toggle",
    },
})

-- Сворачивание окна в special:minimized (Super+H — убрать, Super+G — показать/скрыть)
hl.bind("SUPER + H", hl.dsp.window.move({ workspace = "special:minimized" }))
hl.bind("SUPER + G", hl.dsp.workspace.toggleSpecial("minimized"))
