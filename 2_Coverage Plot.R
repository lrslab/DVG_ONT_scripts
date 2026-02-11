library(ggplot2)
library(dplyr)
library(cowplot)

# F and R strand separated coverage plot
bedf<-read.csv("DRS Data/EILV/polyA2/F.bed", sep="\t", header=F)
colnames(bedf)<-c("chro", "start", "end", "coverage")
bedf$strand="F"

bedr<-read.csv("DRS Data/EILV/polyA2/R.bed", sep="\t", header=F)
colnames(bedr)<-c("chro", "start", "end", "coverage")
bedr$coverage=-bedr$coverage
bedr$strand="R"

bed=rbind(bedf, bedr)

ggplot(bed)+
  geom_rect(aes(xmin=start, xmax=end, ymin=0, ymax=coverage, fill=strand))+
  theme_bw()+
  theme(panel.grid.minor=element_blank(), 
        panel.grid.major=element_blank(), 
        panel.background=element_blank(), 
        legend.position="none")+
  scale_fill_manual(values=c("#FAD586", "#C64756"))#+scale_y_log10()+xlim(c(0, 7600))+ylim(c(-100,7000))
