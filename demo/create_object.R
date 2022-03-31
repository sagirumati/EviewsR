library(EviewsR)

eviews_wfcreate(wf="EviewsR_workfile",page="EviewsR_page",frequency = "m",start_date = "1990",
end_date = "2022")

exec_commands(c("open EviewsR_workfile","genr y=rnd","genr x=rnd","save","exit"))

create_object(wf="EviewsR_workfile",action="equation",action_opt="",
object_name="eviews_equation",view_or_proc="ls",options_list="",arg_list="y ar(1)")
