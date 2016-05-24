import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.1
import QtQuick.Controls.Styles 1.3
import QtQuick.Dialogs 1.2
import QtQuick.Particles 2.0

import "src/lists"
import "src/bars"
import "src/buttons"

import "src/variables/fontawesome.js" as FontAwesome
import "./js/main.js" as MainJs

Item
{
    width: parent.width
    height: parent.height
    id: functions

    MessageDialog
    {
        id: messageDialog
        icon: StandardIcon.Warning
        visible: false
        onAccepted:
        {
            visible = false;
        }
    }
}
