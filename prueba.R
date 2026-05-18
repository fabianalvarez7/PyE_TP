# ============================================================
# TP Probabilidad y Estadística – PyE TUIA 2026
# Dataset: EPH Continua – 4° Trimestre 2025 (INDEC)
# Tema: Situación laboral de los ocupados en Argentina
# Descarga automática vía paquete {eph}
# ============================================================

library(eph)
library(tidyverse)

# ============================================================
# 1. DESCARGA DE DATOS
# ============================================================
# get_microdata() descarga directamente desde INDEC.

ind <- get_microdata(
  year   = 2025,
  period = 4,
  type   = "individual"
)

cat("Filas descargadas:", nrow(ind), "\n")
cat("Columnas disponibles:", ncol(ind), "\n")

# ============================================================
# 2. PREPARACIÓN Y LIMPIEZA
# ============================================================
# Población de interés: OCUPADOS (ESTADO == 1)
#
# Variables utilizadas:
#
# CAT_OCUP → Categoría ocupacional (pág. del registro EPH)
#   1 = Patrón / empleador
#   2 = Cuenta propia
#   3 = Obrero / empleado (relación de dependencia)
#   4 = Trabajador familiar sin remuneración
#
# PP07H → ¿Le descuentan aportes jubilatorios? (solo asalariados, CAT_OCUP == 3)
#   1 = Sí  → asalariado formal
#   2 = No  → asalariado informal
#
# PP07G2 → ¿Está inscripto como monotributista? (cuenta propia y patrón)
#   1 = Sí  → cuenta propia/patrón monotributista
#   0 / NA  → no inscripto (informal)
#
# Formalidad laboral: variable construida que combina PP07H y PP07G2
#   - Asalariado formal       : CAT_OCUP == 3 & PP07H == 1
#   - Asalariado informal     : CAT_OCUP == 3 & PP07H == 2
#   - Monotributista          : CAT_OCUP %in% c(1,2) & PP07G2 == 1
#   - Cuenta propia/patrón sin registro : resto de CAT_OCUP %in% c(1,2)
#   - Sin dato                : CAT_OCUP == 4 u otros
#
# P21 → Ingreso de la ocupación principal (en pesos)
#
# PP3E_TOT → Total de horas trabajadas en la semana en la ocupación principal

datos <- ind %>%
  filter(ESTADO == 1) %>%                          # solo ocupados
  filter(CAT_OCUP %in% 1:4) %>%                    # categoría informada
  filter(!is.na(P21), P21 >= 0) %>%                # ingreso disponible
  filter(!is.na(PP3E_TOT), PP3E_TOT > 0,
         PP3E_TOT != 999) %>%                        # horas disponibles (999 = sin dato)
  mutate(
    # Variable 1: Categoría ocupacional
    Cat_ocup = factor(CAT_OCUP,
                      levels = c(1, 2, 3, 4),
                      labels = c("Patrón/empleador",
                                 "Cuenta propia",
                                 "Asalariado",
                                 "Trab. familiar s/rem.")),

    # Variable 2: Formalidad laboral (variable construida)
    Formalidad = case_when(
      CAT_OCUP == 3 & PP07H  == 1 ~ "Asalariado formal",
      CAT_OCUP == 3 & PP07H  == 2 ~ "Asalariado informal",
      CAT_OCUP %in% c(1, 2) & PP07G2 == 1 ~ "Monotributista",
      CAT_OCUP %in% c(1, 2)               ~ "Cuenta propia/patrón sin registro",
      TRUE ~ "Sin dato"
    ) %>% factor(levels = c("Asalariado formal",
                             "Asalariado informal",
                             "Monotributista",
                             "Cuenta propia/patrón sin registro",
                             "Sin dato")),

    # Variable 3: Ingreso de la ocupación principal
    Ingreso = as.numeric(P21),

    # Variable 4: Horas semanales trabajadas
    Horas_sem = as.numeric(PP3E_TOT)
  )

cat("\nOcupados con datos completos:", nrow(datos), "\n")

# ============================================================
# 3. ANÁLISIS DE VARIABLES CUALITATIVAS
# ============================================================

# --- 3.1 Categoría ocupacional ---
tabla_cat <- datos %>%
  count(Cat_ocup) %>%
  mutate(Porcentaje = round(n / sum(n) * 100, 1))

cat("\n=== CATEGORÍA OCUPACIONAL ===\n")
print(tabla_cat)

# Cuántos monotributistas hay dentro de cuenta propia + patrón
n_mono <- datos %>% filter(Formalidad == "Monotributista") %>% nrow()
n_cp   <- datos %>% filter(Cat_ocup %in% c("Cuenta propia", "Patrón/empleador")) %>% nrow()
cat(sprintf("\nMonotributistas dentro de cuenta propia/patrón: %d de %d (%.1f%%)\n",
            n_mono, n_cp, n_mono / n_cp * 100))

# --- 3.2 Formalidad laboral ---
tabla_form <- datos %>%
  count(Formalidad) %>%
  mutate(Porcentaje = round(n / sum(n) * 100, 1))

cat("\n=== FORMALIDAD LABORAL ===\n")
print(tabla_form)

# --- 3.3 Formalidad dentro de cada categoría ocupacional ---
cat("\n=== FORMALIDAD POR CATEGORÍA OCUPACIONAL ===\n")
datos %>%
  count(Cat_ocup, Formalidad) %>%
  group_by(Cat_ocup) %>%
  mutate(Pct = round(n / sum(n) * 100, 1)) %>%
  print(n = 30)

# ============================================================
# 4. ANÁLISIS DE VARIABLES CUANTITATIVAS
# ============================================================

# Nota: el análisis de ingresos y horas se hace sobre ocupados con P21 > 0
# (se excluyen personas con ingreso cero en la ocupación principal)
datos_ingreso <- datos %>% filter(Ingreso > 0)

# --- 4.1 Ingreso de la ocupación principal (P21) ---
resumen_ingreso <- datos_ingreso %>%
  summarise(
    Media   = round(mean(Ingreso)),
    Mediana = round(median(Ingreso)),
    DS      = round(sd(Ingreso)),
    Q1      = round(quantile(Ingreso, 0.25)),
    Q3      = round(quantile(Ingreso, 0.75)),
    Mínimo  = min(Ingreso),
    Máximo  = max(Ingreso)
  )

cat("\n=== INGRESO OCUPACIÓN PRINCIPAL – P21 (pesos) ===\n")
print(resumen_ingreso)

# Ingreso por categoría ocupacional
cat("\n=== INGRESO POR CATEGORÍA OCUPACIONAL ===\n")
datos_ingreso %>%
  group_by(Cat_ocup) %>%
  summarise(
    Media   = round(mean(Ingreso)),
    Mediana = round(median(Ingreso)),
    DS      = round(sd(Ingreso)),
    n       = n()
  ) %>%
  print()

# Ingreso por formalidad
cat("\n=== INGRESO POR FORMALIDAD ===\n")
datos_ingreso %>%
  group_by(Formalidad) %>%
  summarise(
    Media   = round(mean(Ingreso)),
    Mediana = round(median(Ingreso)),
    n       = n()
  ) %>%
  print()

# --- 4.2 Horas semanales trabajadas (PP3E_TOT) ---
resumen_horas <- datos %>%
  summarise(
    Media   = round(mean(Horas_sem), 1),
    Mediana = median(Horas_sem),
    DS      = round(sd(Horas_sem), 1),
    Q1      = quantile(Horas_sem, 0.25),
    Q3      = quantile(Horas_sem, 0.75),
    Mínimo  = min(Horas_sem),
    Máximo  = max(Horas_sem)
  )

cat("\n=== HORAS SEMANALES TRABAJADAS – PP3E_TOT ===\n")
print(resumen_horas)

# Horas por categoría ocupacional
cat("\n=== HORAS SEMANALES POR CATEGORÍA OCUPACIONAL ===\n")
datos %>%
  group_by(Cat_ocup) %>%
  summarise(
    Media   = round(mean(Horas_sem), 1),
    Mediana = median(Horas_sem),
    DS      = round(sd(Horas_sem), 1),
    n       = n()
  ) %>%
  print()

# ============================================================
# 5. VISUALIZACIONES
# ============================================================

dir.create("graficos", showWarnings = FALSE)

col_azul  <- "#2C7BB6"
col_rojo  <- "#D7191C"
paleta_4  <- c("#2C7BB6", "#ABD9E9", "#FDAE61", "#D7191C")

# -- G1: Distribución por categoría ocupacional --
g1 <- ggplot(tabla_cat, aes(x = reorder(Cat_ocup, Porcentaje), y = Porcentaje)) +
  geom_col(fill = col_azul) +
  geom_text(aes(label = paste0(Porcentaje, "%")), hjust = -0.1, size = 3.5) +
  coord_flip() +
  scale_y_continuous(limits = c(0, 80)) +
  labs(title = "Distribución por categoría ocupacional",
       subtitle = "Ocupados – EPH 4T2025",
       x = NULL, y = "Porcentaje (%)") +
  theme_minimal()

ggsave("graficos/g1_cat_ocup.png", g1, width = 7, height = 4, dpi = 150)

# -- G2: Distribución por formalidad laboral --
g2 <- ggplot(tabla_form %>% filter(Formalidad != "Sin dato"),
             aes(x = reorder(Formalidad, Porcentaje), y = Porcentaje)) +
  geom_col(fill = col_azul) +
  geom_text(aes(label = paste0(Porcentaje, "%")), hjust = -0.1, size = 3.5) +
  coord_flip() +
  scale_y_continuous(limits = c(0, 60)) +
  labs(title = "Distribución por condición de formalidad laboral",
       subtitle = "Ocupados – EPH 4T2025",
       x = NULL, y = "Porcentaje (%)") +
  theme_minimal()

ggsave("graficos/g2_formalidad.png", g2, width = 8, height = 4, dpi = 150)

# -- G3: Boxplot ingreso por categoría ocupacional --
g3 <- ggplot(datos_ingreso, aes(x = Cat_ocup, y = Ingreso, fill = Cat_ocup)) +
  geom_boxplot(outlier.alpha = 0.15, outlier.size = 0.6) +
  scale_y_continuous(labels = scales::comma,
                     limits = c(0, quantile(datos_ingreso$Ingreso, 0.99))) +
  scale_fill_manual(values = paleta_4) +
  labs(title = "Ingreso de la ocupación principal según categoría ocupacional",
       subtitle = "Se excluye el 1% superior – EPH 4T2025",
       x = NULL, y = "Ingreso P21 (pesos)") +
  theme_minimal() +
  theme(legend.position = "none",
        axis.text.x = element_text(angle = 15, hjust = 1))

ggsave("graficos/g3_ingreso_catocup.png", g3, width = 7, height = 5, dpi = 150)

# -- G4: Mediana de ingreso por formalidad --
mediana_form <- datos_ingreso %>%
  filter(Formalidad != "Sin dato") %>%
  group_by(Formalidad) %>%
  summarise(Mediana_ingreso = median(Ingreso))

g4 <- ggplot(mediana_form, aes(x = reorder(Formalidad, Mediana_ingreso),
                                y = Mediana_ingreso)) +
  geom_col(fill = col_azul) +
  geom_text(aes(label = scales::comma(Mediana_ingreso)), hjust = -0.1, size = 3.5) +
  coord_flip() +
  scale_y_continuous(labels = scales::comma,
                     limits = c(0, max(mediana_form$Mediana_ingreso) * 1.2)) +
  labs(title = "Mediana del ingreso por condición de formalidad",
       subtitle = "Ocupados con P21 > 0 – EPH 4T2025",
       x = NULL, y = "Ingreso mediano P21 (pesos)") +
  theme_minimal()

ggsave("graficos/g4_ingreso_formalidad.png", g4, width = 8, height = 4, dpi = 150)

# -- G5: Histograma de horas semanales --
g5 <- ggplot(datos, aes(x = Horas_sem)) +
  geom_histogram(binwidth = 4, fill = col_azul, color = "white") +
  geom_vline(xintercept = mean(datos$Horas_sem), color = col_rojo,
             linetype = "dashed", linewidth = 0.8) +
  annotate("text", x = mean(datos$Horas_sem) + 1, y = Inf,
           label = paste0("Media: ", round(mean(datos$Horas_sem), 1), " hs"),
           vjust = 2, hjust = 0, color = col_rojo, size = 3.5) +
  labs(title = "Distribución de horas semanales trabajadas",
       subtitle = "Ocupación principal – EPH 4T2025",
       x = "Horas semanales (PP3E_TOT)", y = "Frecuencia") +
  theme_minimal()

ggsave("graficos/g5_horas.png", g5, width = 6, height = 4, dpi = 150)

cat("\nGráficos guardados en graficos/\n")
cat("Análisis completado.\n")



ind %>%
  filter(CAT_OCUP %in% c(1, 2)) %>%
  count(PP07G2)

datos %>% count(PP3E_TOT) %>% arrange(desc(PP3E_TOT)) %>% head(20)

ind %>%
  filter(CAT_OCUP %in% c(1, 2)) %>%
  select(starts_with("PP07G")) %>%
  summary()
