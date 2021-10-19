library(magrittr)

# Read files
vaccines <- data.table::fread("vaccines.csv", encoding = "UTF-8", colClasses = c("IBGE6" = "character"))
population <- data.table::fread("population.csv", encoding = "UTF-8", colClasses = c("IBGE" = "character"))

# The vaccination data uses IBGE6, while the population data uses IBGE7
# The last digit of IBGE7 is redundant -> drop it and create IBGE6
population <- dplyr::mutate(population, IBGE6 = substr(IBGE, 0, 6))

# Merge vaccinations with population on IBGE6
master <- dplyr::right_join(population, vaccines, by = "IBGE6")

# Drop IBGE6 and keep only IBGE(7)
master <- dplyr::select(master, -IBGE6)

# Write output files in the root folder
data.table::fwrite(master, file = "master.csv", row.names = FALSE)
