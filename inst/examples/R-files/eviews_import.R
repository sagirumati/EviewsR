library(EviewsR)

Data=data.frame(x=cumsum(rnorm(100)),y=cumsum(rnorm(100)))

write.csv(Data,"eviews_import.csv",row.names = FALSE)

eviews_import(source_description = "eviews_import.csv",start_date = "1990",frequency = "m",
              rename_string = "x ab",smpl_string = "1990m10 1992m10")

# Alternatively, use the dataframe as the source_description

eviews_import(source_description = Data,wf="eviews_import1",start_date = "1990",
              frequency = "m",rename_string = "x ab",smpl_string = "1990m10 1992m10")
