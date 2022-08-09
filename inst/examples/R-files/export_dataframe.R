library(EviewsR)


Data=data.frame(x=cumsum(rnorm(100)),y=cumsum(rnorm(100)))

export_dataframe(wf="export_dataframe",source_description=Data,start_date = '1990',frequency = "m")
