library(stringr)
get_articles = function(){
  #devuelve los nombres de todos los articulos por e.g "Articulo 39"
  
  indices = readLines("./data/schema.txt")
  indices = indices[grep("Art",indices)]
  indices = indices[-grep("\\(.*?\\)",indices)]
  indices = gsub("í","i",indices)
  return(indices)
}

get_content = function(x){
  #devuelve el contenido de cada uno de los artículos.
  
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
  #devuelve dataframe con los docvars sin procesar (sin separar)
  
  df = data.frame(matrix(ncol = 5, nrow = 0))
  colnames(df) = c("Libro","Título","Capítulo","Sección","Artículo")
  lines = readLines("./data/schema.txt")
  pos = rep(NaN,4) #Alojará libro,titulo... del los articulos
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
      if (indice!=4){pos[(indice+1):length(pos)] = NaN}
      
    }
  }
  return(df)
}

separator = function(){
  #separa el df con los headers: Libro I: | De las garantías...
  df2 = lapply(df, function(x){
    sapply(x, function(y){
      if (!is.na(y) && !grepl("Art",y)){
        trimws(unlist(strsplit(y,":"))[2])
      } else {
        y
      }
      
    })
  })
  df2 = as.data.frame(df2)

  df3 = lapply(df, function(x){
    sapply(x, function(y){
      if (!is.na(y) && !grepl("Art",y)){
        trimws(unlist(strsplit(y,":"))[1])
      } else {
        y
      }
      
    })
  })
  df3 = as.data.frame(df3)
  
  df = get_titles()
  df_names = c()
  df_start = c()
  for (row in 1:nrow(df)){
    df_row = ""
    df_numeros_row = ""
    for (cell in 1:5){
      if (!grepl("NaN", df[row,cell])){
        
        df_row = paste(df_row, df[row,cell], sep = "")
        df_row = paste(df_row, "\n", sep = "")
        
        
      }
      if (!grepl("NaN",df3[row,cell])){
        df_numeros_row= paste(df_numeros_row, df3[row,cell], sep = "")
        df_numeros_row= paste(df_numeros_row, ".", sep="")
        
      }
    }
    df_names = c(df_names,trimws(df_numeros_row) ) 
    df_start = c(df_start, trimws(df_row)) 
    
  }
  return (list(docvars = df2, names = df_names, starts = df_start))
}