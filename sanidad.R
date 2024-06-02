# Cargamos los datos
sanidad <- read.csv("C:/Users/andre/OneDrive/Escritorio/Tenerife/sanidad.csv")

# Eliminamos filas con valores nulos
sanidad <- sanidad[complete.cases(sanidad), ]

# Corregimos errores tipográficos
sanidad$actividad_tipo <- tolower(sanidad$actividad_tipo)
sanidad$nombre <- tolower(sanidad$nombre)


# Estandarizamos formatos de fecha
sanidad$fecha_creacion <- as.Date(sanidad$fecha_creacion, "%Y-%m-%d")
sanidad$fecha_actualizacion <- as.Date(sanidad$fecha_actualizacion, "%Y-%m-%d")

# Eliminamos duplicados
sanidad <- sanidad[!duplicated(sanidad), ]
