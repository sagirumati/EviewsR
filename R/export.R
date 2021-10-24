export=function(x=c(),wf=""){
write.csv(x,file="eviews/someFileName.csv")
  system2("EViews","run eviews_import_data_to_eviews.prg")
}


y=runif(100)
x=runif(100)
data=data.frame(x,y)
export(data)
