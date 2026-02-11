library(ggplot2)
library(dplyr)
library(data.table)

dfv <- fread("R Output/EILV_polyA2/Viral Spliced and Unspliced Reads/EILV_polyA2_Chimeric.csv", sep=",", header=T)
dfv <- dfv[(dfv$label=="virus"),]
length(unique(dfv$readname))

dfv_end3 <- dfv[order(-refend),]
dfv_end3 <- dfv_end3[!duplicated(dfv_end3$readname),]
dfv_end3 <- subset(dfv_end3, select=c("readname", "refend"))
colnames(dfv_end3) <- c("readname", "end3")
dfv_end5 <- dfv[order(refstart),]
dfv_end5 <- dfv_end5[!duplicated(dfv_end5$readname),]
dfv_end5 <- subset(dfv_end5, select=c("readname", "refstart"))
colnames(dfv_end5) <- c("readname", "end5")
dfv_ends <- merge(dfv_end3, dfv_end5, by="readname")

dfv_int3 <- dfv[order(-refend),]
dfv_int3 <- dfv_int3[duplicated(dfv_int3$readname),]
dfv_int3 <- subset(dfv_int3, select=c("readname", "refend"))
colnames(dfv_int3) <- c("readname", "int3")
length(unique(dfv_int3$readname))
dfv_int5 <- dfv[order(refstart),]
dfv_int5 <- dfv_int5[duplicated(dfv_int5$readname),]
dfv_int5 <- subset(dfv_int5, select=c("readname", "refstart"))
colnames(dfv_int5) <- c("readname", "int5")
length(unique(dfv_int5$readname))

#### plot
# 3*6
ggplot()+
  geom_histogram(aes(x=dfv_int5$int5), binwidth=10, color="lightseagreen")+
  geom_histogram(aes(x=dfv_int3$int3), binwidth=10, color="lightcoral")+
  geom_histogram(aes(x=dfv_ends$end5), binwidth=10, color="grey80")+
  geom_histogram(aes(x=dfv_ends$end3), binwidth=10, color="grey40")+
  theme_bw()+
  theme(axis.title.x=element_blank(), 
        panel.grid.minor=element_blank(), 
        panel.grid.major=element_blank(), 
        panel.background=element_blank(), 
        legend.position="none")
