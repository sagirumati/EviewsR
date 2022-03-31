library(EviewsR)

rwalk(wf="",series="X Y Z",page="",rndseed=12345,frequency="M",num_observations=100)
plot(eviews$XYZ[[2]],ylab = "EViewsR",type = "l",col="red")
