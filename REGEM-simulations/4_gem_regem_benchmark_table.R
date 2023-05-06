library(data.table)

setwd("/Users/duytp/Desktop/metagem_and_regem_manuscript_code/REGEM-simulations/")

sets <- c("sexE", "bmiE", "sexI_bmiE", "sexE_bmiE")

time   <- 0
memory <- 0
for (i in sets) {
  for (j in 1:22) {
    process <- fread(paste0("gem_", i, "_chr", j, "_process_resource_usage.out"), fill = T)
    system  <- fread(paste0("gem_", i, "_chr", j, "_system_resource_usage.out"), fill = T)
    time    <- time + (nrow(system) * 8)
    memory  <- max(memory, max(process$V12, na.rm = T))
  }
  time <- time / 60
  print(paste0("GEM - ", i, ": ", time, " - ", memory / 1000))
}



for (i in sets) {
  process <- fread(paste0("regem_", i, "_process_resource_usage.log"), fill = T)
  system  <- fread(paste0("regem_", i, "_system_resource_usage.log"), fill = T)
  time    <- nrow(system) / 60
  memory  <- max(process$V12, na.rm = T)
  
  print(paste0("REGEM - ", i, ": ", time, " - ", memory / 1000))
}
