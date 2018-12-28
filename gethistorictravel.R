yrs = seq(from = 1981, to = 2011, by = 10)
yr = yrs[3]

for(i in seq_along(yrs)) {
yr = yrs[i]
lad_sf = readRDS(paste0("~/ITSLeeds/historictraveldata/lad_", yr, ".Rds"))
lad = st_set_geometry(lad_sf, NULL)
lad = select_if(lad, is.numeric)

modes_min = c(
  car_driv = sum(lad %>% select(starts_with("car_driv")), na.rm = T),
  car_pass = sum(lad %>% select(starts_with("car_p")), na.rm = T),
  pt = sum(lad %>% select(matches("bus|br|under|rail|train")), na.rm = T),
  walk = sum(lad %>% select(matches("foot|walk")), na.rm = T),
  cycle = sum(lad %>% select(matches("pedal|bicycle")), na.rm = T),
  mfh = sum(lad %>% select(matches("home")), na.rm = T)
)
modes_min = c(
  modes_min,
  other = sum(lad, na.rm = TRUE) - sum(modes_min)
)
sum(lad, na.rm = TRUE) == sum(modes_min)
m = data_frame(
  year = yr,
  mode = names(modes_min),
  number = modes_min,
  proportion = modes_min / sum(modes_min)
  )
if(yr == 1981)
  my = m else
    my = rbind(m, my)
}
my
write_csv(my, "modes.csv")

# other stuff -------------------------------------------------------------
# 
# sas_sf = st_as_sf(sas, coords = c("Easting", "Northing"), crs = 27700)
# # zi = zones %>% filter(grepl(pattern = "^N", lau118cd))
# zones = ukboundaries::lad2018 %>%
#   filter(!grepl(pattern = "^N", lau118cd)) %>% 
#   st_transform(27700)