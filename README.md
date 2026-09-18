# ¿Hay fútbol?

This plugin is mainly useful in Spain. During LALIGA broadcasts, Spanish internet providers apply court-authorized blocks to IP addresses linked to unauthorized streams. 

Click the ball to see the current answer and the number of blocked IPs. The popup also links back to the source. Middle-clicking refreshes the result immediately.

The plugin checks `https://hayahora.futbol/estado/blocked-any.txt` once every five minutes. It uses this small text endpoint instead of downloading the full data set.

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

The plugin runs `curl` as your user. It does not write outside its own Omarchy configuration or collect analytics.

## Remove

```bash
omarchy plugin remove lucas.football
```

## Data source

The status comes from the public block list maintained by [hayahora.futbol](https://hayahora.futbol/). This plugin treats a non-empty list as "football now" because the site associates those active blocks with football broadcasts. It is an indicator, not an official match calendar.

The site and its data belong to their respective maintainers. This repository is not affiliated with hayahora.futbol, LaLiga, or Omarchy.

## License

MIT. See [LICENSE](LICENSE).
