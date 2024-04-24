#####################
#     IMPORTS
#####################

#' @import knitr magrittr
#' @importFrom utils write.csv read.csv  getFromNamespace tail
#' @importFrom stats na.omit
#' @importFrom zoo index coredata
#' @importFrom xts xts is.xts
#' @importFrom Rdpack reprompt




globalVariables(".")

`%n%`=function(x,y) if(is.null(x)) y else x

###############################
# FUNCTIONS IN ASCENDING ORDER
###############################

# eviews_path

eviews_path=function(){
  getwd() %>% normalizePath() %>%
    shQuote_cmd() %>%
    paste0("%eviews_path=",.,"\ncd %eviews_path")
}


# eviews_string

eviews_string=function(x) x %>% get %>% shQuote_cmd %>% paste0('%',x,'=',.) %>% assign(x,.)

# kable_format

kable_format <- function(){
  if(opts_knit$get("rmarkdown.pandoc.to")=="docx") format="pandoc"
  if(opts_knit$get("rmarkdown.pandoc.to")=="latex") format="latex"
  if(opts_knit$get("rmarkdown.pandoc.to")=="html") format="html"
  return(format)
}


# shQuote_cmd

shQuote_cmd= function(x) gsub('"','""',x) %>% paste0('"',.,'"')


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
  }


.onAttach <- function(libname, pkgname) {
  packageStartupMessage("Thank you for using EviewsR!

          To acknowledge our work, please cite the package:

                        PLAIN TEXT:

 1. Mati S. (2020). EviewsR: A Seamless Integration of EViews and R. CRAN. https://CRAN.R-project.org/package=DynareR

 2.  Mati S., Civcir I., Abba S.I (2023). EviewsR: An R Package for Dynamic
  and Reproducible Research Using EViews, R, R Markdown and Quarto. The R
  Journal. doi:10.32614/RJ-2023-045, url:
  https://journal.r-project.org/articles/RJ-2023-045/

              BIBTEX:


  @Article{Mati2020,
    title = {EviewsR: A Seamless Integration of EViews and R},
    author = {Sagiru Mati},
    year = {2020},
    journal = {CRAN},
    url = {https://CRAN.R-project.org/package=EviewsR},
  }

  @article{Mati2023,
  author = {Mati, Sagiru and Civcir, Irfan and Abba, S. I.},
  title = {EviewsR: An R Package for Dynamic and Reproducible Research Using EViews, R, R Markdown and Quarto},
  journal = {The R Journal},
  year = {2023},
  note = {https://doi.org/10.32614/RJ-2023-045},
  doi = {10.32614/RJ-2023-045},
  volume = {15},
  issue = {2},
  issn = {2073-4859},
  pages = {169-205},
}")
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




# y=function(x){
#   x<<-paste0('%',x,'=',shQuote(x))
# }



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

