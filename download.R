library(magrittr)

# Read state code from argument (e.g. ES for Espirito Santo)
state <- commandArgs(trailingOnly = TRUE)
if(length(state) != 1)
  stop("Usage: Rscript download.R <state-code>")

# Web scrape the page to find the latest URL to the data file
url <- 
  rvest::read_html("https://opendatasus.saude.gov.br/dataset/covid-19-vacinacao/resource/ef3bd0b8-b605-474b-9ae5-c97390c197a8") %>%
  rvest::html_nodes(sprintf('a:contains("Dados %s")', state)) %>% 
  rvest::html_attr('href')

# Compute vaccination data
x <- 
  # download and read file
  data.table::fread(
    url, 
    select = c(
      "vacina_dataaplicacao" = "character", 
      "paciente_endereco_coibgemunicipio" = "character", 
      "vacina_descricao_dose" = "character"), 
    col.names = c("date", "ibge", "type"), 
    encoding = "UTF-8", 
    sep = ";",
    header = TRUE,
    tmpdir = getwd(),
    data.table = FALSE,
    verbose = TRUE) %>%
  # sanitize fields
  dplyr::mutate(
    date = as.Date(date),
    ibge = gsub("\\D", "", ibge),
    type = gsub("\\s|ª", "", type),
    type = gsub("1", "First", type),
    type = gsub("2", "Second", type),
    type = gsub("3", "Third", type)) %>%
  # filter out invalid dates and ibge
  dplyr::filter(!is.na(date) & grepl("^\\d{6}$", ibge)) %>%
  # compute number of doses for each date, municipality and type of dose
  dplyr::group_by(date, ibge, type) %>%
  dplyr::summarise(n = dplyr::n()) %>%
  # filter out dates before Dec 2020
  dplyr::filter(date > "2020-12-01") %>%
  # format date in YYYY-MM-DD
  dplyr::mutate(date = format(date, "%Y-%m-%d")) %>%
  # capitalize columns
  dplyr::rename(Date = date, IBGE6 = ibge, Type = type, N = n)

# Write output file in the download folder
data.table::fwrite(x, file = sprintf("download/%s.csv", state), row.names = FALSE)
