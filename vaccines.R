library(magrittr)

# List the available data files produced with the script download.R
files <- list.files("download", full.names = TRUE)

# Compute cumulative number of doses
vaccines <- 
  # read files
  lapply(files, data.table::fread, encoding = "UTF-8", colClasses = c("IBGE6" = "character")) %>%
  # bind rows
  dplyr::bind_rows() %>%
  # group by date, municipality and type of dose
  dplyr::group_by(Date, IBGE6, Type) %>%
  dplyr::summarise(N = dplyr::n()) %>%
  # pivot wider to list all types of doses
  tidyr::pivot_wider(id_cols = c("Date", "IBGE6"), names_from = "Type", values_from = "N", values_fill = list(N = 0)) %>%
  # group by municipality and cumulate
  dplyr::group_by(IBGE6) %>%
  dplyr::arrange(Date) %>%
  dplyr::mutate(dplyr::across(-Date, cumsum)) %>%
  # drop observations before Dec 2020
  dplyr::filter(Date > "2020-12-01")

# Write output files in the root folder
data.table::fwrite(vaccines, file = "vaccines.csv", row.names = FALSE)
