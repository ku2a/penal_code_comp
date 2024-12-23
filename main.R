source("./data/generador.R")
source("./data/check_data.R")
source("./data/processor.R")
source("./install_requirements.R")

start_install()
library(quanteda)
df = get_titles()
articulos = unlist(get_content())



utils = separator()
corpus_names = utils$names
corpus_starts = utils$starts
corpus_docvars = utils$docvars

for ( i in 1:length(articulos)){
  articulos[[i]] = paste(corpus_starts[[i]],articulos[[i]],sep = "\n")
}
corpus = corpus(articulos)
docvars(corpus) = corpus_docvars
names(corpus) = corpus_names
