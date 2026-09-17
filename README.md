# ¿Hay fútbol?

## Why this exists

This widget is mainly useful in Spain. During LALIGA broadcasts, Spanish internet providers apply court-authorized blocks to IP addresses linked to unauthorized streams. The mechanism was requested by LALIGA and Telefónica Audiovisual Digital and authorized by [Barcelona Commercial Court No. 6](https://www.poderjudicial.es/search/AN/openDocument/766326fb999ba14aa0a8778d75e36f0d/20250331); it is not a law written by LALIGA.

The problem is that Cloudflare and other infrastructure providers use the same IP address for many unrelated websites. Blocking one shared address can therefore make legitimate services unreachable in Spain. [OONI measured](https://ooni.org/post/2026-laliga-collateral/) match-time events where blocking only 4–20 IP addresses affected more than 400,000 domains. This plugin puts the current status from [hayahora.futbol](https://hayahora.futbol/) in the Omarchy bar, so a strange outage during a match is easier to recognize.

Click the ball to see the current answer and the number of blocked IPs. The popup also links back to the source. Middle-clicking refreshes the result immediately.

The widget checks `https://hayahora.futbol/estado/blocked-any.txt` once every five minutes. It uses this small text endpoint instead of downloading the full data set.

## Install

```bash
omarchy plugin add https://github.com/Lucacas05/omarchy-hay-futbol.git --enable
```

Omarchy places the widget in the center section of the bar by default. You can drag it elsewhere or move it from the command line:

```bash
omarchy bar move lucas.football --after omarchy.weather
```

## Use

- Left-click the football to open the status popup.
- Middle-click it to refresh without waiting for the next scheduled check.
- Click `Abrir hayahora.futbol` in the popup to visit the source page.

When the request fails, the popup says `SIN CONEXIÓN` and keeps the last successful state.

## Requirements

- Omarchy Quattro
- `curl`
- An internet connection to `hayahora.futbol`

The plugin runs `curl` as your user. It does not need `sudo`, write outside its own Omarchy configuration, or collect analytics.

## Remove

```bash
omarchy plugin remove lucas.football
```

## Data source

The status comes from the public block list maintained by [hayahora.futbol](https://hayahora.futbol/). This plugin treats a non-empty list as "football now" because the site associates those active blocks with football broadcasts. It is an indicator, not an official match calendar.

The site and its data belong to their respective maintainers. This repository is not affiliated with hayahora.futbol, LaLiga, or Omarchy.

## License

MIT. See [LICENSE](LICENSE).
