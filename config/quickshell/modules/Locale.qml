import QtQuick
import "../" as Root

// Keyboard layout and date for the right side of the bar.

Row {
    id: root
    spacing: 6

    property date now: new Date()

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: root.now = new Date()
    }

    Text {
        text: Root.KeyboardLayout.code + " | " + Qt.formatDateTime(root.now, "ddd, dd MMM yyyy")
        color: Root.Theme.muted
        font.family: Root.Theme.fontFamily
        font.pixelSize: Root.Theme.fontSize
    }
}
