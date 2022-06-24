# library(magrittr)
# d=dir("sagiru",".Rmd")
# k=dir("sagiru") %>% gsub(d,'',.) %>% file.remove(paste0("sagiru/",.),recursive = T,force = T)
#
#

library(EviewsR)
commands='wfcreate m 1990 2000
rndseed 123

for %y z y x
genr {%y}=@cumsum(nrnd)
graph {%y}_graph.line {%y}
{%y}_graph.save(d=300,t=png,w=20,h=20) {%y}_graph
next
group gr z y x
freeze(zyx) gr.line
zyx.template eviews10
zyx.save(d=300,t=png) zyx
'
exec_commands(commands)
 hexSticker::sticker("eviews.pdf",package = "EviewsR",s_width =2.5,s_height = 2.3,s_x = 0.27,s_y = 1,p_color = "#01B5F2",spotlight=T,p_y = 1.8,h_color = "#01B5F2",white_around_sticker=T)


 hexSticker::sticker("zyx.png",package = "EviewsR1",s_width =2.5,s_height = 2.3,s_x = 0.27,s_y = 1,p_color = "#01B5F2",spotlight=T,p_y = 1.8,h_color = "#01B5F2",white_around_sticker=T)
