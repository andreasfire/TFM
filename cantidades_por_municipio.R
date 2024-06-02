#EJEMPLO DE DIAGRAMA DE BARRAS QUE CUENTA (EN ESTE CASO) LOS SERVICIOS PÚBLICOS POR MUNICIPIO
serv <- read.csv("C:/Users/andre/OneDrive/Escritorio/Tenerife/servicios_publicos.csv")


# Instalamos y cargamos la librería 'ggplot2' si no está instalada
if (!requireNamespace("ggplot2", quietly = TRUE)) {
  install.packages("ggplot2")
}
library(ggplot2)

# Suponiendo que tienes tus datos en un data frame llamado 'datos'
# y que tienes la columna 'municipio_nombre' que representa el municipio

# Instalamos y cargamos la librería 'ggplot2' si no está instalada
if (!requireNamespace("ggplot2", quietly = TRUE)) {
  install.packages("ggplot2")
}
library(ggplot2)

# Creamos una tabla resumen con la cantidad de datos por municipio
datos_resumen <- as.data.frame(table(serv$municipio_nombre))

# Renombramos las columnas
colnames(datos_resumen) <- c("Municipio", "Servicios públicos")

# Creamos el gráfico de barras
ggplot(datos_resumen, aes(x = reorder(Municipio, -`Servicios públicos`), y = `Servicios públicos`)) +
  geom_bar(stat = "identity", fill = "skyblue") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  labs(x = "Municipio", y = "Servicios públicos",
       title = "Servicios públicos por Municipio")

