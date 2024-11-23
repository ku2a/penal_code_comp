source("./data/generador.R")
source("./data/check_data.R")
source("./data/processor.R")
source("./install_requirements.R")

start_install()
library(quanteda)
df = get_titles()
articulos = unlist(get_content())
corpus = corpus(articulos)
docvars(corpus) = df