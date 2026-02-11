library(data.table)
library(dplyr)
library(ggplot2)

dfvs <- fread("R Output/EILV_polyA2/Classification of Spliced Reads/Spliced_2.csv", sep=",", header=T)
dfv1 <- dfvs[order(refstart),]
dfv1 <- dfv1[!duplicated(dfv1$readname),]
dfv1 <- subset(dfv1, select=c("readname", "refstart", "refend", "qrylength", "mappedlength", "strand"))
dfv2 <- dfvs[order(-refstart),]
dfv2 <- dfv2[!duplicated(dfv2$readname),]
dfv2 <- subset(dfv2, select=c("readname", "refstart", "refend"))
colnames(dfv2) <- c("readname", "refstart2", "refend2")
dfvs=merge(dfv1, dfv2, by="readname")
colnames(dfvs) <- c("readname", "refstart", "refend2", "qrylength", "mappedlength", "strand", "refstart2", "refend")
dfvs <- dplyr::filter(dfvs, refstart2 >= 11903)
dfvs <- dplyr::filter(dfvs, refend2 <= 4111)

ggplot(dfvs, aes(refend2, refstart2))+
  geom_point(colour="firebrick2", size=0.3, alpha=0.3)+
  theme_bw()+
  theme(panel.grid.minor=element_blank(), 
        panel.grid.major=element_blank(), 
        panel.background=element_blank(), 
        legend.position="none")+coord_cartesian(xlim = c(0,4111), ylim = c(11903,12423))
