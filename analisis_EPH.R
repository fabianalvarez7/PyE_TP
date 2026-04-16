# ============================================================
# TP Probabilidad y Estadística – PyE TUIA 2026
# Dataset: EPH Continua – 3er Trimestre 2025 (INDEC)
# Fuente: https://www.indec.gob.ar/
# ============================================================

library(tidyverse)
library(readxl)

# ============================================================
# 1. CARGA DE DATOS
# ============================================================

ruta <- "/Users/fabianalvarez/Documents/TUIA/Probabilidad-y-Estadistica/TP/EPH_usu_3_Trim_2025_xls/usu_individual_T325.xlsx"
ind <- read_excel(ruta)

# ============================================================
# 2. PREPARACIÓN Y LIMPIEZA
# ============================================================
# Cómo se decodificaron las variables:

# CH04 → Sexo (pág. 16 del manual)
# El dataset guarda 1 o 2. El script los convierte a texto legible: 1 → "Varón", 2 → "Mujer"

# CH06 → Edad (pág. 16)
# Es simplemente la edad en años cumplidos. No necesita decodificación, solo convertirla a número.

# IPCF → Ingreso per cápita familiar (pág. 34)
# Ya viene calculado en el dataset: es el ingreso total del hogar dividido por la cantidad de miembros.

# NIVEL_ED → (pág. 18):
# 1	Primario incompleto
# 2	Primario completo
# 3	Secundario incompleto
# 4	Secundario completo
# 5	Superior incompleto
# 6	Superior completo
# 7	Sin instrucción


datos <- ind %>%
  # Adultos (18+), entrevistas realizadas, nivel educativo informado
  filter(CH06 >= 18,
         ESTADO %in% c(1, 2, 3),
         NIVEL_ED %in% 1:7) %>%
  mutate(
    Sexo = factor(CH04,
                  levels = c(1, 2),
                  labels = c("Varón", "Mujer")),

    Nivel_educativo = factor(NIVEL_ED,
                             levels = 1:7,
                             labels = c("Primaria inc.",
                                        "Primaria comp.",
                                        "Secundaria inc.",
                                        "Secundaria comp.",
                                        "Superior inc.",
                                        "Superior comp.",
                                        "Sin instrucción")),

    Edad = as.numeric(CH06),
    IPCF = as.numeric(IPCF)
  )

# Para el análisis de ingresos filtramos IPCF > 0
# (se excluyen hogares sin ingreso declarado)
datos_ingreso <- datos %>% filter(IPCF > 0)

cat("Casos totales en la muestra (adultos):", nrow(datos), "\n")
cat("Casos con IPCF > 0:", nrow(datos_ingreso), "\n")

# ============================================================
# 3. ANÁLISIS DE VARIABLES CUALITATIVAS
# ============================================================

# --- 3.1 Sexo ---
tabla_sexo <- datos %>%
  count(Sexo) %>%
  mutate(Porcentaje = round(n / sum(n) * 100, 1))

cat("\n=== DISTRIBUCIÓN POR SEXO ===\n")
print(tabla_sexo)

# --- 3.2 Nivel educativo ---
tabla_edu <- datos %>%
  count(Nivel_educativo) %>%
  mutate(Porcentaje = round(n / sum(n) * 100, 1))

cat("\n=== DISTRIBUCIÓN POR NIVEL EDUCATIVO ===\n")
print(tabla_edu)

# --- 3.3 Tabla cruzada: Sexo × Nivel educativo ---
tabla_cruzada <- datos %>%
  count(Sexo, Nivel_educativo) %>%
  group_by(Nivel_educativo) %>%
  mutate(Porcentaje = round(n / sum(n) * 100, 1)) %>%
  ungroup()

cat("\n=== NIVEL EDUCATIVO POR SEXO ===\n")
print(tabla_cruzada)

# ============================================================
# 4. ANÁLISIS DE VARIABLES CUANTITATIVAS
# ============================================================

# --- 4.1 Edad ---
resumen_edad <- datos %>%
  summarise(
    Media    = round(mean(Edad), 1),
    Mediana  = median(Edad),
    DS       = round(sd(Edad), 1),
    Mínimo   = min(Edad),
    Máximo   = max(Edad),
    Q1       = quantile(Edad, 0.25),
    Q3       = quantile(Edad, 0.75)
  )

cat("\n=== ESTADÍSTICOS DE EDAD ===\n")
print(resumen_edad)

# Edad por sexo
cat("\n=== EDAD POR SEXO ===\n")
datos %>%
  group_by(Sexo) %>%
  summarise(
    Media   = round(mean(Edad), 1),
    Mediana = median(Edad),
    DS      = round(sd(Edad), 1)
  ) %>%
  print()

# --- 4.2 IPCF ---
resumen_ipcf <- datos_ingreso %>%
  summarise(
    Media    = round(mean(IPCF)),
    Mediana  = round(median(IPCF)),
    DS       = round(sd(IPCF)),
    Mínimo   = min(IPCF),
    Máximo   = max(IPCF),
    Q1       = round(quantile(IPCF, 0.25)),
    Q3       = round(quantile(IPCF, 0.75))
  )

cat("\n=== ESTADÍSTICOS DE IPCF (pesos) ===\n")
print(resumen_ipcf)

# IPCF por sexo
cat("\n=== IPCF POR SEXO ===\n")
datos_ingreso %>%
  group_by(Sexo) %>%
  summarise(
    Media   = round(mean(IPCF)),
    Mediana = round(median(IPCF)),
    DS      = round(sd(IPCF)),
    n       = n()
  ) %>%
  print()

# IPCF por nivel educativo
cat("\n=== IPCF POR NIVEL EDUCATIVO ===\n")
datos_ingreso %>%
  group_by(Nivel_educativo) %>%
  summarise(
    Media   = round(mean(IPCF)),
    Mediana = round(median(IPCF)),
    n       = n()
  ) %>%
  print()

# ============================================================
# 5. VISUALIZACIONES
# ============================================================

# Paleta de colores
col_azul  <- "#2C7BB6"
col_rojo  <- "#D7191C"
col_gris  <- "#636363"

# -- G1: Distribución por sexo (barras) --
g1 <- ggplot(tabla_sexo, aes(x = Sexo, y = Porcentaje, fill = Sexo)) +
  geom_col(width = 0.5) +
  geom_text(aes(label = paste0(Porcentaje, "%")), vjust = -0.5, size = 4) +
  scale_fill_manual(values = c("Varón" = col_azul, "Mujer" = col_rojo)) +
  labs(title = "Distribución por sexo",
       subtitle = "Adultos en aglomerados urbanos – EPH 3T2025",
       x = NULL, y = "Porcentaje (%)") +
  theme_minimal() +
  theme(legend.position = "none")

ggsave("graficos/g1_sexo.png", g1, width = 5, height = 4, dpi = 150)

# -- G2: Distribución por nivel educativo --
g2 <- ggplot(tabla_edu, aes(x = reorder(Nivel_educativo, Porcentaje),
                             y = Porcentaje)) +
  geom_col(fill = col_azul) +
  geom_text(aes(label = paste0(Porcentaje, "%")), hjust = -0.1, size = 3.5) +
  coord_flip() +
  labs(title = "Distribución por nivel educativo alcanzado",
       subtitle = "Adultos en aglomerados urbanos – EPH 3T2025",
       x = NULL, y = "Porcentaje (%)") +
  theme_minimal() +
  scale_y_continuous(limits = c(0, 30))

ggsave("graficos/g2_educacion.png", g2, width = 7, height = 5, dpi = 150)

# -- G3: Histograma de edad --
g3 <- ggplot(datos, aes(x = Edad)) +
  geom_histogram(binwidth = 5, fill = col_azul, color = "white") +
  geom_vline(xintercept = mean(datos$Edad), color = col_rojo,
             linetype = "dashed", linewidth = 0.8) +
  annotate("text", x = mean(datos$Edad) + 2, y = Inf,
           label = paste0("Media: ", round(mean(datos$Edad), 1)),
           vjust = 2, hjust = 0, color = col_rojo, size = 3.5) +
  labs(title = "Distribución de edad",
       subtitle = "Adultos en aglomerados urbanos – EPH 3T2025",
       x = "Edad (años)", y = "Frecuencia") +
  theme_minimal()

ggsave("graficos/g3_edad.png", g3, width = 6, height = 4, dpi = 150)

# -- G4: Boxplot IPCF por sexo --
g4 <- ggplot(datos_ingreso, aes(x = Sexo, y = IPCF, fill = Sexo)) +
  geom_boxplot(outlier.alpha = 0.2, outlier.size = 0.8) +
  scale_y_continuous(labels = scales::comma, limits = c(0, quantile(datos_ingreso$IPCF, 0.99))) +
  scale_fill_manual(values = c("Varón" = col_azul, "Mujer" = col_rojo)) +
  labs(title = "Ingreso per cápita familiar según sexo",
       subtitle = "Se excluye el 1% superior – EPH 3T2025",
       x = NULL, y = "IPCF (pesos)") +
  theme_minimal() +
  theme(legend.position = "none")

ggsave("graficos/g4_ipcf_sexo.png", g4, width = 5, height = 4, dpi = 150)

# -- G5: IPCF mediana por nivel educativo --
mediana_edu <- datos_ingreso %>%
  group_by(Nivel_educativo) %>%
  summarise(Mediana_IPCF = median(IPCF))

g5 <- ggplot(mediana_edu, aes(x = reorder(Nivel_educativo, Mediana_IPCF),
                               y = Mediana_IPCF)) +
  geom_col(fill = col_azul) +
  geom_text(aes(label = scales::comma(Mediana_IPCF)), hjust = -0.1, size = 3.5) +
  coord_flip() +
  scale_y_continuous(labels = scales::comma,
                     limits = c(0, max(mediana_edu$Mediana_IPCF) * 1.15)) +
  labs(title = "Mediana del IPCF por nivel educativo",
       subtitle = "EPH 3T2025",
       x = NULL, y = "IPCF mediana (pesos)") +
  theme_minimal()

ggsave("graficos/g5_ipcf_educacion.png", g5, width = 7, height = 5, dpi = 150)

cat("\nGráficos guardados en la carpeta 'graficos/'\n")
cat("Análisis completado.\n")
