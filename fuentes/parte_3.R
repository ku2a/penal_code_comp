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



library(spacyr)
library(udpipe)

spacy_initialize(model = "es_core_news_sm")
#ud_model <- udpipe_download_model(language = "spanish-ancora")
udmodel_es <- udpipe_load_model(file = 'spanish-ancora-ud-2.5-191206.udpipe')

annotations <- udpipe_annotate(udmodel_es, x = corpus)

ent = spacy_extract_entity(corpus)
freqs = table(ent$text)
comunes = freqs[order(-freqs)][1:20]
comunes


annotations_df <- as.data.frame(annotations)


head(annotations_df)

keywords <- keywords_rake(
  annotations_df,    
  term = "lemma",        
  group = "doc_id",
  relevant = ( ! annotations_df$xpos  %in% c("PUNCT","SYM","NUM","CCONJ","ADP")),
  ngram_max = 5,
)

keywords = keywords[order(-keywords$freq),]  #Ordenamos for frecuencia

head(keywords,20)

