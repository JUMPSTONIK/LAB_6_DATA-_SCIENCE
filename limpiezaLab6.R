library(stringi)
library(dplyr)
library(qdapRegex)
library(readr)
library("stringr") 
#install.packages("qdapRegex")
#install.packages("stopwords")
library("stopwords")
library('tm')

#obtener data del csv
data <- read.csv("data.csv", sep=";", encoding = "utf-8")
View(data)
head(data)
str(data)

Tweets = data$Tweet
#Tweets
Tweets <- iconv(Tweets, to="ASCII//TRANSLIT")

#hacemos los cambios de las tildes por el incov
Tweets <- gsub("A!","a", prue,fixed = TRUE)
Tweets <- gsub("AC","e", prueva,fixed = TRUE)
Tweets <- gsub("A-","i", prueva,fixed = TRUE)
Tweets <- gsub("A3","o", prueva,fixed = TRUE)
Tweets <- gsub("As","u", prueva,fixed = TRUE)
Tweets <- gsub("A?","¿", prueva ,fixed = TRUE)
Tweets <- gsub("?A","?", prueva ,fixed = TRUE)
Tweets <- gsub("a?|"," ", prueva,fixed = TRUE)
Tweets <- gsub("\n"," ", prueva,fixed = TRUE)
Tweets <- gsub("?Y","", prueva,fixed = TRUE)
Tweets <- gsub("'C","", prueva,fixed = TRUE)
Tweets <- gsub("'Z","", prueva,fixed = TRUE)
Tweets <- gsub("Ys","", prueva,fixed = TRUE)
#Tweets

#volver todo a minuscula
Tweets <- sapply(Tweets, tolower)
#Tweets

#Eliminacion de URLS
Tweets <- gsub(pattern = "(http[^[:space:]]*)", replacement = " ", Tweets)
#Tweets

#eliminar stopwords
Tweets <- removeWords(Tweets,stopwords("spanish"))
#Tweets

#eliminar emoticones
Tweets <- gsub("[^\x01-\x7F]", "", Tweets)
#Tweets

#eliminar caracteres especiales y de puntuacion
Tweets <-  gsub("[[:punct:]]", "", Tweets)
#Tweets

#quitando links de twitter
Tweets <- gsub("http[[:alnum:][:punct:]]*", "", Tweets)
#Tweets
#quitamos caracteres especiales de la codificación, como saltos de línea y tabulaciones
Tweets <- gsub("[[:cntrl:]]", " ", Tweets)

#eliminamos espacios en blanco
Tweets <- stripWhitespace(Tweets)
Tweets

#asignar las variables al DataLab5

data$Tweet = Tweets

#examinando duplicados
distinct(data)
duplicated(data)
nrow(data[duplicated(data), ])
data <- distinct(data)

options(PACKAGE_MAINFOLDER="C:/Users/...")
options(java.parameters = "-Xmx8000m")

#Guardar el csv
write.csv(x=data, file= "C:/Users/JUMPSTONIK/DataClean.csv")
