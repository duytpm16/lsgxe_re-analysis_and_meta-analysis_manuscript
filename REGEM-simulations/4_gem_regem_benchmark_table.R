library(data.table)

setwd("/Users/duytp/Desktop/metagem_and_regem_manuscript_code/REGEM-simulations/")

sets <- c("sexE", "bmiE", "sexI_bmiE", "sexE_bmiE")

time   <- 0
memory <- 0
for (i in sets) {
  for (j in 1:22) {
    process <- fread(paste0("gem_", i, "_chr", j, "_process_resource_usage.out"), fill = T)
    time <- time + nrow(process) * 4
    memory <- max(memory, max(process$V12, na.rm = T))
  }
  time <- time / 60
  print(paste0(i, ": ", time, " - ", memory / 1000))
}
