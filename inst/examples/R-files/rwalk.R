library(EviewsR)

rwalk(series="X Y Z",rndseed=12345,frequency="M",
      num_observations=100)

plot(eviews$XYZ[[2]],ylab = "EViewsR",type = "l",col="red")

rwalk(wf="EviewsR_exec_commands",series="rw1 rw2 rw3",rndseed=12345,frequency="M")

head(eviews$rw1rw2rw3)
