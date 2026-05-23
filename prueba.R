# ============================================================
# Trabajo Práctico Probabilidad y Estadística TUIA 2026
# Dataset: EPH Individual – 4° Trimestre 2025 (INDEC).
# Tema: Situación laboral en Argentina.
# ============================================================
install.packages('eph')
install.packages('tidyverse')
install.packages('psych')
library(eph)
library(tidyverse)
library(psych)

options(scipen = 999) # Elimina la notación científica

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
# Población de interés: Personas con trabajo → OCUPADOS (Campo: ESTADO == 1)

# Variables cualitativas:

# CAT_OCUP → Categoría ocupacional
#   1 = Patrón / empleador
#   2 = Cuenta propia
#   3 = Obrero / empleado (relación de dependencia)
#   4 = Trabajador familiar sin remuneración

# EMPLEO → Condición de formalidad laboral (asalariados y trabajadores independientes)
#   1 = Formal
#   2 = Informal
#   9 = Ns/Nr

# Variables cuantitativas:

# P21 → Ingreso de la ocupación principal (en pesos)

# PP3E_TOT → Total de horas trabajadas en la semana en la ocupación principal


datos <- ind %>%
  filter(ESTADO == 1) %>%                          # solo ocupados
  filter(CAT_OCUP %in% 1:4) %>%                    # categoría ocupacional
  filter(!is.na(P21), P21 >= 0) %>%                # ingreso mensual
  filter(!is.na(PP3E_TOT), PP3E_TOT > 0,
         PP3E_TOT != 999) %>%            # horas semanales trabajadas (999 = sin dato)
  mutate(
    # Variable 1: Categoría ocupacional
    Cat_ocupacional = factor(CAT_OCUP,
                      levels = c(1, 2, 3, 4),
                      labels = c("Patrón/empleador",
                                 "Cuenta propia",
                                 "Asalariado",
                                 "Trab. familiar s/rem.")),

    # Variable 2: Formalidad laboral (Campo: EMPLEO)
    Formalidad = case_when(
      EMPLEO == 1 ~ "Formal",
      EMPLEO == 2 ~ "Informal",
      TRUE        ~ "Sin dato"
    ) %>% factor(levels = c("Formal", "Informal", "Sin dato")),

    # Variable 3: Ingreso en pesos de la ocupación principal
    Ingreso_mensual_ARS = as.numeric(P21),

    # Variable 4: Horas semanales trabajadas
    Horas_semanales = as.numeric(PP3E_TOT)
  ) %>%
  select(Cat_ocupacional, Formalidad, Ingreso_mensual_ARS, Horas_semanales)

cat("\nOcupados con datos completos:", nrow(datos), "\n")

# ============================================================
# 3. ANÁLISIS DE VARIABLES CUALITATIVAS
# ============================================================

# --- 3.1 Categoría ocupacional ---
tabla_cat <- datos %>%
  count(Cat_ocupacional) %>%
  mutate(Porcentaje = round(n / sum(n) * 100, 1))

cat("\n=== CATEGORÍA OCUPACIONAL ===\n")
print(tabla_cat)

# --- 3.2 Formalidad laboral ---
tabla_form <- datos %>%
  count(Formalidad) %>%
  mutate(Porcentaje = round(n / sum(n) * 100, 1))

cat("\n=== FORMALIDAD LABORAL ===\n")
print(tabla_form)

# --- 3.3 Formalidad dentro de cada categoría ocupacional ---
cat("\n=== FORMALIDAD POR CATEGORÍA OCUPACIONAL ===\n")
tabla_formalidad_por_cat <- datos %>%
  count(Cat_ocupacional, Formalidad) %>%
  group_by(Cat_ocupacional) %>%
  mutate(Porcentaje = round(n / sum(n) * 100, 1))

print(tabla_formalidad_por_cat, n = 30)

# ============================================================
# 4. ANÁLISIS DE VARIABLES CUANTITATIVAS
# ============================================================

# El análisis de ingresos y horas se hace sobre ocupados con ingresos (P21) > 0
datos_ingreso <- datos %>% filter(Ingreso_mensual_ARS > 0)

# --- 4.1 Ingreso de la ocupación principal (P21) ---
resumen_ingreso <- datos_ingreso %>%
  summarise(
    Media = round(mean(Ingreso_mensual_ARS)),
    Mediana = round(median(Ingreso_mensual_ARS)),
    DS = round(sd(Ingreso_mensual_ARS)),
    Q1 = round(quantile(Ingreso_mensual_ARS,0.25)),
    Q3 = round(quantile(Ingreso_mensual_ARS,0.75)),
    Mínimo = min(Ingreso_mensual_ARS),
    Máximo = max(Ingreso_mensual_ARS)
  )

cat("\n=== INGRESO OCUPACIÓN PRINCIPAL – P21 (pesos) ===\n")
print(resumen_ingreso)

# Ingreso por categoría ocupacional
cat("\n=== INGRESO POR CATEGORÍA OCUPACIONAL ===\n")
ingreso_por_categoriria <- datos_ingreso %>%
  group_by(Cat_ocupacional) %>%
  summarise(
    Media = round(mean(Ingreso_mensual_ARS)),
    Mediana = round(median(Ingreso_mensual_ARS)),
    DS = round(sd(Ingreso_mensual_ARS)),
    n = n()
  ) %>%
  print()

# Ingreso por formalidad
cat("\n=== INGRESO POR FORMALIDAD ===\n")
ingreso_por_formalidad <- datos_ingreso %>%
  group_by(Formalidad) %>%
  summarise(
    Media   = round(mean(Ingreso_mensual_ARS)),
    Mediana = round(median(Ingreso_mensual_ARS)),
    n       = n()
  ) %>%
  print()

# --- 4.1.1 Forma de distribución del ingreso ---
cat("\n=== FORMA DE DISTRIBUCIÓN – INGRESO ===\n")
cat("Asimetría:", round(skew(datos_ingreso$Ingreso_mensual_ARS), 3), "\n")
cat("CV (%):", round(100 * sd(datos_ingreso$Ingreso_mensual_ARS) /
                       mean(datos_ingreso$Ingreso_mensual_ARS), 1), "\n")

# --- 4.2 Horas semanales trabajadas (PP3E_TOT) ---
resumen_horas <- datos %>%
  summarise(
    Media   = round(mean(Horas_semanales), 1),
    Mediana = median(Horas_semanales),
    DS      = round(sd(Horas_semanales), 1),
    Q1      = quantile(Horas_semanales, 0.25),
    Q3      = quantile(Horas_semanales, 0.75),
    Mínimo  = min(Horas_semanales),
    Máximo  = max(Horas_semanales)
  )

cat("\n=== HORAS SEMANALES TRABAJADAS – PP3E_TOT ===\n")
print(resumen_horas)

# Horas por categoría ocupacional
cat("\n=== HORAS SEMANALES POR CATEGORÍA OCUPACIONAL ===\n")
datos %>%
  group_by(Cat_ocupacional) %>%
  summarise(
    Media   = round(mean(Horas_semanales), 1),
    Mediana = median(Horas_semanales),
    DS      = round(sd(Horas_semanales), 1),
    n       = n()
  ) %>%
  print()

# --- 4.2.1 Forma de distribución de horas ---
cat("\n=== FORMA DE DISTRIBUCIÓN – HORAS ===\n")
cat("Asimetría:", round(skew(datos$Horas_semanales), 3), "\n")
cat("CV (%):", round(100 * sd(datos$Horas_semanales) /
                       mean(datos$Horas_semanales), 1), "\n")

# ============================================================
# 5. VISUALIZACIONES
# ============================================================

dir.create("graficos", showWarnings = FALSE)

col_azul  <- "#2C7BB6"
col_rojo  <- "#D7191C"
paleta_4  <- c("#2C7BB6", "#ABD9E9", "#FDAE61", "#D7191C")

# -- G1: Distribución por categoría ocupacional --
g1 <- ggplot(tabla_cat, aes(x = reorder(Cat_ocupacional, Porcentaje), y = Porcentaje)) +
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
tabla_form_pie <- tabla_form %>%
  filter(Formalidad != "Sin dato") %>%
  mutate(Porcentaje = round(n / sum(n) * 100, 1))

g2 <- ggplot(tabla_form_pie,
             aes(x = "", y = Porcentaje, fill = Formalidad)) +
  geom_bar(stat = "identity", width = 1) +
  coord_polar("y", start = 0) +
  geom_text(aes(label = paste0(Porcentaje, "%")),
            position = position_stack(vjust = 0.5), size = 5) +
  scale_fill_manual(values = c("Formal" = col_azul, "Informal" = col_rojo)) +
  labs(title = "Distribución por condición de formalidad laboral",
       subtitle = "Ocupados – EPH 4T2025",
       fill = NULL) +
  theme_void()

ggsave("graficos/g2_formalidad.png", g2, width = 5, height = 5, dpi = 150, bg = "white")

# -- G3: Boxplot ingreso por categoría ocupacional --
stats_g3 <- datos_ingreso %>%
  group_by(Cat_ocupacional) %>%
  summarise(
    Min     = quantile(Ingreso_mensual_ARS, 0.00),
    Q1      = quantile(Ingreso_mensual_ARS, 0.25),
    Mediana = quantile(Ingreso_mensual_ARS, 0.50),
    Q3      = quantile(Ingreso_mensual_ARS, 0.75),
    Max     = quantile(Ingreso_mensual_ARS, 0.99)
  ) %>%
  pivot_longer(-Cat_ocupacional, names_to = "stat", values_to = "valor")

g3 <- ggplot(datos_ingreso, aes(x = Cat_ocupacional, y = Ingreso_mensual_ARS, fill = Cat_ocupacional)) +
  geom_boxplot(outlier.alpha = 0.15, outlier.size = 0.6) +
  geom_text(data = stats_g3,
            aes(x = Cat_ocupacional, y = valor,
                label = format(round(valor), big.mark = ".", scientific = FALSE)),
            hjust = -0.05, nudge_x = 0.42, size = 2.2, inherit.aes = FALSE) +
  scale_y_continuous(labels = function(x) format(x, big.mark = ".", scientific = FALSE),
                     limits = c(0, quantile(datos_ingreso$Ingreso_mensual_ARS, 0.99))) +
  scale_fill_manual(values = paleta_4) +
  labs(title = "Ingreso de la ocupación principal según categoría ocupacional",
       subtitle = "Se excluye el 1% superior – EPH 4T2025",
       x = NULL, y = "Ingreso (pesos)") +
  theme_minimal() +
  theme(legend.position = "none",
        axis.text.x = element_text(angle = 15, hjust = 1))

ggsave("graficos/g3_ingreso_catocup.png", g3, width = 10, height = 5, dpi = 150)

# -- G4: Mediana de ingreso por formalidad --
mediana_form <- datos_ingreso %>%
  filter(Formalidad != "Sin dato") %>%
  group_by(Formalidad) %>%
  summarise(Mediana_ingreso = median(Ingreso_mensual_ARS))

g4 <- ggplot(mediana_form, aes(x = reorder(Formalidad, Mediana_ingreso),
                                y = Mediana_ingreso)) +
  geom_col(fill = col_azul) +
  geom_text(aes(label = format(Mediana_ingreso, big.mark = ".", scientific = FALSE)), hjust = -0.1, size = 3.5) +
  coord_flip() +
  scale_y_continuous(labels = function(x) format(x, big.mark = ".", scientific = FALSE),
                     limits = c(0, max(mediana_form$Mediana_ingreso) * 1.2)) +
  labs(title = "Mediana del ingreso por condición de formalidad",
       subtitle = "Ocupados con P21 > 0 – EPH 4T2025",
       x = NULL, y = "Ingreso mediano P21 (pesos)") +
  theme_minimal()

ggsave("graficos/g4_ingreso_formalidad.png", g4, width = 8, height = 4, dpi = 150)

# -- G5: Histograma de horas semanales --
g5 <- ggplot(datos, aes(x = Horas_semanales)) +
  geom_histogram(binwidth = 4, fill = col_azul, color = "white") +
  geom_vline(xintercept = mean(datos$Horas_semanales), color = col_rojo,
             linetype = "dashed", linewidth = 0.8) +
  annotate("text", x = mean(datos$Horas_semanales) + 1, y = Inf,
           label = paste0("Media: ", round(mean(datos$Horas_semanales), 1), " hs"),
           vjust = 2, hjust = 0, color = col_rojo, size = 3.5) +
  labs(title = "Distribución de horas semanales trabajadas",
       subtitle = "Ocupación principal – EPH 4T2025",
       x = "Horas semanales", y = "Frecuencia") +
  theme_minimal()

ggsave("graficos/g5_horas.png", g5, width = 6, height = 4, dpi = 150)

saveRDS(datos, "datos_EPH.rds")
