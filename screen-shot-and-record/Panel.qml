import QtQuick
import QtQuick.Layouts
import qs.Commons
import qs.Widgets

Item {
  id: root

  // Plugin API (injected by PluginPanelSlot)
  property var pluginApi: null

  // SmartPanel properties (required for panel behavior)
  readonly property var geometryPlaceholder: panelContainer
  readonly property bool allowAttach: true

  // Preferred dimensions
  property real contentPreferredWidth: 180 * Style.uiScaleRatio
  property real contentPreferredHeight: 300 * Style.uiScaleRatio

  property var mainInstance: pluginApi?.mainInstance

  anchors.fill: parent

    NBox {
        Layout.fillWidth: true
        Layout.fillHeight: true
        anchors.fill: parent
        anchors.margins: Style.marginM

        ColumnLayout {
            anchors.fill: parent
            spacing: Style.marginM
            anchors.margins: Style.marginM

            RowLayout {
                Layout.fillWidth: true
                spacing: Style.marginS

                NIcon {
                    icon: "screenshot"
                    pointSize: Style.fontSizeL
                    color: Color.mPrimary
                }

                NText {
                    text: pluginApi?.tr("panel.title") || "Screenshot"
                    pointSize: Style.fontSizeL
                    font.weight: Style.fontWeightBold
                    color: Color.mOnSurface
                    Layout.fillWidth: true
                }
            }

            NButton {
                icon: "screenshot"
                text: pluginApi?.tr("panel.target.screenshot") || "Screenshot"
                backgroundColor: Color.mPrimary
                textColor: Color.mOnPrimary
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignVCenter
                onClicked: {
                    mainInstance?.open("screenshot")
                    pluginApi.closePanel(pluginApi.panelOpenScreen)
                }
            }
            NButton {
                icon: "text-recognition"
                text: pluginApi?.tr("panel.target.ocr") || "OCR"
                backgroundColor: Color.mPrimary
                textColor: Color.mOnPrimary
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignVCenter
                onClicked: {
                    mainInstance?.open("ocr")
                    pluginApi.closePanel(pluginApi.panelOpenScreen)
                }
            }
            NButton {
                icon: "photo-search"
                text: pluginApi?.tr("panel.target.search") || "Image Search"
                backgroundColor: Color.mPrimary
                textColor: Color.mOnPrimary
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignVCenter
                onClicked: {
                    mainInstance?.open("search")
                    pluginApi.closePanel(pluginApi.panelOpenScreen)
                }
            }
            NButton {
                icon: "camera"
                text: pluginApi?.tr("panel.target.record") || "Screen Recording"
                backgroundColor: Color.mPrimary
                textColor: Color.mOnPrimary
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignVCenter
                onClicked: {
                    mainInstance?.open("record")
                    pluginApi.closePanel(pluginApi.panelOpenScreen)
                }
            }
            NButton {
                icon: "camera-spark"
                text: pluginApi?.tr("panel.target.recordsound") || "Screen Recording (with Audio)"
                backgroundColor: Color.mPrimary
                textColor: Color.mOnPrimary
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignVCenter
                onClicked: {
                    mainInstance?.open("recordsound")
                    pluginApi.closePanel(pluginApi.panelOpenScreen)
                }
            }
        }
    }
}