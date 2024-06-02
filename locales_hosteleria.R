# Cargamos los datos
locales_hosteleria <- read.csv("C:/Users/andre/OneDrive/Escritorio/Tenerife/locales_hosteleria.csv")

# Eliminamos filas con valores nulos
locales_hosteleria <- locales_hosteleria[complete.cases(locales_hosteleria), ]

# Corregimos errores tipográficos
locales_hosteleria$actividad_tipo <- tolower(locales_hosteleria$actividad_tipo)
locales_hosteleria$nombre <- tolower(locales_hosteleria$nombre)
# Repite este proceso para otras variables que necesiten corrección.

# Estandarizamos formatos de fecha
locales_hosteleria$fecha_creacion <- as.Date(locales_hosteleria$fecha_creacion, "%Y-%m-%d")
locales_hosteleria$fecha_actualizacion <- as.Date(locales_hosteleria$fecha_actualizacion, "%Y-%m-%d")

# Eliminamos duplicados
locales_hosteleria <- locales_hosteleria[!duplicated(locales_hosteleria), ]

# Guardar el marco de datos limpio en un nuevo archivo CSV
#write.csv(locales_hosteleria, file = "C:/Users/andre/OneDrive/Escritorio/Tenerife/locales_hosteleria_limpio.csv", row.names = FALSE)
