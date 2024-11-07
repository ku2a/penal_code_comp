get_articles_obj = function(){
  url = "https://www.conceptosjuridicos.com/codigo-penal"
  lines = readLines(url)
  texto = lines[33]
  matches <- regmatches(texto, gregexpr("<a\\s+href=\"[^\"]*\">Art[^<]*<\\/a>", texto))
  matches = matches[[1]]
  return(matches)
}

writeIndex = function(){
  file1 = file(
    description = "./data/articulos/indices.txt",
    blocking = TRUE,
    encoding = "UTF-8",
    open = "w"
  )
  matches = get_articles_obj()
  for (line in matches){
    art = regmatches(line, regexpr("Art[^<]*", line,perl = TRUE))
    sust = gsub(" ","_",art)
    sust = gsub("í","i",sust)
    file_path = paste("./data/articulos/",sust,".txt",sep="")
    writeLines(file_path,file1)
  }
  close(file1)
}

writeAll= function(){
  matches = get_articles_obj()
  for (line in matches){
    link = gsub("\"","",regmatches(line, regexpr("\"[^\"]*\"", line,perl = TRUE)))
    articulo= readLines(link)
    art = regmatches(line, regexpr("Art[^<]*", line,perl = TRUE))
    sust = gsub(" ","_",art)
    sust = gsub("í","i",sust)
    print(sust)
    file_path = paste("./data/articulos/",sust,".txt",sep="")
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
