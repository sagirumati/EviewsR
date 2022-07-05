#####################
#     IMPORTS
#####################

#' @import knitr magrittr
#' @importFrom utils write.csv read.csv assignInMyNamespace getFromNamespace

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


graphicsDefault=r'(
%pagelist=@pagelist

if %pagelist1<>"" then
%pagelist=%pagelist1
endif

for %page {%pagelist}
pageselect {%page}


if %figKeep1="first" then
%figKeep=@wlookup("*","graph")
%figKeep=@wleft(%figKeep,1)
endif

if %figKeep1="last" then
%figKeep=@wlookup("*","graph")
%figKeep=@wright(%figKeep,1)
endif

if %figKeep1="all" then
%figKeep=@wlookup("*","graph")
endif

if %figKeep1="none" then
%figKeep=""
endif

if %figKeep1="" then
%figKeep=@wlookup("*","graph")
endif


if @wcount(%figKeep)>0 then
for %y {%figKeep}
{%y}.axis(l) font(Calibri,14,-b,-i,-u,-s)
{%y}.axis(r) font(Calibri,14,-b,-i,-u,-s)
{%y}.axis(b) font(Calibri,14,-b,-i,-u,-s)
{%y}.axis(t) font(Calibri,14,-b,-i,-u,-s)
{%y}.legend columns(5) inbox position(BOTCENTER) font(Calibri,12,-b,-i,-u,-s)
{%y}.options antialias(on)
{%y}.options size(6,3)
{%y}.options -background frameaxes(all) framewidth(0.5)
{%y}.setelem(1) linecolor(@rgb(57,106,177)) linewidth(1.5)
{%y}.setelem(2) linecolor(@rgb(218,124,48)) linewidth(1.5)
{%y}.setelem(3) linecolor(@rgb(62,150,81)) linewidth(1.5)
{%y}.setelem(4) linecolor(@rgb(204,37,41)) linewidth(1.5)
{%y}.setelem(5) linecolor(@rgb(83,81,84)) linewidth(1.5)
{%y}.setelem(6) linecolor(@rgb(107,76,154)) linewidth(1.5)
{%y}.setelem(7) linecolor(@rgb(146,36,40)) linewidth(1.5)
{%y}.setelem(8) linecolor(@rgb(148,139,61)) linewidth(1.5)
{%y}.setelem(9) linecolor(@rgb(255,0,255)) linewidth(1.5)
{%y}.setelem(10) linewidth(1.5)
{%y}.setelem(11) linecolor(@rgb(192,192,192)) linewidth(1.5)
{%y}.setelem(12) linecolor(@rgb(0,255,255)) linewidth(1.5)
{%y}.setelem(13) linecolor(@rgb(255,255,0)) linewidth(1.5)
{%y}.setelem(14) linecolor(@rgb(0,0,255)) linewidth(1.5)
{%y}.setelem(15) linecolor(@rgb(255,0,0)) linewidth(1.5)
{%y}.setelem(16) linecolor(@rgb(0,127,0)) linewidth(1.5)
{%y}.setelem(17) linecolor(@rgb(0,0,0)) linewidth(1.5)
{%y}.setelem(18) linecolor(@rgb(0,127,127)) linewidth(1.5)
{%y}.setelem(19) linecolor(@rgb(127,0,127)) linewidth(1.5)
{%y}.setelem(20) linecolor(@rgb(127,127,0)) linewidth(1.5)
{%y}.setelem(21) linecolor(@rgb(0,0,127)) linewidth(1.5)
{%y}.setelem(22) linecolor(@rgb(255,0,255)) linewidth(1.5)
{%y}.setelem(23) linecolor(@rgb(127,127,127)) linewidth(1.5)
{%y}.setelem(24) linecolor(@rgb(192,192,192)) linewidth(1.5)
{%y}.setelem(25) linecolor(@rgb(0,255,255)) linewidth(1.5)
{%y}.setelem(26) linecolor(@rgb(255,255,0)) linewidth(1.5)
{%y}.setelem(27) linecolor(@rgb(0,0,255)) linewidth(1.5)
{%y}.setelem(28) linecolor(@rgb(255,0,0)) linewidth(1.5)
{%y}.setelem(29) linecolor(@rgb(0,127,0)) linewidth(1.5)
{%y}.setelem(30) linecolor(@rgb(0,0,0)) linewidth(1.5)
{%y}.setfont legend(Calibri,12,-b,-i,-u,-s) text(Calibri,14,-b,-i,-u,-s) obs(Calibri,14,-b,-i,-u,-s) axis(Calibri,14,-b,-i,-u,-s)
{%y}.setfont obs(Calibri,14,-b,-i,-u,-s)
{%y}.textdefault font(Calibri,14,-b,-i,-u,-s)
next
endif
next
)'

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

shQuote_cmd= \(x)  shQuote(x,type="cmd")



# y=function(x){
#   x<<-paste0('%',x,'=',shQuote(x))
# }


`%n%`=function(x,y) if(is.null(x)) y else x
