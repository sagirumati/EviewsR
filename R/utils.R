#####################
#     IMPORTS
#####################

#' @import knitr magrittr
#' @importFrom utils write.csv read.csv  getFromNamespace tail
#' @importFrom stats na.omit



globalVariables(".")

###############################
# FUNCTIONS IN ASCENDING ORDER
###############################

# eviews_path

eviews_path=function(){
  getwd() %>% normalizePath() %>%
    shQuote_cmd() %>%
    paste0("%eviews_path=",.,"\ncd %eviews_path")
}


## eviews_string

# eviews_string= \(x) x %>%  shQuote(type="cmd") %>% paste0('%',x,'=',.) %>%  assign(x,.,parent.frame())

# eviews_string=function(x) {for (i in x) assign(i,paste0('%',i,'=',shQuote_cmd(get(i))),envir = globalenv())}
#
# eviews_string=function(x) {
#   for (i in x){
#
#     i %>% get %>%  shQuote_cmd %>%
#       paste0('%',i,'=',.) %>%
#       assign(i,.,envir =parent.frame())
#   }
# }


# eviews_string=\(x) assign(x,paste0('%',x,'=',get(x)))

eviews_string=\(x) x %>% get %>% shQuote_cmd %>% paste0('%',x,'=',.) %>% assign(x,.)

# kable_format

kable_format <- function(){
  if(opts_knit$get("rmarkdown.pandoc.to")=="docx") format="pandoc"
  if(opts_knit$get("rmarkdown.pandoc.to")=="latex") format="latex"
  if(opts_knit$get("rmarkdown.pandoc.to")=="html") format="html"
  return(format)
}


# system_exec

system_exec=function(){

if(!exists("engine_path")) set_eviews_path()

fileName=eval(expression(fileName),envir = parent.frame()) # Dynamic scoping
engine_path=eval(expression(engine_path),envir = parent.frame())

getwd() %>% paste0(.,"/",fileName) %>% shQuote_cmd() %>%
  paste("exec",.) %>%
system2(set_eviews_path(engine_path),.)
}


# unlink_eviews

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
  # set_eviews_path()
  if(!exists("eviews") || !is.environment(eviews)) eviews<<-new.env()

  #  if (is.null(opts_chunk$get('fig.ncol')) && is_latex_output()) opts_chunk$set(fig.ncol=2)
  # if(is_latex_output() && opts_chunk$get('fig.ncol')>1) opts_chunk$set(out.width="0.45\\textwidth")
  #

  # fig.cur = opts_chunk$get('fig.cur') %n% 2L
  # fig.num = opts_chunk$get('fig.num') %n% 2L
  # fig.ncol = opts_chunk$get('fig.ncol') %n% fig.num
  #
  #  if (is.null(opts_chunk$get('fig.ncol')) && is_latex_output()) opts_chunk$set(fig.ncol=fig.ncol)
  # if(is_latex_output() && opts_chunk$get('fig.ncol')>1) opts_chunk$set(out.width="0.45\\textwidth")
  # opts_chunk$set(opts_chunk$get())

  }





# trim whitespace for handling of special commands
# trimmed <- gsub("^\\s*|\\s*$", "", contents)

# is_blank
# function (x)
# {
#   all(grepl("^\\s*$", x))
# }
# which(!nzchar(a))
# if (Sys.info()["sysname"]=="Windows") shell(fileName) else system2("EViews",paste0("exec ",shQuote_cmd(paste0(path,"/",fileName))))


#
# knit_counter = function(init = 0L) {
#   n = init
#   function(reset = FALSE) {
#     if (reset) return(n <<- init)
#     n <<- n + 1L
#     n - 1L
#   }
# }

# getFromNamespace('knit_counter','knitr',envir = knit_global())
# plot_counter=knit_counter(1L)
#
 # plot_counter <- getFromNamespace('plot_counter','knitr')
# utils::assignInMyNamespace("plot_counter", plot_counter)

# plot_counter=do.call(":::",list("knitr",'plot_counter'))



# shQuote_cmd

# shQuote_cmd= \(x)  shQuote(x,type="cmd")

shQuote_cmd= \(x)  paste0('"',x,shQuote_cmd= \(x)  shQuote(x,type="cmd"type="cmd")



# y=function(x){
#   x<<-paste0('%',x,'=',shQuote(x))
# }


`%n%`=function(x,y) if(is.null(x)) y else x
