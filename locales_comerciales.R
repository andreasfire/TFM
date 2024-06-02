# Cargamos los datos
locales_comerciales <- read.csv("C:/Users/andre/OneDrive/Escritorio/Tenerife/locales_comerciales.csv")

# Eliminamos filas con valores nulos
locales_comerciales <- locales_comerciales[complete.cases(locales_comerciales), ]

# Corregimos errores tipográficos
locales_comerciales$actividad_tipo <- tolower(locales_comerciales$actividad_tipo)
locales_comerciales$nombre <- tolower(locales_comerciales$nombre)

# Estandarizamos formatos de fecha
locales_comerciales$fecha_creacion <- as.Date(locales_comerciales$fecha_creacion, "%Y-%m-%d")
locales_comerciales$fecha_actualizacion <- as.Date(locales_comerciales$fecha_actualizacion, "%Y-%m-%d")

# Eliminamos duplicados
locales_comerciales <- locales_comerciales[!duplicated(locales_comerciales), ]

# Guardamos el marco de datos limpio en un nuevo archivo CSV
#write.csv(locales_comerciales, file = "C:/Users/andre/OneDrive/Escritorio/Tenerife/locales_comerciales_limpio.csv", row.names = FALSE)
