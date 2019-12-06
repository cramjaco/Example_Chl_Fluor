## Plots chlorophyll fluorescence at the 2017 station p2

library(tidyverse)
library(oce)
ExFluo <- read_csv("ExFluo.csv")

## dealing with time, trim to just station p2

 t0 = as.POSIXct("2017-01-08 03:54:47 UTC")
 t1 = as.POSIXct("2017-01-14 03:54:47 UTC")
 
ExFluo <- ExFluo %>% filter(time > t0 & time < t1) %>% filter(depth < 180)
# t1 = max(ExFluo$time) + 1 * 60^2
# t0 = as.POSIXct(round(min(subset(ctdamot, variable == 'nh4')$time) - 2 * 60^2, 'day'))
# reaonsalbe intervals for x axis
 tseq = seq(from = round(t0, 'day'), to = round(t1, 'day'), by = 86400/2)

## plot of chlorophyl fluorescence vs depth and time
fluamstoxyP <- ggplot(ExFluo, aes(time, depth)) +
  # actually make the image
    geom_tile(aes(fill = log10(value))) + 
    scale_y_reverse(limits = c(180, 0), breaks = seq(from = 0, to = 180, by = 20)) +
    scale_x_datetime(
      limits = c(t0,t1), # redundant, but in case you didn't trim the times earleir
                     breaks = tseq,
                     labels = scales::date_format(format = '%b-%d: %H%M', tz = "US/Pacific")
                     ) +
  # adjust the colors for the image
  scale_fill_gradientn(colours = c("blue4", "blue1", "white", "green1", "green4"),
                       values = oce::rescale(c(-1, -.5, -.2 ,  .05, .5)), name = "Chlorophyll Fluorescence") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))
fluamstoxyP


