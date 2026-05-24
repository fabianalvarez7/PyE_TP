Probabilidad y Estadística

TUIA - FCEIA

Unidad 6 - Muestras aleatorias e inferencia

Gottig, Nicolás
Avila, Aylen
L'heureux, Julián

REPASO

¿Cuál es la variable de medición y la población?
¿Qué característica tiene?
¿Cómo podemos abordarlo?
¿Podemos pensar en las etapas para resolver el problema?

REPASO

REPASO

REPASO

REPASO

REPASO

REPASO

¿Qué características debe tener una buena muestra?

REPASO

EN EL PLANTEO DEL PROBLEMA SE DEBE…

● Delimitar claramente la población
● Decidir  sobre  qué  población  estadística  se  desea  conocer

alguna característica (parámetro o forma).

● Deﬁnir si el objetivo es:

○ Conocer  el  comportamiento  de  una  cierta  variable  en

○

una población
Estimar  un  parámetro  (media  poblacional,  proporción
pob…, desvío pob…)

○ Decidir  sobre  un  valor  hipotético  que  le  asignamos  a

dichos parámetros).

REPASO

EN LA PLANIFICACIÓN DEBEMOS…

● Deﬁnir  el  tipo  y  tamaño  de  la  muestra  (más  allá  del  diseño

muestral, recordar siempre la aleatoriedad)

● Deﬁnir los estadísticos.
● Decidir el nivel de error y los riesgos asociados.
●
●

Elegir las herramientas de inferencia que correspondan.
Veriﬁcar los requerimientos (supuestos) de las técnicas

Para la media poblacional.. la
media muestral.

Para la proporción, la
frecuencia relativa de la
muestra es el mejor estimador

Usamos un estimador
(estadístico)

Parámetro

Para la varianza poblacional, la
varianza muestral es el mejor
estimador

MUESTRAS ALEATORIAS

MUESTRAS ALEATORIAS

MUESTRAS NO ALEATORIAS

●

Las  unidades  de  la  población

●

Las  unidades  que  integran  la

tienen  cierta  chance  de  ser

muestra  se  seleccionan  por

seleccionadas.

criterio de conveniencia.

●

Las unidades que participan se

●

En general están sesgadas. No

eligen mediante el azar.

reﬂejan  el  comportamiento  de

● No  presenta  un  sesgo  de

toda la población.

selección.

●

Permiten  calcular  los  riesgos

de inferencias erroneas.

MUESTRAS ALEATORIAS

TIPOS DE MUESTRAS ALEATORIAS

● MUESTRA  ALEATORIA  ESTRATIFICADA.  (Se  divide  la  población  en  estratos  homogéneos

para adentro y se examinan parcialmente).

● MUESTRA  ALEATORIA  POR  CONGLOMERADOS.  (Se  seleccionan  m  conglomerados  y  se

observan todas las unidades o una muestra, son heterogéneos para adentro).

● MUESTRA ALEATORIA SISTEMÁTICA. Se selecciona una unidad cada k unidades.

● MUESTRA ALEATORIA SIMPLE. Se seleccionan n elementos de una población, cada uno con la

misma probabilidad de ser seleccionado.

MUESTRAS ALEATORIAS

LA MUESTRA ALEATORIA ES UN VECTOR ALEATORIO DE TAMAÑO n (antes de ser seleccionadas)

Cada una de esas V.A son los posibles valores que puede tomar un individuo i. Se dice que las variables Xi
(con i = 1, 2…, n) son i.i.d (independientes e idénticamente distribuidas).

DESPUÉS DE SELECCIONARLAS SE CONVIERTE EN UN VECTOR DE NÚMEROS U OBSERVACIONES

A partir de esta muestra realizaremos el análisis descriptivo (cap. 2) y el análisis inferencial (cap 8).

MUESTRAS ALEATORIAS

Si  un  estimador  es  una  función  de  las  variables  de  la  muestra…  ¡TAMBIÉN  ES  UNA

VARIABLE  ALEATORIA!  y  por  lo  tanto  tienen  una  distribución…  ¿Cuál  es  la

distribución asociada a los estadísticos?

TEOREMA CENTRAL DEL LÍMITE

Si  el  tamaño  de  la  muestra  es  suﬁcientemente  grande,  la  distribución  de  la  media

muestral se aproxima a una distribución normal, sin importar la distribución original

de la población.

Teorema Central del Límite interactivo

https://seeing-theory.brown.edu/probability-distributions/index.html#section3

TEOREMA CENTRAL DEL LÍMITE

LA VARIABLE ALEATORIA X TIENE DISTRIBUCIÓN NORMAL

La media muestral también tiene dist. Normal para cualquier tamaño de n.

SI LA V.A. X NO TIENE DIST. NORMAL PERO n ES SUFICIENTEMENTE GRANDE:

Por el Teorema Central del Límite, si n es suﬁcientemente grande, la media muestral se acerca a la normal.

La  naturaleza  del  estudio  y  la  técnica  a  utilizar  condicionan  la  suﬁciencia  del  tamaño  muestral  para  una  buena  estimación.  El  número  mínimo  para  obtener  una
buena aproximación depende de la distribución de las variables aleatorias individuales.. cuanto más sesgadas, mayor deberá ser el valor de n. En la práctica más de
30, 50, 80 o 100.. (aunque podría ser mucho menos si la distribución de la población es parecida a la normal)

DISTRIBUCIÓN DE LOS ESTIMADORES

Si conocemos la distribución de la media muestral (por ende, sus propiedades) podemos conocer la probabilidad de cometer un error en la estimación. ¿Qué pasa
con la distribución de la media muestral cuando aumenta n?

DISTRIBUCIÓN DE LOS ESTIMADORES

https://mpru.shinyapps.io/samplingDistributions/

Distribución beta de parámetros a = 1 y b = 2 y distribución de la media muestral para 500 rep. n = 50.

INFERENCIA

ESTIMACIÓN PUNTUAL
• Se asigna al parámetro, de manera aproximada, el mismo valor que se obtuvo para el estadístico en

la muestra.

ESTIMACIÓN POR INTERVALO DE CONFIANZA
• Se asigna un conjunto de valores al parámetro a partir del valor del estadístico en la muestra. Ese

conjunto de valores cubre al valor del parámetro con un cierto nivel de conﬁanza.

PRUEBA DE HIPÓTESIS
• Se prueba una hipótesis sobre la población (por ejemplo, sobre el valor de algún parámetro) a partir

de información de una muestra tomada de dicha población

INFERENCIA

Si queremos estimar el valor de un parámetro…

- Deﬁnimos un estadístico que nos dé información sobre ese parámetro, es decir, deﬁnimos un ESTIMADOR

- Seleccionamos una muestra de la población de interés

- Calculamos el valor de ese estimador con los datos de la muestra

EN LA ESTIMACIÓN PUNTUAL LE ASIGNAMOS AL PARÁMETRO, DE MANERA APROXIMADA, EL RESULTADO DE LA
ESTIMACIÓN EN LA MUESTRA

¿PODEMOS AGREGAR MÁS INFORMACIÓN SOBRE LA ESTIMACIÓN?

INFERENCIA

La media muestral se distribuye

La proporción se distribuye

La varianza muestral se distribuye

Si  X  es  normal  o  n  es
suﬁcientemente grande.

lo

Si  la  relación  entre  el  tamaño  de  la
muestra y la proporción cumple con:

Si no se cumplen estos requisitos se
usan métodos no paramétricos y de
libre distribución

Si no se cumplen estos requisitos se
realiza  la  estimación  con  intervalos
exactos, basados en binomial.

Si  X  es  normal.  Si  no  lo  es  se  deben
usar
la
varianza (Ej. método de Bonnet)

robustos  para

intervalos

INFERENCIA

PARA EL INTERVALO DE CONFIANZA

-

-

-

-

Fijamos un nivel de conﬁanza (1-alfa)... o de riesgo (alfa)... alfa = nivel de riesgo

Por ejemplo, si alfa = 0.05, el nivel de conﬁanza es 0.95, o 95 %. Subamos la conﬁanza a 99 %.

Calculamos el error de estimación con la distribución que corresponda (según conozcamos o no sigma)

Calculamos los intervalos de conﬁanza.

La  distribución  sobre  la  que
calculamos los intervalos NO
es  de  la  variable,  sino  de  su
media muestral.

IC PARA LA MEDIA (DESVÍO CONOCIDO)

DESPUÉS DE RECOLECTAR LOS DATOS (Y considerando que conocemos el desvío poblacional):

¿Cómo se interpreta entonces el intervalo de conﬁanza?

ANTES DE RECOLECTAR LOS DATOS (Y considerando que conocemos el desvío poblacional):

IC PARA LA MEDIA (DESVÍO CONOCIDO)

Un  grupo  de  biólogos  está  investigando  la  longitud  de  peces
adultos  de  cierta  especie  que  habita  en  un  lago.  Por  estudios
anteriores  se  conoce  que  esta  variable  se  comporta  según  el
modelo  Normal  y  que  la  desviación  estándar  poblacional  es  de
0,6 cm; pero no se conoce la longitud promedio poblacional.
Los biólogos seleccionan una muestra aleatoria de 25 ejemplares
adultos de esta especie y encuentran que la longitud promedio de
la muestra es de 27,2 cm.

a)
b)

c)
d)

Deﬁna población y variable de interés.
Estime la longitud promedio poblacional con un nivel de conﬁanza
de 95 %. Interprete el intervalo obtenido en términos del problema.
Antes de tomar la muestra, ¿qué signiﬁca el valor 0,95?
¿Cómo determinaríamos el tamaño de la muestra?

DISTRIBUCIÓN NORMAL

¿Suponemos que la muestra es aleatoria y proviene de una distribución normal, cómo lo evaluamos?

DISTRIBUCIÓN NORMAL

¿Cómo sabemos si los datos se distribuyen normalmente?

●

●

Se  utilizan  pruebas  de  “bondad  de  ajuste”  (test  de  hipótesis)

sobre las muestras.

También  puede  evaluarse  a  través  de

los  diagramas  de

probabilidad (funcionan mejor para muestras grandes!)

Diagramas de probabilidad

Compara los percentiles teóricos de una distribución con los percentiles

empíricos  de  nuestra  muestra…  Esto  nos  aporta  información  sobre  si

podemos rechazar la normalidad, no aceptarla.

DISTRIBUCIÓN NORMAL

DISTRIBUCIÓN NORMAL

LOS GRÁFICOS SE ACOMPAÑAN CON UNA PRUEBA DE AJUSTE

Como otras, la prueba de Anderson Darling parte de la hipótesis de que los datos siguen una distribución normal. Con la

información de la muestra vemos si es posible rechazar esta hipótesis.

Para esto nos ﬁjamos en un valor especíﬁco (p-valor). Si es grande (0.05, 0.10) esta hipótesis no puede rechazarse. En R el

paquete nortest incluye una sentencia ad.test(x).

Anderson darling parte de que:

Hipótesis nula: La distribución es normal.

Hipótesis alternativa: La distribución no es normal.

P-Valor > 0.05… no podemos rechazar que la distribución sea normal.

DISTRIBUCIÓN NORMAL

Anderson-Darling normality test

Anderson-Darling normality test

Anderson-Darling normality test

data:  dnormal
A = 0.26182, p-value = 0.6848

data:  dexp
A = 1.1355, p-value = 0.004919

data:  dbeta
A = 1.8214, p-value = 9.311e-05

NO OLVIDAR LA ALEATORIEDAD

IC PARA LA MEDIA (DESVÍO CONOCIDO)

Considerando:

a.

b.

Que la población  es inﬁnita  (en la práctica, una población de un tamaño desconocido y  presumiblemente muy
grande).
Que conocemos el desvío de la población.

Podemos estimar el valor de n despejando del ERROR…

1.
2.
3.

Debemos ﬁjar el nivel de riesgo (o conﬁanza). Ej. Conﬁanza al 95 %.
Debemos ﬁjar el valor que pretendemos para el ERROR.
Despejamos n.

IC PARA LA MEDIA (DESVÍO DESCONOCIDO)

¿ QUÉ PASA SI NO CONOCEMOS EL DESVÍO POBLACIONAL?
Usamos la distribución t-student en vez de la distribución normal para calcular el error de estimación.

La distribución t-student recibe como parámetro los grados de libertad (n-1). Si n es grande, se aproxima a la normal.
Tiene colas “más pesadas”, por lo que los intervalos resultarán más amplios (menos precisos).

El intervalo resulta:

IC PARA LA MEDIA (DESVÍO DESCONOCIDO)

IC PARA LA MEDIA (DESVÍO DESCONOCIDO)

6 - Los siguientes datos corresponden a la resistencia a la
tensión (en kg / cm2) de 16 trozos de ﬁbra seleccionados
al  azar:

48,89 - 52,07 - 49,29 - 51,66 -  51,16 - 49,72 - 48,50 - 50,25 -
49,20 - 48,10 - 47,90 - 46,94 - 51,76 - 50,75 - 49,86 - 51,57

a)

a)

b)

c)

¿La  muestra  sugiere  que  la  distribución  de  la
variable en la población es normal?
Estime la resistencia promedio a la tensión con un
nivel de conﬁanza del 98 %. Interprete el resultado
obtenido.
¿Qué  ocurriría  con  la  precisión  de  la  estimación  si
se  decidiera  construir  un  intervalo  con  un  nivel  de
conﬁanza mayor? Comente.
¿Y  si  quisiera  mayor  nivel  de  conﬁanza  y  mayor
precisión?

INFERENCIA SOBRE LA PROPORCIÓN

ESTIMACIÓN DE LA PROPORCIÓN POBLACIONAL (pi)

●
●
●
●

●
●

LA FORMA DE ESTIMAR LA PROPORCIÓN POBLACIONAL ES SIMILAR A LA MEDIA, PERO SE UTILIZAN OTRAS DISTRIBUCIONES COMO BASE.
La estimación puntual de pi es la frec. relativa muestral.
Para los intervalos de conﬁanza se ﬁja un nivel de conﬁanza (1-alfa) o un nivel de riesgo (alfa) y se calculan los errores.
La V.A X toma el valor 1 o 0 de acuerdo al éxito. Su distribución es Bernoulli con parámetro pi, donde pi es la proporción de éxitos (y el parámetro que
nos interesa!!).
Se toma una muestra de n elementos y se calcula la frecuencia relativa muestral. (fo).
Si n es lo suﬁcientemente grande tal que n.fo >= 5 y n(1- fo) >= 5 la distribución binomial se acerca a la distribución normal… pero podemos usar la
distribución exacta (binomial)

LOS INTERVALOS EXACTOS PUEDEN DEDUCIRSE A PARTIR DE LA BINOMIAL. No se presentan los intervalos pero pueden realizarse en R de forma exacta.

En  R  usamos  funciones  del  paquete  DescTools.  Cuando  se  calculan  los  intervalos  aproximados  (basados  en  Z)  se  utiliza  el  método  “Wald”.  Si  se  calculan  los
intervalos exactos se usa el método “Clopper-pearson”. El método por defecto está basado en Z.

INFERENCIA SOBRE LA PROPORCIÓN

SI n es suﬁcientemente grande, la proporción muestral se distribuye de la siguiente manera:

Y el intervalo de conﬁanza queda deﬁnido como:

INFERENCIA SOBRE LA PROPORCIÓN

Una  empresa  garantiza  los  elementos  que  produce  y  reemplaza  a  sus  clientes  los  elementos  que  no  cumplen  las
especiﬁcaciones.  Históricamente  sólo  el  4  %  de  los  elementos  no  cumplía  las  especiﬁcaciones;  pero,  en  el  último
tiempo,  los  reclamos  de  los  compradores  aumentaron  y  los  ingenieros  a  cargo  del  proceso  sospechan  que  este
porcentaje  aumentó.  Con  el  objetivo  de  estimar  el  nuevo  %  de  elementos  fuera  de  especiﬁcaciones  (y  conﬁrmar  la
sospecha de los ingenieros), se seleccionó una muestra aleatoria de n = 150 elementos producidos y se observó que 9
no cumplían las especiﬁcaciones.

-
-

¿Cuál es la población y la variable de estudio?
Estimar  mediante  intervalos  de  conﬁanza  al  95  %  la  proporción  de  placas  que  están  fuera  de  las
especiﬁcaciones.

INFERENCIA SOBRE LA PROPORCIÓN

Una  empresa  garantiza  los  elementos  que  produce  y  reemplaza  a  sus  clientes  los  elementos  que  no  cumplen  las
especiﬁcaciones.  Históricamente  sólo  el  4  %  de  los  elementos  no  cumplía  las  especiﬁcaciones;  pero,  en  el  último
tiempo,  los  reclamos  de  los  compradores  aumentaron  y  los  ingenieros  a  cargo  del  proceso  sospechan  que  este
porcentaje  aumentó.  Con  el  objetivo  de  estimar  el  nuevo  %  de  elementos  fuera  de  especiﬁcaciones  (y  conﬁrmar  la
sospecha de los ingenieros), se seleccionó una muestra aleatoria de n = 150 elementos producidos y se observó que 9
no cumplían las especiﬁcaciones.

-
-

¿Cuál es la población y la variable de estudio?
Estimar  mediante  intervalos  de  conﬁanza  al  95  %  la  proporción  de  placas  que  están  fuera  de  las
especiﬁcaciones.

Si estuviésemos en la etapa de planiﬁcación deberíamos determinar el tamaño de la muestra. ¿Cómo lo hacemos?

INFERENCIA SOBRE LA PROPORCIÓN

Relación éxito-fracaso

Al  valor  de  E  lo  ﬁjamos  nosotros,  el  valor  de  Z  surge  de  la
conﬁanza  que  ﬁjamos  nosotros  y  fo  lo  podemos  obtener  de
estudios  anteriores,  de  nuestra  experiencia  o  bien  le  podemos
asignar el valor 0,50 que nos va a dar el n más grande posible.

INFERENCIA SOBRE LA PROPORCIÓN

9 - En una empresa productora de placas de madera consideran buenas a aquellas unidades que presentan como
máximo 1 imperfección. Históricamente, sólo el 85 % de las placas producidas se podían considerar buenas y
por  esa  razón  realizaron  una  serie  de  mejoras  en  el  proceso  para  mejorar  la  calidad  de  las  placas.  Luego  de
implementar las mejoras, en la empresa seleccionaron una muestra aleatoria simple de 200 placas y encontraron
que 182 placas eran buenas.

a) Deﬁna población y variable. Plantee un objetivo para el estudio realizado.
b) Estime la proporción de placas con un nivel de conﬁanza del 95 %. Interprete.
c)  ¿Considera  que  las  mejoras  produjeron  un  aumento  en  la  proporción  de  placas  buenas  del  proceso?
Justiﬁque.
d) ¿Qué alternativas tiene para obtener este intervalo en R? Explique.

INFERENCIA SOBRE LA PROPORCIÓN

INFERENCIA SOBRE LA VARIANZA

Conociendo la distribución de ese estadístico, si la población es normal, podemos construir intervalos de conﬁanza encontrando en la
distribución Chi-cuadrado valores que satisfagan la siguiente condición:

*Si la población no es normal deben construirse intervalos robustos frente a la falta de normalidad (Ej. Bonett).

DISTRIBUCIÓN NORMAL

