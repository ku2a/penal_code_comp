source("./data/processor.R")
get_html_arts = function(){
  #Devuelve los links de los artículos
  url = "https://www.conceptosjuridicos.com/codigo-penal"
  articulos = get_articles()
  links = sapply(articulos, function(x){
    y = tolower(gsub(" ","-",x))
    link = paste(url,y,sep = "-")
    link = paste(link,"/",sep="")
    })
  return(links)
}

writeAll= function(){
  #Escribe el contenido en html de cada uno de los artículos a la carpeta articulos
  articulos = get_articles()
  links = get_html_arts()
  downloaded = list.files("./data/articulos/")  # ver cuales ya están descargados

  for (i in 1:length(articulos)){
    
    art = gsub(" ","_",articulos[i]) #nombre del archivo
    
    file_name = paste(art,".txt",sep="")
    if (file_name %in% downloaded){
      
      next # solo queremos descargar los que no están
    }
    
    contenido= readLines(links[[i]])[[33]] # el contenido se encuentra en 
    # el indice 33 en todos los artículos (comprobado en las pruebas)

  

    file_path = paste("./data/articulos/",file_name,sep="")
    fil3 = file(
      description = file_path,
      encoding = "UTF-8",
      blocking = TRUE,
      open = "w"
      
    )
    writeLines(contenido,fil3)
    close(fil3)
    
  }
}
