# Cargamos los datos
empresas_industriales <- read.csv("C:/Users/andre/OneDrive/Escritorio/Tenerife/empresas_industriales.csv")

# Eliminamos filas con valores nulos
empresas_industriales <- empresas_industriales[complete.cases(empresas_industriales), ]

# Corregimos errores tipográficos
empresas_industriales$actividad_tipo <- tolower(empresas_industriales$actividad_tipo)
empresas_industriales$nombre <- tolower(empresas_industriales$nombre)


# Estandarizamos formatos de fecha
empresas_industriales$fecha_creacion <- as.Date(empresas_industriales$fecha_creacion, "%Y-%m-%d")
empresas_industriales$fecha_actualizacion <- as.Date(empresas_industriales$fecha_actualizacion, "%Y-%m-%d")

# Eliminamos duplicados
empresas_industriales <- empresas_industriales[!duplicated(empresas_industriales), ]
