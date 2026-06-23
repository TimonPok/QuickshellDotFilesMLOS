import Quickshell
import Quickshell.Wayland
import Quickshell.Services.Notifications
import QtQuick
import QtQuick.Layouts

Scope{
	id: root
	NotificationServer {
		id: server
		actionsSupported: true
		bodySupported: true
		imageSupported: true

		onNotification: n => {
			console.log("got:",n.body)
			n.tracked = true
		}
	}







	PanelWindow{
		id:panwin
		visible:true
		anchors {top:true;right:true}
		margins{top:45;right:12}
		implicitWidth:380
		implicitHeight:Math.max(1,column.implicitHeight)
		color:"transparent"
		exclusionMode:ExclusionMode.Ignore
		property bool isOpen:false

		ColumnLayout {
			id:column
			width:parent.width
			spacing: 10

			Repeater{
				model:server.trackedNotifications
				delegate: Rectangle {
					id: card
					opacity:0.0


					required property var modelData
					
					Timer {
						running:card.modelData.urgency!==NotificationUrgency.Critical
						interval: 5000

						onTriggered: card.modelData.dismiss()
					}
					x:parent.width
					Behavior on x {
						NumberAnimation {
							duration: card.modelData.urgency===NotificationUrgency.Critical ? 400:150
							easing.type:Easing.OutQuint
						}
					}
					Behavior on opacity{
						NumberAnimation{
							duration:card.modelData.urgency===NotificationUrgency.Critical
							? 400:250
							easing.type:Easing.OutCubic
						}
					}
					Component.onCompleted: {
						card.x=0
						card.opacity=1.0
						console.log(width)
					}



					Layout.fillWidth:true
					Layout.preferredHeight:60
					radius:8
					color: "#151515"
					border.width:2
					border.color:modelData.urgency === NotificationUrgency.Critical 
					? "#FF7900" : "#d72638"

					RowLayout {
						id:layout
						anchors.fill:parent
						anchors.margins:10
						spacing:10
						Image {
							Layout.preferredHeight:36
							Layout.preferredWidth:36
							Layout.alignment: Qt.AlignTop
							fillMode:Image.PreserveAspectFit
							visible:source.toString() !==""
							source:card.modelData.image || card.modelData.appIcon || ""
						}

						ColumnLayout {
							Layout.fillWidth:true
							spacing:2
							
							Text { 
								Layout.fillWidth:true
								visible:text!==""
								text:card.modelData.summary
								color:modelData.urgency===NotificationUrgency.Critical ? "#FF0000": "#00FFFF" 
								font.bold:true
								font.pixelSize:15
								elide:Text.ElideRight
							}
							Text{
								Layout.fillWidth:true
								visible:text!==""
								text:card.modelData.body
								font.pixelSize:14
								color:"#FFFFFF"
								wrapMode:Text.WordWrap
								
							}
						
						}
					}
					MouseArea {
						anchors.fill: parent
						onClicked: {
							//panwin.implicitwidth = 0;
							card.modelData.dismiss()
						}
					}
				}
			}
		}
	}
}
