get_articles = function(){
  indices = readLines("./data/articulos/indices.txt")
  lines= lapply(indices,function(x){readLines(x)[[33]]})
  lines = lapply(lines,function(x){
    unlist(regmatches(x,gregexec("<blockquote>.*?</blockquote>",x)))
  })
  lines = lapply(lines, function(x){
    separado = strsplit(x,"<p>")[[1]]
    gsub("<.*?>","",separado[2:(length(separado)-1)]) })
}
