library(EviewsR)

# The first example creates an `EViews` workfile with monthly frequency from 1990 2021,
# then save the workfile in the current working directory

exec_commands(c("wfcreate(wf=EviewsR_exec_commands,page=Page) m 2000 2022",
                "save EviewsR_exec_commands","exit"))


# The second example opens the `EViews` workfile and then generate a random series
# named `y` and plots its line graph. It also freezes `ols` equation as `EviewsROLS`

eviewsCommands=r'(genr y=rnd
genr x=rnd
equation ols.ls y c x
freeze(EviewsROLS,mode=overwrite) ols)'

exec_commands(commands=eviewsCommands,wf="EviewsR_exec_commands")

# unlink("EviewsR_exec_commands.wf1")
