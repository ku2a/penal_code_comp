library(stringr)
get_articles = function(){
  indices = readLines("./data/schema.txt")
  indices = indices[grep("Art",indices)]
  indices = indices[-grep("\\(.*?\\)",indices)]
  indices = gsub("í","i",indices)
  return(indices)
}

get_content = function(x){
  url = "./data/articulos/"
  indices = paste(url, gsub(" ","_",get_articles()),".txt",sep="")
  lines= lapply(indices,function(x){readLines(x)[[33]]})
  lines = lapply(lines,function(x){
    unlist(regmatches(x,gregexec("<blockquote>.*?</blockquote>",x)))
  })
  lines = lapply(lines, function(x){
    separado = strsplit(x,"<p>")[[1]]
    separado = gsub("<.*?>","",separado[2:(length(separado)-1)]) 
    paste(separado,collapse = "\n")
    })
  
}
get_titles = function(){
  df = data.frame(matrix(ncol = 5, nrow = 0))
  colnames(df) = c("Libro","Título","Capítulo","Sección","Artículo")
  lines = readLines("./data/schema.txt")
  pos = rep("unknown",4) #Alojará libro,titulo... del los articulos
  posibles = c("LIBRO","TITULO|TÍTULO","CAPITULO|CAPÍTULO","SECCIÓN")
  #Algunos titulos y capitulos llevan tilde o no
  #Lo mismo ocurre con las mayusculas, las escribimos en mayuscula y ya haremos
  #un toupper
  for (line in lines){
    line = str_squish(line)
    #Puede tener un character invisible al final (que no es un whitespace normal)
    indice = which(sapply(posibles,function(x){grepl(x,toupper(line))}))
    
    n=0
    if (length(indice)==0){
      #No encontró los anteriores, es decir, es un  articulo
      if (!grepl("\\(.*?\\)",line)){
        #Quitamos aquellos (sruprimidos) pues no nos interesan.
        line = gsub("Articulo","Artículo",line)
        df[nrow(df)+1,] = append(pos,line)
      }
      
    } else {
      pos[indice] = line
      if (indice!=4){pos[(indice+1):length(pos)] = "unkown"}
      
    }
  }
  return(df)
}