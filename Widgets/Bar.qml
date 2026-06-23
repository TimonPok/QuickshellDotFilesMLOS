import QtQuick
import Quickshell
import QtQuick.Layouts
import Quickshell.Hyprland


PanelWindow {
    id:panel


    color:"transparent" 
    property bool clockStyle: false

    anchors {
	    top: true
	    right: true
	    left:true
	}
    margins {left:5;top:5;right:5;bottom:5}
    aboveWindows: true
    
    implicitHeight: 35
    property bool wide: false


    Rectangle {
	    id:smth

    }






    RowLayout{
	        id: clipwraprect
		implicitWidth:parent.width
		implicitHeight:parent.height
		anchors.fill:parent
	    Rectangle {
		id: clockbar
		anchors.centerIn:parent
		color: "#1e1e1e"
		border.color: "#d72638"
		border.width: 2
		radius:wide=== true ? 50:8
		implicitWidth:wide === true ? 300:panel.width
		height: parent.height

		Behavior on implicitWidth {
			NumberAnimation{
				duration: 900
				//easing.type: Easing.OutBounce
				easing.type: Easing.OutQuint
			}
		}

		SystemClock {
		    id: clock
		    precision: SystemClock.seconds
		}
		Text {
		    anchors {
			centerIn: clockbar
			verticalCenter: parent.verticalCenter
			rightMargin:16

		    }            
		    text: Qt.formatDateTime(clock.date, (clockStyle ? "yyyy-MM-dd - HH:mm:ss" : "ddd, MMM dd - HH:mm:ss"))
		    color: "#D72638"

		    font.pixelSize: 14
		    font.bold: true
		    MouseArea{
			acceptedButtons: Qt.AllButtons;
			anchors.fill: parent
			onClicked: {
			    if (mouse.button === Qt.LeftButton) {
				wide = !wide
			    }
			    if (mouse.button === Qt.RightButton) {
				clockStyle = !clockStyle
			}

			}
		    
		    }
	        }
		


	}
	Item{
		Layout.fillWidth:true
	}
	Rectangle{
		    id:widgets
		    color:"#1e1e1e"
		    implicitWidth:300
		    implicitHeight:parent
		    border.color: "#d72638"
		    border.width:2
		    radius:wide === true ? 50:8

	    }
    }
}
