import QtQuick
import Quickshell
import Quickshell.Wayland
import "." as Root

PanelWindow {
    id: window

    // Stretching the layer makes centering independent of the output size.
    // Its empty input region means it remains completely click-through.
    anchors { top: true; bottom: true; left: true; right: true }
    color: "transparent"
    exclusiveZone: 0
    mask: Region {}
    WlrLayershell.layer: WlrLayer.Overlay
    WlrLayershell.keyboardFocus: WlrKeyboardFocus.None

    property bool shown: false
    property int itemWidth: 126
    property int padding: 10

    function show() {
        shown = true
        hideTimer.restart()
    }

    Connections {
        target: Root.KeyboardLayout
        function onLayoutChanged() { window.show() }
    }

    Timer {
        id: hideTimer
        interval: 240
        onTriggered: window.shown = false
    }

    Rectangle {
        id: switcher
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: 200
        width: Math.max(272, Root.KeyboardLayout.layouts.length * window.itemWidth + window.padding * 2)
        height: 128
        radius: Root.Theme.radius
        color: Qt.rgba(Root.Theme.bg.r, Root.Theme.bg.g, Root.Theme.bg.b, 0.96)
        border.width: 1
        border.color: Root.Theme.subtle
        opacity: window.shown ? 1 : 0
        scale: window.shown ? 1 : 0.96

        Behavior on opacity { NumberAnimation { duration: 300; easing.type: Easing.OutCubic } }
        Behavior on scale { NumberAnimation { duration: 210; easing.type: Easing.OutBack } }

        // One moving selection surface, inspired by the workspace indicator.
        Rectangle {
            id: selection
            x: window.padding + Math.max(0, Root.KeyboardLayout.currentIndex) * window.itemWidth
            y: window.padding
            width: window.itemWidth
            height: parent.height - window.padding * 2
            radius: Root.Theme.radius
            color: Root.Theme.accent

            Behavior on x {
                NumberAnimation { duration: 320; easing.type: Easing.OutCubic }
            }
        }

        Row {
            anchors.centerIn: parent
            spacing: 0

            Repeater {
                model: Root.KeyboardLayout.layouts

                Item {
                    required property string modelData
                    required property int index

                    width: window.itemWidth
                    height: switcher.height - window.padding * 2
                    property bool active: index === Root.KeyboardLayout.currentIndex

                    Column {
                        anchors.centerIn: parent
                        spacing: 8

                        Text {
                            anchors.horizontalCenter: parent.horizontalCenter
                            text: Root.KeyboardLayout.shortCode(modelData).toLowerCase()
                            color: parent.parent.active ? Root.Theme.bg : Root.Theme.fg
                            font.family: Root.Theme.fontFamily
                            font.pixelSize: 30

                            Behavior on color { ColorAnimation { duration: 180 } }
                        }

                        Text {
                            anchors.horizontalCenter: parent.horizontalCenter
                            text: modelData
                            color: parent.parent.active ? Root.Theme.bg : Root.Theme.muted
                            font.family: Root.Theme.fontFamily
                            font.pixelSize: Root.Theme.fontSize

                            Behavior on color { ColorAnimation { duration: 180 } }
                        }
                    }
                }
            }
        }
    }
}
