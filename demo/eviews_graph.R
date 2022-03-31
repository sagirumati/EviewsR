library(EviewsR)

exec_commands(c("wfcreate(wf=Workfile,page=Page) m 1990 2022",
"genr y=rnd","genr x=rnd","save workfile","exit"))

eviews_graph(wf="workfile",page = "page",series="x y",mode = "overwrite",options = "m")

unlink("workfile.wf1")
