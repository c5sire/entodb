library(rjson)
library(stringr)

#'
#'@author Reinhard Simon
#'@param query an R object (list of lists)
esQuery <- function(query, host = "localhost", port=9200){
  
  qq = toJSON(query)
  cmd= paste("curl -XPOST \"http://",host,":",port,"/_search\" -d \"",qq,"\"",sep="")
  y=system(cmd, intern=T)
  y = paste(y,collapse="")
  ss= str_locate(y,"[{]")[[1]]
  rs= str_sub(y, ss,str_length(y))
  rs=fromJSON(rs)
  rs
}

esPut <- function(record, host="localhost", port=9200)

