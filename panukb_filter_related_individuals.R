library(data.table)
library(tidyverse)
setwd("/proj/GEM/data/UKB/work/METAGEM/benchmark_v2")

panukb <- fread("/proj/GEM/data/UKB/downloaded/PanUKB/all_pops_non_eur_pruned_within_pop_pc_covs.tsv", data.table = FALSE)
panukb <- panukb %>% 
              select(id       = s, 
                     ancestry = pop, 
                     related  = related, 
                     sex      = sex, 
                     age      = age, 
                     age2     = age2,
                     age_sex  = age_sex, 
                     age2_sex = age2_sex,
                     one_of(paste0("PC", 1:10))) %>%
              filter(!is.na(ancestry)) %>%
              filter(ancestry == "EUR") %>%
              filter(related == FALSE)

bridge <- fread("/proj/GEM/data/UKB/downloaded/ukb42646bridge31063.txt", data.table = FALSE)
bridge <- bridge %>%
            select(pheno_id  = V1,
                   panukb_id = V2) %>%
            filter(panukb_id %in% panukb$id)


pheno <- fread("/proj/GEM/data/UKB/downloaded/ukb672044.subset_pheno_20230406.csv", data.table = F)
pheno <- pheno %>%
           select(id   = eid,
                  WHR  = WHR,
                  BMI  = BMI,
                  age  = age,
                  age2 = age2,
                  sex  = sex) %>%
           filter(id %in% bridge$pheno_id)
stopifnot(all(pheno$id == bridge$pheno_id))

panukb <- panukb[match(bridge$panukb_id, panukb$id),]
stopifnot(all(panukb$id == bridge$panukb_id))
panukb <- panukb %>%
            mutate(pheno_id = bridge$pheno_id) %>%
            filter(pheno_id %in% pheno$id)

stopifnot(nrow(panukb) == nrow(pheno))
stopifnot(all(panukb$pheno_id == pheno$id))

pheno <- pheno %>%
            mutate(PC1 = panukb$PC1,
                   PC2 = panukb$PC2,
                   PC3 = panukb$PC3,
                   PC4 = panukb$PC4,
                   PC5 = panukb$PC5)

write.table(x = pheno, file = "ukb672044_eur_subset.csv", sep = ",", quote = F, row.names = F)

  
