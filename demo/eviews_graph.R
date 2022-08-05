library(EviewsR)

demo(exec_commands)

eviews_graph(wf="EviewsR_exec_commands",page = "page",series="x y",mode = "overwrite",
             graph_options = "m")

# Create a graph from dataframe

Data=data.frame(x=cumsum(rnorm(100)),y=cumsum(rnorm(100)))
eviews_graph(series=Data,start_date=1990,frequency="m")
