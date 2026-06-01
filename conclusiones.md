TRABAJO PRÁCTICO: PROBABILIDAD Y

ESTADÍSTICA

Informe de Cátedra - Segunda Parte: Estimación e Inferencia (TUIA 2026)

a) Selección y Justificación de la Variable de Agrupación

Para profundizar en el impacto de la estructura laboral sobre la distribución de ingresos en Argentina, se

seleccionó la variable cualitativa  "Categoría Ocupacional"  con el propósito de segmentar la muestra de

ocupados extraída de la Encuesta Permanente de Hogares (EPH) correspondiente al 4° Trimestre de 2025

[cite:   tp_PyE_consignas.md].   El   análisis   inferencial   se   centrará   específicamente   en   los   tres   colectivos

principales   que   perciben   ingresos   monetarios   directos   por   su   actividad   de   manera   independiente   o   bajo

relación de dependencia: Patrón / Empleador, Asalariado y Cuenta Propia [cite: prueba.R]. Se excluye de

este   análisis   particular   únicamente   a   los   trabajadores   familiares   sin   remuneración,   debido   a   su   carácter

marginal (0.5%) y a que su ingreso declarado es nulo por definición estructural [cite: g1_cat_ocup.png].

Justificación socioeconómica:  En el mercado de trabajo argentino, la categoría ocupacional actúa como

un vector de segmentación estructural y una barrera institucional en la determinación de las retribuciones

económicas. Comparar las medias de ingresos de estos tres sectores permite dimensionar analíticamente las

brechas entre quienes asumen el riesgo de inversión capitalista y coordinan equipos de trabajo (patrones),

quienes   venden   su   fuerza   laboral   bajo   un   marco   de   dependencia   jurídica   y   regulatoria   (asalariados),   y

quienes   dependen   de   la   auto-ocupación   o   el   autoempleo   en   un   contexto   volátil   (cuentapropistas)   [cite:

prueba.R]. Evaluar si estas diferencias observables en la muestra son estadísticamente significativas en la

población   es   indispensable   para   mapear   los   niveles   de   precarización,   concentración   del   ingreso   y

desigualdad en el tejido socioeconómico actual [cite: recomendaciones.md].

b) Identificación de los Parámetros de Interés y Notación

La variable cuantitativa continua de estudio es el Ingreso de la ocupación principal (en pesos argentinos,

ARS)  [cite: prueba.R]. Los parámetros de interés sobre los cuales se realiza la inferencia son las  medias
poblacionales   (μi)  del   ingreso   mensual   para   cada   una   de   las   subpoblaciones   definidas   [cite:
tp_PyE_consignas.md].

La   notación   estadística   formal   y   los   estimadores   puntuales   obtenidos   de   la   muestra   se   definen   a

continuación:

•

Subpoblación 1: Patrón / Empleador

◦

μ1: Media poblacional del ingreso mensual de la ocupación principal para los patrones en Argentina.

◦

x̄1: Media muestral calculada de ingresos para el estrato patronal ($1.854.989) [cite: g6_ic_ingreso.png].

◦

n1: Tamaño muestral del sector patronal en la base de la EPH [cite: prueba.R].

TUIA 2026 - Probabilidad y Estadística

1

•

Subpoblación 2: Asalariados

◦

μ2: Media poblacional del ingreso mensual de la ocupación principal para los obreros y empleados en
Argentina.

◦

x̄2: Media muestral calculada de ingresos para el sector asalariado ($959.267) [cite: g6_ic_ingreso.png].

◦

n2: Tamaño muestral de asalariados registrados en la encuesta [cite: prueba.R].

•

Subpoblación 3: Trabajadores por Cuenta Propia

◦

μ3: Media poblacional del ingreso mensual de la ocupación principal para los cuentapropistas en
Argentina.

◦

x̄3: Media muestral calculada de ingresos para los trabajadores independientes ($742.347) [cite:
g6_ic_ingreso.png].

◦

n3: Tamaño muestral del sector cuentapropista bajo análisis [cite: prueba.R].

c) Inferencia Estadística: Intervalos de Confianza y Pruebas de Hipótesis

Con el propósito de evaluar la generalidad de las brechas de ingresos, se modeló la estimación por intervalos

de confianza y el contraste formal de hipótesis para muestras independientes con varianzas poblacionales

desconocidas   [cite:   tp_PyE_consignas.md].   Dado   el   masivo   volumen   de   registros   de   la   EPH   para   cada
categoría ocupacional (ni  ≥ 30), el Teorema del Límite Central (TLC) garantiza la aproximación asintótica a
través de la distribución Normal Estándar (Z) [cite: recomendaciones.md]. Por consiguiente, los estimadores

convergen a la normalidad de forma equivalente a una distribución t-Student con infinitos grados de libertad.

1. Estimación por Intervalos de Confianza (95%)

A partir del procesamiento de datos en el entorno R, se construyeron los intervalos de confianza del 95%
para la verdadera media poblacional (μi) de cada categoría laboral [cite: prueba.R, g6_ic_ingreso.png]:

Categoría Ocupacional

Ingreso Medio Muestral (x̄i)

Intervalo de Confianza del 95%

1. Patrón / Empleador

$1.854.989

[$1.685.000 ; $2.025.000]

2. Asalariado

$959.267

[$935.000 ; $984.000]

3. Cuenta Propia

$742.347

[$715.000 ; $770.000]

Interpretación   probabilística:  Con   un   nivel   de   confianza   del   95%,   se   estima   que   la   media   real   de   los

ingresos mensuales de los patrones se sitúa entre los  $1.685.000  y los  $2.025.000  [cite: g6_ic_ingreso.png].

Con el mismo criterio estadístico, el verdadero promedio de ingresos del sector asalariado se halla acotado

entre $935.000 y $984.000, mientras que la media poblacional del cuentapropismo se ubica en el rango de los

$715.000 a los $770.000 [cite: g6_ic_ingreso.png].

TUIA 2026 - Probabilidad y Estadística

2

2. Contraste de Hipótesis para la Brecha Estructural (Patrones vs. Trabajadores)

Para   convalidar   analíticamente   el   patrón   de   segmentación,   se   plantea   una   prueba   de   hipótesis   bilateral
enfocada en contrastar la media de la subpoblación de mayores ingresos (Patrones,  μ1) frente a la de la
masa laboral dependiente (Asalariados, μ2):

•
Hipótesis Nula (H0): μ1 − μ2 = 0 (No existe diferencia significativa entre la media poblacional de ingresos
de patrones y asalariados).

•
Hipótesis Alternativa (H1): μ1 − μ2 ≠ 0 (Existe una diferencia estadísticamente significativa entre ambos
ingresos medios).

Bajo la condición de validez de H0, el estadístico de prueba estandarizado se formula algebraicamente como:

Zcalc = &frac;(x̄1 − x̄2) − 0, √( (s1

2 / n1) + (s2

2 / n2) )

Para un nivel de significación normativo de  α = 0.05, los valores críticos bilaterales corresponden a  Zcrít  =
±1.96.   Al   resolver   computacionalmente   la   fórmula,   la   enorme   distancia   entre   las   medias   muestrales   (Δ   =

$895.722) y la precisión conferida por los grandes tamaños de muestra derivan en un estadístico de prueba
Zcalc  que  excede  críticamente  el  umbral  superior  de  rechazo  de  la  distribución,  consolidando  un  p-valor
asintóticamente igual a 0 (p < 0.05).

3. Interpretación Contextual e Integración

Al   ser   el   p-valor   menor   que   el   nivel   de   significación   adoptado   (α   =   0.05),  se   rechaza   formalmente   la
Hipótesis Nula (H0). Existe evidencia empírica categórica en la muestra de la EPH para asegurar que las
diferencias salariales entre los estratos de ocupación en Argentina son estadísticamente significativas y no un

producto   colateral   de   fluctuaciones   o   desvíos   del   muestreo   [cite:   tp_PyE_consignas.md,

recomendaciones.md].

Conclusión y Sugerencia Estadística: La absoluta falta de superposición visual y numérica entre los

tres   intervalos   calculados   (el   límite   inferior   de   los   patrones   se   sitúa  $701.000  por   encima   del   límite

superior asalariado, el cual a su vez aventaja por $165.000 al techo cuentapropista) ratifica una severa

segmentación   estructural   en   la   distribución   de   la   riqueza

[cite:   g6_ic_ingreso.png].   Los

empleadores   consolidan   una   posición   económica   superior   que   duplica   la   remuneración   del   sector

asalariado y casi triplica la del autoempleo [cite: g6_ic_ingreso.png]. Este comportamiento se halla en

perfecta consonancia con el análisis descriptivo primario del informe: la tasa de informalidad general

alcanza el  44.9%  [cite: g2_formalidad.png], provocando que la mitad de la masa laboral precarizada

perciba un ingreso mediano de apenas $400.000 o menos [cite: g4_ingreso_formalidad.png], una barrera

económica que deprime el escalón de ingresos de los cuentapropistas e independientes frente a las

estructuras de capital [cite: g3_ingreso_catocup.png].

TUIA 2026 - Probabilidad y Estadística

3

