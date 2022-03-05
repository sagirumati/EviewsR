#' @export
graphf=function(xx=T){
 # if (xx==T){
   # for (i in c('x','y')){
     eviews_graphics=list.files(pattern=paste0('_graph_eviewsr'),ignore.case = T)
 knitr::include_graphics(eviews_graphics)
 }


