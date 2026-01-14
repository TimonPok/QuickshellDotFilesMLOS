import Quickshell
import Quickshell.Wayland
import QtQuick
import "~/Wallpapers"

PanelWindow {
    id: wallpaper
    anchors {
        top:true
        bottom:true
        left:true
        right:true
    }
    aboveWindows: false
    
    Image {
        asynchronous: true
        source: "IMissYouNiko"

        width: parent.width
        height: parent.height
    }    
}
