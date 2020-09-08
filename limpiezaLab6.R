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
#View(data)
#head(data)
#str(data)

Tweets = data$Tweet
#Tweets
Tweets <- iconv(Tweets, to="ASCII//TRANSLIT")

#hacemos los cambios de las tildes por el incov
Tweets <- gsub("A!","a", Tweets,fixed = TRUE)
Tweets <- gsub("AC","e", Tweets,fixed = TRUE)
Tweets <- gsub("A-","i", Tweets,fixed = TRUE)
Tweets <- gsub("A3","o", Tweets,fixed = TRUE)
Tweets <- gsub("As","u", Tweets,fixed = TRUE)
Tweets <- gsub("A?","¿", Tweets ,fixed = TRUE)
Tweets <- gsub("?A","?", Tweets ,fixed = TRUE)
Tweets <- gsub("a?|"," ",Tweets,fixed = TRUE)
Tweets <- gsub("\n"," ", Tweets,fixed = TRUE)
Tweets <- gsub("?Y","", Tweets,fixed = TRUE)
Tweets <- gsub("'C","", Tweets,fixed = TRUE)
Tweets <- gsub("'Z","", Tweets,fixed = TRUE)
Tweets <- gsub("Ys","", Tweets,fixed = TRUE)
Tweets[1223]

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
duplicated(data$Tweet)
nrow(data[duplicated(data$Tweet), ])
data <- data[!duplicated(data$Tweet),]

#options(PACKAGE_MAINFOLDER="C:/Users/...")
#options(java.parameters = "-Xmx8000m")

#Guardar el csv
write.csv(x=data, file= "C:/Users/JUMPSTONIK/DataClean.csv")
