import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import qs.Commons
import qs.Services.UI
import qs.Widgets

ColumnLayout {
  id: root
  spacing: Style.marginM

  property var pluginApi: null
  
  property var cfg: pluginApi?.pluginSettings || ({})
  property var defaults: pluginApi?.manifest?.metadata?.defaultSettings || ({})

  property string apiKey: cfg.apiKey ?? defaults.apiKey ?? "YOUR_API_KEY_HERE"
  property string country: cfg.country ?? defaults.country ?? "us"
  property string category: cfg.category ?? defaults.category ?? "general"
  property int refreshInterval: cfg.refreshInterval ?? defaults.refreshInterval ?? 30
  property int maxHeadlines: cfg.maxHeadlines ?? defaults.maxHeadlines ?? 10
  property int widgetWidth: cfg.widgetWidth ?? defaults.widgetWidth ?? 300
  property int rollingSpeed: cfg.rollingSpeed ?? defaults.rollingSpeed ?? 50

  function saveSettings() {
    if (!pluginApi) return;
    
    pluginApi.pluginSettings.apiKey = apiKey;
    pluginApi.pluginSettings.country = country;
    pluginApi.pluginSettings.category = category;
    pluginApi.pluginSettings.refreshInterval = refreshInterval;
    pluginApi.pluginSettings.maxHeadlines = maxHeadlines;
    pluginApi.pluginSettings.widgetWidth = widgetWidth;
    pluginApi.pluginSettings.rollingSpeed = rollingSpeed;
    
    pluginApi.saveSettings();
  }

  // Header
  RowLayout {
    Layout.fillWidth: true
    spacing: Style.marginM

    NIcon {
      icon: "newspaper"
      pointSize: Style.fontSizeXL
      color: Color.mPrimary
    }

    NText {
      text: pluginApi?.tr("news.settings.title") || "News Settings"
      pointSize: Style.fontSizeL
      font.weight: Font.Medium
      color: Color.mOnSurface
    }

    Item { Layout.fillWidth: true }
  }

  Rectangle {
    Layout.fillWidth: true
    Layout.preferredHeight: 1
    color: Color.mOutline
  }

  // API Key Section
  NLabel {
    label: pluginApi?.tr("news.settings.api-key") || "API Key"
    description: pluginApi?.tr("news.settings.api-key-desc") || "Get your free API key from newsapi.org"
  }

  NTextInput {
    id: apiKeyField
    Layout.fillWidth: true
    placeholderText: "YOUR_API_KEY_HERE"
    text: root.apiKey
    onTextChanged: {
      root.apiKey = text;
      root.saveSettings();
    }

  NButton {
    text: pluginApi?.tr("news.settings.get-api-key") || "Get API Key"
    icon: "external-link"
    onClicked: Qt.openUrlExternally("https://newsapi.org/register")
  }

  Rectangle {
    Layout.fillWidth: true
    Layout.preferredHeight: 1
    color: Color.mOutline
    Layout.topMargin: Style.marginS
    Layout.bottomMargin: Style.marginS
  }

  // News Settings
  NLabel {
    label: pluginApi?.tr("news.settings.news-settings") || "News Settings"
  }

  // Country
  NLabel {
    label: pluginApi?.tr("news.settings.country") || "Country"
    description: "Select which country's news to display"
  }

  NComboBox {
    id: countryCombo
    Layout.fillWidth: true
    model: ["United States", "United Kingdom", "Canada", "Australia", "Germany", "France", "Italy", "Japan", "South Korea", "India"]
    
    property var countryValues: ["us", "gb", "ca", "au", "de", "fr", "it", "jp", "kr", "in"]
    
    Component.onCompleted: {
      var idx = countryValues.indexOf(root.country);
      currentIndex = idx >= 0 ? idx : 0;
    }
    
    onCurrentIndexChanged: {
      if (currentIndex >= 0 && currentIndex < countryValues.length) {
        root.country = countryValues[currentIndex];
        root.saveSettings();
      }
    }
  }

  // Category
  NLabel {
    label: pluginApi?.tr("news.settings.category") || "Category"
    description: "Filter news by category"
  }

  NComboBox {
    id: categoryCombo
    Layout.fillWidth: true
    model: ["General", "Business", "Entertainment", "Health", "Science", "Sports", "Technology"]
    
    property var categoryValues: ["general", "business", "entertainment", "health", "science", "sports", "technology"]
    
    Component.onCompleted: {
      var idx = categoryValues.indexOf(root.category);
      currentIndex = idx >= 0 ? idx : 0;
    }
    
    onCurrentIndexChanged: {
      if (currentIndex >= 0 && currentIndex < categoryValues.length) {
        root.category = categoryValues[currentIndex];
        root.saveSettings();
      }
    }
  }

  // Refresh Interval
  NLabel {
    label: pluginApi?.tr("news.settings.refresh-interval") || "Refresh Interval"
    description: "Check for new headlines every " + root.refreshInterval + " minutes"
  }

  NSpinBox {
    id: refreshIntervalSpinBox
    Layout.fillWidth: true
    from: 5
    to: 1440
    value: root.refreshInterval
    stepSize: 5
    
    onValueModified: {
      root.refreshInterval = value;
      root.saveSettings();
    }
  }

  // Max Headlines
  NLabel {
    label: pluginApi?.tr("news.settings.max-headlines") || "Max Headlines"
    description: "Maximum number of headlines to display"
  }

  NSpinBox {
    id: maxHeadlinesSpinBox
    Layout.fillWidth: true
    from: 1
    to: 100
    value: root.maxHeadlines
    
    onValueModified: {
      root.maxHeadlines = value;
      root.saveSettings();
    }
  }

  // Widget Width
  NLabel {
    label: pluginApi?.tr("news.settings.widget-width") || "Widget Width"
    description: root.widgetWidth + " pixels"
  }

  NSpinBox {
    id: widgetWidthSpinBox
    Layout.fillWidth: true
    from: 100
    to: 1000
    value: root.widgetWidth
    stepSize: 10
    
    onValueModified: {
      root.widgetWidth = value;
      root.saveSettings();
    }
  }

  // Scroll Speed
  NLabel {
    label: pluginApi?.tr("news.settings.rolling-speed") || "Scroll Speed"
    description: root.rollingSpeed + " ms per pixel (lower = faster)"
  }

  NSpinBox {
    id: rollingSpeedSpinBox
    Layout.fillWidth: true
    from: 10
    to: 200
    value: root.rollingSpeed
    stepSize: 10
    
    onValueModified: {
      root.rollingSpeed = value;
      root.saveSettings();
    }
  }

  Rectangle {
    Layout.fillWidth: true
    Layout.preferredHeight: 1
    color: Color.mOutline
    Layout.topMargin: Style.marginS
    Layout.bottomMargin: Style.marginS
  }

  // Info
  RowLayout {
    Layout.fillWidth: true
    spacing: Style.marginS

    NIcon {
      icon: "info"
      pointSize: Style.fontSizeM
      color: Color.mPrimary
    }

    NText {
      text: pluginApi?.tr("news.settings.info") || "About NewsAPI"
      pointSize: Style.fontSizeM
      font.weight: Font.Medium
      color: Color.mOnSurface
    }
  }

  NText {
    text: pluginApi?.tr("news.settings.info-text") || "NewsAPI provides news from over 80,000 sources worldwide. The free tier allows 100 requests per day. News updates automatically based on your refresh interval."
    pointSize: Style.fontSizeXS
    color: Color.mOnSurfaceVariant
    wrapMode: Text.Wrap
    Layout.fillWidth: true
  }
}
