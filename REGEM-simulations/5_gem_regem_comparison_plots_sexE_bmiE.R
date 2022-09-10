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

intnames = c("G", "G-sex", "G-BMI")
titlenames = c("Main", "G x Sex", "G x BMI")

plots <- vector(mode = "list", length = 21)

# Beta 
index = 1
for (j in 1:3) {
  
  d <- data.frame(x = regem[,paste0("Beta_", intnames[j])], y = gem[,paste0("Beta_", intnames[j])])
  d$title <- titlenames[j]
  d <- d %>% distinct(x, .keep_all = T)
  d <- d %>% distinct(y, .keep_all = T)
  if (intnames[j] == "G-BMI") {
    xmax = ymax = round_any(max(c(abs(d$x), abs(d$y))), 0.01, f = ceiling)
  } else if (intnames[j] == "G-sex") {
    xmax = ymax = round_any(max(c(abs(d$x), abs(d$y))), 0.1, f = ceiling)
  } else {
    xmax = ymax = round_any(max(c(abs(d$x), abs(d$y))), 0.2, f = ceiling)    
  }
  
  y_title <- c(expression(bold('GEM')))
  x_title <- c(expression(bold('REGEM')))
  
  
  p <- ggplot(d, aes(x = x, y = y)) +
    geom_hline(yintercept = 0, linetype = "dashed") +
    geom_vline(xintercept = 0, linetype = "dashed") +
    geom_abline(size = 1, color = "red", linetype = "longdash", alpha = 0.5) +
    geom_scattermore(aes(x = x, y = y), color = "black", alpha = 1, pointsize = 6) +
    labs(y = y_title, x = x_title) +
    scale_y_continuous(limits = c(-ymax, ymax), labels = function(x) ifelse(x == 0, "0", x)) +
    scale_x_continuous(limits = c(-xmax, xmax), labels = function(x) ifelse(x == 0, "0", x)) +
    theme(panel.background = element_blank(),
          panel.grid = element_line(size = 1, color = "grey95"),
          panel.border = element_rect(colour = "black", size = 1.8, fill=NA),
          axis.line = element_blank(),
          axis.ticks = element_blank(),
          plot.title = element_text(hjust = 0.5, size = 13, face = "bold"),
          strip.background =element_rect(fill="grey90"),
          strip.text = element_text(size = 12, face = "bold")) +
    facet_grid(. ~ title)
  
  if (intnames[j] == "G") {
    p <- p + ggtitle(expression(bold("Effect Estimates")))
  }
  
  plots[[index]] <- p
  index <- index + 7
}


# Model-based SE
index = 2
for (j in 1:3) {
  
  d <- data.frame(x = regem[,paste0("SE_Beta_", intnames[j])], y = gem[,paste0("SE_Beta_", intnames[j])])
  d <- d %>% distinct(x, .keep_all = T)
  d <- d %>% distinct(y, .keep_all = T)
  
  d$title <- titlenames[j]
  
  if (intnames[j] == "G-BMI") {
    xmax = round_any(max(d$x), 0.01, f = ceiling)
    ymax = round_any(max(d$y), 0.01, f = ceiling)
  } else if (intnames[j] == "G") {
    xmax = round_any(max(d$x), 0.05, f = ceiling)
    ymax = round_any(max(d$y), 0.05, f = ceiling)
  } else {
    xmax = round_any(max(d$x), 0.1, f = ceiling)
    ymax = round_any(max(d$y), 0.1, f = ceiling)
  }
  
  
  y_title <- c(expression(bold('GEM')))
  x_title <- c(expression(bold('REGEM')))
  
  
  p <- ggplot(d, aes(x = x, y = y)) +
    geom_hline(yintercept = 0, linetype = "dashed") +
    geom_vline(xintercept = 0, linetype = "dashed") +
    geom_abline(size = 1, color = "red", linetype = "longdash", alpha = 0.5) +
    geom_scattermore(aes(x = x, y = y), color = "black", alpha = 1, pointsize = 6) +
    labs(y = y_title, x = x_title) +
    scale_y_continuous(limits = c(0, ymax), labels = function(x) ifelse(x == 0, "0", x)) +
    scale_x_continuous(limits = c(0, xmax), labels = function(x) ifelse(x == 0, "0", x)) +
    theme(panel.background = element_blank(),
          panel.grid = element_line(size = 1, color = "grey95"),
          panel.border = element_rect(colour = "black", size = 1.8, fill=NA),
          axis.line = element_blank(),
          axis.ticks = element_blank(),
          plot.title = element_text(hjust = 0.5, size = 13, face = "bold"),
          strip.background =element_rect(fill="grey90"),
          strip.text = element_text(size = 12, face = "bold")
    ) +
    facet_grid(. ~ title)
  
  if (intnames[j] == "G") {
    p <- p + ggtitle(expression(bold("Model-based SE")))
  }
  plots[[index]] <- p
  index <- index + 7
}


# Model-based Covariances
combo <- c("G_G-sex", "G_G-BMI", "G-sex_G-BMI")
combotitle <- c("G - G x Sex", "G - G x BMI", "G x Sex - G x BMI")
index = 3
for (j in 1:3) {
  
  d <- data.frame(x = regem[,paste0("Cov_Beta_", combo[j]), ], y = gem[,paste0("Cov_Beta_", combo[j])])
  d <- d %>% distinct(x, .keep_all = T)
  d <- d %>% distinct(y, .keep_all = T)
  
  d$title <- combotitle[j]
  
  if (j == 1) {
    breaks = c(-1e-04,  0, 1e-04)
  } else if (j == 2) {
    breaks = c(-1.5e-05, 0, 1.5e-05)
  } else {
    breaks = c(-6e-05, 0, 3e-05)
  }
  
  
  y_title <- c(expression(bold('GEM')))
  x_title <- c(expression(bold('REGEM')))
  
  
  p <- ggplot(d, aes(x = x, y = y)) +
    geom_hline(yintercept = 0, linetype = "dashed") +
    geom_vline(xintercept = 0, linetype = "dashed") +
    geom_abline(size = 1, color = "red", linetype = "longdash", alpha = 0.5) +
    geom_scattermore(aes(x = x, y = y), color = "black", alpha = 1, pointsize = 6) +
    labs(y = y_title, x = x_title)+
    scale_y_continuous(breaks = breaks, labels = function(x) ifelse(x == 0, 0, format(x, scientific = TRUE))) +
    scale_x_continuous(breaks = breaks, labels = function(x) ifelse(x == 0, 0, format(x, scientific = TRUE))) +
    theme(panel.background = element_blank(),
          panel.grid = element_line(size = 1, color = "grey95"),
          panel.border = element_rect(colour = "black", size = 1.8, fill=NA),
          axis.line = element_blank(),
          axis.ticks = element_blank(),
          plot.title = element_text(hjust = 0.5, size = 13, face = "bold"),
          strip.background =element_rect(fill="grey90"),
          strip.text = element_text(size = 12, face = "bold")
    ) +
    facet_grid(. ~ title)
  
  if (j == 1) {
    p <- p + ggtitle(expression(bold("Model-based Covariance")))
  }
  plots[[index]] <- p
  index <- index + 7
}


index = 4
for (j in 1:3) {
  
  d <- data.frame(x = regem[,paste0("robust_SE_Beta_", intnames[j])], y = gem[,paste0("robust_SE_Beta_", intnames[j])])
  d <- d %>% distinct(x, .keep_all = T)
  d <- d %>% distinct(y, .keep_all = T)
  
  d$title <- titlenames[j]
  
  if (intnames[j] == "G-BMI") {
    xmax = round_any(max(d$x), 0.01, f = ceiling)
    ymax = round_any(max(d$y), 0.01, f = ceiling)
  } else if (intnames[j] == "G") {
    xmax = round_any(max(d$x), 0.05, f = ceiling)
    ymax = round_any(max(d$y), 0.05, f = ceiling)
  } else {
    xmax = round_any(max(d$x), 0.1, f = ceiling)
    ymax = round_any(max(d$y), 0.1, f = ceiling)
  }
  
  
  y_title <- c(expression(bold('GEM')))
  x_title <- c(expression(bold('REGEM')))
  
  
  p <- ggplot(d, aes(x = x, y = y)) +
    geom_hline(yintercept = 0, linetype = "dashed") +
    geom_vline(xintercept = 0, linetype = "dashed") +
    geom_abline(size = 1, color = "red", linetype = "longdash", alpha = 0.5) +
    geom_scattermore(aes(x = x, y = y), color = "black", alpha = 1, pointsize = 6) +
    labs(y = y_title, x = x_title) +
    scale_y_continuous(limits = c(0, ymax), labels = function(x) ifelse(x == 0, "0", x)) +
    scale_x_continuous(limits = c(0, xmax), labels = function(x) ifelse(x == 0, "0", x)) +
    theme(panel.background = element_blank(),
          panel.grid = element_line(size = 1, color = "grey95"),
          panel.border = element_rect(colour = "black", size = 1.8, fill=NA),
          axis.line = element_blank(),
          axis.ticks = element_blank(),
          plot.title = element_text(hjust = 0.5, size = 13, face = "bold"),
          strip.background =element_rect(fill="grey90"),
          strip.text = element_text(size = 12, face = "bold")
    ) +
    facet_grid(. ~ title)
  
  if (intnames[j] == "G") {
    p <- p + ggtitle(expression(bold("Robust SE")))
  }
  plots[[index]] <- p
  index <- index + 7
}


# Robust Covariances
combo <- c("G_G-sex", "G_G-BMI", "G-sex_G-BMI")
combotitle <- c("G - G x Sex", "G - G x BMI", "G x Sex - G x BMI")
index = 5
for (j in 1:3) {
  
  d <- data.frame(x = regem[,paste0("robust_Cov_Beta_", combo[j]), ], y = gem[,paste0("robust_Cov_Beta_", combo[j])])
  d <- d %>% distinct(x, .keep_all = T)
  d <- d %>% distinct(y, .keep_all = T)
  
  d$title <- combotitle[j]
  
  if (j == 1) {
    breaks = c(-3e-04, 0, 3e-04)
  } else if (j == 2) {
    breaks = c(-2.5e-05, 0, 5e-05)
  } else {
    breaks = c(-2e-04, -1e-04, 0, 4e-05)
  }
  
  
  y_title <- c(expression(bold('GEM')))
  x_title <- c(expression(bold('REGEM')))
  
  
  p <- ggplot(d, aes(x = x, y = y)) +
    geom_hline(yintercept = 0, linetype = "dashed") +
    geom_vline(xintercept = 0, linetype = "dashed") +
    geom_abline(size = 1, color = "red", linetype = "longdash", alpha = 0.5) +
    geom_scattermore(aes(x = x, y = y), color = "black", alpha = 1, pointsize = 6) +
    labs(y = y_title, x = x_title)+
    scale_y_continuous(breaks = breaks, labels = function(x) ifelse(x == 0, 0, format(x, scientific = TRUE))) +
    scale_x_continuous(breaks = breaks, labels = function(x) ifelse(x == 0, 0, format(x, scientific = TRUE))) +
    theme(panel.background = element_blank(),
          panel.grid = element_line(size = 1, color = "grey95"),
          panel.border = element_rect(colour = "black", size = 1.8, fill=NA),
          axis.line = element_blank(),
          axis.ticks = element_blank(),
          plot.title = element_text(hjust = 0.5, size = 13, face = "bold"),
          strip.background =element_rect(fill="grey90"),
          strip.text = element_text(size = 12, face = "bold")
    ) +
    facet_grid(. ~ title)
  
  if (j == 1) {
    p <- p + ggtitle(expression(bold("Robust Covariance")))
  }
  plots[[index]] <- p
  index <- index + 7
}


index = 6
for (j in c("Interaction", "Joint")) {
  
  d <- data.frame(x = -log10(regem[,paste0("P_Value_", j)]), y = -log10(gem[,paste0("P_Value_", j)]))
  
  d$title <- j
  d <- d %>% distinct(x, .keep_all = T)
  d <- d %>% distinct(y, .keep_all = T)
  
  if (j == "Interaction") {
    xmax = ymax = 80
  } else {
    xmax = round_any(max(d$x), 10, f = ceiling)
    ymax = round_any(max(d$y), 10, f = ceiling)
  }
  
  
  y_title <- c(expression(bold('GEM')))
  x_title <- c(expression(bold('REGEM')))
  
  p <- ggplot(d, aes(x = x, y = y)) +
    geom_hline(yintercept = 0, linetype = "dashed") +
    geom_vline(xintercept = 0, linetype = "dashed") +
    geom_abline(size = 1, color = "red", linetype = "longdash", alpha = 0.4) +
    geom_scattermore(aes(x = x, y = y), color = "black", alpha = 1, pointsize = 6) +
    labs(y = y_title, x = x_title) +
    scale_y_continuous(limits = c(0, ymax), labels = function(x) ifelse(x == 0, "0", x)) +
    scale_x_continuous(limits = c(0, xmax), labels = function(x) ifelse(x == 0, "0", x)) +
    theme(panel.background = element_blank(),
          panel.border = element_rect(colour = "black", size = 1.8, fill=NA),
          panel.grid = element_line(size = 1, color = "grey95"),
          axis.ticks = element_blank(),
          plot.title = element_text(hjust = 0.5, size = 13, face = "bold"),
          strip.background =element_rect(fill="grey90"),
          strip.text = element_text(size = 12, face = "bold")
    ) +
    facet_grid(. ~ title)
  
  if (j == "Interaction") {
    p <- p + ggtitle(c(expression(bold('Model-based -log'["10"]~'('*italic("P")*')'))))
  }
  
  
  plots[[index]] <- p
  index <- index + 7
}

index = 7
for (j in c("Interaction", "Joint")) {
  
  d <- data.frame(x = -log10(regem[,paste0("robust_P_Value_", j)]), y = -log10(gem[,paste0("robust_P_Value_", j)]))
  
  d$title <- j
  d <- d %>% distinct(x, .keep_all = T)
  d <- d %>% distinct(y, .keep_all = T)
  
  if (j == "Interaction") {
    xmax = ymax = 80
  } else {
    xmax = round_any(max(d$x), 10, f = ceiling)
    ymax = round_any(max(d$y), 10, f = ceiling)
  }
  
  
  y_title <- c(expression(bold('GEM')))
  x_title <- c(expression(bold('REGEM')))
  
  p <- ggplot(d, aes(x = x, y = y)) +
    geom_hline(yintercept = 0, linetype = "dashed") +
    geom_vline(xintercept = 0, linetype = "dashed") +
    geom_abline(size = 1, color = "red", linetype = "longdash", alpha = 0.4) +
    geom_scattermore(aes(x = x, y = y), color = "black", alpha = 1, pointsize = 6) +
    labs(y = y_title, x = x_title) +
    scale_y_continuous(limits = c(0, ymax), labels = function(x) ifelse(x == 0, "0", x)) +
    scale_x_continuous(limits = c(0, xmax), labels = function(x) ifelse(x == 0, "0", x)) +
    theme(panel.background = element_blank(),
          panel.border = element_rect(colour = "black", size = 1.8, fill=NA),
          panel.grid = element_line(size = 1, color = "grey90"),
          axis.ticks = element_blank(),
          plot.title = element_text(hjust = 0.5, size = 13, face = "bold"),
          strip.background =element_rect(fill="grey90"),
          strip.text = element_text(size = 12, face = "bold")
    ) +
    facet_grid(. ~ title)
  
  if (j == "Interaction") {
    p <- p + ggtitle(c(expression(bold('Robust -log'["10"]~'('*italic("P")*')'))))
  }
  
  
  plots[[index]] <- p
  index <- index + 7
}

cowplot::plot_grid(plotlist = plots, nrow = 3, ncol = 7, labels = c("A", "", "", "", "", "B", ""))
