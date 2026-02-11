library(ggplot2)
library(dplyr)
library(data.table)

#### comparison of polyA length between viral and host reads

v_polyA <- read.csv("DRS Data/EILV/polyA2/virus_polyA.txt", sep="\t", header=T)
v_polyA <- subset(v_polyA, select=c("readname", "polya_length", "qc_tag"))
v_polyA <- v_polyA[(v_polyA$qc_tag=="PASS"),]
v_polyA <- v_polyA[!(duplicated(v_polyA)),]
v_polyA$label="virus"
h_polyA <- read.csv("DRS Data/EILV/polyA2/host_polyA.txt", sep="\t", header=T)
h_polyA <- subset(h_polyA, select=c("readname", "polya_length", "qc_tag"))
h_polyA <- h_polyA[(h_polyA$qc_tag=="PASS"),]
h_polyA <- h_polyA[!(duplicated(h_polyA)),]
h_polyA$label="host"
polyA <- rbind(v_polyA, h_polyA)

ggplot(polyA)+
  geom_boxplot(aes(x=factor(label, level=c('virus','host')), y=polya_length, color=label), outlier.size=0.3, alpha=0.1)+
  theme_bw()+
  theme(axis.title.x=element_blank(), 
        panel.grid.minor=element_blank(), 
        panel.grid.major=element_blank(), 
        panel.background=element_blank(), 
        legend.position="none",
        axis.text=element_text(size=14),
        axis.title=element_text(size=16, face="bold"))+ylab("Poly(A) length")+
  coord_cartesian(ylim = c(0,300))+scale_y_continuous(breaks=seq(0,300,by=50))
