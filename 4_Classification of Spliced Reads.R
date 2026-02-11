library(dplyr)
library(data.table)

dfv <- fread("R Output/EILV_polyA2/Viral Spliced and Unspliced Reads/EILV_polyA2_Spliced_2.csv", sep=",", header=T)
dfv <- dfv[order(refstart)]
length(unique(dfv$readname))

#### classification according to fragment amounts

dfv_2 <- dfv[duplicated(dfv$readname)]
dfv_3 <- dfv_2[duplicated(dfv_2$readname)]
dfv_4 <- dfv_3[duplicated(dfv_3$readname)]
dfv_5 <- dfv_4[duplicated(dfv_4$readname)]
dfv_6 <- dfv_5[duplicated(dfv_5$readname)]
dfv_7 <- dfv_6[duplicated(dfv_6$readname)]
dfv_8 <- dfv_7[duplicated(dfv_7$readname)]
dfv_9 <- dfv_8[duplicated(dfv_8$readname)]
dfv_12 <- dfv_9[duplicated(dfv_9$readname)]

s12 <- factor(dfv_12$readname)
dfv_12 <- dfv %>% filter(readname %in% s12)
length(unique(dfv_12$readname))
write.csv(dfv_12, "R Output/EILV_polyA2/Classification of Spliced Reads/Spliced_12.csv")

s9 <- factor(dfv_9$readname)
dfv_9 <- dfv %>% filter(readname %in% s9)
dfv_9 <- dfv_9 %>% filter(!(readname %in% s12))
length(unique(dfv_9$readname))
write.csv(dfv_9, "R Output/EILV_polyA2/Classification of Spliced Reads/Spliced_9.csv")

s8 <- factor(dfv_8$readname)
dfv_8 <- dfv %>% filter(readname %in% s8)
dfv_8 <- dfv_8 %>% filter(!(readname %in% s9))
length(unique(dfv_8$readname))
write.csv(dfv_8, "R Output/EILV_polyA2/Classification of Spliced Reads/Spliced_8.csv")

s7 <- factor(dfv_7$readname)
dfv_7 <- dfv %>% filter(readname %in% s7)
dfv_7 <- dfv_7 %>% filter(!(readname %in% s8))
length(unique(dfv_7$readname))
write.csv(dfv_7, "R Output/EILV_polyA2/Classification of Spliced Reads/Spliced_7.csv")

s6 <- factor(dfv_6$readname)
dfv_6 <- dfv %>% filter(readname %in% s6)
dfv_6 <- dfv_6 %>% filter(!(readname %in% s7))
length(unique(dfv_6$readname))
write.csv(dfv_6, "R Output/EILV_polyA2/Classification of Spliced Reads/Spliced_6.csv")

s5 <- factor(dfv_5$readname)
dfv_5 <- dfv %>% filter(readname %in% s5)
dfv_5 <- dfv_5 %>% filter(!(readname %in% s6))
length(unique(dfv_5$readname))
write.csv(dfv_5, "R Output/EILV_polyA2/Classification of Spliced Reads/Spliced_5.csv")

s4 <- factor(dfv_4$readname)
dfv_4 <- dfv %>% filter(readname %in% s4)
dfv_4 <- dfv_4 %>% filter(!(readname %in% s5))
length(unique(dfv_4$readname))
write.csv(dfv_4, "R Output/EILV_polyA2/Classification of Spliced Reads/Spliced_4.csv")

s3 <- factor(dfv_3$readname)
dfv_3 <- dfv %>% filter(readname %in% s3)
dfv_3 <- dfv_3 %>% filter(!(readname %in% s4))
length(unique(dfv_3$readname))
write.csv(dfv_3, "R Output/EILV_polyA2/Classification of Spliced Reads/Spliced_3.csv")

s2 <- factor(dfv_2$readname)
dfv_2 <- dfv %>% filter(readname %in% s2)
dfv_2 <- dfv_2 %>% filter(!(readname %in% s3))
length(unique(dfv_2$readname))
write.csv(dfv_2, "R Output/EILV_polyA2/Classification of Spliced Reads/Spliced_2.csv")

#### classification according to sequence strand

dfv_negative <- dfv[(strand=="-")]
snegative <- factor(dfv_negative$readname)
dfv_negative <- dfv %>% filter(readname %in% snegative)
length(unique(dfv_negative$readname))
write.csv(dfv_negative, "R Output/EILV_polyA2/Classification of Spliced Reads/Negative.csv")

dfv_positive <- dfv %>% filter(!(readname %in% snegative))
length(unique(dfv_positive$readname))
write.csv(dfv_positive, "R Output/EILV_polyA2/Classification of Spliced Reads/Positive.csv")

#### classification according to start point (to classify gRNA and sgRNA reads)

dfv_start <- dfv[!duplicated(dfv$readname),]
dfv_7303 <- dplyr::filter(dfv_start, refstart <= 7303)
s7303 <- factor(dfv_7303$readname)
dfv_7303 <- dfv %>% filter(readname %in% s7303)
length(unique(dfv_7303$readname))
write.csv(dfv_7303, "R Output/EILV_polyA2/Classification of Spliced Reads/7303.csv")

dfv_11902 <- dplyr::filter(dfv_start, refstart <= 11902)
dfv_11902 <- dplyr::filter(dfv_11902, refstart > 7303)
s11902 <- factor(dfv_11902$readname)
dfv_11902 <- dfv %>% filter(readname %in% s11902)
length(unique(dfv_11902$readname))
write.csv(dfv_11902, "R Output/EILV_polyA2/Classification of Spliced Reads/11902.csv")

ggplot()+
  geom_histogram(aes(x=dfv_11902$refstart), binwidth=10, color="chartreuse1")+
  geom_histogram(aes(x=dfv_11902$refend), binwidth=10, color="brown1")+
  theme_bw()+
  theme(axis.title.x=element_blank(), 
        panel.grid.minor=element_blank(), 
        panel.grid.major=element_blank(), 
        panel.background=element_blank(), 
        legend.position="none")

dfv_12423 <- dplyr::filter(dfv_start, refstart > 11902)
s12423 <- factor(dfv_12423$readname)
dfv_12423 <- dfv %>% filter(readname %in% s12423)
length(unique(dfv_12423$readname))
write.csv(dfv_12423, "R Output/EILV_polyA2/Classification of Spliced Reads/12423.csv")
