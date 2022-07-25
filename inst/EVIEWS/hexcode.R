library(magrittr)
d=dir("sagiru",".Rmd")
k=dir("sagiru") %>% gsub(d,'',.) %>% file.remove(paste0("sagiru/",.),recursive = T,force = T)

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
zyx.options size(3,3) gridwidth(1)
zyx.save(d=300,t=png,w=20,h=20) zyx
'
exec_commands(commands)
 #hexSticker::sticker("eviews.pdf",package = "EviewsR",s_width =2.5,s_height = 2.3,s_x = 0.27,s_y = 1,p_color = "#01B5F2",spotlight=T,p_y = 1.8,h_color = "#01B5F2",white_around_sticker=T)


 #hexSticker::sticker("zyx.png",package = "EviewsR",s_width =1.8,s_height = 1.8,s_x = 1.27,s_y = 0.94,p_color = "#E391BC",spotlight=T,p_y = 1.8,h_color = "#01B5F2",white_around_sticker=T,url="www.smati.com.ng",u_size = 4,u_y = 0.079,u_x = 1.03)
  # hexSticker::sticker("zyx.png",asp = 1.05,package = "EviewsR",s_width =1.9,s_height = 1.8,s_x = 1.26098,s_y = 0.94,p_color = "#01B5F2",spotlight=T,p_y = 1.8,h_color = "#01B5F2",white_around_sticker=T)
 #hexSticker::sticker("zyx.png",package = "EviewsR",s_width =1.8,s_height = 1.8,s_x = 1.235,s_y = 0.94,p_color = "#932D80",spotlight=T,p_y = 1.75,h_color = "#01B5F2",white_around_sticker=T,url="www.smati.com.ng",u_size = 4,u_y = 0.079,u_x = 1.03,p_family = "serif",p_fontface = "bold.italic",angle=30)

# hexSticker::sticker("eviews_logo.jpg",package = "EviewsR",s_width =1,s_height = 1,s_x = 1,s_y = 1,p_color = "#932D80",spotlight=T,p_x = 1,p_y = 1.75,h_color = "#01B5F2",white_around_sticker=T,url="www.smati.com.ng",u_size = 4,u_y = 0.079,u_x = 1.03,p_family = "serif",p_fontface = "bold.italic",angle=0,filename = "EviewsR_hex.png")

# hexSticker::sticker("zyx.png",package = "EviewsR",asp = 1,s_width =1.5,s_height = 1.5,s_x = 1,s_y =1,p_color = "#932D80",spotlight=T,p_x = 1,p_y = 1.75,h_color = "#01B5F2",white_around_sticker=T,url="www.smati.com.ng",u_size = 4,u_y = 0.079,u_x = 1.03,p_family = "serif",p_fontface = "bold.italic",angle=0,filename = "Eviewsr_test.png")
# shell.exec("Eviewsr_test.png")


# hexSticker::sticker("zyx.png",package = "EviewsR",asp = 1,s_width =1.5,s_height = 1.5,s_x = 1,s_y =1,p_color = "#932D80",spotlight=T,p_x = 1,p_y = 1.75,h_color = "#01B5F2",white_around_sticker=T,url="www.smati.com.ng",u_size = 4,u_y = 0.079,u_x = 1.03,p_family = "serif",p_fontface = "bold.italic",angle=0,filename = "Eviewsr_test.png")


#selected
 hexSticker::sticker("zyx.png",package = "EviewsR",s_width =1.8,s_height = 1.8,s_x = 1.235,s_y = 0.94,p_color = "#932D80",spotlight=T,p_x = 0.78,p_y = 1.75,h_color = "#01B5F2",white_around_sticker=T,url="www.smati.com.ng",u_size = 4,u_y = 0.079,u_x = 1.03,p_family = "serif",p_fontface = "bold.italic",p_size = 10,angle=30)

shell.exec("EviewsR.png")


# shell.exec("Eviewsr_hex.png")
 # shell.exec("Eviewsr1.png")
