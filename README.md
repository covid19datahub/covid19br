# COVID-19 Vaccinations for Brazilian Municipalities [![Twitter URL](https://img.shields.io/twitter/url?style=social&url=https%3A%2F%2Fgithub.com%2Feguidotti%2Fcovid19br)](https://twitter.com/intent/tweet?url=https%3A%2F%2Fgithub.com%2Feguidotti%2Fcovid19br)

This repository extracts the time-series of administrated COVID-19 vaccine doses for Brazilian municipalities from the 130GB dataset published on [this webpage](https://opendatasus.saude.gov.br/dataset/covid-19-vacinacao) by the Ministry of Health of Brazil, through the Information System of the National Immunization Program (SI-PNI).

The data extracted are available in the form of ready-to-use CSV files with the following structure: 

| field                   | description                                                  |
| ----------------------- | ------------------------------------------------------------ |
| `IBGE`                  | 7 digits IBGE code to identify Brazilian municipalities      |
| `Municipio`             | The name of the municipality                                 |
| `Population`            | The total population (2021)                                  |
| `Date`                  | Date in the format YYYY-MM-DD                                |
| `TotalVaccinations`     | Total number of COVID-19 vaccination doses administered      |
| `PeopleVaccinated`      | Total number of people who received at least one vaccine dose |
| `PeopleFullyVaccinated` | Total number of people who received all doses prescribed by the vaccination protocol |

## Data files

Main files intended for re-use:

- `data.csv.gz`: contains the time-series of the vaccination data, merged with population
  - https://raw.githubusercontent.com/eguidotti/covid19br/main/data.csv.gz
- `data-latest.csv`: contains only the latest counts in `data.csv.gz`
  - https://raw.githubusercontent.com/eguidotti/covid19br/main/data-latest.csv

Additional files:

- `vaccines.csv.gz`: contains the time-series of the vaccination data
	- https://raw.githubusercontent.com/eguidotti/covid19br/main/vaccines.csv.gz
- `vaccines-latest.csv` contains only the latest counts in `vaccines.csv.gz`
  - https://raw.githubusercontent.com/eguidotti/covid19br/main/vaccines-latest.csv
- `population.csv`: contains the estimated population for each municipality in 2021.
  - https://raw.githubusercontent.com/eguidotti/covid19br/main/population.csv 

## Update frequency

- The files are updated daily

## How it works

- The script `download.R` is run by several [workflows](https://github.com/eguidotti/covid19br/actions) to download the data for each state. The output is saved in the folder `download`

- The script `vaccines.R` reads the data files from the folder `download` and generates the files `vaccines.csv.gz` and `vaccines-latest.csv`
- The script `data.R` merges the files `vaccines.csv.gz` and `population.csv` to generate the files `data.csv.gz` and `data-latest.csv`

## Data sources

- The vaccination data are from the [Minist??rio da Sa??de](https://opendatasus.saude.gov.br/dataset/covid-19-vacinacao)
- The population data are from the [Instituto Brasileiro de Geografia e Estat??stica](https://www.ibge.gov.br/en/statistics/social/population/18448-estimates-of-resident-population-for-municipalities-and-federation-units.html)

## Data license

[![](https://opendatasus.saude.gov.br/base/images/od_80x15_blue.png)](http://opendefinition.org/okd/)

[Creative Commons Attribution](http://www.opendefinition.org/licenses/cc-by) 

## Workflows

[![DATA](https://github.com/eguidotti/covid19br/actions/workflows/_data.yaml/badge.svg)](https://github.com/eguidotti/covid19br/actions/workflows/_data.yaml)

|Estados|Status|
|-------|------|
|Acre|[![Acre](https://github.com/eguidotti/covid19br/actions/workflows/AC.yaml/badge.svg)](https://github.com/eguidotti/covid19br/actions/workflows/AC.yaml)|
|Alagoas|[![Alagoas](https://github.com/eguidotti/covid19br/actions/workflows/AL.yaml/badge.svg)](https://github.com/eguidotti/covid19br/actions/workflows/AL.yaml)|
|Amap??|[![Amap??](https://github.com/eguidotti/covid19br/actions/workflows/AP.yaml/badge.svg)](https://github.com/eguidotti/covid19br/actions/workflows/AP.yaml)|
|Amazonas|[![Amazonas](https://github.com/eguidotti/covid19br/actions/workflows/AM.yaml/badge.svg)](https://github.com/eguidotti/covid19br/actions/workflows/AM.yaml)|
|Bahia|[![Bahia](https://github.com/eguidotti/covid19br/actions/workflows/BA.yaml/badge.svg)](https://github.com/eguidotti/covid19br/actions/workflows/BA.yaml)|
|Cear??|[![Cear??](https://github.com/eguidotti/covid19br/actions/workflows/CE.yaml/badge.svg)](https://github.com/eguidotti/covid19br/actions/workflows/CE.yaml)|
|Distrito Federal|[![Distrito Federal](https://github.com/eguidotti/covid19br/actions/workflows/DF.yaml/badge.svg)](https://github.com/eguidotti/covid19br/actions/workflows/DF.yaml)|
|Esp??rito Santo|[![Esp??rito Santo](https://github.com/eguidotti/covid19br/actions/workflows/ES.yaml/badge.svg)](https://github.com/eguidotti/covid19br/actions/workflows/ES.yaml)|
|Goi??s|[![Goi??s](https://github.com/eguidotti/covid19br/actions/workflows/GO.yaml/badge.svg)](https://github.com/eguidotti/covid19br/actions/workflows/GO.yaml)|
|Maranh??o|[![Maranh??o](https://github.com/eguidotti/covid19br/actions/workflows/MA.yaml/badge.svg)](https://github.com/eguidotti/covid19br/actions/workflows/MA.yaml)|
|Mato Grosso|[![Mato Grosso](https://github.com/eguidotti/covid19br/actions/workflows/MT.yaml/badge.svg)](https://github.com/eguidotti/covid19br/actions/workflows/MT.yaml)|
|Mato Grosso do Sul|[![Mato Grosso do Sul](https://github.com/eguidotti/covid19br/actions/workflows/MS.yaml/badge.svg)](https://github.com/eguidotti/covid19br/actions/workflows/MS.yaml)|
|Minas Gerais|[![Minas Gerais](https://github.com/eguidotti/covid19br/actions/workflows/MG.yaml/badge.svg)](https://github.com/eguidotti/covid19br/actions/workflows/MG.yaml)|
|Par??|[![Par??](https://github.com/eguidotti/covid19br/actions/workflows/PA.yaml/badge.svg)](https://github.com/eguidotti/covid19br/actions/workflows/PA.yaml)|
|Para??ba|[![Para??ba](https://github.com/eguidotti/covid19br/actions/workflows/PB.yaml/badge.svg)](https://github.com/eguidotti/covid19br/actions/workflows/PB.yaml)|
|Paran??|[![Paran??](https://github.com/eguidotti/covid19br/actions/workflows/PR.yaml/badge.svg)](https://github.com/eguidotti/covid19br/actions/workflows/PR.yaml)|
|Pernambuco|[![Pernambuco](https://github.com/eguidotti/covid19br/actions/workflows/PE.yaml/badge.svg)](https://github.com/eguidotti/covid19br/actions/workflows/PE.yaml)|
|Piau??|[![Piau??](https://github.com/eguidotti/covid19br/actions/workflows/PI.yaml/badge.svg)](https://github.com/eguidotti/covid19br/actions/workflows/PI.yaml)|
|Rio de Janeiro|[![Rio de Janeiro](https://github.com/eguidotti/covid19br/actions/workflows/RJ.yaml/badge.svg)](https://github.com/eguidotti/covid19br/actions/workflows/RJ.yaml)|
|Rio Grande do Norte|[![Rio Grande do Norte](https://github.com/eguidotti/covid19br/actions/workflows/RN.yaml/badge.svg)](https://github.com/eguidotti/covid19br/actions/workflows/RN.yaml)|
|Rio Grande do Sul|[![Rio Grande do Sul](https://github.com/eguidotti/covid19br/actions/workflows/RS.yaml/badge.svg)](https://github.com/eguidotti/covid19br/actions/workflows/RS.yaml)|
|Rond??nia|[![Rond??nia](https://github.com/eguidotti/covid19br/actions/workflows/RO.yaml/badge.svg)](https://github.com/eguidotti/covid19br/actions/workflows/RO.yaml)|
|Roraima|[![Roraima](https://github.com/eguidotti/covid19br/actions/workflows/RR.yaml/badge.svg)](https://github.com/eguidotti/covid19br/actions/workflows/RR.yaml)|
|Santa Catarina|[![Santa Catarina](https://github.com/eguidotti/covid19br/actions/workflows/SC.yaml/badge.svg)](https://github.com/eguidotti/covid19br/actions/workflows/SC.yaml)|
|S??o Paulo|[![S??o Paulo](https://github.com/eguidotti/covid19br/actions/workflows/SP.yaml/badge.svg)](https://github.com/eguidotti/covid19br/actions/workflows/SP.yaml)|
|Sergipe|[![Sergipe](https://github.com/eguidotti/covid19br/actions/workflows/SE.yaml/badge.svg)](https://github.com/eguidotti/covid19br/actions/workflows/SE.yaml)|
|Tocantins|[![Tocantins](https://github.com/eguidotti/covid19br/actions/workflows/TO.yaml/badge.svg)](https://github.com/eguidotti/covid19br/actions/workflows/TO.yaml)|

## Visualization

An interactive visualization of the latest data is available [here](https://datawrapper.dwcdn.net/RBpM2/).

![](joss/covid-19-vaccinations-in-brazil.png)

