## https://data.cms.gov/summary-statistics-on-beneficiary-enrollment/medicare-and-medicaid-reports/cms-program-statistics-medicare-total-enrollment
medicare_enrollment <- "https://docs.google.com/spreadsheets/d/11r-Lt-Q3eXRx-wGLxaMF7ymUhZOjsKFSnZDmHp0UWkc/edit#gid=310095942"
googlesheets4::gs4_deauth()

# MDCR ENROLL AB 1.  Total Medicare Enrollment:  
# Total, Original Medicare, and Medicare Advantage 
# and Other Health Plan Enrollment, Yearly Trend
mdcr_enroll_ab_1 <- googlesheets4::read_sheet(ss = medicare_enrollment, sheet = "mdcr_enroll_ab_1")
readr::write_rds(mdcr_enroll_ab_1, "data/mdcr_enroll_ab_1.rds", "xz", compression = 9L)
# readr::read_rds(here::here("data", "mdcr_enroll_ab_1.rds"))

enroll_clean_1 <- mdcr_enroll_ab_1 |> 
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

readr::write_rds(enroll_clean_1, "data/clean/enroll_clean_1.rds", "xz", compression = 9L)

# MDCR ENROLL AB 2.  Total Medicare Enrollment:  
# Total, Original Medicare, Medicare Advantage and 
# Other Health Plan Enrollment, and Resident Population, by Area of Residence
mdcr_enroll_ab_2 <- googlesheets4::read_sheet(ss = medicare_enrollment, sheet = "mdcr_enroll_ab_2")
readr::write_rds(mdcr_enroll_ab_2, "data/mdcr_enroll_ab_2.rds", "xz", compression = 9L)

enroll_clean_2 <- mdcr_enroll_ab_2 |> 
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

readr::write_rds(enroll_clean_2, "data/clean/enroll_clean_2.rds", "xz", compression = 9L)

# MDCR ENROLL AB 3.  Total Medicare Enrollment:  
# Part A and/or Part B Total, Aged, and Disabled Enrollees, Yearly Trend
mdcr_enroll_ab_3 <- googlesheets4::read_sheet(ss = medicare_enrollment, sheet = "mdcr_enroll_ab_3")
readr::write_rds(mdcr_enroll_ab_3, "data/mdcr_enroll_ab_3.rds", "xz", compression = 9L)

enroll_clean_3 <- mdcr_enroll_ab_3 |> 
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

readr::write_rds(enroll_clean_3, "data/clean/enroll_clean_3.rds", "xz", compression = 9L)

# MDCR ENROLL AB 4.  Total Medicare Enrollment: 
# Part A and/or Part B Enrollees, by Age Group, Yearly Trend
mdcr_enroll_ab_4 <- googlesheets4::read_sheet(ss = medicare_enrollment, sheet = "mdcr_enroll_ab_4")
readr::write_rds(mdcr_enroll_ab_4, "data/mdcr_enroll_ab_4.rds", "xz", compression = 9L)

enroll_clean_4 <- mdcr_enroll_ab_4 |> 
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

readr::write_rds(enroll_clean_4, "data/clean/enroll_clean_4.rds", "xz", compression = 9L)

# MDCR ENROLL AB 5.  Total Medicare Enrollment:  
# Part A and/or Part B Enrollees, by Demographic Characteristics
mdcr_enroll_ab_5 <- googlesheets4::read_sheet(ss = medicare_enrollment, sheet = "mdcr_enroll_ab_5")
readr::write_rds(mdcr_enroll_ab_5, "data/mdcr_enroll_ab_5.rds", "xz", compression = 9L)

enroll_clean_5 <- mdcr_enroll_ab_5 |> 
  janitor::clean_names() |> 
  dplyr::mutate(year = as.integer(year))

readr::write_rds(enroll_clean_5, "data/clean/enroll_clean_5.rds", "xz", compression = 9L)

# MDCR ENROLL AB 6.  Total Medicare Enrollment:  
# Part A and/or Part B Enrollees, 
# by Type of Entitlement and Demographic Characteristics
mdcr_enroll_ab_6 <- googlesheets4::read_sheet(ss = medicare_enrollment, sheet = "mdcr_enroll_ab_6")
readr::write_rds(mdcr_enroll_ab_6, "data/mdcr_enroll_ab_6.rds", "xz", compression = 9L)

enroll_clean_6 <- mdcr_enroll_ab_6 |> 
  dplyr::mutate(year = as.integer(year))

readr::write_rds(enroll_clean_6, "data/clean/enroll_clean_6.rds", "xz", compression = 9L)

# MDCR ENROLL AB 7.  Total Medicare Enrollment:  
# Part A and/or Part B Total, Aged, and Disabled Enrollees, 
# by Area of Residence
mdcr_enroll_ab_7 <- googlesheets4::read_sheet(ss = medicare_enrollment, sheet = "mdcr_enroll_ab_7")
readr::write_rds(mdcr_enroll_ab_7, "data/mdcr_enroll_ab_7.rds", "xz", compression = 9L)

enroll_clean_7 <- mdcr_enroll_ab_7 |> 
  janitor::clean_names() |> 
  dplyr::mutate(year = as.integer(year))

readr::write_rds(enroll_clean_7, "data/clean/enroll_clean_7.rds", "xz", compression = 9L)

# MDCR ENROLL AB 8.  Total Medicare Enrollment:  
# Part A and/or Part B Enrollees, by Type of Entitlement and Area of Residence
mdcr_enroll_ab_8 <- googlesheets4::read_sheet(ss = medicare_enrollment, sheet = "mdcr_enroll_ab_8")
readr::write_rds(mdcr_enroll_ab_8, "data/mdcr_enroll_ab_8.rds", "xz", compression = 9L)

enroll_clean_8 <- mdcr_enroll_ab_8 |> 
  dplyr::mutate(year = as.integer(year))

readr::write_rds(enroll_clean_8, "data/clean/enroll_clean_8.rds", "xz", compression = 9L)

# Medicare Enrollment Averages by State, 1985-2012
medicare_enrollment_averages <- "https://docs.google.com/spreadsheets/d/1p52ijKIAlVn59tpPtsV4LwtHlctRFVyoeCLj5ABc-7k/edit#gid=1696265805"

mdcr_enroll_avgs <- googlesheets4::read_sheet(ss = medicare_enrollment_averages)
readr::write_rds(mdcr_enroll_avgs, "data/mdcr_enroll_avgs.rds", "xz", compression = 9L)

enroll_clean_avgs <- mdcr_enroll_avgs |> 
  tidyr::pivot_longer(!area_of_residence,
                      names_to = "year", 
                      values_to = "enrollment_average") |> 
  dplyr::mutate(year = as.integer(year), 
                .before = area_of_residence)

readr::write_rds(enroll_clean_avgs, "data/clean/enroll_clean_avgs.rds", "xz", compression = 9L)

## https://data.cms.gov/summary-statistics-on-beneficiary-enrollment/medicare-and-medicaid-reports/cms-program-statistics-medicare-deaths
medicare_deaths <- "https://docs.google.com/spreadsheets/d/1yQ9eJe4f7KoOK4fY2_7L-sux2bJ92AO4XrDoYOr6nSY/edit#gid=264964884"
googlesheets4::gs4_deauth()

# MDCR ENROLL AB 33.  Medicare Deaths:  
# Total (Original Medicare and Medicare Advantage 
# and Other Health Plan) Beneficiaries, by Month of Death, Yearly Trend
mdcr_enroll_ab_33 <- googlesheets4::read_sheet(ss = medicare_deaths, sheet = "mdcr_enroll_ab_33")
readr::write_rds(mdcr_enroll_ab_33, "data/mdcr_enroll_ab_33.rds", "xz", compression = 9L)

enroll_clean_33 <- mdcr_enroll_ab_33 |> 
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

readr::write_rds(enroll_clean_33, "data/clean/enroll_clean_33.rds", "xz", compression = 9L)

# MDCR ENROLL AB 34.  Medicare Deaths:  
# Total, Original Medicare, and Medicare Advantage 
# and Other Health Plan Beneficiaries, by Demographic Characteristics
mdcr_enroll_ab_34 <- googlesheets4::read_sheet(ss = medicare_deaths, sheet = "mdcr_enroll_ab_34")
readr::write_rds(mdcr_enroll_ab_34, "data/mdcr_enroll_ab_34.rds", "xz", compression = 9L)

enroll_clean_34 <- mdcr_enroll_ab_34 |> 
  dplyr::mutate(year = as.integer(year))

readr::write_rds(enroll_clean_34, "data/clean/enroll_clean_34.rds", "xz", compression = 9L)

# MDCR ENROLL AB 35.  Medicare Deaths:  
# Total (Original Medicare and Medicare Advantage 
# and Other Health Plan) Beneficiaries, by Area of Residence
mdcr_enroll_ab_35 <- googlesheets4::read_sheet(ss = medicare_deaths, sheet = "mdcr_enroll_ab_35")
readr::write_rds(mdcr_enroll_ab_35, "data/mdcr_enroll_ab_35.rds", "xz", compression = 9L)

enroll_clean_35 <- mdcr_enroll_ab_35 |> 
  dplyr::mutate(year = as.integer(year))

readr::write_rds(enroll_clean_35, "data/clean/enroll_clean_35.rds", "xz", compression = 9L)

# MDCR ENROLL AB 36.  Medicare Deaths:  
# Original Medicare Beneficiaries, by Month of Death, Yearly Trend
mdcr_enroll_ab_36 <- googlesheets4::read_sheet(ss = medicare_deaths, sheet = "mdcr_enroll_ab_36")
readr::write_rds(mdcr_enroll_ab_36, "data/mdcr_enroll_ab_36.rds", "xz", compression = 9L)

enroll_clean_36 <- mdcr_enroll_ab_36 |> 
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

readr::write_rds(enroll_clean_36, "data/clean/enroll_clean_36.rds", "xz", compression = 9L)

# MDCR ENROLL AB 37.  Medicare Deaths:  
# Original Medicare Beneficiaries, by Area of Residence
mdcr_enroll_ab_37 <- googlesheets4::read_sheet(ss = medicare_deaths, sheet = "mdcr_enroll_ab_37")
readr::write_rds(mdcr_enroll_ab_37, "data/mdcr_enroll_ab_37.rds", "xz", compression = 9L)

enroll_clean_37 <- mdcr_enroll_ab_37 |> 
  dplyr::mutate(year = as.integer(year))

readr::write_rds(enroll_clean_37, "data/clean/enroll_clean_37.rds", "xz", compression = 9L)

# MDCR ENROLL AB 38.  Medicare Deaths:  
# Medicare Advantage and Other Health Plan Beneficiaries, by Month of Death, Yearly Trend
mdcr_enroll_ab_38 <- googlesheets4::read_sheet(ss = medicare_deaths, sheet = "mdcr_enroll_ab_38")
readr::write_rds(mdcr_enroll_ab_38, "data/mdcr_enroll_ab_38.rds", "xz", compression = 9L)

enroll_clean_38 <- mdcr_enroll_ab_38 |> 
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

readr::write_rds(enroll_clean_38, "data/clean/enroll_clean_38.rds", "xz", compression = 9L)

# MDCR ENROLL AB 39.  Medicare Deaths:  
# Medicare Advantage and Other Health Plan Beneficiaries, by Area of Residence
mdcr_enroll_ab_39 <- googlesheets4::read_sheet(ss = medicare_deaths, sheet = "mdcr_enroll_ab_39")
readr::write_rds(mdcr_enroll_ab_39, "data/mdcr_enroll_ab_39.rds", "xz", compression = 9L)

enroll_clean_39 <- mdcr_enroll_ab_39 |> 
  dplyr::mutate(year = as.integer(year))

readr::write_rds(enroll_clean_39, "data/clean/enroll_clean_39.rds", "xz", compression = 9L)

# MDCR ENROLL AB 21.  Medicare Newly Enrolled Beneficiaries:  
# Total, Aged, and Disabled Enrollees, Yearly Trend
medicare_new <- "https://docs.google.com/spreadsheets/d/1xWzuKlfe1pfKrVFZMqWnSqEG7pbqMbTtC3amSKjo2t0/edit#gid=1837294709"

mdcr_enroll_ab_21 <- googlesheets4::read_sheet(ss = medicare_new, sheet = "mdcr_enroll_ab_21")
readr::write_rds(mdcr_enroll_ab_21, "data/mdcr_enroll_ab_21.rds", "xz", compression = 9L)

enroll_clean_21 <- mdcr_enroll_ab_21 |> 
  dplyr::mutate(year = as.integer(year))

readr::write_rds(enroll_clean_21, "data/clean/enroll_clean_21.rds", "xz", compression = 9L)

# MDCR ENROLL AB 22.  Medicare Newly Enrolled Beneficiaries: 
# Total Enrollees by Month of Enrollment, Yearly Trend
mdcr_enroll_ab_22 <- googlesheets4::read_sheet(ss = medicare_new, sheet = "mdcr_enroll_ab_22")
readr::write_rds(mdcr_enroll_ab_22, "data/mdcr_enroll_ab_22.rds", "xz", compression = 9L)

mdcr_enroll_ab_22 <- readr::read_rds(here::here("data", "mdcr_enroll_ab_22.rds"))
enroll_clean_22 <- mdcr_enroll_ab_22 |> 
  janitor::clean_names() |> 
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

readr::write_rds(enroll_clean_22, "data/clean/enroll_clean_22.rds", "xz", compression = 9L)

# MDCR ENROLL AB 23.  Medicare Newly Enrolled Beneficiaries: # Total Enrollees, by Demographic Characteristics
# MDCR ENROLL AB 24.  Medicare Newly Enrolled Beneficiaries: # Total, Aged, and Disabled Enrollees, by Area of Residence
# MDCR ENROLL AB 25.  Medicare Newly Enrolled Beneficiaries: # Total, Aged, and Disabled Original Medicare Enrollees

# MDCR ENROLL AB 26.  Medicare Newly Enrolled Beneficiaries: 
# Original Medicare Enrollees by Month of Enrollment, Yearly Trend
mdcr_enroll_ab_26 <- googlesheets4::read_sheet(ss = medicare_new, sheet = "mdcr_enroll_ab_26")
readr::write_rds(mdcr_enroll_ab_26, "data/mdcr_enroll_ab_26.rds", "xz", compression = 9L)

enroll_clean_26 <- mdcr_enroll_ab_26 |> 
  dplyr::mutate(Year = as.integer(Year))

readr::write_rds(enroll_clean_26, "data/clean/enroll_clean_26.rds", "xz", compression = 9L)

# MDCR ENROLL AB 27.  Medicare Newly Enrolled Beneficiaries: # Original Medicare Enrollees, by Demographic Characteristics
# MDCR ENROLL AB 28.  Medicare Newly Enrolled Beneficiaries: # Total, Aged, and Disabled Original Medicare Enrollees, by Area of Residence
# MDCR ENROLL AB 29.  Medicare Newly Enrolled Beneficiaries: # Total, Aged, and Disabled Medicare Advantage and Other Health Plan Enrollees, Yearly Trend

# MDCR ENROLL AB 30.  Medicare Newly Enrolled Beneficiaries: 
# Medicare Advantage and Other Health Plan Enrollees, by Month of Enrollment, Yearly Trend
mdcr_enroll_ab_30 <- googlesheets4::read_sheet(ss = medicare_new, sheet = "mdcr_enroll_ab_30")
readr::write_rds(mdcr_enroll_ab_30, "data/mdcr_enroll_ab_30.rds", "xz", compression = 9L)

enroll_clean_30 <- mdcr_enroll_ab_30 |> 
  dplyr::mutate(Year = as.integer(Year))

readr::write_rds(enroll_clean_30, "data/clean/enroll_clean_30.rds", "xz", compression = 9L)

# MDCR ENROLL AB 31.  Medicare Newly Enrolled Beneficiaries: # Medicare Advantage and Other Health Plan Enrollees, by Demographic Characteristics
# MDCR ENROLL AB 32.  Medicare Newly Enrolled Beneficiaries: # Total, Aged, and Disabled Medicare Advantage and Other Health Plan Enrollees, by Area of Residence