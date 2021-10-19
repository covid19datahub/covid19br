library(magrittr)

files <- list.files("download", full.names = TRUE)

vaccines <- lapply(files, function(file){
  # read file
  data.table::fread(file, encoding = "UTF-8") %>%
  # pivot wider
  tidyr::pivot_wider(id_cols = c("date", "ibge"), names_from = "type", values_from = "n", values_fill = list(n = 0)) %>%
  # group by municipality and cumulate
  dplyr::group_by(ibge) %>%
  dplyr::arrange(date) %>%
  dplyr::mutate(dplyr::across(-date, cumsum)) %>%
  # drop observations before Dec 2020
  dplyr::filter(date > "2020-12-01")
})

vaccines <- dplyr::bind_rows(vaccines)




