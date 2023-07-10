## https://data.cms.gov/summary-statistics-on-beneficiary-enrollment/medicare-and-medicaid-reports/cms-program-statistics-medicare-deaths
medicare_deaths <- "https://docs.google.com/spreadsheets/d/1yQ9eJe4f7KoOK4fY2_7L-sux2bJ92AO4XrDoYOr6nSY/edit#gid=264964884"
googlesheets4::gs4_deauth()

# FUNCTIONS
change_abs <- function(df, col, by) {
  
  df |> dplyr::mutate(
    "{{ col }}_chg" := {{ col }} - dplyr::lag({{ col }}, order_by = {{ by }}),
    .after = {{ col }})
}

change_pct <- function(df, col, col_abs, by) {
  
  df |> dplyr::mutate(
    "{{ col }}_pct_chg" := {{ col_abs }} / dplyr::lag({{ col }}, order_by = {{ by }}),
    .after = {{ col_abs }})
}

pct <- function(df, col, col_total) {
  df |> dplyr::mutate(
    "{{ col }}_pct" := {{ col }} / {{ col_total }}, .after = {{ col }})
}

# MDCR ENROLL AB 33.  Medicare Deaths:  
# Total (Original Medicare and Medicare Advantage 
# and Other Health Plan) Beneficiaries, by Month of Death, Yearly Trend
mdcr_enroll_ab_33 <- googlesheets4::read_sheet(
  ss = medicare_deaths, 
  sheet = "mdcr_enroll_ab_33")

mdcr_enroll_ab_33 <- mdcr_enroll_ab_33 |> 
  dplyr::mutate(year = as.integer(year)) |> 
  change_abs(total, year) |> 
  change_pct(total, total_chg, year) |> 
  change_abs(january, year) |> 
  change_pct(january, january_chg, year) |> 
  pct(january, total) |> 
  change_abs(february, year) |> 
  change_pct(february, february_chg, year) |> 
  pct(february, total) |> 
  change_abs(march, year) |> 
  change_pct(march, march_chg, year) |> 
  pct(march, total) |> 
  change_abs(april, year) |> 
  change_pct(april, april_chg, year) |> 
  pct(april, total) |> 
  change_abs(may, year) |> 
  change_pct(may, may_chg, year) |> 
  pct(may, total) |> 
  change_abs(june, year) |> 
  change_pct(june, june_chg, year) |> 
  pct(june, total) |> 
  change_abs(july, year) |> 
  change_pct(july, july_chg, year) |> 
  pct(july, total) |> 
  change_abs(august, year) |> 
  change_pct(august, august_chg, year) |> 
  pct(august, total) |> 
  change_abs(september, year) |> 
  change_pct(september, september_chg, year) |> 
  pct(september, total) |> 
  change_abs(october, year) |> 
  change_pct(october, october_chg, year) |> 
  pct(october, total) |> 
  change_abs(november, year) |> 
  change_pct(november, november_chg, year) |> 
  pct(november, total) |> 
  change_abs(december, year) |> 
  change_pct(december, december_chg, year) |> 
  pct(december, total)

readr::write_rds(mdcr_enroll_ab_33, 
                 "data/mdcr_enroll_ab_33.rds", 
                 "xz", 
                 compression = 9L)

readr::read_rds(here::here("data", "mdcr_enroll_ab_33.rds"))

# MDCR ENROLL AB 34.  Medicare Deaths:  
# Total, Original Medicare, and Medicare Advantage 
# and Other Health Plan Beneficiaries, by Demographic Characteristics
mdcr_enroll_ab_34 <- googlesheets4::read_sheet(
  ss = medicare_deaths, 
  sheet = "mdcr_enroll_ab_34")

mdcr_enroll_ab_34 <- mdcr_enroll_ab_34 |> 
  dplyr::mutate(year = as.integer(year))

readr::write_rds(mdcr_enroll_ab_34, 
                 "data/mdcr_enroll_ab_34.rds", 
                 "xz", 
                 compression = 9L)

readr::read_rds(here::here("data", "mdcr_enroll_ab_34.rds"))

# MDCR ENROLL AB 35.  Medicare Deaths:  
# Total (Original Medicare and Medicare Advantage 
# and Other Health Plan) Beneficiaries, by Area of Residence
mdcr_enroll_ab_35 <- googlesheets4::read_sheet(
  ss = medicare_deaths, 
  sheet = "mdcr_enroll_ab_35")

mdcr_enroll_ab_35 <- mdcr_enroll_ab_35 |> 
  dplyr::mutate(year = as.integer(year))

readr::write_rds(mdcr_enroll_ab_35, 
                 "data/mdcr_enroll_ab_35.rds", 
                 "xz", 
                 compression = 9L)

readr::read_rds(here::here("data", "mdcr_enroll_ab_35.rds"))

# MDCR ENROLL AB 36.  Medicare Deaths:  
# Original Medicare Beneficiaries, by Month of Death, Yearly Trend
mdcr_enroll_ab_36 <- googlesheets4::read_sheet(
  ss = medicare_deaths, 
  sheet = "mdcr_enroll_ab_36")

mdcr_enroll_ab_36 <- mdcr_enroll_ab_36 |> 
  dplyr::mutate(year = as.integer(year)) |> 
  change_abs(total, year) |> 
  change_pct(total, total_chg, year) |> 
  change_abs(january, year) |> 
  change_pct(january, january_chg, year) |> 
  pct(january, total) |> 
  change_abs(february, year) |> 
  change_pct(february, february_chg, year) |> 
  pct(february, total) |> 
  change_abs(march, year) |> 
  change_pct(march, march_chg, year) |> 
  pct(march, total) |> 
  change_abs(april, year) |> 
  change_pct(april, april_chg, year) |> 
  pct(april, total) |> 
  change_abs(may, year) |> 
  change_pct(may, may_chg, year) |> 
  pct(may, total) |> 
  change_abs(june, year) |> 
  change_pct(june, june_chg, year) |> 
  pct(june, total) |> 
  change_abs(july, year) |> 
  change_pct(july, july_chg, year) |> 
  pct(july, total) |> 
  change_abs(august, year) |> 
  change_pct(august, august_chg, year) |> 
  pct(august, total) |> 
  change_abs(september, year) |> 
  change_pct(september, september_chg, year) |> 
  pct(september, total) |> 
  change_abs(october, year) |> 
  change_pct(october, october_chg, year) |> 
  pct(october, total) |> 
  change_abs(november, year) |> 
  change_pct(november, november_chg, year) |> 
  pct(november, total) |> 
  change_abs(december, year) |> 
  change_pct(december, december_chg, year) |> 
  pct(december, total)

readr::write_rds(mdcr_enroll_ab_36, 
                 "data/mdcr_enroll_ab_36.rds", 
                 "xz", 
                 compression = 9L)

readr::read_rds(here::here("data", "mdcr_enroll_ab_36.rds"))

# MDCR ENROLL AB 37.  Medicare Deaths:  
# Original Medicare Beneficiaries, by Area of Residence
mdcr_enroll_ab_37 <- googlesheets4::read_sheet(
  ss = medicare_deaths, 
  sheet = "mdcr_enroll_ab_37")

mdcr_enroll_ab_37 <- mdcr_enroll_ab_37 |> 
  dplyr::mutate(year = as.integer(year))

readr::write_rds(mdcr_enroll_ab_37, 
                 "data/mdcr_enroll_ab_37.rds", 
                 "xz", 
                 compression = 9L)

readr::read_rds(here::here("data", "mdcr_enroll_ab_37.rds"))

# MDCR ENROLL AB 38.  Medicare Deaths:  
# Medicare Advantage and Other Health Plan Beneficiaries, by Month of Death, Yearly Trend
mdcr_enroll_ab_38 <- googlesheets4::read_sheet(
  ss = medicare_deaths, 
  sheet = "mdcr_enroll_ab_38")

mdcr_enroll_ab_38 <- mdcr_enroll_ab_38 |> 
  dplyr::mutate(year = as.integer(year)) |> 
  change_abs(total, year) |> 
  change_pct(total, total_chg, year) |> 
  change_abs(january, year) |> 
  change_pct(january, january_chg, year) |> 
  pct(january, total) |> 
  change_abs(february, year) |> 
  change_pct(february, february_chg, year) |> 
  pct(february, total) |> 
  change_abs(march, year) |> 
  change_pct(march, march_chg, year) |> 
  pct(march, total) |> 
  change_abs(april, year) |> 
  change_pct(april, april_chg, year) |> 
  pct(april, total) |> 
  change_abs(may, year) |> 
  change_pct(may, may_chg, year) |> 
  pct(may, total) |> 
  change_abs(june, year) |> 
  change_pct(june, june_chg, year) |> 
  pct(june, total) |> 
  change_abs(july, year) |> 
  change_pct(july, july_chg, year) |> 
  pct(july, total) |> 
  change_abs(august, year) |> 
  change_pct(august, august_chg, year) |> 
  pct(august, total) |> 
  change_abs(september, year) |> 
  change_pct(september, september_chg, year) |> 
  pct(september, total) |> 
  change_abs(october, year) |> 
  change_pct(october, october_chg, year) |> 
  pct(october, total) |> 
  change_abs(november, year) |> 
  change_pct(november, november_chg, year) |> 
  pct(november, total) |> 
  change_abs(december, year) |> 
  change_pct(december, december_chg, year) |> 
  pct(december, total)

readr::write_rds(mdcr_enroll_ab_38, 
                 "data/mdcr_enroll_ab_38.rds", 
                 "xz", 
                 compression = 9L)

readr::read_rds(here::here("data", "mdcr_enroll_ab_38.rds"))

# MDCR ENROLL AB 39.  Medicare Deaths:  
# Medicare Advantage and Other Health Plan Beneficiaries, by Area of Residence
mdcr_enroll_ab_39 <- googlesheets4::read_sheet(
  ss = medicare_deaths, 
  sheet = "mdcr_enroll_ab_39")

mdcr_enroll_ab_39 <- mdcr_enroll_ab_39 |> 
  dplyr::mutate(year = as.integer(year))

readr::write_rds(mdcr_enroll_ab_39, 
                 "data/mdcr_enroll_ab_39.rds", 
                 "xz", 
                 compression = 9L)

readr::read_rds(here::here("data", "mdcr_enroll_ab_39.rds"))
