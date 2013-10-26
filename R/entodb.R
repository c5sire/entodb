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

recordToJSON <- function(record){
  ss = "{"
  for(i in 1:ncol(record)){
    ss = paste(ss, "\"", names(record)[i], "\": \"", record[1,i],"\"" ,sep="" )
    if(i<ncol(record)) ss = paste(ss, ",", sep="")
  }
  ss = paste(ss,"}", sep="")
  ss
}

#' @param record a row from a data frame
esPut <- function(record, index, type, host="localhost", port=9200){
  firstname = "Reinhard"
  lastname = "Simon"
  record = as.data.frame(cbind(firstname, lastname), stringsAsF=F)
  index = "persons"
  type = "person"
  host = "localhost"
  port = 9200
  
  id = rownames(record)
  
  rec = recordToJSON(record)
  
  cmd = paste("curl -XPUT \"http://",host,":",port,"/",index,"/",type,"/",id,"\"",
              " -d \"",rec,"\"",sep="")
  y=system(cmd, intern=T)
}

