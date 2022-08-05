library(EviewsR)

demo(exec_commands)

# To import all graph objects

import_graph(wf="exec_commands")

# To import only graphs that begin with x:

import_graph(wf="exec_commands",graph="x*")

# To access the graph objects in base R

# eviewspage-x_graph # graph saved in "figure/" folder

# To get the graph objects in R Markdown or Quarto

# chunkLabel-eviewspage-x_graph # graph saved in "fig.path" folder
