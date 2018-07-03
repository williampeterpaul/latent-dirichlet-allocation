produceDtm = function(x) {
  x = tolower(x)
  x = removeRedundancies(x)
  x = removeSpam(x)
  
  x = Corpus(VectorSource(x))
  x = tm_map(x, removeWords, c(tolower(keywords), stopwords("SMART")))
  x = DocumentTermMatrix(x)

  return(x)
}

removeRedundancies = function(x) {
  x = iconv(x, "latin1", "ASCII", sub = "")
  x = gsub("?(f|ht)(tp)(s?)(://)(.*)[.|/](.*)", "", x)
  x = gsub("[[:punct:]]", "", x)
  x = gsub("[[:cntrl:]]", "", x)
  x = gsub("\\d+", "", x)
  x = gsub("rt", "", x)

  return(x)
}

removeSpam = function(x) {
  x = split(x, ceiling(seq_along(x) / 3000))
  x = lapply(x, function(z) { z[which(rowSums(outer(z, z, jarowinkler) > 0.8) > 1)] = ""; gc(); return(z) })
  x = do.call(c, x)
  
  return(x)
}
