library(ggplot2)
library(tidyr)

data <- read.csv("EC(-)DVG.csv")
virus_temp <- data[data$refend <=4111, ]
virus_temp <- virus_temp[order(virus_temp$refend), ]
readname_column <- virus_temp$readname

data$readname <- factor(data$readname, levels =rev(readname_column))
plot <- ggplot(data)

for (temp in readname_column) {
  plot <- plot+ geom_hline(yintercept = temp, linetype = "dashed")
}

plot <- plot + geom_segment(aes(x = refstart, xend = refend, y=readname, yend = readname, color=readname))
plot <- plot +
  theme_bw()+
  labs(x='',y='')+
    theme(
    axis.text.y = element_blank(),
    strip.background = element_blank(),
    legend.position = 'none',
    text = element_text(size = 12),
    panel.grid.minor =element_blank(),
  )
ggsave("EC_DVG.pdf", plot, width = 6, height = 3)
