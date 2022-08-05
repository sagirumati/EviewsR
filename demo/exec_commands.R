library(EviewsR)

# The first example creates an `EViews` workfile with monthly frequency from 1990 2021,
# then save the workfile in the current working directory

exec_commands(c("wfcreate(wf=exec_commands,page=eviewsPage) m 2000 2022"))

# The second example opens the `EViews` workfile and then generate a random series
# named `y` and plots its line graph. It also freezes `ols` equation as `EviewsROLS`

eviewsCommands=r'(pagecreate(page=eviewspage1) 7 2020 2022
for %page eviewspage eviewspage1
pageselect {%page}
genr y=rnd
genr x=rnd
equation ols.ls y c x
graph x_graph.line x
graph y_graph.area y
freeze(OLSTable,mode=overwrite) ols
next
)'

exec_commands(commands=eviewsCommands,wf="exec_commands")

# unlink("exec_commands.wf1")
