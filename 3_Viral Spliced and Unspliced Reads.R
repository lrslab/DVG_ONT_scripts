library(data.table)
library(dplyr)
library(ggplot2)

# host reads
dfh <- fread("DRS Data/EILV/polyA2/mos8.bed", sep="\t", header=F)
colnames(dfh) <- c("chro", "refstart", "refend", "qrylength", "mappedlength", "strand","readname", "label")
dfh <- dfh[(dfh$label=="host"),]
dfh <- dfh[!(dfh$qrylength=="0"),]
length(unique(dfh$readname))

# virus reads
dfv <- fread("DRS Data/EILV/polyA2/virus8.bed", sep="\t", header=F)
colnames(dfv) <- c("chro", "refstart", "refend", "qrylength", "mappedlength", "strand","readname", "label")
dfv <- dfv[(dfv$label=="virus")]
dfv <- dfv[!(dfv$qrylength=="0")]
length(unique(dfv$readname))

# virus-host chimeric reads
dfvreadname <- factor(dfv$readname)
dfh <- dfh %>% filter(readname %in% dfvreadname)
length(unique(dfh$readname))

# combine virus reads and chimeric reads
dfv <- rbind(dfv, dfh)

# add polyA length information
polyA <- fread("DRS Data/EILV/polyA2/virus_polyA.txt", sep="\t", header=T)
polyA <- subset(polyA, select=c("readname", "polya_length", "qc_tag"))
polyA <- polyA[order(qc_tag),]
polyA <- polyA[!duplicated(polyA$readname)]
dfva=merge(dfv, polyA, by="readname")
length(unique(dfva$readname))

# identify spliced reads
dfvas <- dfva[duplicated(dfva$readname)]
s <- factor(dfvas$readname)
dfvas <- dfva %>% filter(readname %in% s)
length(unique(dfvas$readname))
write.csv(dfvas, "R Output/EILV_polyA2/Viral Spliced and Unspliced Reads/EILV_polyA2_Spliced.csv")

# identify unspliced reads
dfvau <- dfva %>% filter(!(readname %in% s))
length(unique(dfvau$readname))
write.csv(dfvau, "R Output/EILV_polyA2/Viral Spliced and Unspliced Reads/EILV_polyA2_Unspliced.csv")

# identify spliced reads and exclude chimeric reads
s2 <- factor(dfh$readname)
dfvas2 <- dfvas %>% filter(!(readname %in% s2))
length(unique(dfvas2$readname))
write.csv(dfvas2, "R Output/EILV_polyA2/Viral Spliced and Unspliced Reads/EILV_polyA2_Spliced_2.csv")

# identify chimeric reads
dfvac <- dfva %>% filter(readname %in% s2) 
length(unique(dfvac$readname))
write.csv(dfvac, "R Output/EILV_polyA2/Viral Spliced and Unspliced Reads/EILV_polyA2_Chimeric.csv")

# count start point of each read
df2=cut(dfvau$refstart, breaks=seq(0, 12423, by=10))
df3=data.frame(df2)
startfreq=count(df3, df2)
write.csv(startfreq, "R Output/EILV_polyA2/Viral Spliced and Unspliced Reads/EILV_polyA2_Unspliced_Start.csv")
df2=cut(dfvas2$refstart, breaks=seq(0, 12423, by=10))
df3=data.frame(df2)
startfreq=count(df3, df2)
write.csv(startfreq, "R Output/EILV_polyA2/Viral Spliced and Unspliced Reads/EILV_polyA2_Spliced_Start.csv")
df2=cut(dfvac$refstart, breaks=seq(0, 12423, by=10))
df3=data.frame(df2)
startfreq=count(df3, df2)
write.csv(startfreq, "R Output/EILV_polyA2/Viral Spliced and Unspliced Reads/EILV_polyA2_Chimeric_Start.csv")

# count end point of each read
df2=cut(dfvau$refend, breaks=seq(0, 12423, by=10))
df3=data.frame(df2)
endfreq=count(df3, df2)
write.csv(endfreq, "R Output/EILV_polyA2/Viral Spliced and Unspliced Reads/EILV_polyA2_Unspliced_End.csv")
df2=cut(dfvas2$refend, breaks=seq(0, 12423, by=10))
df3=data.frame(df2)
endfreq=count(df3, df2)
write.csv(endfreq, "R Output/EILV_polyA2/Viral Spliced and Unspliced Reads/EILV_polyA2_Spliced_End.csv")
df2=cut(dfvac$refend, breaks=seq(0, 12423, by=10))
df3=data.frame(df2)
endfreq=count(df3, df2)
write.csv(endfreq, "R Output/EILV_polyA2/Viral Spliced and Unspliced Reads/EILV_polyA2_Chimeric_End.csv")
