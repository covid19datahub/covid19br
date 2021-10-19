library(magrittr)
# require data.table and dplyr

output <- "out.csv"

url <- "https://s3-sa-east-1.amazonaws.com/ckan.saude.gov.br/PNI/vacina/uf/2021-10-18/uf%3DAC/part-00000-e92958d4-32d4-4903-b87e-b1cdc8d831f2.c000.csv"

names <- c("date", "ibge", "type")
select <- c("vacina_dataaplicacao", "paciente_endereco_coibgemunicipio", "vacina_descricao_dose")

x <- 
  # read data
  data.table::fread(url, encoding = "UTF-8", select = select, col.names = names) %>%
  # sanitize fields
  dplyr::mutate(
    date = as.Date(date),
    ibge = gsub("\\D", "", ibge),
    type = gsub("\\W", "", type)) %>%
  # filter out invalid dates and ibge
  dplyr::filter(!is.na(date) & grepl("^\\d{6}$", ibge)) %>%
  # compute number of doses for each date, municipality and type of dose
  dplyr::group_by(date, ibge, type) %>%
  dplyr::summarise(n = dplyr::n()) %>%
  # filter out dates before Dec 2020
  dplyr::filter(date > "2020-12-01") %>%
  # format date in YYYY-MM-DD
  dplyr::mutate(date = format(date, "%Y-%m-%d"))

# write output file
data.table::fwrite(x, file = output, row.names = FALSE)


