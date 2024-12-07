# install.packages('R.matlab')
library(R.matlab)
library(ggplot2)
library(tidyverse)

setwd('~/UC San Diego/ECON 280 Computation/econ280project')

df <- readMat('data/cleandata/CompustatData_.mat')

df_rnd <- data.frame(na.omit(df$RND[36,]))
colnames(df_rnd) <- 'rnd'

df_rnd <- df_rnd %>% 
  filter(rnd > 0) 

# calculate interquartile range
q1 <- quantile(df_rnd$rnd, 0.25)
q3 <- quantile(df_rnd$rnd, 0.75)
iqr <- IQR(df_rnd$rnd)

# define bounds for outliers
lower <- q1 - 1.5 * iqr
upper <- q3 + 1.5 * iqr

# remove outliers
df_rnd <- df_rnd %>%
  filter(rnd >= lower & rnd <= upper)

ggplot(df_rnd, aes(x = rnd)) +
  geom_histogram(fill = 'steelblue3', color = 'steelblue4', binwidth=2) +
  labs(title = 'Distribution of R&D Spending, 2015', 
       x = 'Revenue (Millions)', 
       y = 'Number of Firms') +
  theme_minimal() + 
  theme(axis.text.x = element_text(size = 14, margin = margin(t = 0), color = 'black'),  
        axis.text.y = element_text(size = 14, margin = margin(r = 0), color = 'black'),
        axis.title.x = element_text(margin = margin(t = 20), size = 16),
        axis.title.y = element_text(margin = margin(r = 20), size = 16), 
        plot.title = element_text(hjust = 0.5, size = 22),
        panel.grid = element_blank())

ggsave(filename = 'histogram.png', 
       path = 'output/')

