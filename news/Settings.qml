import QtQuick
import QtQuick.Layouts
import qs.Commons
import qs.Widgets

ColumnLayout {
  id: root
  spacing: Style.marginM

  property var pluginApi: null
  
  property var cfg: pluginApi?.pluginSettings || ({})
  property var defaults: pluginApi?.manifest?.metadata?.defaultSettings || ({})

  // Local state
  property string apiKeyValue: cfg.apiKey ?? defaults.apiKey ?? "YOUR_API_KEY_HERE"
  property string countryValue: cfg.country ?? defaults.country ?? "us"
  property string categoryValue: cfg.category ?? defaults.category ?? "general"
  property int refreshIntervalValue: cfg.refreshInterval ?? defaults.refreshInterval ?? 30
  property int maxHeadlinesValue: cfg.maxHeadlines ?? defaults.maxHeadlines ?? 10
  property int widgetWidthValue: cfg.widgetWidth ?? defaults.widgetWidth ?? 300
  property int rollingSpeedValue: cfg.rollingSpeed ?? defaults.rollingSpeed ?? 50

  function saveSettings() {
    if (!pluginApi) return;
    
    pluginApi.pluginSettings.apiKey = apiKeyValue;
    pluginApi.pluginSettings.country = countryValue;
    pluginApi.pluginSettings.category = categoryValue;
    pluginApi.pluginSettings.refreshInterval = refreshIntervalValue;
    pluginApi.pluginSettings.maxHeadlines = maxHeadlinesValue;
    pluginApi.pluginSettings.widgetWidth = widgetWidthValue;
    pluginApi.pluginSettings.rollingSpeed = rollingSpeedValue;
    
    pluginApi.saveSettings();
  }

  NTextInput {
    label: "API Key"
    description: "Get your free API key from newsapi.org/register"
    text: apiKeyValue
    onTextChanged: apiKeyValue = text
    onEditingFinished: saveSettings()
  }

  NButton {
    text: "Get API Key"
    icon: "external-link"
    onClicked: Qt.openUrlExternally("https://newsapi.org/register")
  }

  NComboBox {
    label: "Country"
    description: "Select which country's news to display"
    minimumWidth: 200
    model: [
      { "key": "us", "name": "United States" },
      { "key": "gb", "name": "United Kingdom" },
      { "key": "ca", "name": "Canada" },
      { "key": "au", "name": "Australia" },
      { "key": "de", "name": "Germany" },
      { "key": "fr", "name": "France" },
      { "key": "it", "name": "Italy" },
      { "key": "jp", "name": "Japan" },
      { "key": "kr", "name": "South Korea" },
      { "key": "in", "name": "India" }
    ]
    currentKey: countryValue
    onSelected: key => {
      countryValue = key;
      saveSettings();
    }
  }

  NComboBox {
    label: "Category"
    description: "Filter news by category"
    minimumWidth: 200
    model: [
      { "key": "general", "name": "General" },
      { "key": "business", "name": "Business" },
      { "key": "entertainment", "name": "Entertainment" },
      { "key": "health", "name": "Health" },
      { "key": "science", "name": "Science" },
      { "key": "sports", "name": "Sports" },
      { "key": "technology", "name": "Technology" }
    ]
    currentKey: categoryValue
    onSelected: key => {
      categoryValue = key;
      saveSettings();
    }
  }

  NSpinBox {
    label: "Refresh Interval"
    description: "Check for new headlines every " + refreshIntervalValue + " minutes"
    from: 5
    to: 1440
    stepSize: 5
    value: refreshIntervalValue
    onValueChanged: {
      refreshIntervalValue = value;
      saveSettings();
    }
  }

  NSpinBox {
    label: "Max Headlines"
    description: "Maximum number of headlines to display"
    from: 1
    to: 100
    value: maxHeadlinesValue
    onValueChanged: {
      maxHeadlinesValue = value;
      saveSettings();
    }
  }

  NSpinBox {
    label: "Widget Width"
    description: "Widget width in pixels: " + widgetWidthValue + "px"
    from: 100
    to: 1000
    stepSize: 10
    value: widgetWidthValue
    onValueChanged: {
      widgetWidthValue = value;
      saveSettings();
    }
  }

  NSpinBox {
    label: "Scroll Speed"
    description: "Time in ms per pixel (lower = faster): " + rollingSpeedValue + "ms"
    from: 10
    to: 200
    stepSize: 10
    value: rollingSpeedValue
    onValueChanged: {
      rollingSpeedValue = value;
      saveSettings();
    }
  }
}
