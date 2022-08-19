library(EviewsR)

library(ggplot2)

demo(exec_commands)

# To import all series objects across all pages, as a dataframe object

import_series(wf="exec_commands")

# Plot the dataframe object

ggplot2::ggplot(eviews$eviewspage,aes(x=date))+geom_line(aes(y=x,color="x"))+
  geom_line(aes(y=y,color="y"))+labs(colour='',x="",y="")

# To import all series objects across all pages, as an `xts` object

import_series(wf="exec_commands",class="xts")


# Plot the `xts` object

ggplot2::autoplot(eviews$eviewspage,facet='')+xlab("")

# To import specific series objects, for example starting with Y

import_series(wf="exec_commands",series="y*")

# To import series objects on specific pages

import_series(wf="exec_commands",page="eviewspage")


# To access the series in base R

head(eviews$eviewspage)

# To get the values above in R Markdown or Quarto:

# chunkLabel$eviewspage


