//@ pragma UseQApplication

import QtQuick
import Quickshell
import Quickshell.Services.Pipewire

import "./Widgets/"

ShellRoot {
    id: root
    
    // Pipewire Audio

    property var defaultAudioSink: Pipewire.defaultAudioSink
//    property int 



    Loader {
        active: true
        sourceComponent: Wallpaper {}
        
    }
    Loader{
        active: true
        sourceComponent: Bar {}
    }
}
