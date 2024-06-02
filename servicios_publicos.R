# Cargamos los datos
servicios_publicos <- read.csv("C:/Users/andre/OneDrive/Escritorio/Tenerife/servicios_publicos.csv")

# Eliminamos filas con valores nulos
servicios_publicos <- servicios_publicos[complete.cases(servicios_publicos), ]

# Corregimos errores tipográficos
servicios_publicos$actividad_tipo <- tolower(servicios_publicos$actividad_tipo)
servicios_publicos$nombre <- tolower(servicios_publicos$nombre)


# Estandarizamos formatos de fecha
servicios_publicos$fecha_creacion <- as.Date(servicios_publicos$fecha_creacion, "%Y-%m-%d")
servicios_publicos$fecha_actualizacion <- as.Date(servicios_publicos$fecha_actualizacion, "%Y-%m-%d")

# Eliminamos duplicados
servicios_publicos <- servicios_publicos[!duplicated(servicios_publicos), ]

View(servicios_publicos)
