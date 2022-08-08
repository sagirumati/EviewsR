library(EviewsR)

demo(exec_commands)


create_object(wf="exec_commands",action="equation",
              object_name="create_object",view_or_proc="ls",arg_list="y ar(1)")

create_object(wf="exec_commands",object_name="x1",
              object_type="series",expression="y^2")
