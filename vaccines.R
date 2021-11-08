library(magrittr)

# List the available data files produced with the script download.R
files <- list.files("download", full.names = TRUE)

# First dose of a 2-doses vaccination cycle
first <- c("FirstDose", "DoseInicial")

# Second dose of a 2-doses vaccination cycle
second <- c("SecondDose", "Tratamentocomduasdoses")

# Unique dose of a one-shot vaccination cycle
oneshot <- c("Única", "Dose", "Tratamentocomumadose")

# Other extra doses
extra <- c(
  "ThirdDose", "DoseAdicional", "FirstReforço", "Reforço",
  "FirstDoseRevacinação", "SecondDoseRevacinação",
  "ThirdReforço", "Revacinação", 
  "Tratamentocomdezessetedoses", "Tratamentocomseisdoses", "ThirdDoseRevacinação", 
  "Tratamentocomquatrodoses", "Tratamentocomtrêsdoses", 
  "Tratamentocomcincodoses", "4DoseRevacinação", "6Reforço", 
  "Tratamentocomsetedoses", "Tratamentocomdozedoses", "5Reforço", 
  "Tratamentocomquinzedoses", "Tratamentocomdezdoses", "4Reforço", 
  "Tratamentocomquartorzedoses", "Tratamentocomnovedoses", 
  "Tratamentocomtrezedoses") 

# Compute cumulative number of doses
vaccines <- 
  # read files
  lapply(files, data.table::fread, encoding = "UTF-8", colClasses = c("IBGE6" = "character")) %>%
  # bind rows
  dplyr::bind_rows() %>%
  # standardize extra doses
  dplyr::mutate(
    Type = replace(Type, Type %in% first, "FirstDose"),
    Type = replace(Type, Type %in% second, "SecondDose"),
    Type = replace(Type, Type %in% oneshot, "OneShot"),
    Type = replace(Type, Type %in% extra, "Extra")) %>%
  # group by date, municipality and type of dose
  dplyr::group_by(Date, IBGE6, Type) %>%
  dplyr::summarise(N = sum(N)) %>%
  # pivot wider to list all types of doses
  tidyr::pivot_wider(id_cols = c("Date", "IBGE6"), names_from = "Type", values_from = "N", values_fill = list(N = 0)) %>%
  # group by municipality and cumulate
  dplyr::group_by(IBGE6) %>%
  dplyr::arrange(Date) %>%
  dplyr::mutate(dplyr::across(-Date, cumsum)) %>%
  # drop observations before Dec 2020
  dplyr::filter(Date > "2020-12-01") %>%
  # compute total number of doses, people vaccinated, and people fully vaccinated
  dplyr::mutate(
    TotalVaccinations = FirstDose + SecondDose + OneShot + Extra,
    PeopleVaccinated = FirstDose + OneShot,
    PeopleFullyVaccinated = SecondDose + OneShot) %>%
  # drop known dose types
  dplyr::select(-dplyr::one_of(c("FirstDose", "SecondDose", "OneShot", "Extra")))

# check that no other dose types have appeared
expected <- c("Date", "IBGE6", "TotalVaccinations", "PeopleVaccinated", "PeopleFullyVaccinated")
if(length(unknown <- setdiff(colnames(vaccines), expected))){
  stop(sprintf("New dose types are available: %s. Check and fix.", paste0(unknown, collapse = ", ")))
}

# Extract latest counts for each municipality
latest <- vaccines %>%
  dplyr::group_by(IBGE6) %>%
  dplyr::arrange(Date) %>%
  dplyr::filter(dplyr::row_number()==dplyr::n()-1)
  
# Write output files in the root folder
data.table::fwrite(vaccines, file = "vaccines.csv.gz", row.names = FALSE)
data.table::fwrite(latest, file = "vaccines-latest.csv", row.names = FALSE)
