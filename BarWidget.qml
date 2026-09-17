import QtQuick
import Quickshell
import Quickshell.Io
import qs.Commons
import qs.Ui

BarWidget {
  id: root
  moduleName: "lucas.football"

  property bool footballNow: false
  property bool loaded: false
  property bool requestFailed: false
  property int blockedCount: 0
  property string pendingText: ""
  property bool opened: false

  readonly property color statusColor: requestFailed
    ? (bar ? bar.barForeground : Color.foreground)
    : (footballNow ? (bar ? bar.urgent : Color.urgent) : Color.accent)

  function refresh() {
    if (!statusProc.running) statusProc.running = true
  }

  function open() {
    refresh()
    opened = true
  }

  function close() {
    opened = false
  }

  function togglePanel() {
    if (opened) close()
    else open()
  }

  function statusLabel() {
    if (requestFailed) return "SIN CONEXIÓN"
    if (!loaded) return "CONSULTANDO…"
    return footballNow ? "SÍ" : "NO"
  }

  function tooltip() {
    if (requestFailed)
      return "¿Hay fútbol?: sin conexión (se conserva el último estado)"
    if (!loaded)
      return "Consultando hayahora.futbol…"
    if (footballNow)
      return "Sí hay fútbol · " + blockedCount + " IPs bloqueadas"
    return "No hay fútbol · 0 IPs bloqueadas"
  }

  implicitWidth: button.implicitWidth
  implicitHeight: button.implicitHeight

  Process {
    id: statusProc
    command: [
      "/usr/bin/curl",
      "--fail",
      "--silent",
      "--show-error",
      "--max-time", "20",
      "--user-agent", "Omarchy-football-widget/1.0",
      "https://hayahora.futbol/estado/blocked-any.txt"
    ]

    stdout: StdioCollector {
      waitForEnd: true
      onStreamFinished: root.pendingText = String(text || "")
    }

    onExited: function(exitCode) {
      if (exitCode !== 0) {
        root.requestFailed = true
        return
      }

      var rows = root.pendingText.trim()
      root.blockedCount = rows === "" ? 0 : rows.split(/\r?\n/).filter(function(row) {
        return row.trim() !== ""
      }).length
      root.footballNow = root.blockedCount > 0
      root.loaded = true
      root.requestFailed = false
    }
  }

  Timer {
    interval: 300000
    running: true
    repeat: true
    triggeredOnStart: true
    onTriggered: root.refresh()
  }

  PopupCard {
    id: popup
    anchorItem: button
    owner: root
    bar: root.bar
    open: root.opened
    contentWidth: Style.space(260)
    contentHeight: Style.space(170)

    Column {
      anchors.fill: parent
      spacing: Style.space(10)

      Text {
        width: parent.width
        text: "¿HAY FÚTBOL AHORA?"
        color: root.bar ? root.bar.barForeground : Color.foreground
        font.family: root.bar ? root.bar.fontFamily : Style.font.family
        font.pixelSize: Style.font.bodySmall
        font.letterSpacing: 1
        horizontalAlignment: Text.AlignHCenter
      }

      Row {
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: Style.space(10)

        Text {
          anchors.verticalCenter: parent.verticalCenter
          text: "\uf1e3"
          color: root.statusColor
          font.family: root.bar ? root.bar.fontFamily : Style.font.family
          font.pixelSize: Style.font.title
        }

        Text {
          anchors.verticalCenter: parent.verticalCenter
          text: root.statusLabel()
          color: root.statusColor
          font.family: root.bar ? root.bar.fontFamily : Style.font.family
          font.pixelSize: Style.font.title
          font.bold: true
        }
      }

      Text {
        width: parent.width
        text: root.loaded && !root.requestFailed
          ? root.blockedCount + " IPs bloqueadas"
          : "No se pudo actualizar el estado"
        color: root.bar ? root.bar.barForeground : Color.foreground
        opacity: 0.65
        font.family: root.bar ? root.bar.fontFamily : Style.font.family
        font.pixelSize: Style.font.bodySmall
        horizontalAlignment: Text.AlignHCenter
      }

      Rectangle {
        width: parent.width
        height: Style.space(38)
        radius: Style.cornerRadius
        color: webMouse.containsMouse
          ? Style.hoverFillFor(root.bar ? root.bar.barForeground : Color.foreground, Color.accent)
          : "transparent"
        border.width: 1
        border.color: root.bar ? root.bar.barForeground : Color.foreground

        Text {
          anchors.centerIn: parent
          text: "Abrir hayahora.futbol  ↗"
          color: root.bar ? root.bar.barForeground : Color.foreground
          font.family: root.bar ? root.bar.fontFamily : Style.font.family
          font.pixelSize: Style.font.body
        }

        MouseArea {
          id: webMouse
          anchors.fill: parent
          hoverEnabled: true
          cursorShape: Qt.PointingHandCursor
          onClicked: {
            root.close()
            if (root.bar) root.bar.run("xdg-open https://hayahora.futbol/")
          }
        }
      }
    }
  }

  BarIconButton {
    id: button
    anchors.fill: parent
    bar: root.bar
    text: "\uf1e3"
    slotSize: Style.bar.statusSlot
    fontSize: Style.font.caption
    active: root.footballNow
    useActiveColor: true
    activeColor: root.bar ? root.bar.urgent : Color.urgent
    foreground: root.bar ? root.bar.barForeground : Color.foreground
    dimmed: !root.footballNow
    tooltipText: root.tooltip()

    onPressed: function(mouseButton) {
      if (mouseButton === Qt.MiddleButton) root.refresh()
      else root.togglePanel()
    }
  }
}
