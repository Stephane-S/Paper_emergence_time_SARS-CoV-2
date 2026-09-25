library(forestplot)
library(dplyr)


base_data <- tibble::tibble(mean  = c(2019.75, 2019.64, 2019.61, 2019.58, 2019.56, 2019.69),
                            lower = c(2019.63, 2019.38, 2019.16, 2017.72, 2018.04, 2018.53),
                            upper = c(2019.86, 2019.87, 2019.91, 2020.46, 2020.50, 2020.36),
                            study = c("Genome (SARS-CoV-2 variants)", "Gene S (SARS-CoV-2 variants)", "RBD (SARS-CoV-2 variants)", "Genome (without SARS-CoV-2 variants)", "Gene S ( without SARS-CoV-2 variants)", "RBD ( without SARS-CoV-2 variants)"),
                            group = c('With (SARS-CoV-2 variants', 'With (SARS-CoV-2 variants', 'With (SARS-CoV-2 variants', 'Without (SARS-CoV-2 variants', 'Without (SARS-CoV-2 variants', 'Without (SARS-CoV-2 variants'),
                            deaths_placebo = c('2019.75', '2019.64', '2019.61', '2019.58', '2019.56', '2019.69'),
                            deaths_steroid = c('2019.63', '2019.38', '2019.16', '2017.72', '2018.04', '2018.53'),
                            OR = c('2019.86', '2019.87', '2019.91', '2020.46', '2020.50', '2020.36'))

base_data |>
  forestplot(labeltext = c(study, deaths_steroid, deaths_placebo, OR),
             zero = 2019,
             boxsize = 0.1,
             xlim = c(2017, 2022),
             ci.vertices = TRUE,
             ci.vertices.height = 0.05,
             fn.ci_norm = fpDrawCircleCI,
             xlab = 'Date (decimal year)',
             xticks = c(2017, 2018, 2019, 2020, 2021),
             graphwidth = unit(65, 'mm'),
             colgap = unit(3, 'mm'),
             align = 'c',
             xlog = FALSE) |>
  fp_set_style(box = "royalblue",
               line = "darkblue",
               summary = "royalblue") |> 
  fp_add_lines("steelblue") |>
  fp_add_header(study = c("", "Datasets") |> fp_align_center(),
                deaths_steroid = c("", "Lower 95%") |> fp_align_center(),
                deaths_placebo = c("TMRCA", "Median 95%") |> fp_align_center(),
                OR = c("", "High 95%")|> fp_align_center()) |>
  fp_set_zebra_style("#EFEFEF")

