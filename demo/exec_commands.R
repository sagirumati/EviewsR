library(EviewsR)

exec_commands(c("wfcreate(wf=Workfile,page=Page) m 2000 2022","save workfile","exit"))

exec_commands(c("genr y=rnd","y.line"),wf="Workfile")

unlink("workfile.wf1")
