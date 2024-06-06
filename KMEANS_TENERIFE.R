# Cargamos las bibliotecas necesarias
library(readr)
library(dplyr)
library(ggplot2)
library(sf)
library(rnaturalearth)
library(rnaturalearthdata)

# Cargamos los datos
administraciones <- read_csv('C:/Users/andre/OneDrive/Escritorio/Tenerife/servicios_publicos.csv')
asociaciones <- read_csv('C:/Users/andre/OneDrive/Escritorio/Tenerife/asociaciones.csv')
centros_deportivos <- read_csv('C:/Users/andre/OneDrive/Escritorio/Tenerife/centros_deportivos.csv')
centros_educativos <- read_csv('C:/Users/andre/OneDrive/Escritorio/Tenerife/centros_educativos.csv')
centros_medicos <- read_csv('C:/Users/andre/OneDrive/Escritorio/Tenerife/sanidad.csv')
empresas_servicios <- read_csv('C:/Users/andre/OneDrive/Escritorio/Tenerife/empresas_servicios.csv')
empresas_transporte <- read_csv('C:/Users/andre/OneDrive/Escritorio/Tenerife/empresas_transporte.csv')
empresas_industriales <- read_csv('C:/Users/andre/OneDrive/Escritorio/Tenerife/empresas_servicios.csv')
locales_hosteleria <- read_csv('C:/Users/andre/OneDrive/Escritorio/Tenerife/locales_hosteleria.csv')
locales_comerciales <- read_csv('C:/Users/andre/OneDrive/Escritorio/Tenerife/locales_comerciales.csv')

# Combinamos los dataframes en uno solo
combined_data <- bind_rows(
  administraciones,
  asociaciones,
  centros_deportivos,
  centros_educativos,
  centros_medicos,
  empresas_servicios,
  empresas_transporte,
  empresas_industriales,
  locales_hosteleria,
  locales_comerciales
)

# Eliminamos filas con valores NA
combined_data_clean <- na.omit(combined_data)

# Seleccionamos solo las columnas numéricas, incluyendo latitud y longitud
combined_data_numeric <- combined_data_clean %>% select_if(is.numeric)

# Normalizamos los datos
combined_data_scaled <- scale(combined_data_numeric)

# Determinamos el número óptimo de clusters usando el método del codo
set.seed(123) 
wss <- (nrow(combined_data_scaled)-1)*sum(apply(combined_data_scaled,2,var))
for (i in 2:15) wss[i] <- sum(kmeans(combined_data_scaled, centers=i)$tot.withinss)

# Gráfico del método del codo
plot(1:15, wss, type="b", xlab="Número de clusters", ylab="Suma de cuadrados dentro del cluster")

# Aplicamos K-Means con el número óptimo de clusters (3 clusters)
set.seed(123)
kmeans_result <- kmeans(combined_data_scaled, centers=3, nstart=25)

# Añadimos los clusters al conjunto de datos original
combined_data_clean$cluster <- kmeans_result$cluster


ggplot(combined_data_clean, aes(x = longitud, y = latitud, color = cluster)) +
  geom_point() +
  labs(title = "Clusters de Infraestructuras en Tenerife", x = "Longitud", y = "Latitud") +
  theme_minimal()

# Cargamos los datos geoespaciales de España
spain <- ne_states(country = "Spain", returnclass = "sf")

# Filtramos los datos para obtener solo Tenerife
tenerife <- spain[spain$woe_name == "Santa Cruz de Tenerife", ]

# Creamos el mapa de Tenerife
tnf <- ggplot(data = tenerife) +
  geom_sf() +
  coord_sf(xlim = c(-17, -15.8), ylim = c(27.9, 28.6)) +  # Coordenadas aproximadas de Tenerife
  labs(title = "Mapa de Tenerife",
       x = "lon",
       y = "lat") +
  theme_minimal()


# Convertimos cluster a factor
combined_data_clean$cluster <- as.factor(combined_data_clean$cluster)

# Creamos el mapa de Tenerife con los puntos coloreados por cluster
tnf +
  geom_point(data = combined_data_clean, aes(x = longitud, y = latitud, color = cluster), size = 3) +
  scale_color_manual(values = c("yellow", "green", "red"),
                     labels = c("Riesgo bajo", "Sin riesgo", "Gentrificado")) +
  labs(title = "Método k-means k=3", color = "Nivel de gentrificación") +
  theme_minimal() +
  theme(axis.text.x = element_blank(),
        axis.text.y = element_blank())



# Aplicamos K-Means con el número óptimo de clusters (otro ejemplo con 4 clusters)
set.seed(123)
kmeans_result <- kmeans(combined_data_scaled, centers=4, nstart=25)

# Añadimos los clusters al conjunto de datos original
combined_data_clean$cluster <- kmeans_result$cluster


ggplot(combined_data_clean, aes(x = longitud, y = latitud, color = cluster)) +
  geom_point() +
  labs(title = "Clusters de Infraestructuras en Tenerife", x = "Longitud", y = "Latitud") +
  theme_minimal()

# Cargamos los datos geoespaciales de España
spain <- ne_states(country = "Spain", returnclass = "sf")

# Filtramos los datos para obtener solo Tenerife
tenerife <- spain[spain$woe_name == "Santa Cruz de Tenerife", ]

# Creamos el mapa de Tenerife
tnf <- ggplot(data = tenerife) +
  geom_sf() +
  coord_sf(xlim = c(-17, -15.8), ylim = c(27.9, 28.6)) +  # Coordenadas aproximadas de Tenerife
  labs(title = "Mapa de Tenerife",
       x = "lon",
       y = "lat") +
  theme_minimal()


# Convertimos cluster a factor
combined_data_clean$cluster <- as.factor(combined_data_clean$cluster)

# Creamos el mapa de Tenerife con los puntos coloreados por cluster
tnf +
  geom_point(data = combined_data_clean, aes(x = longitud, y = latitud, color = cluster), size = 3) +
  scale_color_manual(values = c("orange", "yellow", "green", "red"),
                     labels = c("Riesgo moderado", "Riesgo bajo", "Sin riesgo", "Gentrificado")) +
  labs(title = "Método k-means k=4", color = "Nivel de gentrificación") +
  theme_minimal() +
  theme(axis.text.x = element_blank(),
        axis.text.y = element_blank())

