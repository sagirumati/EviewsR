library(EviewsR)

exec_commands(c("wfcreate(wf=Workfile,page=Page) m 1990 2022","genr y=rnd","genr x=rnd",
"save workfile","exit"))

import(object_name="myDataFrame",wf="workfile",drop_list = "y")
