# Plan de trabajo – TP PyE TUIA 2026

## Estado actual
- [x] Revisión del enunciado del TP
- [x] Análisis de contenidos disponibles (Unidad 1, Unidad 2, módulos R)
- [x] Selección del dataset → EPH 3T2025
- [x] Definición del problema estadístico
- [x] Escritura del código R base (`TP/analisis_EPH.R`) — corre sin errores
- [x] Verificar códigos NIVEL_ED — **corregido**: el orden estaba mal (código 7 = Sin instrucción, no código 1)
- [x] Corregir ruta de carga de datos (`read_excel` necesita el archivo, no la carpeta)
- [x] Agregar comentarios al código explicando la decodificación de cada variable (según manual pág. 16–18)
- [ ] Re-ejecutar script con etiquetas corregidas y verificar gráficos g2 y g5
- [ ] Redacción del informe PDF

---

## Requisitos del TP (consigna)

Entrega: **04/06/2026 a las 11:59 am** — formato PDF + archivo .R

El informe debe incluir:
1. **Introducción y problema**: unidad de análisis, población, 4 variables (2 cualitativas + 2 cuantitativas), parámetros asociados
2. **Descripción de la muestra**: diseño muestral o supuesto de aleatoriedad
3. **Análisis descriptivo** de las variables
4. **Conclusión**: indicar si es exhaustiva o preliminar
5. **Máximo 4 páginas**

Restricción importante: **no usar series de tiempo** (corte transversal solamente).

---

## Técnicas disponibles (dentro del contenido del curso)

- Carga y limpieza: `read.csv`, tidyverse (`dplyr`, `tidyr`)
- Variables cualitativas: `table()`, `prop.table()`, gráficos de barras (`ggplot2`)
- Variables cuantitativas: `summary()`, `mean()`, `sd()`, `median()`, `quantile()`, histogramas, boxplots
- Agrupaciones: `group_by()` + `summarise()`
- Joins y transformaciones: `merge`, `left_join`, `filter`, `select`, `mutate`

---

## Dataset elegido: EPH 3er Trimestre 2025 (INDEC)

**Archivos:**
- `EPH_usu_3_Trim_2025_xls/usu_individual_T325.xlsx` — 44.946 filas × 235 cols (archivo principal)
- `EPH_usu_3_Trim_2025_xls/usu_hogar_T325.xlsx` — 15.860 filas × 98 cols (no usado por ahora)
- `EPH_registro_3T2025.pdf` — codebook de variables (no se pudo leer aún, ver pendiente)
- `EPH_nota_metodologica_1_trim_2019.pdf` — diseño muestral

**Problema estadístico definido:**
- **Unidad de análisis:** Persona de 18 años o más residente en aglomerados urbanos de Argentina
- **Población:** Adultos en los 31 aglomerados urbanos relevados por la EPH, 3T2025
- **Variables:**
  | Variable | Tipo | Columna | Códigos |
  |---|---|---|---|
  | Sexo | Cualitativa nominal | `CH04` | 1=Varón, 2=Mujer |
  | Nivel educativo | Cualitativa ordinal | `NIVEL_ED` | 1–7 (ver pendiente) |
  | Edad | Cuantitativa discreta | `CH06` | En años |
  | Ingreso per cápita familiar | Cuantitativa continua | `IPCF` | En pesos |

**Resultados obtenidos (script ya corrido):**
- Muestra: 34.336 adultos / 24.543 con IPCF > 0
- Sexo: 53.2% mujeres, 46.8% varones
- Edad: media 45.5 años, mediana 44, DS 18.3
- IPCF: mediana $477.000, media $660.271 (sesgo alto por valores extremos)
- IPCF mediana varones $500.000 vs mujeres $460.000
- Patrón IPCF × educación: **pendiente re-ejecutar** con etiquetas corregidas

**Bug corregido (sesión 2026-04-16):**
Las etiquetas de `NIVEL_ED` estaban en orden incorrecto. Según el manual (pág. 18), el código **7 = Sin instrucción** (no código 1). Los 238 casos con IPCF bajo que parecían "Superior comp." eran en realidad personas sin instrucción.

**Gráficos generados:** `TP/graficos/` (g1 a g5)

---

## Pendiente para próxima sesión

1. Re-ejecutar el script completo y verificar que g2 y g5 muestren etiquetas correctas
2. Redactar el informe PDF (4 páginas máx.)

---

## Próximos pasos

1. [PENDIENTE] Re-ejecutar script y revisar gráficos con etiquetas corregidas
2. [PENDIENTE] Redactar informe PDF

---

## Archivos del repositorio

```
Probabilidad_y_Estadistica/
├── TRABAJO PRÁCTICO – PyE TUIA 2026.pdf        ← enunciado
├── PLAN_TP.md                                   ← este archivo
├── EPH_registro_3T2025.pdf                      ← codebook variables (leer con Poppler)
├── EPH_nota_metodologica_1_trim_2019.pdf        ← diseño muestral
├── EPH_usu_3_Trim_2025_xls/
│   ├── usu_individual_T325.xlsx                 ← datos individuos (principal)
│   └── usu_hogar_T325.xlsx                      ← datos hogares (no usado aún)
├── TP/
│   ├── analisis_EPH.R                           ← código R completo (CORRE OK)
│   └── graficos/                                ← 5 gráficos generados (g1–g5)
├── Unidad1/
│   ├── Modulo1.R
│   ├── Modulo2.R
│   └── Unidad 1.pdf
└── Unidad2/
    └── Unidad 2.pdf
```
