import QtQuick
import "../" as Root

Text {
    id: clock
    property date now: new Date()

    text: Qt.formatDateTime(now, "hh:mm")
    color: Root.Theme.fg
    font.family: Root.Theme.fontFamily
    font.pixelSize: Root.Theme.fontSize

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: clock.now = new Date()
    }
}
