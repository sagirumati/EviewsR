export=function(x=c(),wf=""){
write.csv(x,file="eviews/someFileName.csv")
  system2("EViews","run eviews_import_data_to_eviews.prg")
}

