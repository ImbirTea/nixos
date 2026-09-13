pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: theme

    property color bg:        "#1b1215"
    property color fg:        "#c9c1c4"
    property color accent:    "#6f5c6a"
    property color muted:     "#615c61"
    property color subtle:    "#3a3236"
    property color urgent:    "#807d82"

    property string fontFamily: "JetBrainsMono Nerd Font"
    property int fontSize: 12
    property int barHeight: 24
    property int radius: 0
    property int gap: 10

    FileView {
        id: paletteFile
        path: Qt.resolvedUrl("colors.json")
        watchChanges: true

        onFileChanged: reload()
        onLoaded: theme.applyPalette(text())
    }

    function applyPalette(raw) {
        if (!raw || raw.length === 0) return
        try {
            const data = JSON.parse(raw)
            const c = data.colors || {}
            const s = data.special || {}

            bg     = s.background || c.color0  || bg
            fg     = s.foreground || c.color7  || fg
            accent = c.color7     || c.color2  || accent
            muted  = c.color7     || c.color1  || muted
            subtle = c.color8     || subtle
            urgent = c.color1     || urgent
        } catch (e) {
            console.warn("Theme: failed to parse colors.json:", e)
        }
    }
}
