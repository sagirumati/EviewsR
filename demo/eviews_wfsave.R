library(EviewsR)

exec_commands(c("wfcreate(wf=Workfile,page=Page) m 1990 2022",
"genr y=rnd","genr x=rnd","save workfile","exit"))

eviews_wfsave(wf="workfile",source_description = "wfsave.csv",drop_list = "x")
