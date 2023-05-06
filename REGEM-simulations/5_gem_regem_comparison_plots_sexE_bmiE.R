library(scattermore)
library(data.table)
library(ggplot2)
library(cowplot)
library(dplyr)
library(plyr)

setwd("C:/Users/duytp/Desktop/metagem_and_regem_manuscript_code/REGEM-simulations/")
gem <- as.data.frame(fread("gem_sexE_bmiE_combined.out"))
gem <- gem[,!colnames(gem) %in% c("SNPID", "CHR", "POS", "Non_Effect_Allele", "Effect_Allele", "N_Samples", "AF")]
gem <- gem[,colnames(gem)[!grepl("N_|AF_|Beta_Marginal|SE_Beta_Marginal|robust_SE_Beta_Marginal", colnames(gem))]]
gc()
regem <- as.data.frame(fread("regem_sexE_bmiE_results"))
regem <- regem[,!colnames(regem) %in% c("SNPID", "CHR", "POS", "Non_Effect_Allele", "Effect_Allele", "N_Samples", "AF")]
regem <- regem[,colnames(regem)[!grepl("N_|AF_|Beta_Marginal|SE_Beta_Marginal|robust_SE_Beta_Marginal", colnames(regem))]]
gc()

intnames   <- c("G", "G-sex", "G-BMI")
titlenames <- c("Main", "G x Sex", "G x BMI")
combo      <- c("G_G-sex", "G_G-BMI", "G-sex_G-BMI")
combotitle <- c("Main - G x Sex", "Main - G x BMI", "G x Sex - G x BMI")
y_title <- c(expression(bold('GEM')))
x_title <- c(expression(bold('REGEM')))

plots <- vector(mode = "list", length = 21)

# Beta----
index = 1
for (j in 1:3) {
  d <- data.frame(x = regem[,paste0("Beta_", intnames[j])], y = gem[,paste0("Beta_", intnames[j])])
  
  p <- ggplot(d, aes(x = x, y = y)) +
        geom_hline(yintercept = 0, linetype = "dashed") +
        geom_vline(xintercept = 0, linetype = "dashed") +
        geom_abline(size = 1, color = "red", linetype = "longdash", alpha = 0.5) +
        geom_scattermore(aes(x = x, y = y), color = "black", alpha = 1, pointsize = 6) +
        labs(x = x_title, y = y_title) +
        theme(panel.background = element_blank(),
              panel.grid = element_line(linewidth = 1, color = "grey95"),
              panel.border = element_rect(colour = "black", fill=NA, size = 1.7),
              axis.line = element_blank(),
              axis.ticks = element_blank(),
              axis.text  = element_text(size = 25, face = "bold"),
              axis.title = element_text(size = 25),
              plot.title = element_text(hjust = 0.5, size = 30, face = "bold")) + 
        ggtitle(titlenames[j])
  
  if (j == 1) {
    p <- p +
          scale_y_continuous(breaks = c(-0.15, -0.10, -0.05, 0, 0.04)) +
          scale_x_continuous(breaks = c(-0.15, -0.10, -0.05, 0, 0.04))
  } else if (j == 2) {
    p <- p +
      scale_y_continuous(breaks = c(-0.09, -0.05, 0, 0.03, 0.07)) +
      scale_x_continuous(breaks = c(-0.09, -0.05, 0, 0.03, 0.07))
  } else if (j == 3) {
    p <- p +
      scale_y_continuous(breaks = c(-0.01, 0, 0.01)) +
      scale_x_continuous(breaks = c(-0.01, 0, 0.01))
  }
  
  plots[[index]] <- p
  index <- index + 7
}


# Model-based SE----
index = 2
for (j in 1:3) {
  
  d <- data.frame(x = regem[,paste0("SE_Beta_", intnames[j])], y = gem[,paste0("SE_Beta_", intnames[j])])

  p <- ggplot(d, aes(x = x, y = y)) +
        geom_hline(yintercept = 0, linetype = "dashed") +
        geom_vline(xintercept = 0, linetype = "dashed") +
        geom_abline(size = 1, color = "red", linetype = "longdash", alpha = 0.5) +
        geom_scattermore(aes(x = x, y = y), color = "black", alpha = 1, pointsize = 6) +
        labs(x = x_title, y = y_title) +
        theme(panel.background = element_blank(),
              panel.grid = element_line(linewidth = 1, color = "grey95"),
              panel.border = element_rect(colour = "black", fill=NA, size = 1.7),
              axis.line = element_blank(),
              axis.ticks = element_blank(),
              axis.text  = element_text(size = 25, face = "bold"),
              axis.title = element_text(size = 25),
              plot.title = element_text(hjust = 0.5, size = 30, face = "bold")) + 
        ggtitle(titlenames[j])
  
  if (j == 1) {
    p <- p +
          scale_y_continuous(breaks = c(0, 0.01, 0.02, 0.03), limits = c(0, 0.03)) +
          scale_x_continuous(breaks = c(0, 0.01, 0.02, 0.03), limits = c(0, 0.03))
  } else if (j == 2) {
    p <- p +
      scale_y_continuous(breaks = c(0, 0.02, 0.04, 0.06), limits = c(0, 0.06)) +
      scale_x_continuous(breaks = c(0, 0.02, 0.04, 0.06), limits = c(0, 0.06))
  } else if (j == 3) {
    p <- p +
      scale_y_continuous(breaks = c(0, 0.002, 0.004)) +
      scale_x_continuous(breaks = c(0, 0.002, 0.004))
  }
  
  plots[[index]] <- p
  index <- index + 7
}


# Model-based Covariances----
index = 3
for (j in 1:3) {
  
  d <- data.frame(x = regem[,paste0("Cov_Beta_", combo[j]), ], y = gem[,paste0("Cov_Beta_", combo[j])])

  p <- ggplot(d, aes(x = x, y = y)) +
        geom_hline(yintercept = 0, linetype = "dashed") +
        geom_vline(xintercept = 0, linetype = "dashed") +
        geom_abline(size = 1, color = "red", linetype = "longdash", alpha = 0.5) +
        geom_scattermore(aes(x = x, y = y), color = "black", alpha = 1, pointsize = 6) +
        labs(x = x_title, y = y_title) +
        theme(panel.background = element_blank(),
              panel.grid = element_line(linewidth = 1, color = "grey95"),
              panel.border = element_rect(colour = "black", fill=NA, size = 1.7),
              axis.line = element_blank(),
              axis.ticks = element_blank(),
              axis.text  = element_text(size = 25, face = "bold"),
              axis.title = element_text(size = 25),
              plot.title = element_text(hjust = 0.5, size = 30, face = "bold")) + 
        ggtitle(combotitle[j])
  
  if (j == 1) {
    p <- p +
          scale_y_continuous(breaks = c(-1.0e-04, 0, 1.0e-04), labels = function(x) format(x, scientific = TRUE)) + 
          scale_x_continuous(breaks = c(-1.0e-04, 0, 1.0e-04), labels = function(x) format(x, scientific = TRUE))
  } else if (j == 2) {
    p <- p +
      scale_y_continuous(breaks = c(-1.0e-05, 0, 1.0e-05), labels = function(x) format(x, scientific = TRUE)) + 
      scale_x_continuous(breaks = c(-1.0e-05, 0, 1.0e-05), labels = function(x) format(x, scientific = TRUE))    
  } else if (j == 3) {
    p <- p +
      scale_y_continuous(breaks = c(-8.0e-05, -4.0e-05, 0), labels = function(x) format(x, scientific = TRUE)) + 
      scale_x_continuous(breaks = c(-8.0e-05, -4.0e-05, 0), labels = function(x) format(x, scientific = TRUE))
  }
  
  plots[[index]] <- p
  index <- index + 7
}


# Robust SE----
index = 4
for (j in 1:3) {
  
  d <- data.frame(x = regem[,paste0("robust_SE_Beta_", intnames[j])], y = gem[,paste0("robust_SE_Beta_", intnames[j])])

  p <- ggplot(d, aes(x = x, y = y)) +
        geom_hline(yintercept = 0, linetype = "dashed") +
        geom_vline(xintercept = 0, linetype = "dashed") +
        geom_abline(size = 1, color = "red", linetype = "longdash", alpha = 0.5) +
        geom_scattermore(aes(x = x, y = y), color = "black", alpha = 1, pointsize = 6) +
        labs(x = x_title, y = y_title) +
        theme(panel.background = element_blank(),
              panel.grid = element_line(linewidth = 1, color = "grey95"),
              panel.border = element_rect(colour = "black", fill=NA, size = 1.7),
              axis.line = element_blank(),
              axis.ticks = element_blank(),
              axis.text  = element_text(size = 25, face = "bold"),
              axis.title = element_text(size = 25),
              plot.title = element_text(hjust = 0.5, size = 30, face = "bold")) + 
        ggtitle(titlenames[j])
  
  if (j == 1) {
    p <- p +
      scale_y_continuous(breaks = c(0, 0.01, 0.02, 0.03), limits = c(0, 0.03)) +
      scale_x_continuous(breaks = c(0, 0.01, 0.02, 0.03), limits = c(0, 0.03))
  } else if (j == 2) {
    p <- p +
      scale_y_continuous(breaks = c(0, 0.02, 0.04, 0.06), limits = c(0, 0.06)) +
      scale_x_continuous(breaks = c(0, 0.02, 0.04, 0.06), limits = c(0, 0.06))
  }
  
  plots[[index]] <- p
  index <- index + 7
}


# Robust Covariances----
index = 5
for (j in 1:3) {
  
  d <- data.frame(x = regem[,paste0("robust_Cov_Beta_", combo[j]), ], y = gem[,paste0("robust_Cov_Beta_", combo[j])])

  p <- ggplot(d, aes(x = x, y = y)) +
        geom_hline(yintercept = 0, linetype = "dashed") +
        geom_vline(xintercept = 0, linetype = "dashed") +
        geom_abline(size = 1, color = "red", linetype = "longdash", alpha = 0.5) +
        geom_scattermore(aes(x = x, y = y), color = "black", alpha = 1, pointsize = 6) +
        labs(x = x_title, y = y_title) +
        theme(panel.background = element_blank(),
              panel.grid = element_line(linewidth = 1, color = "grey95"),
              panel.border = element_rect(colour = "black", fill=NA, size = 1.7),
              axis.line = element_blank(),
              axis.ticks = element_blank(),
              axis.text  = element_text(size = 25, face = "bold"),
              axis.title = element_text(size = 25),
              plot.title = element_text(hjust = 0.5, size = 30, face = "bold")) + 
        ggtitle(combotitle[j])
  
  
  if (j == 1) {
    p <- p +
      scale_y_continuous(breaks = c(-2.0e-04, 0, 2.0e-04), labels = function(x) format(x, scientific = TRUE)) + 
      scale_x_continuous(breaks = c(-2.0e-04, 0, 2.0e-04), labels = function(x) format(x, scientific = TRUE))
  }
  plots[[index]] <- p
  index <- index + 7
}


# Model-based P-values----
index = 6
for (j in c("Interaction", "Joint")) {
  
  d <- data.frame(x = -log10(regem[,paste0("P_Value_", j)]), y = -log10(gem[,paste0("P_Value_", j)]))

  p <- ggplot(d, aes(x = x, y = y)) +
        geom_hline(yintercept = 0, linetype = "dashed") +
        geom_vline(xintercept = 0, linetype = "dashed") +
        geom_abline(size = 1, color = "red", linetype = "longdash", alpha = 0.4) +
        geom_scattermore(aes(x = x, y = y), color = "black", alpha = 1, pointsize = 6) +
        labs(x = x_title, y = y_title) +
        theme(panel.background = element_blank(),
              panel.grid = element_line(linewidth = 1, color = "grey95"),
              panel.border = element_rect(colour = "black", fill=NA, size = 1.7),
              axis.line = element_blank(),
              axis.ticks = element_blank(),
              axis.text  = element_text(size = 25, face = "bold"),
              axis.title = element_text(size = 25),
              plot.title = element_text(hjust = 0.5, size = 30, face = "bold")) + 
        ggtitle(paste0(j, " Test"))
  
  if (j == "Interaction") {
    p <- p +
          scale_y_continuous(breaks = c(0, 10, 20, 30, 40, 50, 60), limits = c(0, 60)) +
          scale_x_continuous(breaks = c(0, 10, 20, 30, 40, 50, 60), limits = c(0, 60))
  } else if (j == "Joint") {
    p <- p +
          scale_y_continuous(breaks = c(0, 50, 100, 150, 200, 250), limits = c(0, 250)) +
          scale_x_continuous(breaks = c(0, 50, 100, 150, 200, 250), limits = c(0, 250))
  }
  
  plots[[index]] <- p
  index <- index + 7
}


# Robust P-values----
index = 7
for (j in c("Interaction", "Joint")) {
  
  d <- data.frame(x = -log10(regem[,paste0("robust_P_Value_", j)]), y = -log10(gem[,paste0("robust_P_Value_", j)]))
  
  p <- ggplot(d, aes(x = x, y = y)) +
        geom_hline(yintercept = 0, linetype = "dashed") +
        geom_vline(xintercept = 0, linetype = "dashed") +
        geom_abline(size = 1, color = "red", linetype = "longdash", alpha = 0.4) +
        geom_scattermore(aes(x = x, y = y), color = "black", alpha = 1, pointsize = 6) +
        labs(x = x_title, y = y_title) +
        theme(panel.background = element_blank(),
              panel.grid = element_line(linewidth = 1, color = "grey95"),
              panel.border = element_rect(colour = "black", fill=NA, size = 1.7),
              axis.line = element_blank(),
              axis.ticks = element_blank(),
              axis.text  = element_text(size = 25, face = "bold"),
              axis.title = element_text(size = 25),
              plot.title = element_text(hjust = 0.5, size = 25, face = "bold")) + 
        ggtitle(paste0(j, " Test"))
  
  if (j == "Interaction") {
    p <- p +
      scale_y_continuous(breaks = c(0, 10, 20, 30, 40, 50, 60), limits = c(0, 60)) +
      scale_x_continuous(breaks = c(0, 10, 20, 30, 40, 50, 60), limits = c(0, 60))
  } else if (j == "Joint") {
    p <- p +
      scale_y_continuous(breaks = c(0, 50, 100, 150, 200, 250), limits = c(0, 250)) +
      scale_x_continuous(breaks = c(0, 50, 100, 150, 200, 250), limits = c(0, 250))
  }
  
  plots[[index]] <- p
  index <- index + 7
}


# Plot----
t1 <- ggdraw() + draw_label("Effect Estimates", fontface='bold', size = 30, hjust = 0.35)
p1 <- cowplot::plot_grid(plotlist = list(plots[[1]], NULL, plots[[8]], NULL, plots[[15]]), rel_heights = c(1, 0.15, 1, 0.15, 1), nrow = 5, ncol = 1, labels = c("A"), label_y = 1.23, label_size = 30)

t2 <- ggdraw() + draw_label("Model-based SE", fontface='bold', size = 30, hjust = 0.35)
p2 <- cowplot::plot_grid(plotlist = list(plots[[2]], NULL, plots[[9]], NULL, plots[[16]]), rel_heights = c(1, 0.15, 1, 0.15, 1), nrow = 5, ncol = 1, labels = c("B"), label_y = 1.23, label_size = 30)

t3 <- ggdraw() + draw_label("Model-based Covariances", fontface='bold', size = 30, hjust = 0.35)
p3 <- cowplot::plot_grid(plotlist = list(plots[[3]], NULL, plots[[10]], NULL, plots[[17]]), rel_heights = c(1, 0.15, 1, 0.15, 1), nrow = 5, ncol = 1, labels = c("C"), label_y = 1.23, label_size = 30)

t4 <- ggdraw() + draw_label("Robust SE", fontface='bold', size = 30, hjust = 0.26)
p4 <- cowplot::plot_grid(plotlist = list(plots[[4]], NULL, plots[[11]], NULL, plots[[18]]), rel_heights = c(1, 0.15, 1, 0.15, 1), nrow = 5, ncol = 1, labels = c("D"), label_y = 1.23, label_size = 30)

t5 <- ggdraw() + draw_label("Robust Covariances", fontface='bold', size = 30, hjust = 0.35)
p5 <- cowplot::plot_grid(plotlist = list(plots[[5]], NULL, plots[[12]], NULL, plots[[19]]), rel_heights = c(1, 0.15, 1, 0.15, 1), nrow = 5, ncol = 1, labels = c("E"), label_y = 1.23, label_size = 30)

t6 <- ggdraw() + draw_label(c(expression(bold('Model-based -log'["10"]~'('*italic("P")*')'))), fontface='bold', size = 30, hjust = 0.40)
p6 <- cowplot::plot_grid(plotlist = list(plots[[6]], NULL, plots[[13]]), rel_heights = c(1, 0.1, 1), nrow = 5, ncol = 1, labels = c("F"), label_y = 1.23, label_size = 30)

t7 <- ggdraw() + draw_label(c(expression(bold('Robust -log'["10"]~'('*italic("P")*')'))), fontface='bold', size = 30, hjust = 0.40)
p7 <- cowplot::plot_grid(plotlist = list(plots[[7]], NULL, plots[[14]]), rel_heights = c(1, 0.1, 1), nrow = 5, ncol = 1, labels = c("G"), label_y = 1.23, label_size = 30)

s1 <- plot_grid(t1, NULL, t2, NULL, t3, NULL, t4, NULL, t5, NULL,
               p1, NULL, p2, NULL, p3, NULL, p4, NULL, p5, NULL,
               nrow = 2,
               ncol = 10, 
               rel_heights = c(0.1, 1),
               rel_widths  = c(1, 0.1, 1, 0.1, 1, 0.1, 1, 0.1, 1, 0.1)) # rel_heights values control title margins

s2 <- plot_grid(NULL, t6, NULL, t7, NULL,
                NULL, p6, NULL, p7, NULL,
                nrow = 2,
                ncol = 5, 
                rel_heights = c(0.1, 1),
                rel_widths  = c(0.23, 0.17, 0.05, 0.17, 0.23)) # rel_heights values control title margins

s3 <- plot_grid(s1, NULL, s2, ncol = 1, rel_heights = c(1, 0.05, 1))
cowplot::save_plot("test.jpg", s3, base_height = 33, base_width = 30)
