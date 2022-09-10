library(data.table)

setwd("/Users/duytp/Desktop/metagem_and_regem_manuscript_code/METAGEM-simulations/")

# 1 - exposure
mb_metal_process <- fread("mb_metal_process_resource_usage.log", skip = 1)
mb_metal_system  <- fread("mb_metal_system_resource_usage.log", skip = 1)
rb_metal_process <- fread("rb_metal_process_resource_usage.log", skip = 1)
rb_metal_system  <- fread("rb_metal_system_resource_usage.log", skip = 1)

mb_metagem_process <- fread("mb_metagem_process_resource_usage.log", skip = 1)
mb_metagem_system  <- fread("mb_metagem_system_resource_usage.log", skip = 1)
rb_metagem_process <- fread("rb_metagem_process_resource_usage.log", skip = 1)
rb_metagem_system  <- fread("rb_metagem_system_resource_usage.log", skip = 1)


metal_mins   <- max(c(nrow(mb_metal_system), nrow(rb_metal_system))) / 60
metagem_mins <- max(c(nrow(mb_metagem_system), nrow(rb_metagem_system))) / 60
metal_memory   <- max(c(mb_metal_process$V12, rb_metal_process$V12)) / 1000000
metagem_memory <- max(c(mb_metagem_process$V12, rb_metagem_process$V12)) / 1000000


# 2 - exposures
mb_metagem_process <- fread("mb_metagem_2e_process_resource_usage.log", skip = 1)
mb_metagem_system  <- fread("mb_metagem_2e_system_resource_usage.log", skip = 1)
rb_metagem_process <- fread("rb_metagem_2e_process_resource_usage.log", skip = 1)
rb_metagem_system  <- fread("rb_metagem_2e_system_resource_usage.log", skip = 1)


metagem_2e_mins <- max(c(nrow(mb_metagem_system), nrow(rb_metagem_system))) / 60
metagem_2e_memory <- max(c(mb_metagem_process$V12, rb_metagem_process$V12)) / 1000000
