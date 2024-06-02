# Cargamos los datos
empresas_servicios <- read.csv("C:/Users/andre/OneDrive/Escritorio/Tenerife/empresas_servicios.csv")

# Eliminamos filas con valores nulos
empresas_servicios <- empresas_servicios[complete.cases(empresas_servicios), ]

# Corregimos errores tipográficos
empresas_servicios$actividad_tipo <- tolower(empresas_servicios$actividad_tipo)
empresas_servicios$nombre <- tolower(empresas_servicios$nombre)


# Estandarizamos formatos de fecha
empresas_servicios$fecha_creacion <- as.Date(empresas_servicios$fecha_creacion, "%Y-%m-%d")
empresas_servicios$fecha_actualizacion <- as.Date(empresas_servicios$fecha_actualizacion, "%Y-%m-%d")

# Eliminamos duplicados
empresas_servicios <- empresas_servicios[!duplicated(empresas_servicios), ]
