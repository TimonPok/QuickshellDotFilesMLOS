import Quickshell
import Quickshell.Wayland
import QtQuick
import "~/Wallpapers"

PanelWindow {
    id: wallpaper
    width: screen.width
    height: screen.height
    aboveWindows:false

    Image {
	anchors.fill: parent 
        asynchronous: true
        source: "IMissYouNiko"
    }    
}
