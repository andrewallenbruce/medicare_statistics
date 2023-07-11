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

