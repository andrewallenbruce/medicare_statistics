## https://data.cms.gov/summary-statistics-on-beneficiary-enrollment/medicare-and-medicaid-reports/cms-program-statistics-medicare-total-enrollment
medicare_enrollment <- "https://docs.google.com/spreadsheets/d/11r-Lt-Q3eXRx-wGLxaMF7ymUhZOjsKFSnZDmHp0UWkc/edit#gid=310095942"
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

# MDCR ENROLL AB 1.  Total Medicare Enrollment:  
# Total, Original Medicare, and Medicare Advantage 
# and Other Health Plan Enrollment, Yearly Trend
mdcr_enroll_ab_1 <- googlesheets4::read_sheet(
  ss = medicare_enrollment, 
  sheet = "mdcr_enroll_ab_1")

mdcr_enroll_ab_1 <- mdcr_enroll_ab_1 |> 
  dplyr::select(year,
                total = enroll_tot,
                original = enroll_orig,
                ma_other = enroll_ma_oth) |> 
  change_abs(total, year) |> 
  change_abs(original, year) |> 
  change_abs(ma_other, year) |> 
  change_pct(total, total_chg, year) |> 
  change_pct(original, original_chg, year) |> 
  change_pct(ma_other, ma_other_chg, year) |> 
  pct(original, total) |> 
  pct(ma_other, total) |> 
  dplyr::mutate(year = as.integer(year))

readr::write_rds(mdcr_enroll_ab_1, 
                 "data/mdcr_enroll_ab_1.rds", 
                 "xz", 
                 compression = 9L)

readr::read_rds(here::here("data", "mdcr_enroll_ab_1.rds"))

# MDCR ENROLL AB 2.  Total Medicare Enrollment:  
# Total, Original Medicare, Medicare Advantage and 
# Other Health Plan Enrollment, and Resident Population, by Area of Residence
mdcr_enroll_ab_2 <- googlesheets4::read_sheet(
  ss = medicare_enrollment, 
  sheet = "mdcr_enroll_ab_2")

mdcr_enroll_ab_2 <- mdcr_enroll_ab_2 |> 
  dplyr::select(year,
                area_of_residence,
                population,
                total = enroll_tot,
                original = enroll_orig,
                ma_other = enroll_ma_oth,
                metro = enroll_metro,
                micro = enroll_micro,
                non_cbsa = enroll_non_cbsa) |> 
  pct(total, population) |> 
  pct(original, total) |> 
  pct(ma_other, total) |> 
  pct(metro, total) |> 
  pct(micro, total) |>
  pct(non_cbsa, total) |> 
  dplyr::mutate(year = as.integer(year))

readr::write_rds(mdcr_enroll_ab_2, 
                 "data/mdcr_enroll_ab_2.rds", 
                 "xz", 
                 compression = 9L)
readr::read_rds(here::here("data", "mdcr_enroll_ab_2.rds"))

# MDCR ENROLL AB 3.  Total Medicare Enrollment:  
# Part A and/or Part B Total, Aged, and Disabled Enrollees, Yearly Trend
mdcr_enroll_ab_3 <- googlesheets4::read_sheet(
  ss = medicare_enrollment, 
  sheet = "mdcr_enroll_ab_3")

mdcr_enroll_ab_3 <- mdcr_enroll_ab_3 |> 
  janitor::clean_names() |> 
  dplyr::mutate(year = as.integer(year)) |> 
  pct(a_and_or_b_aged, a_and_or_b_tot) |>
  pct(a_and_or_b_dsb, a_and_or_b_tot) |>
  pct(a_and_b_aged, a_and_b_tot) |>
  pct(a_and_b_dsb, a_and_b_tot) |>
  pct(a_aged, a_tot) |>
  pct(a_dsb, a_tot) |>
  pct(b_aged, b_tot) |>
  pct(b_dsb, b_tot) |> 
  change_abs(a_and_or_b_tot, year) |> 
  change_abs(a_and_b_tot, year) |> 
  change_abs(a_tot, year) |> 
  change_abs(b_tot, year) |> 
  change_pct(a_and_or_b_tot, a_and_or_b_tot_chg, year) |> 
  change_pct(a_and_b_tot, a_and_b_tot_chg, year) |> 
  change_pct(a_tot, a_tot_chg, year) |> 
  change_pct(b_tot, b_tot_chg, year) 

readr::write_rds(mdcr_enroll_ab_3, 
                 "data/mdcr_enroll_ab_3.rds", 
                 "xz", 
                 compression = 9L)

readr::read_rds(here::here("data", "mdcr_enroll_ab_3.rds"))


# MDCR ENROLL AB 4.  Total Medicare Enrollment: 
# Part A and/or Part B Enrollees, by Age Group, Yearly Trend
mdcr_enroll_ab_4 <- googlesheets4::read_sheet(
  ss = medicare_enrollment, 
  sheet = "mdcr_enroll_ab_4")

mdcr_enroll_ab_4 <- mdcr_enroll_ab_4 |> 
  dplyr::select(year, total, dplyr::contains("tot_")) |> 
  dplyr::mutate(year = as.integer(year)) |> 
  dplyr::mutate(pct_lt_18 = janitor::round_half_up(tot_lt_18 / total, digits = 10), .after = tot_lt_18) |> 
  dplyr::mutate(pct_18_24 = janitor::round_half_up(tot_18_24 / total, digits = 5), .after = tot_18_24) |> 
  dplyr::mutate(pct_25_34 = janitor::round_half_up(tot_25_34 / total, digits = 5), .after = tot_25_34) |> 
  dplyr::mutate(pct_35_44 = janitor::round_half_up(tot_35_44 / total, digits = 5), .after = tot_35_44) |> 
  dplyr::mutate(pct_45_54 = janitor::round_half_up(tot_45_54 / total, digits = 5), .after = tot_45_54) |> 
  dplyr::mutate(pct_55_64 = janitor::round_half_up(tot_55_64 / total, digits = 5), .after = tot_55_64) |> 
  dplyr::mutate(pct_65_74 = janitor::round_half_up(tot_65_74 / total, digits = 5), .after = tot_65_74) |> 
  dplyr::mutate(pct_75_84 = janitor::round_half_up(tot_75_84 / total, digits = 5), .after = tot_75_84) |> 
  dplyr::mutate(pct_85_94 = janitor::round_half_up(tot_85_94 / total, digits = 5), .after = tot_85_94) |> 
  dplyr::mutate(pct_95_gt = janitor::round_half_up(tot_95_gt / total, digits = 5), .after = tot_95_gt) |> 
  dplyr::select(year, total, dplyr::contains("tot_"), dplyr::contains("pct_"))

readr::write_rds(mdcr_enroll_ab_4, 
                 "data/mdcr_enroll_ab_4.rds", 
                 "xz", 
                 compression = 9L)

readr::read_rds(here::here("data", "mdcr_enroll_ab_4.rds"))


# MDCR ENROLL AB 5.  Total Medicare Enrollment:  
# Part A and/or Part B Enrollees, by Demographic Characteristics
mdcr_enroll_ab_5 <- googlesheets4::read_sheet(
  ss = medicare_enrollment, 
  sheet = "mdcr_enroll_ab_5")

mdcr_enroll_ab_5 <- mdcr_enroll_ab_5 |> 
  janitor::clean_names()

mdcr_enroll_ab_5 <- mdcr_enroll_ab_5 |> 
  dplyr::mutate(year = as.integer(year))

readr::write_rds(mdcr_enroll_ab_5, 
                 "data/mdcr_enroll_ab_5.rds", 
                 "xz", 
                 compression = 9L)

readr::read_rds(here::here("data", "mdcr_enroll_ab_5.rds"))

# MDCR ENROLL AB 6.  Total Medicare Enrollment:  
# Part A and/or Part B Enrollees, 
# by Type of Entitlement and Demographic Characteristics
mdcr_enroll_ab_6 <- googlesheets4::read_sheet(
  ss = medicare_enrollment, 
  sheet = "mdcr_enroll_ab_6")

mdcr_enroll_ab_6 <- mdcr_enroll_ab_6 |> 
  dplyr::mutate(year = as.integer(year))

readr::write_rds(mdcr_enroll_ab_6, 
                 "data/mdcr_enroll_ab_6.rds", 
                 "xz", 
                 compression = 9L)

readr::read_rds(here::here("data", "mdcr_enroll_ab_6.rds"))

# MDCR ENROLL AB 7.  Total Medicare Enrollment:  
# Part A and/or Part B Total, Aged, and Disabled Enrollees, 
# by Area of Residence
mdcr_enroll_ab_7 <- googlesheets4::read_sheet(
  ss = medicare_enrollment, 
  sheet = "mdcr_enroll_ab_7")

mdcr_enroll_ab_7 <- mdcr_enroll_ab_7 |> 
  janitor::clean_names() |> 
  dplyr::mutate(year = as.integer(year))

readr::write_rds(mdcr_enroll_ab_7, 
                 "data/mdcr_enroll_ab_7.rds", 
                 "xz", 
                 compression = 9L)

readr::read_rds(here::here("data", "mdcr_enroll_ab_7.rds"))

# MDCR ENROLL AB 8.  Total Medicare Enrollment:  
# Part A and/or Part B Enrollees, by Type of Entitlement and Area of Residence
mdcr_enroll_ab_8 <- googlesheets4::read_sheet(
  ss = medicare_enrollment, 
  sheet = "mdcr_enroll_ab_8")

mdcr_enroll_ab_8 <- mdcr_enroll_ab_8 |> 
  dplyr::mutate(year = as.integer(year))

readr::write_rds(mdcr_enroll_ab_8, 
                 "data/mdcr_enroll_ab_8.rds", 
                 "xz", 
                 compression = 9L)

readr::read_rds(here::here("data", "mdcr_enroll_ab_8.rds"))

# Medicare Enrollment Averages by State, 1985-2012
medicare_enrollment_averages <- "https://docs.google.com/spreadsheets/d/1p52ijKIAlVn59tpPtsV4LwtHlctRFVyoeCLj5ABc-7k/edit#gid=1696265805"

mdcr_enroll_avgs <- googlesheets4::read_sheet(ss = medicare_enrollment_averages)

mdcr_enroll_avgs

readr::write_rds(mdcr_enroll_avgs, 
                 "data/mdcr_enroll_avgs.rds", 
                 "xz", 
                 compression = 9L)

readr::read_rds(here::here("data", "mdcr_enroll_avgs.rds"))