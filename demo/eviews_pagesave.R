library(EviewsR)

exec_commands(c("wfcreate(wf=Workfile,page=Page) m 1990 2022",
"genr y=rnd","genr x=rnd","save workfile","exit"))

eviews_pagesave(wf="workfile",source_description = "pagesave.csv",drop_list = "y")
