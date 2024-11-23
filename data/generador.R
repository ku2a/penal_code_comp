source("./data/processor.R")
get_html_arts = function(){
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
  articulos = get_articles()
  links = get_html_arts()
  for (i in 1:length(articulos)){
    contenido= readLines(links[i])
    art = gsub(" ","_",contenido[i])
  
    
    file_path = paste("./data/articulos/",art,".txt",sep="")
    fil3 = file(
      description = file_path,
      encoding = "UTF-8",
      blocking = TRUE,
      open = "w"
      
    )
    writeLines(articulo,fil3)
    close(fil3)
    
  }
}
