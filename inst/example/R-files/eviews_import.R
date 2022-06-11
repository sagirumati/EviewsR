library(EviewsR)

x=runif(100); y=runif(100); data=data.frame(x,y)
write.csv(data,"EviewsR_eviews_import.csv",row.names = FALSE)

eviews_import(source_description = "EviewsR_eviews_import.csv",start_date = "1990",frequency = "m",
              rename_string = "x ab",smpl_string = "1990m10 1992m10")

# Alternatively, use the dataframe as the source_description

eviews_import(source_description = data,wf="EviewsR_eviews_import1",start_date = "1990",
              frequency = "m",rename_string = "x ab",smpl_string = "1990m10 1992m10")
