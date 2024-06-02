# Cargamos los datos
empresas_transporte <- read.csv("C:/Users/andre/OneDrive/Escritorio/Tenerife/empresas_transporte.csv")

# Eliminamos filas con valores nulos
empresas_transporte <- empresas_transporte[complete.cases(empresas_transporte), ]

# Corregimos errores tipográficos
empresas_transporte$actividad_tipo <- tolower(empresas_transporte$actividad_tipo)
empresas_transporte$nombre <- tolower(empresas_transporte$nombre)


# Estandarizamos formatos de fecha
empresas_transporte$fecha_creacion <- as.Date(empresas_transporte$fecha_creacion, "%Y-%m-%d")
empresas_transporte$fecha_actualizacion <- as.Date(empresas_transporte$fecha_actualizacion, "%Y-%m-%d")

# Eliminamos duplicados
empresas_transporte <- empresas_transporte[!duplicated(empresas_transporte), ]

