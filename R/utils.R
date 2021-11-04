
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

unlink_eviews=function(){
  unlink(list.files(pattern=".~f1"))
  k=list.files(pattern="_Snapshots")
  unlink(k,recursive = T,force = T)
  unlink(list.files(pattern=".~rg"))

}
