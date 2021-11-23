#' @seealso eng_eviews, eviews_commands, eviews_graph, eviews_import, eviews_object, eviews_pagesave, eviews_rwalk, eviews_wfcreate, eviews_wfsave, import_table, import

export=function(x=c(),wf=""){
write.csv(x,file="eviews/someFileName.csv")
  system2("EViews","run eviews_import.prg")
}


