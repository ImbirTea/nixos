pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    property string name: ""
    property string code: "??"
    property var layouts: []
    property int currentIndex: -1
    property bool ready: false

    signal layoutChanged(string name)

    function shortCode(name) {
        const map = {
            "English (US)": "EN",
            "Russian": "RU",
        }
        if (map[name]) return map[name]
        return name ? name.split(" ")[0].slice(0, 2).toUpperCase() : "??"
    }

    function refresh() { layoutProc.running = true }

    function updateLayout(data) {
        const nextName = data.names[data.current_idx]
        const changed = ready && nextName !== name

        name = nextName
        code = shortCode(nextName)
        layouts = data.names
        currentIndex = data.current_idx
        ready = true

        if (changed)
            layoutChanged(nextName)
    }

    Process {
        id: layoutProc
        command: ["niri", "msg", "-j", "keyboard-layouts"]
        running: true
        stdout: StdioCollector {
            onStreamFinished: {
                try {
                    root.updateLayout(JSON.parse(text))
                } catch (e) {
                    console.warn("KeyboardLayout: bad JSON from niri:", e)
                }
            }
        }
    }

    Process {
        command: ["niri", "msg", "-j", "event-stream"]
        running: true
        stdout: SplitParser {
            splitMarker: "\n"
            onRead: root.refresh()
        }
    }
}
