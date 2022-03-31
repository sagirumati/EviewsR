library(EviewsR)

x=runif(100); y=runif(100); data=data.frame(x,y);write.csv(data,"eviewsr.csv",row.names = FALSE)

eviews_import(source_description = "eviewsr.csv",start_date = "1990",frequency = "m",
rename_string = "x ab",smpl_string = "1990m10 1992m10")
