---
title:
source: "https://campusv.fceia.unr.edu.ar/pluginfile.php/343603/mod_resource/content/1/script_e1.R"
author:
published:
created: 2026-05-24
description:
tags:
  - "clippings"
---
```
#########################################################
# EJERCICIO N° 1
#########################################################

# Paquetes
library(readxl)
install.packages("DescTools")
library(DescTools)

# Importamos dataset
peces <- read_excel("peces.xlsx")
View(peces)

# Ítem b - Estimación puntual
mean(peces$longitud)
## Se estima que la longitud promedio de los peces del lago es igual a 27.22 cm

# Ítem b - Estimación por IC 95 % (1 - alfa = 0.95) - Sigma es conocido e igual a 0.6 cm.
MeanCI(x = peces$longitud, 
       sd = 0.6, # desvío estándar poblacional conocido
       conf.level = 0.95 # grado de confianza
       )

## IC95%: (26.98;27.46) cm
## El intervalo (26.98;27.46) cm contiene/cubre a la long. promedio de los
## peces del lago, con una confianza del 95%.

# Ítem c - Margen de error
(27.4552 - 26.9848)/2
## Margen de error: 0.2352 cm

# Ítem d - Estimación por IC 90 %
MeanCI(x = peces$longitud, 
       sd = 0.6, # desvío estándar poblacional conocido
       conf.level = 0.90 # grado de confianza (AHORA es del 90 %)
)

## Margen de error:
(27.41738  - 27.02262 )/2
## Margen de error: 0.19738 cm
```