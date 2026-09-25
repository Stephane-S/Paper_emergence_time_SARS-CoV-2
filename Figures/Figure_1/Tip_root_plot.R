library(ggplot2)
library(gridExtra)
library(ggtext)
library(grid)

source('multiplot.R')

plot_tip_to_root_divergence <- function(decimal_years, tip_to_root_divergence, title, position, data_color) {
  
  # Create a data frame with the x and y values
  data <- data.frame(decimal_years, tip_to_root_divergence, title)
  
  # Calculate regression coefficients and R-squared value
  model <- lm(tip_to_root_divergence ~ decimal_years, data = data)
  slope <- coef(model)[2]
  print(slope)
  x_intercept <- -coef(model)[1]/slope
  r_squared <- summary(model)$r.squared
  lb1 <- 'test'
  lb1
  
  # Create the scatter plot with points and regression line
  p <- ggplot(data, aes(x = decimal_years, y = tip_to_root_divergence)) +

    geom_point(color = data_color,
               size  = 4,
               stroke = 0,
               shape=16,
               alpha = .7) +
    
    geom_smooth(method = "lm", se = FALSE, fullrange = TRUE, size=1, color = 'gray') +
    
    # Add a black horizontal line for the x-axis
    geom_hline(yintercept = 0, color = "black") +
    
    coord_cartesian(expand = FALSE) +
    
    theme_bw(base_size = 12, base_family = "Helvetica") +
    
    #title
    #labs(title = title) +
    ggtitle(title) +
    
    theme(plot.title = element_text(hjust = 0.5),
          axis.title.x = element_blank(),
          axis.title.y = element_blank(),
          panel.grid.major = element_blank(),
          panel.grid.minor = element_blank(),
          panel.background = element_blank(),
          axis.line = element_line(colour = "black")) +
    
    
    # Set x and y axis labels
    #xlab("Decimal Years") +
    #ylab("Tip-to-Root Divergence") +
    
    # Set y-axis limits to include 0
    xlim(x_intercept, max(decimal_years) + 1) +
    ylim(0, max(tip_to_root_divergence) +0.1) +
    
    # Add text in top-left corner with slope, x-intercept, and R-squared value
    annotate("text", x = position[1], y = position[2],
             label = paste0("Slope =  ", formatC(slope, format = "e", digits = 1), "\n",
                            "X-Intercept = ", round(x_intercept, 2), "\n",
                            "R2 = ", round(r_squared, 2)),
             hjust = 0, vjust = 1, size = 4)
  
    
  # Return the plot
  return(p)
}




# Example usage
years <- c(2001.5, 2002.5, 2003.5, 2004.5, 2005.5)
divergences <- c(0.015, 0.02, 0.03, 0.04, 0.05)

# Define the data frames for each plot
#data1 <- data.frame(decimal_years = c(2000, 2001, 2002, 2003, 2004),
#                    divergences = c(1.2, 2.1, 3.0, 4.2, 5.3),
#                    title = "Plot 1")

genome_noVariant <- read.csv('tip_root_data/genome_noVariant.csv', sep = '\t')
genome_Variant <- read.csv('tip_root_data/genome.csv', sep = '\t')
gene_s_noVariant <- read.csv('tip_root_data/gene_s_noVariant.csv', sep = '\t')
gene_s_Variant <- read.csv('tip_root_data/gene_s.csv', sep = '\t')
rbd_noVariant <- read.csv('tip_root_data/rbd_noVariant.csv', sep = '\t')
rbd_Variant <- read.csv('tip_root_data/rbd.csv', sep = '\t')
  


p1 <- plot_tip_to_root_divergence(genome_noVariant$date, genome_noVariant$distance, 'Whole genomes (no Sars-CoV 2 variants)', c(1995, 0.8), '#ef8a62')
p2 <- plot_tip_to_root_divergence(genome_Variant$date, genome_Variant$distance, 'Whole genome', c(2000, 0.24), '#2166ac')

p3 <- plot_tip_to_root_divergence(gene_s_noVariant$date, gene_s_noVariant$distance, 'Gene S (no Sars-CoV 2 variants)', c(1998, 1.4), '#ef8a62')
p4 <- plot_tip_to_root_divergence(gene_s_Variant$date, gene_s_Variant$distance, 'Gene S', c(2003, 0.5), '#2166ac')

p5 <- plot_tip_to_root_divergence(rbd_noVariant$date, rbd_noVariant$distance, 'RBD (no Sars-CoV 2 variants)', c(2006.5, 0.9), '#ef8a62')
p6 <- plot_tip_to_root_divergence(rbd_Variant$date, rbd_Variant$distance, 'RBD', c(2002, 0.3), '#2166ac')

yleft <- textGrob("Root-to-tip divergence (subs/site)", rot = 90, gp = gpar(fontsize = 18))
bottom <- textGrob("Date (decimal year)", gp = gpar(fontsize = 18))

multiplot <- grid.arrange(p1, p2, p3, p4, p5, p6, ncol = 2,
                          left = yleft, bottom = bottom)

ggsave(
  'test.svg',
  plot = multiplot,
  dpi = 300,
  limitsize = FALSE)

  #multiplot(p1, p2, p3, p4, cols=2)
#> `geom_smooth()` using method = 'loess'

