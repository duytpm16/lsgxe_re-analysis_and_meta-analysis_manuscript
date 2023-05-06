library(scattermore)
library(data.table)
library(ggplot2)
library(cowplot)
library(plyr)
library(dplyr)


setwd("C:/Users/duytp/Desktop/metagem_and_regem_manuscript_code/REGEM-simulations/")
gem <- as.data.frame(fread("gem_sexE_combined.out"))
gem <- gem[,!colnames(gem) %in% c("SNPID", "CHR", "POS", "Non_Effect_Allele", "Effect_Allele", "N_Samples", "AF")]
gem <- gem[,colnames(gem)[!grepl("N_|AF_|Beta_Marginal|SE_Beta_Marginal|robust_SE_Beta_Marginal", colnames(gem))]]
gc()
regem <- as.data.frame(fread("regem_sexE_results"))
regem <- regem[,!colnames(regem) %in% c("SNPID", "CHR", "POS", "Non_Effect_Allele", "Effect_Allele", "N_Samples", "AF")]
regem <- regem[,colnames(regem)[!grepl("N_|AF_|Beta_Marginal|SE_Beta_Marginal|robust_SE_Beta_Marginal", colnames(regem))]]
gc()

intnames   <- c("G", "G-sex")
titlenames <- c("Main", "G x Sex")
y_title <- c(expression(bold('GEM')))
x_title <- c(expression(bold('REGEM')))


# Main effects----
d <- data.frame(x = regem$Beta_G, y = gem$Beta_G)

a <- ggplot(d, aes(x = x, y = y)) +
      geom_hline(yintercept = 0, linetype = "dashed") +
      geom_vline(xintercept = 0, linetype = "dashed") +
      geom_abline(linewidth = 1, color = "darkred", linetype = "longdash", alpha = 0.5) +
      geom_scattermore(aes(x = x, y = y), color = "black", alpha = 1, pointsize = 6) +
      scale_y_continuous(breaks = c(-0.15, -0.10, -0.05, 0, 0.04)) +
      scale_x_continuous(breaks = c(-0.15, -0.10, -0.05, 0, 0.04)) +
      labs(x = x_title, y = y_title) +
      theme(panel.background = element_blank(),
            panel.grid = element_line(linewidth = 1, color = "grey95"),
            panel.border = element_rect(colour = "black", fill=NA, size = 1.7),
            axis.line = element_blank(),
            axis.ticks = element_blank(),
            axis.text  = element_text(size = 15, face = "bold"),
            axis.title = element_text(size = 20),
            plot.title = element_text(hjust = 0.5, size = 25, face = "bold")) + 
      ggtitle("Main")



# GxSex effects----
d <- data.frame(x = regem$`Beta_G-sex`, y = gem$`Beta_G-sex`)

b <- ggplot(d, aes(x = x, y = y)) +
      geom_hline(yintercept = 0, linetype = "dashed") +
      geom_vline(xintercept = 0, linetype = "dashed") +
      geom_abline(linewidth = 1, color = "darkred", linetype = "longdash", alpha = 0.5) +
      geom_scattermore(aes(x = x, y = y), color = "black", alpha = 1, pointsize = 6) +
      scale_y_continuous(breaks = c(-0.08, -0.04, 0, 0.04, 0.07)) +
      scale_x_continuous(breaks = c(-0.08, -0.04, 0, 0.04, 0.07)) +
      labs(x = x_title, y = y_title) +
      theme(panel.background = element_blank(),
            panel.grid = element_line(linewidth = 1, color = "grey95"),
            panel.border = element_rect(colour = "black", fill=NA, size = 1.7),
            axis.line = element_blank(),
            axis.ticks = element_blank(),
            axis.text  = element_text(size = 15, face = "bold"),
            axis.title = element_text(size = 20),
            plot.title = element_text(hjust = 0.5, size = 25, face = "bold")) + 
      ggtitle("G x Sex")


# Model-based Main Effect SE----
d <- data.frame(x = regem$SE_Beta_G, y = gem$SE_Beta_G)

c <- ggplot(d, aes(x = x, y = y)) +
      geom_hline(yintercept = 0, linetype = "dashed") +
      geom_vline(xintercept = 0, linetype = "dashed") +
      geom_abline(linewidth = 1, color = "darkred", linetype = "longdash", alpha = 0.5) +
      geom_scattermore(aes(x = x, y = y), color = "black", alpha = 1, pointsize = 6) +
      scale_y_continuous(breaks = c(0, 0.005, 0.01, 0.015, 0.02, 0.025)) +
      scale_x_continuous(breaks = c(0, 0.005, 0.01, 0.015, 0.02, 0.025)) +
      labs(x = x_title, y = y_title) +
      theme(panel.background = element_blank(),
            panel.grid = element_line(linewidth = 1, color = "grey95"),
            panel.border = element_rect(colour = "black", fill=NA, size = 1.7),
            axis.line = element_blank(),
            axis.ticks = element_blank(),
            axis.text  = element_text(size = 15, face = "bold"),
            axis.title = element_text(size = 20),
            plot.title = element_text(hjust = 0.5, size = 25, face = "bold")) + 
      ggtitle("Model-based")


# Model-based GxSex SE----
d <- data.frame(x = regem$`SE_Beta_G-sex`, y = gem$`SE_Beta_G-sex`)

e <- ggplot(d, aes(x = x, y = y)) +
      geom_hline(yintercept = 0, linetype = "dashed") +
      geom_vline(xintercept = 0, linetype = "dashed") +
      geom_abline(linewidth = 1, color = "darkred", linetype = "longdash", alpha = 0.5) +
      geom_scattermore(aes(x = x, y = y), color = "black", alpha = 1, pointsize = 6) +
      labs(x = x_title, y = y_title) +
      theme(panel.background = element_blank(),
            panel.grid = element_line(linewidth = 1, color = "grey95"),
            panel.border = element_rect(colour = "black", fill=NA, size = 1.7),
            axis.line = element_blank(),
            axis.ticks = element_blank(),
            axis.text  = element_text(size = 15, face = "bold"),
            axis.title = element_text(size = 20),
            plot.title = element_text(hjust = 0.5, size = 25, face = "bold")) + 
      ggtitle("Model-based")


# Model-based Covariance----
d <- data.frame(x = regem$`Cov_Beta_G_G-sex`, y = gem$`Cov_Beta_G_G-sex`)

f <- ggplot(d, aes(x = x, y = y)) +
      geom_hline(yintercept = 0, linetype = "dashed") +
      geom_vline(xintercept = 0, linetype = "dashed") +
      geom_abline(linewidth = 1, color = "darkred", linetype = "longdash", alpha = 0.5) +
      geom_scattermore(aes(x = x, y = y), color = "black", alpha = 1, pointsize = 6) +
      scale_y_continuous(breaks = c(-1.0e-04, 0, 1.0e-04), labels = function(x) format(x, scientific = TRUE)) + 
      scale_x_continuous(breaks = c(-1.0e-04, 0, 1.0e-04), labels = function(x) format(x, scientific = TRUE)) +
      labs(x = x_title, y = y_title) +
      theme(panel.background = element_blank(),
            panel.grid = element_line(linewidth = 1, color = "grey95"),
            panel.border = element_rect(colour = "black", fill=NA, size = 1.7),
            axis.line = element_blank(),
            axis.ticks = element_blank(),
            axis.text  = element_text(size = 15, face = "bold"),
            axis.title = element_text(size = 20),
            plot.title = element_text(hjust = 0.5, size = 25, face = "bold")) + 
      ggtitle("Model-based")


# Model-based Interaction----
d <- data.frame(x = -log10(regem$P_Value_Interaction), y = -log10(gem$P_Value_Interaction))

g <- ggplot(d, aes(x = x, y = y)) +
      geom_hline(yintercept = 0, linetype = "dashed") +
      geom_vline(xintercept = 0, linetype = "dashed") +
      geom_abline(linewidth = 1, color = "darkred", linetype = "longdash", alpha = 0.5) +
      geom_scattermore(aes(x = x, y = y), color = "black", alpha = 1, pointsize = 6) +
      scale_y_continuous(breaks = c(0, 10, 20, 30, 40, 50, 60), limits = c(0, 60)) +
      scale_x_continuous(breaks = c(0, 10, 20, 30, 40, 50, 60), limits = c(0, 60)) +
      labs(x = x_title, y = y_title) +
      theme(panel.background = element_blank(),
            panel.grid = element_line(linewidth = 1, color = "grey95"),
            panel.border = element_rect(colour = "black", fill=NA, size = 1.7),
            axis.line = element_blank(),
            axis.ticks = element_blank(),
            axis.text  = element_text(size = 15, face = "bold"),
            axis.title = element_text(size = 20),
            plot.title = element_text(hjust = 0.5, size = 25, face = "bold")) + 
      ggtitle("Model-based")


# Model-based Joint----
d <- data.frame(x = -log10(regem$P_Value_Joint), y = -log10(gem$P_Value_Joint))

h <- ggplot(d, aes(x = x, y = y)) +
      geom_hline(yintercept = 0, linetype = "dashed") +
      geom_vline(xintercept = 0, linetype = "dashed") +
      geom_abline(linewidth = 1, color = "darkred", linetype = "longdash", alpha = 0.5) +
      geom_scattermore(aes(x = x, y = y), color = "black", alpha = 1, pointsize = 6) +
      scale_y_continuous(breaks = c(0, 50, 100, 150, 200, 250), limits = c(0, 250)) +
      scale_x_continuous(breaks = c(0, 50, 100, 150, 200, 250), limits = c(0, 250)) +
      labs(x = x_title, y = y_title) +
      labs(x = x_title, y = y_title) +
      theme(panel.background = element_blank(),
            panel.grid = element_line(linewidth = 1, color = "grey95"),
            panel.border = element_rect(colour = "black", fill=NA, size = 1.7),
            axis.line = element_blank(),
            axis.ticks = element_blank(),
            axis.text  = element_text(size = 15, face = "bold"),
            axis.title = element_text(size = 20),
            plot.title = element_text(hjust = 0.5, size = 25, face = "bold")) + 
      ggtitle('Model-based')




# Robust Main Effect SE----
d <- data.frame(x = regem$robust_SE_Beta_G, y = gem$robust_SE_Beta_G)

i <- ggplot(d, aes(x = x, y = y)) +
      geom_hline(yintercept = 0, linetype = "dashed") +
      geom_vline(xintercept = 0, linetype = "dashed") +
      geom_abline(linewidth = 1, color = "darkred", linetype = "longdash", alpha = 0.5) +
      geom_scattermore(aes(x = x, y = y), color = "black", alpha = 1, pointsize = 6) +
      labs(x = x_title, y = y_title) +
      theme(panel.background = element_blank(),
            panel.grid = element_line(linewidth = 1, color = "grey95"),
            panel.border = element_rect(colour = "black", fill=NA, size = 1.7),
            axis.line = element_blank(),
            axis.ticks = element_blank(),
            axis.text  = element_text(size = 15, face = "bold"),
            axis.title = element_text(size = 20),
            plot.title = element_text(hjust = 0.5, size = 25, face = "bold")) + 
      ggtitle("Robust")



# Robust GxSex effects SE----
d <- data.frame(x = regem$`robust_SE_Beta_G-sex`, y = gem$`robust_SE_Beta_G-sex`)

j <- ggplot(d, aes(x = x, y = y)) +
      geom_hline(yintercept = 0, linetype = "dashed") +
      geom_vline(xintercept = 0, linetype = "dashed") +
      geom_abline(linewidth = 1, color = "darkred", linetype = "longdash", alpha = 0.5) +
      geom_scattermore(aes(x = x, y = y), color = "black", alpha = 1, pointsize = 6) +
      labs(x = x_title, y = y_title) +
      theme(panel.background = element_blank(),
            panel.grid = element_line(linewidth = 1, color = "grey95"),
            panel.border = element_rect(colour = "black", fill=NA, size = 1.7),
            axis.line = element_blank(),
            axis.ticks = element_blank(),
            axis.text  = element_text(size = 15, face = "bold"),
            axis.title = element_text(size = 20),
            plot.title = element_text(hjust = 0.5, size = 25, face = "bold")) + 
      ggtitle("Robust")



# Robust Covariance----
d <- data.frame(x = regem$`robust_Cov_Beta_G_G-sex`, y = gem$`robust_Cov_Beta_G_G-sex`)

k <- ggplot(d, aes(x = x, y = y)) +
      geom_hline(yintercept = 0, linetype = "dashed") +
      geom_vline(xintercept = 0, linetype = "dashed") +
      geom_abline(linewidth = 1, color = "darkred", linetype = "longdash", alpha = 0.5) +
      geom_scattermore(aes(x = x, y = y), color = "black", alpha = 1, pointsize = 6) +
      labs(x = x_title, y = y_title) +
      theme(panel.background = element_blank(),
            panel.grid = element_line(linewidth = 1, color = "grey95"),
            panel.border = element_rect(colour = "black", fill=NA, size = 1.7),
            axis.line = element_blank(),
            axis.ticks = element_blank(),
            axis.text  = element_text(size = 15, face = "bold"),
            axis.title = element_text(size = 20),
            plot.title = element_text(hjust = 0.5, size = 25, face = "bold")) + 
      ggtitle("Robust")


# Robust Interaction----
d <- data.frame(x = -log10(regem$robust_P_Value_Interaction), y = -log10(gem$robust_P_Value_Interaction))

l <- ggplot(d, aes(x = x, y = y)) +
      geom_hline(yintercept = 0, linetype = "dashed") +
      geom_vline(xintercept = 0, linetype = "dashed") +
      geom_abline(linewidth = 1, color = "darkred", linetype = "longdash", alpha = 0.5) +
      geom_scattermore(aes(x = x, y = y), color = "black", alpha = 1, pointsize = 6) +
      scale_y_continuous(breaks = c(0, 10, 20, 30, 40, 50, 60), limits = c(0, 60)) +
      scale_x_continuous(breaks = c(0, 10, 20, 30, 40, 50, 60), limits = c(0, 60)) +
      labs(x = x_title, y = y_title) +
      theme(panel.background = element_blank(),
            panel.grid = element_line(linewidth = 1, color = "grey95"),
            panel.border = element_rect(colour = "black", fill=NA, size = 1.7),
            axis.line = element_blank(),
            axis.ticks = element_blank(),
            axis.text  = element_text(size = 15, face = "bold"),
            axis.title = element_text(size = 20),
            plot.title = element_text(hjust = 0.5, size = 25, face = "bold")) +  
      ggtitle("Robust")


# Robust Joint----
d <- data.frame(x = -log10(regem$robust_P_Value_Joint), y = -log10(gem$robust_P_Value_Joint))

m <- ggplot(d, aes(x = x, y = y)) +
      geom_hline(yintercept = 0, linetype = "dashed") +
      geom_vline(xintercept = 0, linetype = "dashed") +
      geom_abline(linewidth = 1, color = "darkred", linetype = "longdash", alpha = 0.5) +
      geom_scattermore(aes(x = x, y = y), color = "black", alpha = 1, pointsize = 6) +
      scale_y_continuous(breaks = c(0, 50, 100, 150, 200, 250), limits = c(0, 250)) +
      scale_x_continuous(breaks = c(0, 50, 100, 150, 200, 250), limits = c(0, 250)) +
      labs(x = x_title, y = y_title) +
      theme(panel.background = element_blank(),
            panel.grid = element_line(linewidth = 1, color = "grey95"),
            panel.border = element_rect(colour = "black", fill=NA, size = 1.7),
            axis.line = element_blank(),
            axis.ticks = element_blank(),
            axis.text  = element_text(size = 15, face = "bold"),
            axis.title = element_text(size = 20),
            plot.title = element_text(hjust = 0.5, size = 25, face = "bold")) + 
      ggtitle("Robust")





# Plot----
t1 <- ggdraw() + draw_label("Effect Estimates", fontface='bold', size = 25, hjust = 0.35)
p1 <- cowplot::plot_grid(plotlist = list(a, NULL, b), rel_heights = c(1, 0.1, 1), nrow = 3, ncol = 1, labels = c("A", ""), label_y = 1.17, label_size = 25)

t2 <- ggdraw() + draw_label("SE of Main Effects", fontface='bold', size = 25, hjust = 0.35)
p2 <- cowplot::plot_grid(plotlist = list(c, NULL, i), rel_heights = c(1, 0.1, 1), nrow = 3, ncol = 1, labels = c("B", ""), label_y = 1.17, label_size = 25)

t3 <- ggdraw() + draw_label("SE of G x Sex Effects", fontface='bold', size = 25, hjust = 0.35)
p3 <- cowplot::plot_grid(plotlist = list(e, NULL, j), rel_heights = c(1, 0.1, 1), nrow = 3, ncol = 1, labels = c("C", ""), label_y = 1.17, label_size = 25)

t4 <- ggdraw() + draw_label("Covariances", fontface='bold', size = 25, hjust = 0.26)
p4 <- cowplot::plot_grid(plotlist = list(f, NULL, k), rel_heights = c(1, 0.1, 1), nrow = 3, ncol = 1, labels = c("D", ""), label_y = 1.17, label_size = 25)

t5 <- ggdraw() + draw_label(c(expression(bold('Interaction Test -log'["10"]~'('*italic("P")*')'))), fontface='bold', size = 25, hjust = 0.40)
p5 <- cowplot::plot_grid(plotlist = list(g, NULL, l), rel_heights = c(1, 0.1, 1), nrow = 3, ncol = 1, labels = c("E", ""), label_y = 1.17, label_size = 25)

t6 <- ggdraw() + draw_label(c(expression(bold('Joint Test -log'["10"]~'('*italic("P")*')'))), fontface='bold', size = 25, hjust = 0.4)
p6 <- cowplot::plot_grid(plotlist = list(h, NULL, m), rel_heights = c(1, 0.1, 1), nrow = 3, ncol = 1, labels = c("F", ""), label_y = 1.17, label_size = 25)

s <- plot_grid(t1, NULL, t2, NULL, t3, NULL, t4,
               p1, NULL, p2, NULL, p3, NULL, p4,
               NULL, NULL, NULL, NULL, NULL, NULL, NULL,
               NULL, NULL, t5, NULL, t6, NULL, NULL,
               NULL, NULL, p5, NULL, p6, NULL, NULL,
               nrow = 5,
               ncol = 7, 
               rel_heights = c(0.1, 1, 0.1, 0.1, 1),
               rel_widths  = c(1, 0.1, 1, 0.1, 1, 0.1, 1)) # rel_heights values control title margins
cowplot::save_plot("test.jpg", s, base_height = 20, base_width = 20)
