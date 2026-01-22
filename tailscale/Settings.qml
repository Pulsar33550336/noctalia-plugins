import QtQuick
import QtQuick.Layouts
import Quickshell
import qs.Commons
import qs.Widgets

ColumnLayout {
  id: root

  property var pluginApi: null

  // Local state - initialized from saved settings or defaults
  property int editRefreshInterval:
    pluginApi?.pluginSettings?.refreshInterval ||
    pluginApi?.manifest?.metadata?.defaultSettings?.refreshInterval ||
    5000

  property bool editCompactMode:
    pluginApi?.pluginSettings?.compactMode ??
    pluginApi?.manifest?.metadata?.defaultSettings?.compactMode ??
    false

  property bool editShowIpAddress:
    pluginApi?.pluginSettings?.showIpAddress ??
    pluginApi?.manifest?.metadata?.defaultSettings?.showIpAddress ??
    true

  property bool editShowPeerCount:
    pluginApi?.pluginSettings?.showPeerCount ??
    pluginApi?.manifest?.metadata?.defaultSettings?.showPeerCount ??
    true

  property bool editHideDisconnected:
    pluginApi?.pluginSettings?.hideDisconnected ??
    pluginApi?.manifest?.metadata?.defaultSettings?.hideDisconnected ??
    false

  property string editTerminalCommand:
    pluginApi?.pluginSettings?.terminalCommand ||
    pluginApi?.manifest?.metadata?.defaultSettings?.terminalCommand ||
    ""

  property int editPingCount:
    pluginApi?.pluginSettings?.pingCount ||
    pluginApi?.manifest?.metadata?.defaultSettings?.pingCount ||
    5

  spacing: Style.marginM

  // Title section
  NText {
    text: pluginApi?.tr("settings.title") || "Tailscale Settings"
    font.pointSize: Style.fontSizeXL
    font.bold: true
  }

  NText {
    text: pluginApi?.tr("settings.description") || "Configure Tailscale status display and behavior"
    color: Color.mSecondary
    Layout.fillWidth: true
    wrapMode: Text.Wrap
  }

  // Refresh interval section
  NDivider {
    Layout.fillWidth: true
    Layout.topMargin: Style.marginM
    Layout.bottomMargin: Style.marginM
  }

  NLabel {
    label: pluginApi?.tr("settings.refresh-interval") || "Refresh Interval"
    description: (pluginApi?.tr("settings.refresh-interval-desc") || "How often to check Tailscale status") + " (" + root.editRefreshInterval + " ms)"
  }

  NSlider {
    Layout.fillWidth: true
    from: 1000
    to: 60000
    stepSize: 1000
    value: root.editRefreshInterval
    onValueChanged: root.editRefreshInterval = value
  }

  // Display options section
  NDivider {
    Layout.fillWidth: true
    Layout.topMargin: Style.marginM
    Layout.bottomMargin: Style.marginM
  }

  NLabel {
    label: pluginApi?.tr("settings.display-options") || "Display Options"
  }

  NToggle {
    Layout.fillWidth: true
    label: pluginApi?.tr("settings.compact-mode") || "Compact Mode"
    description: pluginApi?.tr("settings.compact-mode-desc") || "Show only icon in the bar"
    checked: root.editCompactMode
    onToggled: checked => root.editCompactMode = checked
  }

  NToggle {
    Layout.fillWidth: true
    label: pluginApi?.tr("settings.show-ip") || "Show IP Address"
    description: pluginApi?.tr("settings.show-ip-desc") || "Display Tailscale IP in the bar widget"
    checked: root.editShowIpAddress
    onToggled: checked => root.editShowIpAddress = checked
  }

  NToggle {
    Layout.fillWidth: true
    label: pluginApi?.tr("settings.show-peers") || "Show Peer Count"
    description: pluginApi?.tr("settings.show-peers-desc") || "Display connected device count in the bar"
    checked: root.editShowPeerCount
    onToggled: checked => root.editShowPeerCount = checked
  }

  NToggle {
    Layout.fillWidth: true
    label: pluginApi?.tr("settings.hide-disconnected") || "Hide Disconnected Peers"
    description: pluginApi?.tr("settings.hide-disconnected-desc") || "Only show online peers in the panel"
    checked: root.editHideDisconnected
    onToggled: checked => root.editHideDisconnected = checked
  }

  // Terminal section
  NDivider {
    Layout.fillWidth: true
    Layout.topMargin: Style.marginM
    Layout.bottomMargin: Style.marginM
  }

  NLabel {
    label: pluginApi?.tr("settings.terminal") || "Terminal Configuration"
  }

  NTextInput {
    Layout.fillWidth: true
    label: pluginApi?.tr("settings.terminal-command") || "Terminal Command"
    description: pluginApi?.tr("settings.terminal-command-desc") || "Command to launch terminal for SSH/ping (e.g., 'ghostty', 'alacritty', 'kitty')"
    placeholderText: "ghostty"
    text: root.editTerminalCommand
    onTextChanged: root.editTerminalCommand = text
  }

  NLabel {
    label: pluginApi?.tr("settings.ping-count") || "Ping Count"
    description: (pluginApi?.tr("settings.ping-count-desc") || "Number of ping packets to send when testing connectivity") + " (" + root.editPingCount + ")"
  }

  NSlider {
    Layout.fillWidth: true
    from: 1
    to: 20
    stepSize: 1
    value: root.editPingCount
    onValueChanged: root.editPingCount = value
  }

  // Save function - called by the dialog
  function saveSettings() {
    if (!pluginApi) {
      Logger.e("Tailscale", "Cannot save: pluginApi is null")
      return
    }

    pluginApi.pluginSettings.refreshInterval = root.editRefreshInterval
    pluginApi.pluginSettings.compactMode = root.editCompactMode
    pluginApi.pluginSettings.showIpAddress = root.editShowIpAddress
    pluginApi.pluginSettings.showPeerCount = root.editShowPeerCount
    pluginApi.pluginSettings.hideDisconnected = root.editHideDisconnected
    pluginApi.pluginSettings.terminalCommand = root.editTerminalCommand
    pluginApi.pluginSettings.pingCount = root.editPingCount

    pluginApi.saveSettings()

    Logger.i("Tailscale", "Settings saved successfully")
  }
}
