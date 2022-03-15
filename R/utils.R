#' @import knitr
#' @importFrom utils write.csv read.csv


kable_format <- function(){
  if(opts_knit$get("rmarkdown.pandoc.to")=="docx") format="pandoc"
  if(opts_knit$get("rmarkdown.pandoc.to")=="latex") format="latex"
  if(opts_knit$get("rmarkdown.pandoc.to")=="html") format="html"
  return(format)
}


eviews_path=function(){
  eviews_path = normalizePath(getwd())
  eviews_path= paste0("%eviews_path=", shQuote(eviews_path),"\ncd %eviews_path")
  return(eviews_path)
}

system_exec=function(){
path=getwd()
fileName=eval(expression(fileName),envir = parent.frame()) # Dynamic scoping
# if (Sys.info()["sysname"]=="Windows") shell(fileName) else system2("EViews",paste0("exec ",shQuote(paste0(path,"/",fileName))))
system2("EViews",paste0("exec ",shQuote(paste0(path,"/",fileName))))
}

unlink_eviews=function(){

  unlink(list.files(pattern=".~f1"))
  unlink(list.files(pattern=".~rg"))
  unlink(list.files(pattern="_Snapshots"),recursive = T,force = T)


  fileName=eval(expression(fileName), parent.frame())
if(exists('table_name.csv',envir = parent.frame()))  table_name.csv=eval(expression(table_name.csv), parent.frame()) #for deleting table_name.csv in import_table function

  unlink(fileName)
  if(exists('table_name.csv',envir = parent.frame())) unlink(table_name.csv)
  }

.onLoad<-function(libname,pkgname){
  knitr::knit_engines$set(eviews=eng_eviews)
  }

 # eview=emptyenv()
 # globalVariables("eviews")

# trim whitespace for handling of special commands
# trimmed <- gsub("^\\s*|\\s*$", "", contents)

# is_blank
# function (x)
# {
#   all(grepl("^\\s*$", x))
# }




`%n%`=function(x,y) if(is.null(x) || xfun::is_blank(x)) y else x
