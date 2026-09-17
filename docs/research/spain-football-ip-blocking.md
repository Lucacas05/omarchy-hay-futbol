# Bloqueos de IP relacionados con el fútbol en España: ficha factual

_Consulta: 17 de septiembre de 2026._

## Resumen utilizable

En España no se trata de «leyes propuestas por LaLiga». El origen inmediato de estos bloqueos es la **Sentencia 310/2024, de 18 de diciembre de 2024**, del Juzgado de lo Mercantil n.º 6 de Barcelona (ROJ `SJM B 309/2024`, ECLI `ES:JMB:2024:309`), dictada a petición de **LaLiga y Telefónica Audiovisual Digital (TAD)** con apoyo en la legislación de propiedad intelectual ya vigente. La sentencia permite un mecanismo dinámico: LaLiga o TAD comunican a determinados operadores españoles nuevas IP que sustituyen a las inicialmente identificadas y los operadores aplican el bloqueo durante partidos en directo. Al ser IP compartidas por CDN y proveedores de nube, la medida puede impedir también el acceso a servicios legítimos ajenos al fútbol.

Una formulación breve y prudente para el README sería:

> En España, los bloqueos dinámicos de IP autorizados judicialmente para combatir retransmisiones no autorizadas de fútbol pueden afectar también a servicios legítimos que comparten infraestructura de CDN o nube —especialmente durante los partidos—. Este plugin ayuda a hacer visible cuándo hay fútbol, una circunstancia que puede explicar fallos de acceso coincidentes.

## Hechos establecidos

### 1. Es una medida judicial solicitada por titulares de derechos, no una ley de LaLiga

- La demanda fue presentada conjuntamente por la **Liga Nacional de Fútbol Profesional** y **Telefónica Audiovisual Digital, S.L.U.** contra seis sociedades de acceso a internet vinculadas a Telefónica, Vodafone, MásOrange y DIGI. Todas las demandadas se **allanaron íntegramente**, por lo que el juzgado resolvió sin contradicción sobre el fondo técnico aportado por las actoras.
- El fallo ordenó el cese del acceso a IP utilizadas para distribuir ilícitamente contenidos de LaLiga, la monitorización de las IP inicialmente bloqueadas para identificar sucesoras y la remisión de nuevos listados. Esos listados pueden ser comunicados por «LALIGA y/o TAD indistintamente» antes o durante el directo, para ejecutar el bloqueo antes de terminar el evento.
- La base jurídica citada por la sentencia es legislación preexistente, entre ella los artículos 138 y 139.1.h de la Ley de Propiedad Intelectual. Por tanto, no debe describirse como una «ley propuesta» ni como una potestad legislativa de LaLiga.

**Fuente primaria:** [texto oficial de la Sentencia 310/2024 en CENDOJ/CGPJ](https://www.poderjudicial.es/search/AN/openDocument/766326fb999ba14aa0a8778d75e36f0d/20250331) ([descarga PDF oficial](https://www.poderjudicial.es/search/contenidos.action?action=accessToPDF&publicinterface=true&tab=AN&reference=766326fb999ba14aa0a8778d75e36f0d&encode=true&optimize=20250331&databasematch=AN)).

**Aclaración de siglas:** aquí **TAD** significa **Telefónica Audiovisual Digital, S.L.U.**, codemandante y titular/licenciataria de derechos audiovisuales; no el Tribunal Administrativo del Deporte.

### 2. Los operadores ejecutan los bloqueos; LaLiga/TAD suministran las identificaciones

La formulación precisa no es que LaLiga «bloquee Internet» directamente. La sentencia habilita a LaLiga/TAD para comunicar IP sustitutas; los **proveedores de acceso demandados** son quienes ejecutan el bloqueo en sus redes. La implementación no es necesariamente idéntica en todos los operadores.

**Fuentes:** [Sentencia 310/2024](https://www.poderjudicial.es/search/AN/openDocument/766326fb999ba14aa0a8778d75e36f0d/20250331); [metodología y explicación de hayahora.futbol](https://hayahora.futbol/#sobre-los-bloqueos).

### 3. La afectación colateral de infraestructura compartida está medida

El informe técnico de **OONI** publicado en junio de 2026 analizó mediciones de conectividad realizadas desde España entre el 1 de enero y el 1 de junio de 2026, además de barridos DNS sobre 9,2 millones de dominios. Sus resultados incluyen:

- 7.441 IP observadas como bloqueadas, pertenecientes a 36 organizaciones de infraestructura, entre ellas Cloudflare, Amazon, Akamai, Meta y Microsoft;
- al menos 554.510 dominios afectados alguna vez en el periodo analizado;
- en ventanas de una hora, el bloqueo de solo 4–20 IP durante retransmisiones llegó a afectar a más de 400.000 dominios por las dependencias de alojamiento compartido;
- la aplicación varió por operador y, en la mayoría de redes estudiadas, se concentró alrededor del horario de los partidos.

Estas cifras son una **estimación de OONI**, no un recuento oficial de LaLiga o de los operadores. «Afectado» puede incluir accesibilidad parcial; no significa que los 554.510 dominios estuvieran caídos simultáneamente, por completo o desde todas las redes. OONI documenta además sesgos de muestreo y presenta su estimación como un límite inferior. El informe declara que Cloudflare patrocinó parte del trabajo, pero que OONI realizó la investigación de forma independiente y asumió sus conclusiones.

**Fuente técnica primaria:** [OONI, “Collateral Damage of IP-Based Blocking During LALIGA Football Streaming in Spain”](https://ooni.org/post/2026-laliga-collateral/) (incluye metodología, datos abiertos y [cuaderno de análisis](https://gist.github.com/hellais/a43e2816178e4c310f5e19dec02d1954#file-20260626-ooni-laliga-final-ipynb)).

### 4. LaLiga reconoce incidencias en webs legítimas, pero disputa su caracterización

En su nota del 15 de febrero de 2025, LaLiga reconoció la «disfunción de diversas webs» y que las IP objetivo se compartían con contenidos legítimos. Sostuvo, no obstante, que el bloqueo no era masivo ni indiscriminado, que disponía de pruebas de uso infractor y atribuyó la afectación a la arquitectura y conducta de Cloudflare. Esas imputaciones a Cloudflare son la **posición de LaLiga**, no hechos neutrales establecidos por la nota.

**Fuente primaria (posición de LaLiga):** [Nota informativa de LaLiga, 15-02-2025](https://www.laliga.com/noticias/nota-informativa-en-relacion-con-el-bloqueo-de-ips-durante-las-ultimas-jornadas-de-laliga-ea-sports-vinculadas-a-las-practicas-ilegales-de-cloudflare).

### 5. hayahora.futbol aporta observaciones, no la lista oficial de órdenes

[hayahora.futbol](https://hayahora.futbol/) declara que un grupo de ingenieros mide desde conexiones domésticas de distintos operadores. Publica estados e historial por IP y operador, listados de texto y JSON, y un comprobador que resuelve los registros A de un dominio para compararlos con IP observadas como bloqueadas. La propia web advierte que:

- sus datos reflejan observaciones, no un listado oficial de órdenes;
- dependen de red, momento e IP observadas;
- un resultado aislado no prueba por sí solo la causa de un fallo;
- no detectar un bloqueo no garantiza accesibilidad desde todas las conexiones.

Esta fuente sirve para explicar la utilidad práctica del plugin y observar coincidencias temporales, pero no para afirmar por sí sola que cada fallo haya sido ordenado por LaLiga.

**Fuente/metodología propia:** [“¿Qué hace esta web?” y datos publicados por hayahora.futbol](https://hayahora.futbol/#sobre-los-bloqueos).

## Posiciones controvertidas que deben atribuirse

- **LaLiga:** afirma que los bloqueos son quirúrgicos, temporales, proporcionales y aplicados tras documentar una emisión ilícita; responsabiliza a Cloudflare de compartir IP entre servicios infractores y legítimos. Véanse sus [notas de febrero](https://www.laliga.com/noticias/nota-informativa-en-relacion-con-el-bloqueo-de-ips-durante-las-ultimas-jornadas-de-laliga-ea-sports-vinculadas-a-las-practicas-ilegales-de-cloudflare) y [octubre de 2025](https://www.laliga.com/noticias/la-comision-de-economia-comercio-y-transformacion-digital-del-congreso-de-los-diputados-respalda-la-estrategia-de-laliga-contra-el-fraude-audiovisual).
- **Cloudflare:** califica la práctica de sobrebloqueo amplio, opaco y desproporcionado. Su frase «without any government oversight» no debe reproducirse como hecho: existe autorización judicial, aunque Cloudflare discute la suficiencia de la supervisión posterior y la proporcionalidad. Véase su [informe de transparencia del primer semestre de 2025](https://blog.cloudflare.com/h1-2025-transparency-report/#addressing-blocking-demands).
- **Alcance de la revisión judicial posterior:** LaLiga informó de que en marzo de 2025 el juzgado rechazó solicitudes de nulidad de Cloudflare y RootedCON y señaló que en ese incidente no se había probado ni cuantificado daño. Esa resolución no convierte en inexistente toda afectación técnica: OONI midió afectación posteriormente. Fuente: [comunicado de LaLiga sobre la desestimación](https://www.laliga.com/en-GB/news/commercial-court-no-6-of-barcelona-upholds-the-judgment-issued-in-favour-of-laliga-and-dismisses-the-annulments-filed-by-cloudflare-and-rootedcon).

## Conclusión editorial

Para presentar el plugin, es sólido afirmar que en España hay **bloqueos dinámicos de IP, autorizados por sentencia y solicitados por LaLiga/TAD, ejecutados por operadores durante partidos**, y que el uso de direcciones compartidas por CDN/nube produce un riesgo —y una afectación medida— sobre servicios legítimos. Deben evitarse tres simplificaciones: llamarlos «leyes de LaLiga», decir que LaLiga ejecuta técnicamente cada bloqueo o atribuirle a un bloqueo concreto cualquier caída coincidente sin medición adicional.
