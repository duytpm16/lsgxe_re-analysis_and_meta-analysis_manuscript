library(data.table)
library(tidyverse)

withdraw_list <- fread("/proj/GEM/data/UKB/downloaded/withdraw42646_182.txt", data.table = FALSE)

data <- fread("/proj/GEM/data/UKB/downloaded/PanUKB/all_pops_non_eur_pruned_within_pop_pc_covs.tsv", data.table = FALSE)
data <- data %>% 
          select(id=s, ancestry=pop, related=related, 
                 sex=sex, age=age, age2=age2,
                 age_sex=age_sex, age2_sex = age2_sex,
                 one_of(paste0("PC", 1:10))) %>%
          mutate(ancestryAFR = as.integer(ancestry == "AFR"),
                 ancestryAMR = as.integer(ancestry == "AMR"),
                 ancestryCSA = as.integer(ancestry == "CSA"),
                 ancestryEAS = as.integer(ancestry == "EAS"),
                 ancestryEUR = as.integer(ancestry == "EUR"),
                 ancestryMID = as.integer(ancestry == "MID")) %>%
          filter(!is.na(ancestry)) %>%
          filter(related == FALSE) %>%
          filter(!(id %in% withdraw_list))


pheno <- fread("/proj/GEM/data/UKB/downloaded/ukb23673_subset_pheno_20211010.csv", data.table = F)
pheno <- pheno %>%
            filter(eid %in% data$id)
# pheno is empty here
  
  