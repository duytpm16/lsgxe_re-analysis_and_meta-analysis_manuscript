library(ggplot2)
library(scattermore)
library(data.table)
library(dplyr)

setwd("/Users/duytp/Desktop/metagem_and_regem_manuscript_code/METAGEM-simulations/")


# Read in model-based
metagem <- as.data.frame(fread("mb_metagem_results"))
metagem <- metagem %>% arrange(SNPID)
metagem <- metagem[!(duplicated(metagem$SNPID)|duplicated(metagem$SNPID, fromLast = TRUE)), ]
gc()

metal <- as.data.frame(fread("mb_METAANALYSIS1.TBL"))
metal <- metal %>% arrange(MarkerName)
metal <- metal[metal$MarkerName %in% metagem$SNPID, ]
metal <- metal[match(metagem$SNPID, metal$MarkerName),]
metal$`P-value` <- as.numeric(metal$`P-value`)
metal <- metal[!is.na(metal$`P-value`),]

metagem <- metagem[metagem$SNPID %in% metal$MarkerName,]
metagem <- metagem[match(metal$MarkerName, metagem$SNPID),]
metagem$Beta_G <- metagem$Beta_G * ifelse(sign(metagem$Beta_G) != sign(metal$Effect), -1, 1)
metagem$`Beta_G-sex` <- metagem$`Beta_G-sex` * ifelse(sign(metagem$`Beta_G-sex`) != sign(metal$IntEffect), -1, 1)

fwrite(metagem, "mb_metagem_results_ordered", sep = "\t", quote = F, row.names = F)
fwrite(metal, "mb_METAANALYSIS1_ordered.TBL", sep = "\t", quote = F, row.names = F)
gc()

rm(metal, metagem)
gc()


# Read in Robust
metagem <- as.data.frame(fread("rb_metagem_results"))
metagem <- metagem %>% arrange(SNPID)
metagem <- metagem[!(duplicated(metagem$SNPID)|duplicated(metagem$SNPID, fromLast = TRUE)), ]
gc()

metal <- as.data.frame(fread("rb_METAANALYSIS1.TBL"))
metal <- metal %>% arrange(MarkerName)
metal <- metal[metal$MarkerName %in% metagem$SNPID, ]
metal <- metal[match(metagem$SNPID, metal$MarkerName),]
metal$`P-value` <- as.numeric(metal$`P-value`)
metal <- metal[!is.na(metal$`P-value`),]

metagem <- metagem[metagem$SNPID %in% metal$MarkerName,]
metagem <- metagem[match(metal$MarkerName, metagem$SNPID),]
metagem$robust_Beta_G <- metagem$robust_Beta_G * ifelse(sign(metagem$robust_Beta_G) != sign(metal$Effect), -1, 1)
metagem$`robust_Beta_G-sex` <- metagem$`robust_Beta_G-sex` * ifelse(sign(metagem$`robust_Beta_G-sex`) != sign(metal$IntEffect), -1, 1)

fwrite(metagem, "rb_metagem_results_ordered", sep = "\t", quote = F, row.names = F)
fwrite(metal, "rb_METAANALYSIS1_ordered.TBL", sep = "\t", quote = F, row.names = F)
gc()

rm(metal, metagem)




# Read in model-based results ordered
metagem <- as.data.frame(fread("mb_metagem_results_ordered"))
metal <- as.data.frame(fread("mb_METAANALYSIS1_ordered.TBL"))
gc()



# Model-based main effects
d <- data.frame(x = metagem$Beta_G, y = metal$Effect)
d <- d %>% distinct(x, .keep_all = T)
d <- d %>% distinct(y, .keep_all = T)
d$title <- "Model-based"
  
y_title <- c(expression(bold('METAL')))
x_title <- c(expression(bold('METAGEM')))
breaks  <- c(-0.35, -0.20, -0.1, 0,  0.1, 0.20, 0.35)
limits  <- c(-0.35, 0.35)
  
a <- ggplot(d, aes(x = x, y = y)) +
      geom_hline(yintercept = 0, linetype = "dashed") +
      geom_vline(xintercept = 0, linetype = "dashed") +
      geom_abline(size = 1, color = "darkred", linetype = "longdash", alpha = 0.5) +
      geom_scattermore(aes(x = x, y = y), color = "black", alpha = 1, pointsize = 6) +
      labs(x = x_title, y = y_title) +
      scale_y_continuous(breaks = breaks, limits = limits, labels = function(x) ifelse(x == 0, "0", x)) +
      scale_x_continuous(breaks = breaks, limits = limits, labels = function(x) ifelse(x == 0, "0", x)) +
      theme(panel.background = element_blank(),
            panel.grid = element_line(size = 1, color = "grey95"),
            panel.border = element_rect(colour = "black", fill=NA, size = 1.7),
            axis.line = element_blank(),
            axis.ticks = element_blank(),
            plot.title = element_text(hjust = 0.5, size = 13, face = "bold"),
            strip.background =element_rect(fill="grey90"),
            strip.text = element_text(size = 12, face = "bold")) +
      facet_grid(. ~ title)
a <- a + ggtitle(expression(bold("Main Effects")))



# Model-based GxSex effects
d <- data.frame(x = metagem$`Beta_G-sex`, y = metal$IntEffect)
d <- d %>% distinct(x, .keep_all = T)
d <- d %>% distinct(y, .keep_all = T)
d$title <- "Model-based"

y_title <- c(expression(bold('METAL')))
x_title <- c(expression(bold('METAGEM')))
breaks  <- c(-1.0, -0.60, -0.20, 0,  0.20, 0.60)
limits  <- c(-1.0, 0.6)

b <- ggplot(d, aes(x = x, y = y)) +
      geom_hline(yintercept = 0, linetype = "dashed") +
      geom_vline(xintercept = 0, linetype = "dashed") +
      geom_abline(size = 1, color = "darkred", linetype = "longdash", alpha = 0.5) +
      geom_scattermore(aes(x = x, y = y), color = "black", alpha = 1, pointsize = 6) +
      labs(x = x_title, y = y_title) +
      scale_y_continuous(breaks = breaks, limits = limits, labels = function(x) ifelse(x == 0, "0", x)) +
      scale_x_continuous(breaks = breaks, limits = limits, labels = function(x) ifelse(x == 0, "0", x)) +
      theme(panel.background = element_blank(),
            panel.grid = element_line(size = 1, color = "grey95"),
            panel.border = element_rect(colour = "black", fill=NA, size = 1.7),
            axis.line = element_blank(),
            axis.ticks = element_blank(),
            plot.title = element_text(hjust = 0.5, size = 13, face = "bold"),
            strip.background =element_rect(fill="grey90"),
            strip.text = element_text(size = 12, face = "bold")) +
      facet_grid(. ~ title)

b <- b + ggtitle(expression(bold("GxSex Effects")))



# Model-based G std. error
d <- data.frame(x = metagem$SE_Beta_G, y = metal$StdErr)
d <- d %>% distinct(x, .keep_all = T)
d <- d %>% distinct(y, .keep_all = T)
d$title <- "Model-based"

y_title <- c(expression(bold('METAL')))
x_title <- c(expression(bold('METAGEM')))

max = ymax = 200
c <- ggplot(d, aes(x = x, y = y)) +
        geom_hline(yintercept = 0, linetype = "dashed") +
        geom_vline(xintercept = 0, linetype = "dashed") +
        geom_abline(size = 1, color = "darkred", linetype = "longdash", alpha = 0.5) +
        geom_scattermore(aes(x = x, y = y), color = "black", alpha = 1, pointsize = 6) +
        scale_y_continuous(limits = c(0, 0.4), labels = function(x) ifelse(x == 0, "0", x)) +
        scale_x_continuous(limits = c(0, 0.4), labels = function(x) ifelse(x == 0, "0", x)) +
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


# Model-based GxSex SE
d <- data.frame(x = metagem$`SE_Beta_G-sex`, y = metal$IntStdErr)
d <- d %>% distinct(x, .keep_all = T)
d <- d %>% distinct(y, .keep_all = T)
d$title <- "Model-based"

y_title <- c(expression(bold('METAL')))
x_title <- c(expression(bold('METAGEM')))

e <- ggplot(d, aes(x = x, y = y)) +
        geom_hline(yintercept = 0, linetype = "dashed") +
        geom_vline(xintercept = 0, linetype = "dashed") +
        geom_abline(size = 1, color = "darkred", linetype = "longdash", alpha = 0.5) +
        geom_scattermore(aes(x = x, y = y), color = "black", alpha = 1, pointsize = 6) +
  scale_y_continuous(breaks = seq(0, 0.9, 0.18), limits = c(0, 0.9), labels = function(x) ifelse(x == 0, "0", x)) +
  scale_x_continuous(breaks = seq(0, 0.9, 0.18), limits = c(0, 0.9), labels = function(x) ifelse(x == 0, "0", x)) +
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
e <- e + ggtitle(expression(bold("SE of GxSex Effects")))


# Covariance
d <- data.frame(x = metagem$`Cov_Beta_G_G-sex`, y = metal$IntCov)
d <- d %>% distinct(x, .keep_all = T)
d <- d %>% distinct(y, .keep_all = T)
d$title <- "Model-based"


y_title <- c(expression(bold('METAL')))
x_title <- c(expression(bold('METAGEM')))

f <- ggplot(d, aes(x = x, y = y)) +
      geom_hline(yintercept = 0, linetype = "dashed") +
      geom_vline(xintercept = 0, linetype = "dashed") +
      geom_abline(size = 1, color = "darkred", linetype = "longdash", alpha = 0.5) +
      geom_scattermore(aes(x = x, y = y), color = "black", alpha = 1, pointsize = 6) +
      scale_y_continuous(breaks = c(-0.1, 0,  0.1, 0.20, 0.35), limits = c(-0.1, 0.35), labels = function(x) ifelse(x == 0, "0", x)) +
      scale_x_continuous(breaks = c(-0.1, 0,  0.1, 0.20, 0.35), limits = c(-0.1, 0.35), labels = function(x) ifelse(x == 0, "0", x)) +
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
f <- f + ggtitle(expression(bold("Covariances")))




d <- data.frame(x = -log10(metagem$P_Value_Joint), y = -log10(metal$`P-value`))
d <- d %>% distinct(x, .keep_all = T)
d <- d %>% distinct(y, .keep_all = T)
d$title <- "Model-based"

xmax = ymax = 200
g <- ggplot(d, aes(x = x, y = y)) +
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

g <- g + ggtitle(c(expression(bold('Joint -log'["10"]~'('*italic("P")*')'))))




## Robust
rm(metagem, metal)
metagem <- as.data.frame(fread("rb_metagem_results_ordered"))
metal <- as.data.frame(fread("rb_METAANALYSIS1_ordered.TBL"))


# Robust main effects
d <- data.frame(x = metagem$robust_Beta_G, y = metal$Effect)
d <- d %>% distinct(x, .keep_all = T)
d <- d %>% distinct(y, .keep_all = T)
d$title <- "Robust"

y_title <- c(expression(bold('METAL')))
x_title <- c(expression(bold('METAGEM')))
breaks  <- c(-0.35, -0.20, -0.1, 0,  0.1, 0.20, 0.35)
limits  <- c(-0.35, 0.35)

h <- ggplot(d, aes(x = x, y = y)) +
  geom_hline(yintercept = 0, linetype = "dashed") +
  geom_vline(xintercept = 0, linetype = "dashed") +
  geom_abline(size = 1, color = "darkred", linetype = "longdash", alpha = 0.5) +
  geom_scattermore(aes(x = x, y = y), color = "black", alpha = 1, pointsize = 6) +
  labs(x = x_title, y = y_title) +
  scale_y_continuous(breaks = breaks, limits = limits, labels = function(x) ifelse(x == 0, "0", x)) +
  scale_x_continuous(breaks = breaks, limits = limits, labels = function(x) ifelse(x == 0, "0", x)) +
  theme(panel.background = element_blank(),
        panel.grid = element_line(size = 1, color = "grey95"),
        panel.border = element_rect(colour = "black", fill=NA, size = 1.7),
        axis.line = element_blank(),
        axis.ticks = element_blank(),
        plot.title = element_text(hjust = 0.5, size = 13, face = "bold"),
        strip.background =element_rect(fill="grey90"),
        strip.text = element_text(size = 12, face = "bold")) +
  facet_grid(. ~ title)



# Robust GxSex effects
d <- data.frame(x = metagem$`robust_Beta_G-sex`, y = metal$IntEffect)
d <- d %>% distinct(x, .keep_all = T)
d <- d %>% distinct(y, .keep_all = T)
d$title <- "Robust"

y_title <- c(expression(bold('METAL')))
x_title <- c(expression(bold('METAGEM')))
breaks  <- c(-1.0, -0.60, -0.20, 0,  0.20, 0.60)
limits  <- c(-1.0, 0.6)

i <- ggplot(d, aes(x = x, y = y)) +
  geom_hline(yintercept = 0, linetype = "dashed") +
  geom_vline(xintercept = 0, linetype = "dashed") +
  geom_abline(size = 1, color = "darkred", linetype = "longdash", alpha = 0.5) +
  geom_scattermore(aes(x = x, y = y), color = "black", alpha = 1, pointsize = 6) +
  labs(x = x_title, y = y_title) +
  scale_y_continuous(breaks = breaks, limits = limits, labels = function(x) ifelse(x == 0, "0", x)) +
  scale_x_continuous(breaks = breaks, limits = limits, labels = function(x) ifelse(x == 0, "0", x)) +
  theme(panel.background = element_blank(),
        panel.grid = element_line(size = 1, color = "grey95"),
        panel.border = element_rect(colour = "black", fill=NA, size = 1.7),
        axis.line = element_blank(),
        axis.ticks = element_blank(),
        plot.title = element_text(hjust = 0.5, size = 13, face = "bold"),
        strip.background =element_rect(fill="grey90"),
        strip.text = element_text(size = 12, face = "bold")) +
  facet_grid(. ~ title)



d <- data.frame(x = metagem$robust_SE_Beta_G, y = metal$StdErr)
d <- d %>% distinct(x, .keep_all = T)
d <- d %>% distinct(y, .keep_all = T)
d$title <- "Robust"

y_title <- c(expression(bold('METAL')))
x_title <- c(expression(bold('METAGEM')))

max = ymax = 200
j <- ggplot(d, aes(x = x, y = y)) +
        geom_hline(yintercept = 0, linetype = "dashed") +
        geom_vline(xintercept = 0, linetype = "dashed") +
        geom_abline(size = 1, color = "darkred", linetype = "longdash", alpha = 0.5) +
        geom_scattermore(aes(x = x, y = y), color = "black", alpha = 1, pointsize = 6) +
        scale_y_continuous(limits = c(0, 0.4), labels = function(x) ifelse(x == 0, "0", x)) +
        scale_x_continuous(limits = c(0, 0.4), labels = function(x) ifelse(x == 0, "0", x)) +
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


d <- data.frame(x = metagem$`robust_SE_Beta_G-sex`, y = metal$IntStdErr)
d <- d %>% distinct(x, .keep_all = T)
d <- d %>% distinct(y, .keep_all = T)
d$title <- "Robust"

y_title <- c(expression(bold('METAL')))
x_title <- c(expression(bold('METAGEM')))

k <- ggplot(d, aes(x = x, y = y)) +
      geom_hline(yintercept = 0, linetype = "dashed") +
      geom_vline(xintercept = 0, linetype = "dashed") +
      geom_abline(size = 1, color = "darkred", linetype = "longdash", alpha = 0.5) +
      geom_scattermore(aes(x = x, y = y), color = "black", alpha = 1, pointsize = 6) +
      scale_y_continuous(breaks = seq(0, 0.9, 0.18), limits = c(0, 0.9), labels = function(x) ifelse(x == 0, "0", x)) +
      scale_x_continuous(breaks = seq(0, 0.9, 0.18), limits = c(0, 0.9), labels = function(x) ifelse(x == 0, "0", x)) +
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


# Covariance
d <- data.frame(x = metagem$`robust_Cov_Beta_G_G-sex`, y = metal$IntCov)
d <- d %>% distinct(x, .keep_all = T)
d <- d %>% distinct(y, .keep_all = T)
d$title <- "Robust"


y_title <- c(expression(bold('METAL')))
x_title <- c(expression(bold('METAGEM')))

l <- ggplot(d, aes(x = x, y = y)) +
      geom_hline(yintercept = 0, linetype = "dashed") +
      geom_vline(xintercept = 0, linetype = "dashed") +
      geom_abline(size = 1, color = "darkred", linetype = "longdash", alpha = 0.5) +
      geom_scattermore(aes(x = x, y = y), color = "black", alpha = 1, pointsize = 6) +
      scale_y_continuous(breaks = c(-0.1, 0,  0.1, 0.20, 0.35), limits = c(-0.1, 0.35), labels = function(x) ifelse(x == 0, "0", x)) +
      scale_x_continuous(breaks = c(-0.1, 0,  0.1, 0.20, 0.35), limits = c(-0.1, 0.35), labels = function(x) ifelse(x == 0, "0", x)) +
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



d <- data.frame(x = -log10(metagem$robust_P_Value_Joint), y = -log10(metal$`P-value`))
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







cowplot::plot_grid(plotlist = list(a, b, c, e, f, g, h, i, j, k, l, m), nrow = 2, ncol = 6, labels = c("A", "B", "C", "D", "E", "F"), hjust = -3)

