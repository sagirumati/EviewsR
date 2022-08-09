library(EviewsR)

demo(exec_commands)

import_equation(wf="exec_commands",page="eviewsPage",equation="OLS")

# To access the data members in base R

eviews$eviewspage_ols

# To obtain R-squared value in base R

eviews$eviewspage_ols$r2

# To get the values above in R Markdown or Quarto:

# chunkLabel$eviewspage_ols

# chunkLabel$eviewspage_ols$r2
