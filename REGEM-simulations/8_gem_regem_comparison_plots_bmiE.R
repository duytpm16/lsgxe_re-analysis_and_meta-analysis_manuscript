library(scattermore)
library(data.table)
library(ggplot2)
library(cowplot)
library(dplyr)
library(plyr)


setwd("C:/Users/duytp/Desktop/metagem_and_regem_manuscript_code/REGEM-simulations/")
gem <- as.data.frame(fread("gem_bmiE_combined.out"))
gem <- gem[,!colnames(gem) %in% c("SNPID", "CHR", "POS", "Non_Effect_Allele", "Effect_Allele", "N_Samples", "AF")]
gem <- gem[,colnames(gem)[!grepl("N_|AF_|Beta_Marginal|SE_Beta_Marginal|robust_SE_Beta_Marginal", colnames(gem))]]
gc()
regem <- as.data.frame(fread("regem_bmiE_results"))
regem <- regem[,!colnames(regem) %in% c("SNPID", "CHR", "POS", "Non_Effect_Allele", "Effect_Allele", "N_Samples", "AF")]
regem <- regem[,colnames(regem)[!grepl("N_|AF_|Beta_Marginal|SE_Beta_Marginal|robust_SE_Beta_Marginal", colnames(regem))]]
gc()

intnames   <- c("G", "G-BMI")
titlenames <- c("Main", "G x BMI")
y_title <- c(expression(bold('GEM')))
x_title <- c(expression(bold('REGEM')))

# Main effects
d <- data.frame(x = regem$Beta_G, y = gem$Beta_G)
d <- d %>% distinct(x, .keep_all = T)
d <- d %>% distinct(y, .keep_all = T)
d$title <- "Main Effects"

a <- ggplot(d, aes(x = x, y = y)) +
  geom_hline(yintercept = 0, linetype = "dashed") +
  geom_vline(xintercept = 0, linetype = "dashed") +
  geom_abline(size = 1, color = "darkred", linetype = "longdash", alpha = 0.5) +
  geom_scattermore(aes(x = x, y = y), color = "black", alpha = 1, pointsize = 6) +
  labs(x = x_title, y = y_title) +
  theme(panel.background = element_blank(),
        panel.grid = element_line(size = 1, color = "grey95"),
        panel.border = element_rect(colour = "black", fill=NA, size = 1.7),
        axis.line = element_blank(),
        axis.ticks = element_blank(),
        plot.title = element_text(hjust = 0.5, size = 13, face = "bold"),
        strip.background =element_rect(fill="grey90"),
        strip.text = element_text(size = 12, face = "bold")) +
  facet_grid(. ~ title)
a <- a + ggtitle(expression(bold("Effects")))



# GxBMI effects
d <- data.frame(x = regem$`Beta_G-BMI`, y = gem$`Beta_G-BMI`)
d <- d %>% distinct(x, .keep_all = T)
d <- d %>% distinct(y, .keep_all = T)
d$title <- "G x BMI Effects"

b <- ggplot(d, aes(x = x, y = y)) +
  geom_hline(yintercept = 0, linetype = "dashed") +
  geom_vline(xintercept = 0, linetype = "dashed") +
  geom_abline(size = 1, color = "darkred", linetype = "longdash", alpha = 0.5) +
  geom_scattermore(aes(x = x, y = y), color = "black", alpha = 1, pointsize = 6) +
  labs(x = x_title, y = y_title) +
  theme(panel.background = element_blank(),
        panel.grid = element_line(size = 1, color = "grey95"),
        panel.border = element_rect(colour = "black", fill=NA, size = 1.7),
        axis.line = element_blank(),
        axis.ticks = element_blank(),
        plot.title = element_text(hjust = 0.5, size = 13, face = "bold"),
        strip.background =element_rect(fill="grey90"),
        strip.text = element_text(size = 12, face = "bold")) +
  facet_grid(. ~ title)




# Model-based G std. error
d <- data.frame(x = regem$SE_Beta_G, y = gem$SE_Beta_G)
d <- d %>% distinct(x, .keep_all = T)
d <- d %>% distinct(y, .keep_all = T)
d$title <- "Model-based"

c <- ggplot(d, aes(x = x, y = y)) +
  geom_hline(yintercept = 0, linetype = "dashed") +
  geom_vline(xintercept = 0, linetype = "dashed") +
  geom_abline(size = 1, color = "darkred", linetype = "longdash", alpha = 0.5) +
  geom_scattermore(aes(x = x, y = y), color = "black", alpha = 1, pointsize = 6) +
  labs(x = x_title, y = y_title) +
  theme(panel.background = element_blank(),
        panel.grid = element_line(size = 1, color = "grey95"),
        panel.border = element_rect(colour = "black", fill=NA, size = 1.7),
        axis.line = element_blank(),
        axis.ticks = element_blank(),
        plot.title = element_text(hjust = 0.5, size = 13, face = "bold"),
        strip.background =element_rect(fill="grey90"),
        strip.text = element_text(size = 12, face = "bold"))  +
  facet_grid(. ~ title)

c <- c + ggtitle(expression(bold("SE of Main Effects")))


# Model-based GxBMI SE
d <- data.frame(x = regem$`SE_Beta_G-BMI`, y = gem$`SE_Beta_G-BMI`)
d <- d %>% distinct(x, .keep_all = T)
d <- d %>% distinct(y, .keep_all = T)
d$title <- "Model-based"


e <- ggplot(d, aes(x = x, y = y)) +
  geom_hline(yintercept = 0, linetype = "dashed") +
  geom_vline(xintercept = 0, linetype = "dashed") +
  geom_abline(size = 1, color = "darkred", linetype = "longdash", alpha = 0.5) +
  geom_scattermore(aes(x = x, y = y), color = "black", alpha = 1, pointsize = 6) +
  labs(x = x_title, y = y_title) +

  scale_y_continuous(breaks = c(0, 0.002, 0.004, 0.0055), labels = function(x) ifelse(x == 0, "0", x)) +
  scale_x_continuous(breaks = c(0, 0.002, 0.004, 0.0055), labels = function(x) ifelse(x == 0, "0", x)) +
  theme(panel.background = element_blank(),
        panel.grid = element_line(size = 1, color = "grey95"),
        panel.border = element_rect(colour = "black", fill=NA, size = 1.7),
        axis.line = element_blank(),
        axis.ticks = element_blank(),
        plot.title = element_text(hjust = 0.5, size = 13, face = "bold"),
        strip.background =element_rect(fill="grey90"),
        strip.text = element_text(size = 12, face = "bold"))  +
  facet_grid(. ~ title)
e <- e + ggtitle(expression(bold("SE of G x BMI Effects")))


# Model-based Covariance
d <- data.frame(x = regem$`Cov_Beta_G_G-BMI`, y = gem$`Cov_Beta_G_G-BMI`)
d <- d %>% distinct(x, .keep_all = T)
d <- d %>% distinct(y, .keep_all = T)
d$title <- "Model-based"


f <- ggplot(d, aes(x = x, y = y)) +
  geom_hline(yintercept = 0, linetype = "dashed") +
  geom_vline(xintercept = 0, linetype = "dashed") +
  geom_abline(size = 1, color = "darkred", linetype = "longdash", alpha = 0.5) +
  geom_scattermore(aes(x = x, y = y), color = "black", alpha = 1, pointsize = 6) +
  labs(x = x_title, y = y_title) +
  scale_y_continuous(breaks = c(-3e-05, -1.5e-05, 0, 1e-05, 2.5e-05), labels = function(x) ifelse(x == 0, "0", x)) +
  scale_x_continuous(breaks = c(-3e-05, -1.5e-05, 0, 1e-05, 2.5e-05), labels = function(x) ifelse(x == 0, "0", x)) +
  theme(panel.background = element_blank(),
        panel.grid = element_line(size = 1, color = "grey95"),
        panel.border = element_rect(colour = "black", fill=NA, size = 1.7),
        axis.line = element_blank(),
        axis.ticks = element_blank(),
        plot.title = element_text(hjust = 0.5, size = 13, face = "bold"),
        strip.background =element_rect(fill="grey90"),
        strip.text = element_text(size = 12, face = "bold"))  +
  facet_grid(. ~ title)
f <- f + ggtitle(expression(bold("Covariances")))


# Model-based Interaction
d <- data.frame(x = -log10(regem$P_Value_Interaction), y = -log10(gem$P_Value_Interaction))
d <- d %>% distinct(x, .keep_all = T)
d <- d %>% distinct(y, .keep_all = T)
d$title <- "Model-based"

g <- ggplot(d, aes(x = x, y = y)) +
  geom_hline(yintercept = 0, linetype = "dashed") +
  geom_vline(xintercept = 0, linetype = "dashed") +
  geom_abline(size = 1, color = "darkred", linetype = "longdash", alpha = 0.5) +
  geom_scattermore(aes(x = x, y = y), color = "black", alpha = 1, pointsize = 6) +
  labs(x = x_title, y = y_title) +
  theme(panel.background = element_blank(),
        panel.grid = element_line(size = 1, color = "grey95"),
        panel.border = element_rect(colour = "black", fill=NA, size = 1.7),
        axis.line = element_blank(),
        axis.ticks = element_blank(),
        plot.title = element_text(hjust = 0.5, size = 13, face = "bold"),
        strip.background =element_rect(fill="grey90"),
        strip.text = element_text(size = 12, face = "bold"))   +
  facet_grid(. ~ title)

g <- g + ggtitle(c(expression(bold('Interaction -log'["10"]~'('*italic("P")*')'))))


# Model-based Joint
d <- data.frame(x = -log10(regem$P_Value_Joint), y = -log10(gem$P_Value_Joint))
d <- d %>% distinct(x, .keep_all = T)
d <- d %>% distinct(y, .keep_all = T)
d$title <- "Model-based"

xmax = ymax = 200
h <- ggplot(d, aes(x = x, y = y)) +
  geom_hline(yintercept = 0, linetype = "dashed") +
  geom_vline(xintercept = 0, linetype = "dashed") +
  geom_abline(size = 1, color = "darkred", linetype = "longdash", alpha = 0.5) +
  geom_scattermore(aes(x = x, y = y), color = "black", alpha = 1, pointsize = 6) +
  scale_y_continuous(limits = c(0, ymax), labels = function(x) ifelse(x == 0, "0", x)) +
  scale_x_continuous(limits = c(0, xmax), labels = function(x) ifelse(x == 0, "0", x)) +
  labs(x = x_title, y = y_title) +
  theme(panel.background = element_blank(),
        panel.grid = element_line(size = 1, color = "grey95"),
        panel.border = element_rect(colour = "black", fill=NA, size = 1.7),
        axis.line = element_blank(),
        axis.ticks = element_blank(),
        plot.title = element_text(hjust = 0.5, size = 13, face = "bold"),
        strip.background =element_rect(fill="grey90"),
        strip.text = element_text(size = 12, face = "bold"))   +
  facet_grid(. ~ title)

h <- h + ggtitle(c(expression(bold('Joint -log'["10"]~'('*italic("P")*')'))))




# Robust G SE
d <- data.frame(x = regem$robust_SE_Beta_G, y = gem$robust_SE_Beta_G)
d <- d %>% distinct(x, .keep_all = T)
d <- d %>% distinct(y, .keep_all = T)
d$title <- "Robust"


i <- ggplot(d, aes(x = x, y = y)) +
  geom_hline(yintercept = 0, linetype = "dashed") +
  geom_vline(xintercept = 0, linetype = "dashed") +
  geom_abline(size = 1, color = "darkred", linetype = "longdash", alpha = 0.5) +
  geom_scattermore(aes(x = x, y = y), color = "black", alpha = 1, pointsize = 6) +
  labs(x = x_title, y = y_title) +
  scale_y_continuous(breaks = c(0, 0.01, 0.02, 0.29), labels = function(x) ifelse(x == 0, "0", x)) +
  scale_x_continuous(breaks = c(0, 0.01, 0.02, 0.29), labels = function(x) ifelse(x == 0, "0", x)) +
  theme(panel.background = element_blank(),
        panel.grid = element_line(size = 1, color = "grey95"),
        panel.border = element_rect(colour = "black", fill=NA, size = 1.7),
        axis.line = element_blank(),
        axis.ticks = element_blank(),
        plot.title = element_text(hjust = 0.5, size = 13, face = "bold"),
        strip.background =element_rect(fill="grey90"),
        strip.text = element_text(size = 12, face = "bold"))  +
  facet_grid(. ~ title)



# Robust GxBMI effects SE
d <- data.frame(x = regem$`robust_SE_Beta_G-BMI`, y = gem$`robust_SE_Beta_G-BMI`)
d <- d %>% distinct(x, .keep_all = T)
d <- d %>% distinct(y, .keep_all = T)
d$title <- "Robust"


j <- ggplot(d, aes(x = x, y = y)) +
  geom_hline(yintercept = 0, linetype = "dashed") +
  geom_vline(xintercept = 0, linetype = "dashed") +
  geom_abline(size = 1, color = "darkred", linetype = "longdash", alpha = 0.5) +
  geom_scattermore(aes(x = x, y = y), color = "black", alpha = 1, pointsize = 6) +
  labs(x = x_title, y = y_title) +
  theme(panel.background = element_blank(),
        panel.grid = element_line(size = 1, color = "grey95"),
        panel.border = element_rect(colour = "black", fill=NA, size = 1.7),
        axis.line = element_blank(),
        axis.ticks = element_blank(),
        plot.title = element_text(hjust = 0.5, size = 13, face = "bold"),
        strip.background =element_rect(fill="grey90"),
        strip.text = element_text(size = 12, face = "bold")) +
  facet_grid(. ~ title)



# Robust Covariance
d <- data.frame(x = regem$`robust_Cov_Beta_G_G-BMI`, y = gem$`robust_Cov_Beta_G_G-BMI`)
d <- d %>% distinct(x, .keep_all = T)
d <- d %>% distinct(y, .keep_all = T)
d$title <- "Robust"


k <- ggplot(d, aes(x = x, y = y)) +
  geom_hline(yintercept = 0, linetype = "dashed") +
  geom_vline(xintercept = 0, linetype = "dashed") +
  geom_abline(size = 1, color = "darkred", linetype = "longdash", alpha = 0.5) +
  geom_scattermore(aes(x = x, y = y), color = "black", alpha = 1, pointsize = 6) +
  labs(x = x_title, y = y_title) +
  scale_y_continuous(breaks = c(-3e-05, 0, 3.5e-05, 6e-05, 8.5e-05), labels = function(x) ifelse(x == 0, "0", x)) +
  scale_x_continuous(breaks = c(-3e-05, 0, 3.5e-05, 6e-05, 8.5e-05), labels = function(x) ifelse(x == 0, "0", x)) +
  theme(panel.background = element_blank(),
        panel.grid = element_line(size = 1, color = "grey95"),
        panel.border = element_rect(colour = "black", fill=NA, size = 1.7),
        axis.line = element_blank(),
        axis.ticks = element_blank(),
        plot.title = element_text(hjust = 0.5, size = 13, face = "bold"),
        strip.background =element_rect(fill="grey90"),
        strip.text = element_text(size = 12, face = "bold"))  +
  facet_grid(. ~ title)


# Robust Interaction
d <- data.frame(x = -log10(regem$robust_P_Value_Interaction), y = -log10(gem$robust_P_Value_Interaction))
d <- d %>% distinct(x, .keep_all = T)
d <- d %>% distinct(y, .keep_all = T)
d$title <- "Robust"

l <- ggplot(d, aes(x = x, y = y)) +
  geom_hline(yintercept = 0, linetype = "dashed") +
  geom_vline(xintercept = 0, linetype = "dashed") +
  geom_abline(size = 1, color = "darkred", linetype = "longdash", alpha = 0.5) +
  geom_scattermore(aes(x = x, y = y), color = "black", alpha = 1, pointsize = 6) +
  labs(x = x_title, y = y_title) +
  theme(panel.background = element_blank(),
        panel.grid = element_line(size = 1, color = "grey95"),
        panel.border = element_rect(colour = "black", fill=NA, size = 1.7),
        axis.line = element_blank(),
        axis.ticks = element_blank(),
        plot.title = element_text(hjust = 0.5, size = 13, face = "bold"),
        strip.background =element_rect(fill="grey90"),
        strip.text = element_text(size = 12, face = "bold"))   +
  facet_grid(. ~ title)


# Robust Joint
d <- data.frame(x = -log10(regem$robust_P_Value_Joint), y = -log10(gem$robust_P_Value_Joint))
d <- d %>% distinct(x, .keep_all = T)
d <- d %>% distinct(y, .keep_all = T)
d$title <- "Robust"

xmax = ymax = 200
m <- ggplot(d, aes(x = x, y = y)) +
  geom_hline(yintercept = 0, linetype = "dashed") +
  geom_vline(xintercept = 0, linetype = "dashed") +
  geom_abline(size = 1, color = "darkred", linetype = "longdash", alpha = 0.5) +
  geom_scattermore(aes(x = x, y = y), color = "black", alpha = 1, pointsize = 6) +
  scale_y_continuous(limits = c(0, ymax), labels = function(x) ifelse(x == 0, "0", x)) +
  scale_x_continuous(limits = c(0, xmax), labels = function(x) ifelse(x == 0, "0", x)) +
  labs(x = x_title, y = y_title) +
  theme(panel.background = element_blank(),
        panel.grid = element_line(size = 1, color = "grey95"),
        panel.border = element_rect(colour = "black", fill=NA, size = 1.7),
        axis.line = element_blank(),
        axis.ticks = element_blank(),
        plot.title = element_text(hjust = 0.5, size = 13, face = "bold"),
        strip.background =element_rect(fill="grey90"),
        strip.text = element_text(size = 12, face = "bold"))   +
  facet_grid(. ~ title)







cowplot::plot_grid(plotlist = list(a, c, e, f, g, h, b, i, j, k, l, m), nrow = 2, ncol = 6, labels = c("A", "B"))

