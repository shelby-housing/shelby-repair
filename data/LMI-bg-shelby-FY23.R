library(stringr)
dt <- read_excel(paste0(Sys.getenv("MY_DATA_FOLDER"), "LMISD/ACS_2015_lowmod_blockgroup_all.xlsx"))

dt <- dt |> 
  filter(State == "47" & County == "157")

LMI <- dt |> 
  janitor::clean_names() |> 
  mutate(GEOID10 = str_remove(geoid, "15000US"),
         moe_lowmod_pct = str_remove(moe_lowmod_pct, "^.{3}") |> as.numeric() / 100) |> 
  select(GEOID10, low:lowmod_pct, moe_lowmod_pct)

write_csv(LMI, "data/LMI-bg-shelby-FY23.csv")
