library(magrittr)
options(timeout = 0)

# Read state code from argument (e.g. ES for Espirito Santo)
state <- commandArgs(trailingOnly = TRUE)
if(length(state) != 1)
  stop("Usage: Rscript download.R <state-code>")

# Base urls containing the data files
baseurls <- c(
  "https://opendatasus.saude.gov.br/dataset/covid-19-vacinacao/resource/5093679f-12c3-4d6b-b7bd-07694de54173",
  "https://opendatasus.saude.gov.br/dataset/covid-19-vacinacao/resource/10aed154-04c8-4cf4-b78a-8f0fa1bc5af4"
)

# Web scrape the pages to find the latest URL to the data file
urls <- 
  unname(unlist(lapply(baseurls, function(baseurl){
    rvest::read_html(baseurl) %>%
      rvest::html_nodes(sprintf('a:contains("Dados %s")', state)) %>% 
      rvest::html_attr('href')  
  })))
  

# Compute vaccination data for each file
x <- lapply(urls, function(url){
  
  # download
  file <- tempfile(tmpdir = getwd())
  download.file(url, destfile = file, quiet = FALSE)
  
  # read file
  data.table::fread(
    cmd = sprintf("awk -F ';' '{print $28\";\"$8\";\"$29}' %s", file), 
    select = c(
      "vacina_dataAplicacao" = "character", 
      "paciente_endereco_coIbgeMunicipio" = "character", 
      "vacina_descricao_dose" = "character"), 
    col.names = c("date", "ibge", "type"), 
    encoding = "UTF-8", 
    sep = ";",
    tmpdir = getwd(),
    header = TRUE,
    data.table = FALSE,
    verbose = TRUE) %>%
  # sanitize fields
  dplyr::mutate(
    # convert to date
    date = as.Date(date),
    # keep digits only
    ibge = gsub("\\D", "", ibge),
    # strip white spaces and superscripts
    type = gsub("[\\p{Zs}ªº]", "", type, perl = TRUE),
    # replace numbers with names 
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
  
})

# Merge data
x <- data.table::rbindlist(x)

# Write output file in the download folder
data.table::fwrite(x, file = sprintf("download/%s.csv.gz", state), row.names = FALSE)
