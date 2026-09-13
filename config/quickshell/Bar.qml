import QtQuick
import Quickshell
import Quickshell.Wayland
import "modules" as Modules
import "." as Root

PanelWindow {
    id: bar

    anchors {
        top: true
        left: true
        right: true
    }
    implicitHeight: Root.Theme.barHeight
    color: "transparent"

    exclusiveZone: Root.Theme.barHeight

    Rectangle {
        anchors.fill: parent

        // The background color stays constant while its alpha varies horizontally.
        gradient: Gradient {
            orientation: Gradient.Horizontal
            GradientStop { position: 0.0;  color: Qt.rgba(Root.Theme.bg.r, Root.Theme.bg.g, Root.Theme.bg.b, 0.75) }
            GradientStop { position: 0.25; color: Qt.rgba(Root.Theme.bg.r, Root.Theme.bg.g, Root.Theme.bg.b, 0.25) }
            GradientStop { position: 0.5; color: Qt.rgba(Root.Theme.bg.r, Root.Theme.bg.g, Root.Theme.bg.b, 0.6) }
            GradientStop { position: 0.75;  color: Qt.rgba(Root.Theme.bg.r, Root.Theme.bg.g, Root.Theme.bg.b, 0.25) }
            GradientStop { position: 1.0;  color: Qt.rgba(Root.Theme.bg.r, Root.Theme.bg.g, Root.Theme.bg.b, 0.75) }
        }

        // A thin bottom edge visually ties the bar to window borders.
        Rectangle {
            anchors.bottom: parent.bottom
            width: parent.width
            height: 1
            color: Root.Theme.subtle
        }

        Item {
            anchors.fill: parent
            anchors.leftMargin: Root.Theme.gap
            anchors.rightMargin: Root.Theme.gap

            // Keep the clock centered in the whole panel, independent of side content.
            Modules.Clock {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }

            Modules.Workspaces {
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
            }

            Modules.Locale {
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
            }
        }
    }
}
