library(EviewsR)
library(ggplot2)

# Simulate random walk and return as a dataframe object

rwalk(series="a b e",rndseed=12345,start_date = 1990,frequency="m",num_observations=100)

ggplot(eviews$abe,aes(x=date,color="blue"))+geom_line(aes(y=a,color="a"))+
  geom_line(aes(y=b,color="b"))+geom_line(aes(y=e,color="e"))+labs(colour='',x="",y="")

# To simulate random walk and return as an `xts` object

rwalk(series="X Y Z",rndseed=12345,start_date = 1990,frequency="m",num_observations=100,class="xts")

plot(eviews$xyz)

autoplot(eviews$xyz,facet="")+xlab("")



# To simulate random walk series on existing workfile

eviews_wfcreate(wf="rwalk",page="rwalk",frequency="7",start_date=2020,end_date="2022")
rwalk(wf="rwalk",series="rw1 rw2 rw3",rndseed=12345,frequency="M")

head(eviews$rw1rw2rw3)
