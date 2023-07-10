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

options(scipen = 999)

mdcr_enroll_ab_1 <- readr::read_rds(here::here("data", "mdcr_enroll_ab_1.rds"))
mdcr_enroll_ab_2 <- readr::read_rds(here::here("data", "mdcr_enroll_ab_2.rds"))
mdcr_enroll_ab_3 <- readr::read_rds(here::here("data", "mdcr_enroll_ab_3.rds"))
mdcr_enroll_ab_4 <- readr::read_rds(here::here("data", "mdcr_enroll_ab_4.rds"))
mdcr_enroll_ab_5 <- readr::read_rds(here::here("data", "mdcr_enroll_ab_5.rds"))
mdcr_enroll_ab_6 <- readr::read_rds(here::here("data", "mdcr_enroll_ab_6.rds"))
mdcr_enroll_ab_7 <- readr::read_rds(here::here("data", "mdcr_enroll_ab_7.rds"))
mdcr_enroll_ab_8 <- readr::read_rds(here::here("data", "mdcr_enroll_ab_8.rds"))
mdcr_enroll_avgs <- readr::read_rds(here::here("data", "mdcr_enroll_avgs.rds"))

mdcr_enroll_ab_33 <- readr::read_rds(here::here("data", "mdcr_enroll_ab_33.rds"))
mdcr_enroll_ab_34 <- readr::read_rds(here::here("data", "mdcr_enroll_ab_34.rds"))
mdcr_enroll_ab_35 <- readr::read_rds(here::here("data", "mdcr_enroll_ab_35.rds"))
mdcr_enroll_ab_36 <- readr::read_rds(here::here("data", "mdcr_enroll_ab_36.rds"))
mdcr_enroll_ab_37 <- readr::read_rds(here::here("data", "mdcr_enroll_ab_37.rds"))
mdcr_enroll_ab_38 <- readr::read_rds(here::here("data", "mdcr_enroll_ab_38.rds"))
mdcr_enroll_ab_39 <- readr::read_rds(here::here("data", "mdcr_enroll_ab_39.rds"))