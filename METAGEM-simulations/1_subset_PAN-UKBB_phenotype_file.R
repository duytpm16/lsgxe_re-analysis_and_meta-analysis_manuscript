set.seed(12345)

library(data.table)

data <- as.data.frame(fread("../../downloaded/ukb23673_UnrelatedWhiteBritish_pheno_with_w42646_20210809_excluded_20211010.csv"))


rows <- 1:nrow(data)

n_100k <- sample(rows, 100000, replace = FALSE)
rows   <- rows[-n_100k]
write.table(data[n_100k,], file = "ukb_100k_set1.csv", quote = F, row.names = F, sep = ",")

for (i in 1:2)
{
  n_50k <- sample(rows, 50000, replace = FALSE)
  rows  <- rows[!(rows %in% n_50k)]
  write.table(data[n_50k,], file = paste0("ukb_50k_set", i, ".csv"), quote = F, row.names = F, sep = ",")
}

for (i in 1:7)
{
  n_10k <- sample(rows, 10000, replace = FALSE)
  rows  <- rows[!(rows %in% n_10k)]
  write.table(data[n_10k,], file = paste0("ukb_10k_set", i, ".csv"), quote = F, row.names = F, sep = ",")
}


write.table(data[rows,], file = paste0("ukb_Xk_set", 1, ".csv"), quote = F, row.names = F, sep = ",")
