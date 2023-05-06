library(ggplot2)
library(scattermore)
library(data.table)
library(dplyr)
library(cowplot)

setwd("/Users/duytp/Desktop/metagem_and_regem_manuscript_code/METAGEM-simulations/")


# Read in model-based
metagem <- as.data.frame(fread("mb_metagem_results"))
metagem <- metagem %>% arrange(SNPID)
metagem <- metagem[!(duplicated(metagem$SNPID)|duplicated(metagem$SNPID, fromLast = TRUE)), ]
gc()

metal <- as.data.frame(fread("mb_METAANALYSIS1.TBL"))
metal <- metal[metal$MarkerName %in% metagem$SNPID, ]
metal <- metal[match(metagem$SNPID, metal$MarkerName),]
metal$`P-value` <- as.numeric(metal$`P-value`)
metal <- metal[!is.na(metal$`P-value`),]

metagem <- metagem[metagem$SNPID %in% metal$MarkerName,]
metagem <- metagem[match(metal$MarkerName, metagem$SNPID),]
metagem$Beta_G <- metagem$Beta_G * ifelse(sign(metagem$Beta_G) != sign(metal$Effect), -1, 1)
metagem$`Beta_G-sex` <- metagem$`Beta_G-sex` * ifelse(sign(metagem$`Beta_G-sex`) != sign(metal$IntEffect), -1, 1)



y_title <- c(expression(bold('METAL')))
x_title <- c(expression(bold('METAGEM')))



# Read in model-based results ordered

# Model-based main effects----
d <- data.frame(x = metagem$Beta_G, y = metal$Effect)

a <- ggplot(d, aes(x = x, y = y)) +
      geom_hline(yintercept = 0, linetype = "dashed") +
      geom_vline(xintercept = 0, linetype = "dashed") +
      geom_abline(size = 1, color = "darkred", linetype = "longdash", alpha = 0.5) +
      geom_scattermore(aes(x = x, y = y), color = "black", alpha = 1, pointsize = 6) +
      labs(x = x_title, y = y_title) +
      theme(panel.background = element_blank(),
            panel.grid = element_line(linewidth = 1, color = "grey95"),
            panel.border = element_rect(colour = "black", fill=NA, size = 1.7),
            axis.line = element_blank(),
            axis.ticks = element_blank(),
            axis.text  = element_text(size = 20, face = "bold"),
            axis.title = element_text(size = 20),
            plot.title = element_text(hjust = 0.5, size = 25, face = "bold")) +
      ggtitle(expression(bold("Model-based")))



# Model-based GxSex effects----
d <- data.frame(x = metagem$`Beta_G-sex`, y = metal$IntEffect)

b <- ggplot(d, aes(x = x, y = y)) +
      geom_hline(yintercept = 0, linetype = "dashed") +
      geom_vline(xintercept = 0, linetype = "dashed") +
      geom_abline(size = 1, color = "darkred", linetype = "longdash", alpha = 0.5) +
      geom_scattermore(aes(x = x, y = y), color = "black", alpha = 1, pointsize = 6) +
      labs(x = x_title, y = y_title) +
      theme(panel.background = element_blank(),
            panel.grid = element_line(linewidth = 1, color = "grey95"),
            panel.border = element_rect(colour = "black", fill=NA, size = 1.7),
            axis.line = element_blank(),
            axis.ticks = element_blank(),
            axis.text  = element_text(size = 20, face = "bold"),
            axis.title = element_text(size = 20),
            plot.title = element_text(hjust = 0.5, size = 25, face = "bold")) +
      ggtitle(expression(bold("Model-based")))



# Model-based G std. error----
d <- data.frame(x = metagem$SE_Beta_G, y = metal$StdErr)

c <- ggplot(d, aes(x = x, y = y)) +
        geom_hline(yintercept = 0, linetype = "dashed") +
        geom_vline(xintercept = 0, linetype = "dashed") +
        geom_abline(size = 1, color = "darkred", linetype = "longdash", alpha = 0.5) +
        geom_scattermore(aes(x = x, y = y), color = "black", alpha = 1, pointsize = 6) +
        labs(x = x_title, y = y_title) +
        theme(panel.background = element_blank(),
              panel.grid = element_line(linewidth = 1, color = "grey95"),
              panel.border = element_rect(colour = "black", fill=NA, size = 1.7),
              axis.line = element_blank(),
              axis.ticks = element_blank(),
              axis.text  = element_text(size = 20, face = "bold"),
              axis.title = element_text(size = 20),
              plot.title = element_text(hjust = 0.5, size = 25, face = "bold")) +
        ggtitle(expression(bold("Model-based")))


# Model-based GxSex SE----
d <- data.frame(x = metagem$`SE_Beta_G-sex`, y = metal$IntStdErr)

e <- ggplot(d, aes(x = x, y = y)) +
        geom_hline(yintercept = 0, linetype = "dashed") +
        geom_vline(xintercept = 0, linetype = "dashed") +
        geom_abline(size = 1, color = "darkred", linetype = "longdash", alpha = 0.5) +
        geom_scattermore(aes(x = x, y = y), color = "black", alpha = 1, pointsize = 6) +
        labs(x = x_title, y = y_title) +
        theme(panel.background = element_blank(),
              panel.grid = element_line(linewidth = 1, color = "grey95"),
              panel.border = element_rect(colour = "black", fill=NA, size = 1.7),
              axis.line = element_blank(),
              axis.ticks = element_blank(),
              axis.text  = element_text(size = 20, face = "bold"),
              axis.title = element_text(size = 20),
              plot.title = element_text(hjust = 0.5, size = 25, face = "bold")) +
        ggtitle(expression(bold("Model-based")))


# Model-based Covariance----
d <- data.frame(x = metagem$`Cov_Beta_G_G-sex`, y = metal$IntCov)

f <- ggplot(d, aes(x = x, y = y)) +
      geom_hline(yintercept = 0, linetype = "dashed") +
      geom_vline(xintercept = 0, linetype = "dashed") +
      geom_abline(size = 1, color = "darkred", linetype = "longdash", alpha = 0.5) +
      geom_scattermore(aes(x = x, y = y), color = "black", alpha = 1, pointsize = 6) +
      labs(x = x_title, y = y_title) +
      theme(panel.background = element_blank(),
            panel.grid = element_line(linewidth = 1, color = "grey95"),
            panel.border = element_rect(colour = "black", fill=NA, size = 1.7),
            axis.line = element_blank(),
            axis.ticks = element_blank(),
            axis.text  = element_text(size = 20, face = "bold"),
            axis.title = element_text(size = 20),
            plot.title = element_text(hjust = 0.5, size = 25, face = "bold")) +
      ggtitle(expression(bold("Model-based")))



# Model-based joint p-value----
d <- data.frame(x = -log10(metagem$P_Value_Joint), y = -log10(metal$`P-value`))

g <- ggplot(d, aes(x = x, y = y)) +
        geom_hline(yintercept = 0, linetype = "dashed") +
        geom_vline(xintercept = 0, linetype = "dashed") +
        geom_abline(size = 1, color = "darkred", linetype = "longdash", alpha = 0.5) +
        geom_scattermore(aes(x = x, y = y), color = "black", alpha = 1, pointsize = 6) +
        labs(x = x_title, y = y_title) +
        theme(panel.background = element_blank(),
              panel.grid = element_line(linewidth = 1, color = "grey95"),
              panel.border = element_rect(colour = "black", fill=NA, size = 1.7),
              axis.line = element_blank(),
              axis.ticks = element_blank(),
              axis.text  = element_text(size = 20, face = "bold"),
              axis.title = element_text(size = 20),
              plot.title = element_text(hjust = 0.5, size = 25, face = "bold")) +
        ggtitle(expression(bold("Model-based")))




## Robust----
rm(metagem, metal)
gc()

# Read in Robust----
metagem <- as.data.frame(fread("rb_metagem_results"))
metagem <- metagem[!(duplicated(metagem$SNPID)|duplicated(metagem$SNPID, fromLast = TRUE)), ]
gc()

metal <- as.data.frame(fread("rb_METAANALYSIS1.TBL"))
metal <- metal[metal$MarkerName %in% metagem$SNPID, ]
metal <- metal[match(metagem$SNPID, metal$MarkerName),]
metal$`P-value` <- as.numeric(metal$`P-value`)
metal <- metal[!is.na(metal$`P-value`),]

metagem <- metagem[metagem$SNPID %in% metal$MarkerName,]
metagem <- metagem[match(metal$MarkerName, metagem$SNPID),]
metagem$robust_Beta_G <- metagem$robust_Beta_G * ifelse(sign(metagem$robust_Beta_G) != sign(metal$Effect), -1, 1)
metagem$`robust_Beta_G-sex` <- metagem$`robust_Beta_G-sex` * ifelse(sign(metagem$`robust_Beta_G-sex`) != sign(metal$IntEffect), -1, 1)



# Robust main effects----
d <- data.frame(x = metagem$robust_Beta_G, y = metal$Effect)

h <- ggplot(d, aes(x = x, y = y)) +
      geom_hline(yintercept = 0, linetype = "dashed") +
      geom_vline(xintercept = 0, linetype = "dashed") +
      geom_abline(size = 1, color = "darkred", linetype = "longdash", alpha = 0.5) +
      geom_scattermore(aes(x = x, y = y), color = "black", alpha = 1, pointsize = 6) +
      labs(x = x_title, y = y_title) +
      theme(panel.background = element_blank(),
            panel.grid = element_line(linewidth = 1, color = "grey95"),
            panel.border = element_rect(colour = "black", fill=NA, size = 1.7),
            axis.line = element_blank(),
            axis.ticks = element_blank(),
            axis.text  = element_text(size = 20, face = "bold"),
            axis.title = element_text(size = 20),
            plot.title = element_text(hjust = 0.5, size = 25, face = "bold")) +
      ggtitle(expression(bold("Robust")))




# Robust GxSex effects----
d <- data.frame(x = metagem$`robust_Beta_G-sex`, y = metal$IntEffect)

i <- ggplot(d, aes(x = x, y = y)) +
      geom_hline(yintercept = 0, linetype = "dashed") +
      geom_vline(xintercept = 0, linetype = "dashed") +
      geom_abline(size = 1, color = "darkred", linetype = "longdash", alpha = 0.5) +
      geom_scattermore(aes(x = x, y = y), color = "black", alpha = 1, pointsize = 6) +
      labs(x = x_title, y = y_title) +
      theme(panel.background = element_blank(),
            panel.grid = element_line(linewidth = 1, color = "grey95"),
            panel.border = element_rect(colour = "black", fill=NA, size = 1.7),
            axis.line = element_blank(),
            axis.ticks = element_blank(),
            axis.text  = element_text(size = 20, face = "bold"),
            axis.title = element_text(size = 20),
            plot.title = element_text(hjust = 0.5, size = 25, face = "bold")) +
      ggtitle(expression(bold("Robust")))



# Robust SE of main effects----
d <- data.frame(x = metagem$robust_SE_Beta_G, y = metal$StdErr)

j <- ggplot(d, aes(x = x, y = y)) +
        geom_hline(yintercept = 0, linetype = "dashed") +
        geom_vline(xintercept = 0, linetype = "dashed") +
        geom_abline(size = 1, color = "darkred", linetype = "longdash", alpha = 0.5) +
        geom_scattermore(aes(x = x, y = y), color = "black", alpha = 1, pointsize = 6) +
        labs(x = x_title, y = y_title) +
        theme(panel.background = element_blank(),
              panel.grid = element_line(linewidth = 1, color = "grey95"),
              panel.border = element_rect(colour = "black", fill=NA, size = 1.7),
              axis.line = element_blank(),
              axis.ticks = element_blank(),
              axis.text  = element_text(size = 20, face = "bold"),
              axis.title = element_text(size = 20),
              plot.title = element_text(hjust = 0.5, size = 25, face = "bold")) +
        ggtitle(expression(bold("Robust")))


# Robust SE of GxSex effects----
d <- data.frame(x = metagem$`robust_SE_Beta_G-sex`, y = metal$IntStdErr)

k <- ggplot(d, aes(x = x, y = y)) +
      geom_hline(yintercept = 0, linetype = "dashed") +
      geom_vline(xintercept = 0, linetype = "dashed") +
      geom_abline(size = 1, color = "darkred", linetype = "longdash", alpha = 0.5) +
      geom_scattermore(aes(x = x, y = y), color = "black", alpha = 1, pointsize = 6) +
      labs(x = x_title, y = y_title) +
      theme(panel.background = element_blank(),
            panel.grid = element_line(linewidth = 1, color = "grey95"),
            panel.border = element_rect(colour = "black", fill=NA, size = 1.7),
            axis.line = element_blank(),
            axis.ticks = element_blank(),
            axis.text  = element_text(size = 20, face = "bold"),
            axis.title = element_text(size = 20),
            plot.title = element_text(hjust = 0.5, size = 25, face = "bold")) +
      ggtitle(expression(bold("Robust")))


# Robust Covariances----
d <- data.frame(x = metagem$`robust_Cov_Beta_G_G-sex`, y = metal$IntCov)

l <- ggplot(d, aes(x = x, y = y)) +
      geom_hline(yintercept = 0, linetype = "dashed") +
      geom_vline(xintercept = 0, linetype = "dashed") +
      geom_abline(size = 1, color = "darkred", linetype = "longdash", alpha = 0.5) +
      geom_scattermore(aes(x = x, y = y), color = "black", alpha = 1, pointsize = 6) +
      labs(x = x_title, y = y_title) +
      theme(panel.background = element_blank(),
            panel.grid = element_line(linewidth = 1, color = "grey95"),
            panel.border = element_rect(colour = "black", fill=NA, size = 1.7),
            axis.line = element_blank(),
            axis.ticks = element_blank(),
            axis.text  = element_text(size = 20, face = "bold"),
            axis.title = element_text(size = 20),
            plot.title = element_text(hjust = 0.5, size = 25, face = "bold")) +
      ggtitle(expression(bold("Robust")))


# Robust joint p-value----
d <- data.frame(x = -log10(metagem$robust_P_Value_Joint), y = -log10(metal$`P-value`))

m <- ggplot(d, aes(x = x, y = y)) +
      geom_hline(yintercept = 0, linetype = "dashed") +
      geom_vline(xintercept = 0, linetype = "dashed") +
      geom_abline(size = 1, color = "darkred", linetype = "longdash", alpha = 0.5) +
      geom_scattermore(aes(x = x, y = y), color = "black", alpha = 1, pointsize = 6) +
      labs(x = x_title, y = y_title) +
      theme(panel.background = element_blank(),
            panel.grid = element_line(linewidth = 1, color = "grey95"),
            panel.border = element_rect(colour = "black", fill=NA, size = 1.7),
            axis.line = element_blank(),
            axis.ticks = element_blank(),
            axis.text  = element_text(size = 20, face = "bold"),
            axis.title = element_text(size = 20),
            plot.title = element_text(hjust = 0.5, size = 25, face = "bold")) +
      ggtitle(expression(bold("Robust")))

rm(metagem, metal)



# Plot----
t1 <- ggdraw() + draw_label("Main Effect Estimates", fontface='bold', size = 25, hjust = 0.35)
p1 <- cowplot::plot_grid(plotlist = list(a, NULL, h), rel_heights = c(1, 0.1, 1), nrow = 3, ncol = 1, labels = c("A", ""), label_y = 1.17, label_size = 25)

t2 <- ggdraw() + draw_label("G x Sex Effect Estimates", fontface='bold', size = 25, hjust = 0.35)
p2 <- cowplot::plot_grid(plotlist = list(b, NULL, i), rel_heights = c(1, 0.1, 1), nrow = 3, ncol = 1, labels = c("B", ""), label_y = 1.17, label_size = 25)

t3 <- ggdraw() + draw_label("SE of Main Effects", fontface='bold', size = 25, hjust = 0.35)
p3 <- cowplot::plot_grid(plotlist = list(c, NULL, j), rel_heights = c(1, 0.1, 1), nrow = 3, ncol = 1, labels = c("C", ""), label_y = 1.17, label_size = 25)

t4 <- ggdraw() + draw_label("SE of G x Sex Effects", fontface='bold', size = 25, hjust = 0.35)
p4 <- cowplot::plot_grid(plotlist = list(e, NULL, k), rel_heights = c(1, 0.1, 1), nrow = 3, ncol = 1, labels = c("D", ""), label_y = 1.17, label_size = 25)

t5 <- ggdraw() + draw_label("Covariances", fontface='bold', size = 25, hjust = 0.26)
p5 <- cowplot::plot_grid(plotlist = list(f, NULL, l), rel_heights = c(1, 0.1, 1), nrow = 3, ncol = 1, labels = c("E", ""), label_y = 1.17, label_size = 25)

t6 <- ggdraw() + draw_label(c(expression(bold('Joint Test -log'["10"]~'('*italic("P")*')'))), fontface='bold', size = 25, hjust = 0.4)
p6 <- cowplot::plot_grid(plotlist = list(g, NULL, m), rel_heights = c(1, 0.1, 1), nrow = 3, ncol = 1, labels = c("F", ""), label_y = 1.17, label_size = 25)

s <- plot_grid(t1, NULL, t2, NULL, t3,
               p1, NULL, p2, NULL, p3,
               NULL, NULL, NULL, NULL, NULL,
               t4, NULL, t5, NULL, t6,
               p4, NULL, p5, NULL, p6,
               nrow = 5,
               ncol = 5, 
               rel_heights = c(0.1, 1, 0.1, 0.1, 1),
               rel_widths  = c(1, 0.1, 1, 0.1, 1)) # rel_heights values control title margins
cowplot::save_plot("test.jpg", s, base_height = 25, base_width = 20)
