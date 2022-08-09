library(EviewsR)

eviews_wfcreate(wf="eviews_wfcreate",page="EviewsR_page",frequency = "m",
                start_date = "1990",end_date = "2022")

# Create a workfile from a dataframe

Data=data.frame(x=cumsum(rnorm(100)),y=cumsum(rnorm(100)))

eviews_wfcreate(source_description=Data,wf="eviews_wfcreate1",page="EviewsR_page",frequency="m",
                start_date="1990")
