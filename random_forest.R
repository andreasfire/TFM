# Cargamos las bibliotecas necesarias
library(dplyr)
library(caret)
library(randomForest)
library(ggplot2)
library(ranger)
library(readr)
library(lubridate)
library(MLmetrics)


# Cargamos los datos de centros
centros_deportivos <- read_csv("C:/Users/andre/OneDrive/Escritorio/Tenerife/centros_deportivos.csv")
centros_educativos <- read_csv("C:/Users/andre/OneDrive/Escritorio/Tenerife/centros_educativos.csv")
empresas_servicios <- read_csv("C:/Users/andre/OneDrive/Escritorio/Tenerife/empresas_servicios.csv")
empresas_transporte <- read_csv("C:/Users/andre/OneDrive/Escritorio/Tenerife/empresas_transporte.csv")
empresas_industriales <- read_csv("C:/Users/andre/OneDrive/Escritorio/Tenerife/empresas_transporte.csv")
locales_comerciales <- read_csv("C:/Users/andre/OneDrive/Escritorio/Tenerife/locales_comerciales.csv")
locales_hosteleria <- read_csv("C:/Users/andre/OneDrive/Escritorio/Tenerife/locales_hosteleria.csv")

# Unimos los data frames de centros
df <- bind_rows(centros_deportivos, centros_educativos, empresas_servicios, empresas_transporte, empresas_industriales, locales_hosteleria, locales_comerciales)
df <- na.omit(df)

# Convertimos datos categóricos a numéricos
df_dummy <- dummyVars("~ .", data = df, fullRank = TRUE)
df <- data.frame(predict(df_dummy, newdata = df))

# Tomamos la columna objetivo (la capital de la isla)

target_column <- 'municipio_nombreSanta.Cruz.de.Tenerife'

# Separamos X e y
y <- df[[target_column]]
X <- df %>% select(-one_of(target_column))

# Manejamos los valores NA (imputación simple con la media para variables numéricas)
preProcess_na <- preProcess(X, method = 'medianImpute')
X <- predict(preProcess_na, newdata = X)

# Convertimos y a factor para asegurarse de que sea una tarea de clasificación
y <- as.factor(y)

# Dividimos en datos de entrenamiento y prueba
set.seed(42)
trainIndex <- createDataPartition(y, p = .8, 
                                  list = FALSE, 
                                  times = 1)
X_train <- X[trainIndex,]
X_test <- X[-trainIndex,]
y_train <- y[trainIndex]
y_test <- y[-trainIndex]

# Verificamos las longitudes de los conjuntos de entrenamiento y prueba
length(X_train)
length(X_test)
length(y_train)
length(y_test)

# Creamos el modelo de Random Forest
model <- randomForest(x = X_train, y = y_train,
                      ntree = 50,
                      set.seed(42))

# Hacemos predicciones
model_predict <- predict(model, X_test)

# Evaluamos el modelo
confusionMatrix(model_predict, y_test)


# Calculamos el F1 Score
f1_score <- F1_Score(y_test, model_predict)
f1_score

# Ajustamos de parámetros
param_grid <- seq(50, 500, 50)

# Lista para almacenar los F1 Scores
f1_scores <- c()

for (params in param_grid) {
  set.seed(1502)
  model <- randomForest(x = X_train, y = y_train, ntree = params)
  
  predict <- predict(model, X_test)
  
  f1 <- F1_Score(y_test, predict, positive = levels(y_test)[1])
  
  f1_scores <- c(f1_scores, f1)
}

best_params <- param_grid[which.max(f1_scores)]
print(paste("Best number of trees:", best_params))
