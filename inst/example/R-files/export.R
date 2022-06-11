library(EviewsR)

x=runif(100); y=runif(100); data=data.frame(x,y)

export(wf="EviewR_export",source_description=data,start_date = '1990',frequency = "m")
