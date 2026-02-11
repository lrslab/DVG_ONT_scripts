library(ggplot2)
library(dplyr)
library(data.table)

#### merge virus8.bed and host8.bed
dfv <- fread("DRS Data/EILV/polyA2/virus8.bed", sep="\t", header=F)
colnames(dfv) <- c("chro", "refstart", "refend", "length", "mappedlength", "strand","readname", "label")
length(unique(dfv$readname))
dfu1 <- dfv[(dfv$label=="unmapped"),]
length(unique(dfu1$readname))
dfv <- dfv[(dfv$label=="virus"),]
length(unique(dfv$readname))
dfv <- dfv[order(-length)]
dfv <- dfv[!duplicated(dfv$readname)]

dfh <- fread("DRS Data/EILV/polyA2/mos8.bed", sep="\t", header=F)
colnames(dfh) <- c("chro", "refstart", "refend", "length", "mappedlength", "strand","readname", "label")
length(unique(dfh$readname))
dfu2 <- dfh[(dfh$label=="unmapped"),]
length(unique(dfu2$readname))
dfh <- dfh[(dfh$label=="host"),]
length(unique(dfh$readname))
dfh <- dfh[order(-length)]
dfh <- dfh[!duplicated(dfh$readname)]

dfu1 <- dfu1[order(-length)]
dfu1 <- dfu1[!duplicated(dfu1$readname),]
dfu2 <- dfu2[order(-length)]
dfu2 <- dfu2[!duplicated(dfu2$readname),]
dfu <- rbind(dfu1, dfu2)
dfu <- dfu[order(length)]
dfu <- dfu[duplicated(dfu),]
length(unique(dfu$readname))

df <- rbind(dfv, dfh, dfu)
length(unique(df$readname))

#### boxplot of read length
# 4*4
ggplot(df)+geom_boxplot(aes(x=factor(label, level=c('virus','host','unmapped')), y=length, color=label), outlier.size=0.3, alpha=0.1)+
  theme_bw()+
  theme(axis.title.x=element_blank(), 
        panel.grid.minor=element_blank(), 
        panel.grid.major=element_blank(), 
        panel.background=element_blank(), 
        legend.position="none",
        axis.text=element_text(size=14),
        axis.title=element_text(size=16, face="bold"))+ylab("Read length")+
  coord_cartesian(ylim = c(0,15000))+scale_y_continuous(breaks=seq(0,15000,by=3000))
