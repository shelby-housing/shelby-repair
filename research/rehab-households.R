path_onedrive <- function(filepath) {
  one_drive <- "~/OneDrive - Shelby County Government/General - Lead + Rehab Work/"
  paste0(one_drive, filepath)
}

raw_path <- path_onedrive("Rehab Cases by Program Year.xlsx")

library(readxl)
library(dplyr)

excel_sheets(raw_path)

raw <- read_excel(raw_path, sheet = "Queue", skip = 1) |>
  janitor::clean_names() |> 
  select(neighborly_id, rank, location, district, parcel,
         pt_age, pt_ami, pt_burden, pt_apr, vi_count, pt_lmi,
         pt_total, address)

raw_23 <- read_excel(raw_path, sheet = "PY23") |>
  janitor::clean_names()

library(sf)

# hsg_sf <- function(place, geom) {
#   
#   p <- paste0("../data/hsg/geom/", place, "/", geom, "/", geom, ".shp")
#   sf::read_sf(p)
#   
# }
# 
# hsg_adb <- function(adb_tbl) {
#   f <- paste0("../data/hsg/data-raw/adb/2023/", adb_tbl, ".txt")
#   read_csv(f)
# }

raw_commish <- hsg_sf("shelby", "commish")
# raw_parcels <- hsg_sf("shelby", "parcel") |> 
#   right_join(raw, by = c("parcel_id" = "parcel"))
# 
# par_dist <- raw_parcels |> 
#   st_join(raw_commish) |> 
#   st_centroid()
# write_sf(par_dist, "research/geo/rehab-applicants-by-commish.shp")
raw <- read_sf("research/geo/rehab-applicants-by-commish.shp")

library(ggplot2)

ggplot() +
  geom_sf(data = raw_commish, aes(fill = "district")) +
  geom_sf(data = par_dist, color = "orangered", size = 1.5)
  

