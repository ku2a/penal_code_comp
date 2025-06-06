source("./data/generador.R")
source("./data/processor.R")
source("./install_requirements.R")
#writeAll() solo si necesita descargar de nuevo los archivos

start_install()
library(quanteda)

#repetimos la parte 1 pues la necesitamos para continuar

#Conseguimos el conetenido de los artículos (Ojo que faltan las cabeceras)
articulos = unlist(get_content())

#Devuelve lso docvars, names y las cabeceras
utils = separator()
corpus_names = utils$names
corpus_starts = utils$starts
corpus_docvars = utils$docvars

#Juntamos las cabeceras y el resto del artículos
for ( i in 1:length(articulos)){
  articulos[[i]] = paste(corpus_starts[[i]],articulos[[i]],sep = "\n")
}
corpus = corpus(articulos)
docvars(corpus) = corpus_docvars
names(corpus) = corpus_names


#DISTANCIAS

dtm = dfm(tokens(corpus))

m <- as.matrix(dtm)
# Usar las primeras 2 componentes principales

# Calcular la matriz de distancias
distMatrix <- dist(m, method = "euclidean")

# Realizar el clustering jerárquico
groups <- hclust(distMatrix)

# Plotear el dendrograma y hacer los clusters
plot(groups, cex = 0.9, hang = -1, labels=FALSE)  # Mostrar el dendrograma
rect.hclust(groups, k = 5)

#Por defecto dist no devuelve una matriz sino un vector con las distancias
#vector 697 * (697-1) pues la matriz es simetrica y la diagonal es 0
distMatrix_full <- as.matrix(distMatrix)

# Cambiamos la diagonal a infinito pues sino tendrá 0's (distancia a sí mismo)
diag(distMatrix_full) <- Inf

#Encontramos los índices de menor distancia
min_index <- which(distMatrix_full == min(distMatrix_full), arr.ind = TRUE)
i <- min_index[1, 1]
j <- min_index[1, 2]