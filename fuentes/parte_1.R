
source("./data/generador.R")
source("./data/processor.R")
source("./install_requirements.R")
#writeAll() solo si necesita descargar de nuevo los archivos

start_install()
library(quanteda)

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

