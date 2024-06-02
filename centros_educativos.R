# Cargamos los datos
centros_educativos <- read.csv("C:/Users/andre/OneDrive/Escritorio/Tenerife/centros_educativos.csv")

# Eliminamos filas con valores nulos
centros_educativos <- centros_educativos[complete.cases(centros_educativos), ]

# Corregimos errores tipográficos
centros_educativos$actividad_tipo <- tolower(centros_educativos$actividad_tipo)
centros_educativos$nombre <- tolower(centros_educativos$nombre)


# Estandarizamos formatos de fecha
centros_educativos$fecha_creacion <- as.Date(centros_educativos$fecha_creacion, "%Y-%m-%d")
centros_educativos$fecha_actualizacion <- as.Date(centros_educativos$fecha_actualizacion, "%Y-%m-%d")

# Eliminamos duplicados
centros_educativos <- centros_educativos[!duplicated(centros_educativos), ]

