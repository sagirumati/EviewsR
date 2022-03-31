library(EviewsR)

exec_commands(c("wfcreate(wf=Workfile,page=Page) m 1990 2022","genr y=rnd","genr x=rnd",
"equation ols.ls y c x","freeze(EviewsROLS,mode=overwrite) ols","save workfile","exit"))

import_table(wf="WORKFILE",page="PAGE",table_name="EviewsROLS",format = "pandoc")
