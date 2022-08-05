library(EviewsR)


demo(exec_commands)

# To import all table objects across all pages

import_table(wf="exec_commands")

# To import specific table objects, for example starting with Y

import_table(wf="exec_commands",table="OLStable")

# To import table objects on specific pages

import_table(wf="exec_commands",page="eviewspage")

# To access the table in base R

eviews$eviewspage_olstable

# To get the values above in R Markdown or Quarto

# chunkLabel$eviewspage_olstable

