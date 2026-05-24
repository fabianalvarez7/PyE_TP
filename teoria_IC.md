# Teoría: Intervalos de Confianza (Consigna 2)

## El problema: no podés medir a toda la población

Tenés ~15.500 ocupados en tu muestra, pero la población real son millones. Calculaste la media de ingreso de la muestra, pero eso es solo una estimación del ingreso medio real de todos los ocupados de Argentina. Si hubieras tomado otra muestra, habrías obtenido otro número ligeramente diferente.

El intervalo de confianza responde a: **¿entre qué valores creemos que está el parámetro real de la población?**

---

## ¿Por qué un rango y no un número exacto?

Porque la media muestral varía de muestra en muestra. El Teorema Central del Límite dice que esa variación tiene un comportamiento predecible (distribución normal), y eso te permite calcular cuánto puede alejarse tu media muestral del valor real.

---

## ¿Cuándo usás t-Student en lugar de Normal?

Hay dos casos:

- Si conocés el desvío estándar de la **población** → usás la distribución Normal
- Si no lo conocés (y en tu TP nunca lo conocés) → usás **t-Student**

La t-Student es similar a la Normal pero con "colas más gordas", lo que produce intervalos un poco más anchos. Es la versión más honesta: como tenés más incertidumbre, el intervalo es más amplio. Con muestras grandes (como la tuya, de miles de casos), la diferencia es mínima.

---

## ¿Qué significa "95% de confianza"?

No significa que el parámetro real tiene 95% de probabilidad de estar en ese intervalo específico.

La interpretación correcta es: si repitieras el muestreo muchas veces y construyeras un intervalo cada vez, **el 95% de esos intervalos capturarían al valor real**. El tuyo es uno de esos casos.

Para el informe escribís algo así:
> "El intervalo (X; Y) cubre la media del ingreso mensual de los asalariados con una confianza del 95%."

---

## Qué pide cada ítem de la consigna

**a)** Elegir una variable cualitativa para dividir en grupos. Vos usás **categoría ocupacional** (Patrón, Cuenta propia, Asalariado). Hay que explicar en 1-2 oraciones por qué comparar esos grupos es interesante para el problema.

**b)** Decir qué parámetro estimás en cada grupo y cómo lo nombrás. En tu caso: media del ingreso de los patrones, media del ingreso de los cuentapropistas, media del ingreso de los asalariados.

**c)** Construir el IC para cada grupo por separado e interpretar si se superponen o no.

---

## La superposición de IC: la parte más importante

Imaginá tres líneas, cada una representa el rango del IC de un grupo:

```
Patrón:        |————————————|
                                   |——————|   Cuenta propia
                                |——————|      Asalariado
```

- Los rangos de Cuenta propia y Asalariado se pisan → no podés decir con confianza que tienen ingresos medios distintos
- El rango de Patrón no se pisa con ninguno → sí podés decir que los patrones ganan claramente más

Eso es lo que probablemente vayas a ver en tu TP, porque en el análisis descriptivo ya se veía que la mediana de patrones era muy superior a la de los otros dos grupos, que eran similares entre sí.

---

## Lo que hace `MeanCI()` en R

```r
MeanCI(x, conf.level = 0.95)
```

Le pasás el vector de datos del grupo y el nivel de confianza. Sin especificar el desvío poblacional (que no conocés), usa automáticamente la distribución t-Student. Devuelve tres valores: la media muestral, el límite inferior y el límite superior del intervalo.
