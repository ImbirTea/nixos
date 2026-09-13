import QtQuick
import Quickshell.Io
import "../" as Root

Row {
    id: root
    spacing: Root.Theme.gap / 2

    property var workspaces: []

    function toRoman(num) {
        const map = [[10,"X"],[9,"IX"],[5,"V"],[4,"IV"],[1,"I"]]
        let res = ""
        for (const [val, sym] of map) {
            while (num >= val) { res += sym; num -= val }
        }
        return res || "0"
    }

    function refresh() { niriProc.running = true }

    Process {
        id: niriProc
        command: ["niri", "msg", "-j", "workspaces"]
        running: true
        stdout: StdioCollector {
            onStreamFinished: {
                try {
                    const ws = JSON.parse(text)
                    ws.sort((a, b) => a.idx - b.idx)
                    root.workspaces = ws
                } catch (e) {
                    console.warn("Workspaces: bad JSON from niri:", e)
                }
            }
        }
    }

    Process {
        id: niriEvents
        command: ["niri", "msg", "-j", "event-stream"]
        running: true
        stdout: SplitParser {
            splitMarker: "\n"
            onRead: function(line) { root.refresh() }
        }
    }

    Repeater {
        model: root.workspaces

        Rectangle {
            required property var modelData

            width: label.implicitWidth + 16
            height: Root.Theme.barHeight - 8
            radius: Root.Theme.radius
            color: modelData.is_focused ? Root.Theme.accent : "transparent"

            Text {
                id: label
                anchors.centerIn: parent
                text: modelData.name || root.toRoman(modelData.idx)
                color: modelData.is_focused ? Root.Theme.bg : Root.Theme.fg
                font.family: Root.Theme.fontFamily
                font.pixelSize: Root.Theme.fontSize
            }

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    switchProc.command = ["niri", "msg", "action", "focus-workspace", String(modelData.idx)]
                    switchProc.running = true
                }
            }
        }
    }

    Process {
        id: switchProc
    }
}
