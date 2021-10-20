# COVID-19 Vaccinations for Brazilian Municipalities

The Ministry of Health, through the Information System of the National Immunization Program (SI-PNI), makes available data relating to the National Vaccination Campaign against Covid-19 [here](https://opendatasus.saude.gov.br/dataset/covid-19-vacinacao).

There is only a "small" problem... the dataset size is greater than 130GB! The dataset reports [32 variables](https://opendatasus.saude.gov.br/dataset/b772ee55-07cd-44d8-958f-b12edd004e0b/resource/38ead83d-b115-4219-852e-7244792bc311/download/dicionario-de-dados-vacinacao.pdf) for each single administrated dose.

This repository extracts the time-series of administrated doses from the dataset and makes it available in the form of lightweight ready-to-use CSV files.

## CSV data files

You can find the following CSV files in this folder:

- `vaccines.csv`: contains vaccination data.
- `population.csv`: contains population data.
- `master.csv`: contains the vaccination data merged with population. This is the main file intended for re-use. The file `master-latest.csv` contains only the latest counts for each municipality. Both files have the following structure:

| field                      | description                                                  |
| -------------------------- | ------------------------------------------------------------ |
| `IBGE`                     | 7 digits IBGE code to identify Brazilian municipalities      |
| `Municipio`                | The name of the municipality                                 |
| `Population`               | The total population (2021)                                  |
| `Date`                     | Date in the format YYYY-MM-DD                                |
| `FirstDose`                | The cumulative number of first doses administrated that are part of a 2-doses vaccination cycle |
| `SecondDose`               | The cumulative number of second doses administrated that are part of a 2-doses vaccination cycle |
| `Dose`                     | The cumulative number of doses administrated that require only one shot |
| `DoseAdicional`, `Reforço` | The cumulative number of additional doses administrated      |

## Data Sources

- The vaccination data are from the [Brazilian Ministry of Health](https://opendatasus.saude.gov.br/dataset/covid-19-vacinacao)
- The population data are from the [Instituto Brasileiro de Geografia e Estatística](https://www.ibge.gov.br/en/statistics/social/population/18448-estimates-of-resident-population-for-municipalities-and-federation-units.html)

## How it works

- The script `download.R` is run by several workflows (below) to download the data for each state. The output is saved in the folder `download`

- The script `vaccines.R` reads the data files into the `download` folder and generates the file `vaccines.csv`
- The script `master.R` merges the files `vaccines.csv` and `population.csv` to generate the files `master.csv` and `master-latest.csv`

## Update frequency

- Daily

## Workflows

[![MASTER](https://github.com/eguidotti/covid19br/actions/workflows/master.yaml/badge.svg)](https://github.com/eguidotti/covid19br/actions/workflows/master.yaml)

|Estados|Status|
|-------|------|
|Acre|[![Acre](https://github.com/eguidotti/covid19br/actions/workflows/AC.yaml/badge.svg)](https://github.com/eguidotti/covid19br/actions/workflows/AC.yaml)|
|Alagoas|[![Alagoas](https://github.com/eguidotti/covid19br/actions/workflows/AL.yaml/badge.svg)](https://github.com/eguidotti/covid19br/actions/workflows/AL.yaml)|
|Amapá|[![Amapá](https://github.com/eguidotti/covid19br/actions/workflows/AP.yaml/badge.svg)](https://github.com/eguidotti/covid19br/actions/workflows/AP.yaml)|
|Amazonas|[![Amazonas](https://github.com/eguidotti/covid19br/actions/workflows/AM.yaml/badge.svg)](https://github.com/eguidotti/covid19br/actions/workflows/AM.yaml)|
|Bahia|[![Bahia](https://github.com/eguidotti/covid19br/actions/workflows/BA.yaml/badge.svg)](https://github.com/eguidotti/covid19br/actions/workflows/BA.yaml)|
|Ceará|[![Ceará](https://github.com/eguidotti/covid19br/actions/workflows/CE.yaml/badge.svg)](https://github.com/eguidotti/covid19br/actions/workflows/CE.yaml)|
|Distrito Federal|[![Distrito Federal](https://github.com/eguidotti/covid19br/actions/workflows/DF.yaml/badge.svg)](https://github.com/eguidotti/covid19br/actions/workflows/DF.yaml)|
|Espírito Santo|[![Espírito Santo](https://github.com/eguidotti/covid19br/actions/workflows/ES.yaml/badge.svg)](https://github.com/eguidotti/covid19br/actions/workflows/ES.yaml)|
|Goiás|[![Goiás](https://github.com/eguidotti/covid19br/actions/workflows/GO.yaml/badge.svg)](https://github.com/eguidotti/covid19br/actions/workflows/GO.yaml)|
|Maranhão|[![Maranhão](https://github.com/eguidotti/covid19br/actions/workflows/MA.yaml/badge.svg)](https://github.com/eguidotti/covid19br/actions/workflows/MA.yaml)|
|Mato Grosso|[![Mato Grosso](https://github.com/eguidotti/covid19br/actions/workflows/MT.yaml/badge.svg)](https://github.com/eguidotti/covid19br/actions/workflows/MT.yaml)|
|Mato Grosso do Sul|[![Mato Grosso do Sul](https://github.com/eguidotti/covid19br/actions/workflows/MS.yaml/badge.svg)](https://github.com/eguidotti/covid19br/actions/workflows/MS.yaml)|
|Minas Gerais|[![Minas Gerais](https://github.com/eguidotti/covid19br/actions/workflows/MG.yaml/badge.svg)](https://github.com/eguidotti/covid19br/actions/workflows/MG.yaml)|
|Pará|[![Pará](https://github.com/eguidotti/covid19br/actions/workflows/PA.yaml/badge.svg)](https://github.com/eguidotti/covid19br/actions/workflows/PA.yaml)|
|Paraíba|[![Paraíba](https://github.com/eguidotti/covid19br/actions/workflows/PB.yaml/badge.svg)](https://github.com/eguidotti/covid19br/actions/workflows/PB.yaml)|
|Paraná|[![Paraná](https://github.com/eguidotti/covid19br/actions/workflows/PR.yaml/badge.svg)](https://github.com/eguidotti/covid19br/actions/workflows/PR.yaml)|
|Pernambuco|[![Pernambuco](https://github.com/eguidotti/covid19br/actions/workflows/PE.yaml/badge.svg)](https://github.com/eguidotti/covid19br/actions/workflows/PE.yaml)|
|Piauí|[![Piauí](https://github.com/eguidotti/covid19br/actions/workflows/PI.yaml/badge.svg)](https://github.com/eguidotti/covid19br/actions/workflows/PI.yaml)|
|Rio de Janeiro|[![Rio de Janeiro](https://github.com/eguidotti/covid19br/actions/workflows/RJ.yaml/badge.svg)](https://github.com/eguidotti/covid19br/actions/workflows/RJ.yaml)|
|Rio Grande do Norte|[![Rio Grande do Norte](https://github.com/eguidotti/covid19br/actions/workflows/RN.yaml/badge.svg)](https://github.com/eguidotti/covid19br/actions/workflows/RN.yaml)|
|Rio Grande do Sul|[![Rio Grande do Sul](https://github.com/eguidotti/covid19br/actions/workflows/RS.yaml/badge.svg)](https://github.com/eguidotti/covid19br/actions/workflows/RS.yaml)|
|Rondônia|[![Rondônia](https://github.com/eguidotti/covid19br/actions/workflows/RO.yaml/badge.svg)](https://github.com/eguidotti/covid19br/actions/workflows/RO.yaml)|
|Roraima|[![Roraima](https://github.com/eguidotti/covid19br/actions/workflows/RR.yaml/badge.svg)](https://github.com/eguidotti/covid19br/actions/workflows/RR.yaml)|
|Santa Catarina|[![Santa Catarina](https://github.com/eguidotti/covid19br/actions/workflows/SC.yaml/badge.svg)](https://github.com/eguidotti/covid19br/actions/workflows/SC.yaml)|
|São Paulo|[![São Paulo](https://github.com/eguidotti/covid19br/actions/workflows/SP.yaml/badge.svg)](https://github.com/eguidotti/covid19br/actions/workflows/SP.yaml)|
|Sergipe|[![Sergipe](https://github.com/eguidotti/covid19br/actions/workflows/SE.yaml/badge.svg)](https://github.com/eguidotti/covid19br/actions/workflows/SE.yaml)|
|Tocantins|[![Tocantins](https://github.com/eguidotti/covid19br/actions/workflows/TO.yaml/badge.svg)](https://github.com/eguidotti/covid19br/actions/workflows/TO.yaml)|