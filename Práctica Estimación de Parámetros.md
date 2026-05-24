---
title: "Práctica: Estimación de Parámetros"
source: "https://joa-ferreyra.github.io/pye-tuia/ejercicios_estimacion.html#ejercicio-n-1"
author:
published:
created: 2026-05-24
description:
tags:
  - "clippings"
---
## Ejercicio N° 1

Un grupo de biólogos estudia la longitud de peces adultos de una especie que habita en un lago. Por investigaciones previas se sabe que esta variable sigue una distribución normal con desviación estándar poblacional 0.6 cm, pero se desconoce la longitud promedio poblacional. Se selecciona una muestra aleatoria de 25 ejemplares y se registra la longitud (en cm) de cada uno. Los datos se encuentran en el archivo [`peces.xlsx`](https://docs.google.com/spreadsheets/d/1dY6kNuctfSkCV9WFi6GK6xwSzmoE0o-7/edit?usp=sharing&ouid=117972151796590988559&rtpof=true&sd=true).

1. Identifique la población de interés y la variable aleatoria en estudio. ¿Qué tipo de variable es?
2. Utilizando R, estime en forma puntual y por intervalo de confianza del 95 % la longitud promedio poblacional de los peces del lago. Interprete los resultados obtenidos en el contexto del problema.
3. Calcule el margen de error de la estimación por intervalo de confianza realizada en el ítem anterior.
4. Repita el procedimiento realizado en b) fijando un nivel de confianza del 90 %. Compare los dos intervalos: ¿qué ocurre con la amplitud? ¿A qué se debe?
5. Suponga que los biólogos quieren planificar un nuevo estudio y desean estimar la longitud promedio con una precisión de 0.1 cm y un nivel de confianza del 95%. ¿Qué información necesitan para calcular el tamaño de muestra necesario? ¿Cuántos ejemplares deberían muestrear?

## Ejercicio N° 2

En el marco de un estudio sobre el desempeño de estudiantes de nivel secundario, se administró una prueba estandarizada de razonamiento lógico a una muestra aleatoria de 18 estudiantes de una región. Se registró el tiempo (en minutos) que cada estudiante tardó en completar la prueba. Los datos se encuentran en el archivo [`estudiantes.csv`](https://drive.google.com/file/d/17n9p6VE_S34VlCw3nMfdKX2AK2ekFxpc/view?usp=sharing).

1. Identifique la población de interés y la variable aleatoria en estudio.
2. ¿Los datos obtenidos son compatibles con el supuesto de normalidad de la variable en la población?
3. Calcule un intervalo de confianza del 90 % para el tiempo promedio de resolución de la prueba estandarizada. ¿Qué distribución se utilizó y por qué? Interprete el resultado en el contexto del problema.

## Ejercicio N° 3

Una universidad quiere conocer la proporción de sus estudiantes que utiliza transporte público como medio principal para llegar al campus. Para ello, se selecciona una muestra aleatoria de 200 estudiantes y se les pregunta a cada uno: **“¿Usás transporte público como medio principal para venir a la facultad?”**. De los encuestados, 134 responden que sí.

1. Identifique la población de interés, la variable aleatoria en estudio y su distribución. ¿Qué parámetro se quiere estimar?
2. Calcule un intervalo de confianza del 95 % para la proporción de estudiantes de la universidad que utiliza transporte público. Justifique la validez de la metodología utilizada e interprete el resultado en el contexto del problema.
3. Suponga que las autoridades quieren repetir el estudio el año siguiente con mayor precisión. Desean que el error de estimación no supere 0,04 (es decir, ±4 puntos porcentuales) con un nivel de confianza del 95%.
	- Si se considera el valor observado en la muestra para el estimador correspondiente, ¿cuántos estudiantes deberían encuestarse?
		- Si no se tuviera ninguna información previa, ¿qué valor conviene asumir para $\pi$ y por qué? ¿Cambia el tamaño de muestra necesario?

## Paquetes y funciones útiles

```
# CÁLCULO DE INTERVALOS DE CONFIANZA
DescTools::MeanCI()   # Intervalos de confianza para promedios poblacionales
DescTools::BinomCI()  # Intervalos de confianza para proporciones poblacionales

# PRUEBA GRÁFICA DE NORMALIDAD
qqnorm()
qqline()
```