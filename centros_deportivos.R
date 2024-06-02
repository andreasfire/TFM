library(ggplot2)
library(sf)

# Crear un data frame con los puntos de latitud y longitud de Tenerife
tenerife_coords <- data.frame(
  longitud = c(
    -16.920252,  -16.830858, -16.745603, -16.741506, -16.750472, -16.734037, 
    -16.666621, -16.612465,
    -16.519955, -16.494665, -16.456063, -16.422121, -16.392171,
    -16.342256, -16.321624, -16.243756, -16.211144, -16.157901,
    -16.138600, -16.122627, -16.136604, -16.178533, -16.230445,
    -16.254405, -16.293006, -16.334269, -16.364884, -16.368212,
    -16.362222, -16.383519, -16.401489, -16.426780, -16.432104,
    -16.430107, -16.451405, -16.492668, -16.523283, -16.547242,
    -16.615793, -16.667705, -16.704310, -16.712297, -16.742246,
    -16.739584, -16.773526, -16.798817, -16.827435, -16.838084,
    -16.838084, -16.864705, -16.891327, -16.921942
  ),
  latitud = c(
    28.353878,  28.390463, 28.373814, 28.378478, 28.371562, 28.383142,
    28.397778, 28.386938,
    28.417380, 28.434939, 28.457176, 28.502806, 28.537893,
    28.549586, 28.576474, 28.568876, 28.567123, 28.586994,
    28.579397, 28.554847, 28.534969, 28.511579, 28.490523,
    28.451325, 28.428501, 28.398647, 28.362929, 28.342429,
    28.304934, 28.280321, 28.245735, 28.204687, 28.176530,
    28.154821, 28.128412, 28.084970, 28.054433, 28.026237,
    28.018011, 28.008023, 28.006260, 28.041510, 28.052083,
    28.089667, 28.116086, 28.152474, 28.193542, 28.225213,
    28.258046, 28.289698, 28.320754, 28.358244
  )
)

# Leer datos de centros educativos
datos <- read.csv("C:/Users/andre/OneDrive/Escritorio/Tenerife/centros_deportivos.csv")
datos_sf <- st_as_sf(datos, coords = c("longitud", "latitud"), crs = 4326)

# Crear el gráfico
ggplot() +
  # Dibujar la forma de la isla de Tenerife
  geom_path(data = tenerife_coords, aes(x = longitud, y = latitud), color = "black") +
  # Añadir los centros educativos
  geom_sf(data = datos_sf, color = "red") +
  coord_sf() +  # Usar coordenadas espaciales
  labs(title = "Centros deportivos en Tenerife", x = "Longitud", y = "Latitud")  # Etiquetas de los ejes y título del gráfico
