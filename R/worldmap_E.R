#map of countries beginning with a certain letter in their local language

#credit to https://statsandr.com/blog/world-map-of-visited-countries-in-r/


#load packages ----

library(highcharter)
library(dplyr)
library(maps)

# get data ----

#dataset called iso3166 from the {maps} package and rename it dat

dat <- iso3166

names(dat)

#We rename the variable a3 by iso-a3:

dat <- rename(dat, "iso-a3" = a3); names(dat)


#wrangle data ----

#selected

countries_selected <- c("IRL", "ESP", "GRC", "SWZ")
dat$select <- ifelse(dat$`iso-a3` %in% countries_selected, 1, 0)

#endonym
known_endonyms <- data.frame(iso.a3 = c("IRL", "ESP", "GRC", "SWZ"), 
                             endonym = c("Éire", "España", "Ellinikí Dimokratía", "Eswatini"))

dat <- dat %>% left_join(known_endonyms, by = c("iso-a3" = "iso.a3"))

# draw map ----

map_nolab <- hcmap(
  map = "custom/world", # high resolution world map
  data = dat, # name of dataset
  joinBy = "iso-a3",
  value = "select",
  showInLegend = FALSE, # hide legend
  nullColor = "#DADADA",
  download_map_data = TRUE) %>%
  hc_mapNavigation(enabled = TRUE) %>%
  hc_legend("none") %>%
  hc_title(text = "World map") # title

map_nolab

map_endo <- hcmap(
  map = "custom/world", # high resolution world map
  data = dat, # name of dataset
  joinBy = "iso-a3",
  value = "select",
  showInLegend = FALSE, # hide legend
  nullColor = "#DADADA",
  download_map_data = TRUE,   
  dataLabels = list(enabled = TRUE, format = "{point.endonym}")
) %>%
  hc_mapNavigation(enabled = TRUE) %>%
  hc_legend("none") %>%
  hc_title(text = "World map") # title

map_endo



