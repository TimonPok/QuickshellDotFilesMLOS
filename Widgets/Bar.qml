import QtQuick
import Quickshell
import Quickshell.Hyprland


PanelWindow {
    id:panel


    
    property bool clockStyle: false

    anchors {
        top: true
        left: true
        right: true
    }
    implicitHeight: 35



    Rectangle {
        id: bar
        anchors.fill:parent
        color: "#052e2b"
        border.color: "#222222"

        border.width: 2

        Row{
            id: workspacesRow

            anchors {
                left: parent.left

                verticalCenter: parent.verticalCenter
                leftMargin:16
            }    
            spacing: 8 
            Repeater {
                model: 10
        
                Text {
                    anchors.top:parent.top
                    property var ws: Hyprland.workspaces.values.find(w=>w.id === index + 1)
                    property bool isActive: Hyprland.focusedWorkspace?.id === (index + 1)

                    text: index
                    color: isActive ? "#0db9d7" : (ws ? "#ffffff" : "#444b7a")


                    font {pixelSize:15; bold:true}
                    
                    MouseArea {
                        anchors.fill:parent
                        onClicked: Hyprland.dispatch("workspace " + (index+1))
                    
                    }
                }
            }
            Text {
                visible: Hyprland.workspaces.length === 0
                text: "No workspaces"
                color: "#ffffff"
            }
        }
        SystemClock {
            id: clock
            precision: SystemClock.Seconds
        }
        Text {
            anchors {
                centerIn: parent
                verticalCenter: parent.verticalCenter
                rightMargin:16

            }            
            text: Qt.formatDateTime(clock.date, (clockStyle ? "yyyy-MM-dd - HH:mm:ss" : "ddd, MMM dd - HH:mm:ss"))
            color: "#ffffff"
            font.pixelSize: 14
            font.bold: true
            MouseArea{
                acceptedButtons: Qt.AllButtons;
                anchors.fill: parent
                onClicked: {
                    if (mouse.button === Qt.RightButton) {
                        clockStyle = !clockStyle
                    }
                }
            
            }
        }        
        Rectangle{
            id: button
            anchors {
                right: parent.right
            }
            color: "#ffffff"
            width: 20
            height: 20
            MouseArea {

                anchors.fill: parent
                onClicked: Qt.quit()
            }    
        }
        
    }
}
