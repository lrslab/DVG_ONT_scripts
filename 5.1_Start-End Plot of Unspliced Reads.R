library(ggplot2)
library(dplyr)
library(data.table)

dfv <- fread("R Output/EILV_polyA2/Viral Spliced and Unspliced Reads/EILV_polyA2_Unspliced.csv", sep=",", header=T)
ggplot(dfv)+
  geom_histogram(aes(x=refstart), binwidth=10, color="grey80")+
  geom_histogram(aes(x=refend), binwidth=10, color="grey40")+
  theme_bw()+
  theme(axis.title.x=element_blank(), 
        panel.grid.minor=element_blank(), 
        panel.grid.major=element_blank(), 
        panel.background=element_blank(), 
        legend.position="none")
