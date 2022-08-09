library(EviewsR)

demo(exec_commands)

eviews_wfsave(wf="exec_commands",source_description = "eviews_wfsave.csv",
              drop_list = "x")
