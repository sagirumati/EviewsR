library(EviewsR)

demo(exec_commands)

import(object_name="importedDataFrame",wf="EviewsR_exec_commands",drop_list = "y")

eviews$importedDataFrame

knitr::kable(head(eviews$importedDataFrame),format="pandoc",caption="Table from EviewsR")
