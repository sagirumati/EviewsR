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

#' @export
set_eviews_path <- function(eviews_system_path="eviews") eviews_system_path<<-eviews_system_path



system_exec=function(){
path=getwd()
eviews_system_path=eval(expression(eviews_system_path),envir = parent.frame())
fileName=eval(expression(fileName),envir = parent.frame()) # Dynamic scoping
# if (Sys.info()["sysname"]=="Windows") shell(fileName) else system2("EViews",paste0("exec ",shQuote(paste0(path,"/",fileName))))
system2(set_eviews_path(eviews_system_path),paste0("exec ",shQuote(paste0(path,"/",fileName))))
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
  set_eviews_path()
  # assign('eviews_system_path',4,envir = topenv())
  }

# trim whitespace for handling of special commands
# trimmed <- gsub("^\\s*|\\s*$", "", contents)

# is_blank
# function (x)
# {
#   all(grepl("^\\s*$", x))
# }




`%n%`=function(x,y) if(is.null(x)) y else x
