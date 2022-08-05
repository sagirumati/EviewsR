library(EviewsR)

demo(exec_commands)

# To import all equation, graph, series and table objects across all pages

import_workfile(wf="exec_commands")

# To import specific objects

import_workfile(wf="exec_commands",equation="ols",graph="x*",series="y*",table="ols*")

# To import objects on specific page(s)

import_workfile(wf="exec_commands",page="eviewspage")


# To access the objects in base R

eviews$eviewspage_ols # equation
# eviewspage-x_graph # graph saved in "figure/" folder
eviews$eviewspage # series
eviews$eviewspage_olstable  # table

# To get the values above in R Markdown or Quarto

# chunkLabel$eviewspage_ols # equation
# chunkLabel-eviewspage-x_graph # graph saved in "fig.path" folder
# chunkLabel$eviewspage # series
# chunkLabel$eviewspage_olstable  # table
