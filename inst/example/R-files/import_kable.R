library(EviewsR)

demo(exec_commands)

# To import the entire table object

import_kable(wf="exec_commands",page="eviewspage",table="OLSTable",format="pandoc")

# To import certain RANGE of the table object

import_kable(wf="exec_commands",page="eviewspage",table="OLSTable",range="r7c1:r10c5",
             format="pandoc")

