library('readxl')

df <- read_excel('code/02_analysis/df.xlsx')

png('output/main_result_r.png', height = 400, width = 600)

par(mar = c(2, 4, 1, 3))

plot(df$Decades, df$`log2(IdeaTFP)`, 
     ylim = c(-6.01,0),
     axes = FALSE, xaxs = 'i', yaxs = 'i', 
     type = 'l', col = 'navyblue', lwd = 3,
     xlab = '', ylab = '')

axis(2, at = c(-6, -5, -4, -3, -2, -1, 0),
     labels = c('1/64', '1/32', '1/16', '1/8', '1/4', '1/2', '1'), las = 2)

text(1970, -1.25, "Effective number of\n researchers (right scale)", col = "black", cex = 0.75)

mtext('Index (1930=1)', side = 2, line = 3, col = 'navyblue', cex = 1.2)

# add right axis
par(new = TRUE)

plot(df$Decades, df$`log2(Scientists)`, 
     ylim = c(-0.01, 5),
     axes = FALSE, xaxs = 'i', yaxs = 'i', 
     type = 'l', col = 'forestgreen', lwd = 3, 
     xlab = '', ylab = '')

axis(side = 4, at = c(0, 1, 2, 3, 4, 5),
     labels = c('1', '2', '4', '8', '16', '32'), las = 2)

text(1980, 1.75, "Research productivity\n (left scale)", col = "black", cex = 0.75)

mtext('Index (1930=1)', side = 4, line = 2, col = 'forestgreen', cex = 1.2)

# add x-axis
axis(1, at = c(df$Decades),
     labels = c('1930s', '1940s', '1950s', '1960s', '1970s', '1980s', '1990s', '2000s'))

# save png in output folder
dev.off()
