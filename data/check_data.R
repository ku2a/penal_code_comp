
source('./data/generador.R')
check_index_exists = function(){
  
  exists = file.exists('./data/articulos/indices.txt')
  ok = FALSE
  if (exists){
    indices = readLines('./data/articulos/indices.txt')
    ok = length(indices)==708
  }
  
  return(exists&ok)
  
}
check_data_exists = function(){
  if (!check_index_exists()){
    writeIndex()
  }
  indices = readLines("./data/articulos/indices.txt")
  to_write=c()
  n=1
  for (indice in indices){
    if (!file.exists(indice)){
      to_write[n] = indice
      n = n+1
    }
  }
  return(to_write)
}