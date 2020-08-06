## Plot energy production of all relevant prosumers in testing period
## Author: Michael Kostmann ## Adjusted by: Anna-Lena Hock and Sabrina Daun
#Description: descriptive statistics of energy data, the data for energy production and consumption is imported and plotted

setwd("~/Documents/DEDA/Rise_of_the_prosumer/Energy_Prosumer_1_Descriptive_Statistics_of_energy_data") #adjust working directory accordingly to folder file is located in

#get data from https://github.com/QuantLet/BLEM/tree/master/data and add as subfolder to "Rise_of_the_prosumer" folder, i.e. same level as "Analysis" folder


# To reproduce our results, the provided R scripts need to be run in the order stated in the titles (1-4)


rm(list=ls())


# Load packages
packages = c("cowplot",
             "purrr", "ggplot2", "lubridate")


#--------uncomment to install packages ----------
#invisible(lapply(packages, install.packages, character.only = TRUE)) #install packages, you dont have yet
invisible(lapply(packages, library, character.only = TRUE))

# Source user-defined functions
functions = c("FUN_getTargets.R", "FUN_getData.R") #from https://github.com/QuantLet/BLEM/tree/master/BLEMevaluateMarketSim
invisible(lapply(functions, source))

# Function for easy string pasting
"%&%"     = function(x, y) {paste(x, y, sep = "")}

# Specify paths to directories containing consumer and prosumer datasets
path_c    = "../data/consumer/"
path_p    = "../data/prosumer/"

files_p    = substring(list.files(path_p, pattern = "*.csv"),
                       1, 17)[c(19, 24, 26, 30, 31, 72, 75, 83, 84, 85, 86, 89)]

# Load net production data per 15-minute time interval
prod = matrix(NA, nrow = 35040, ncol = length(files_p))
i = 0

for(id in files_p) {
  i = i+1
  prod[, i] = getTargets(path_p,
                         id,
                         return = "production",
                         min = "2017-01-01 00:00",
                         max = "2018-01-01 00:00")
}

# Vector of x-axis labels
ids = substring(files_p, 15, 17)

# Initiate list to save plots for plotting grid
plotgrids = list()

# Loop over specified producers
for(i in 1:length(files_p)){
  
  p_title =  ggdraw() + 
    draw_label("Prosumer "%&%ids[i],
               size     = 10,
               fontface = "bold")
  
  t = data.frame("time"   = seq.POSIXt(as.POSIXct("2017-01-01 00:00"),
                                       as.POSIXct("2018-01-01 00:00"),
                                       by = 900)[1:nrow(prod)],
                 "value" = prod[, i])
  
  p = ggplot(t, aes(x = time, y = value)) +
    geom_line() +
    scale_y_continuous(limits = c(0, max(prod))) +
    ylab("kWh/15 minutes") +
    xlab("timestamp") +
    theme(
      panel.background = element_rect(fill = "transparent"), # bg of the panel
      plot.background = element_rect(fill = "transparent", color = NA), # bg of the plot
      panel.grid.major = element_blank(), # get rid of major grid
      panel.grid.minor = element_blank(), # get rid of minor grid
      legend.background = element_rect(fill = "transparent"), # get rid of legend bg
      legend.box.background = element_rect(fill = "transparent") # get rid of legend panel bg
    )
  
  plotgrids[[i]] = plot_grid(p_title, p, ncol = 1, rel_heights = c(0.1, 1))
  
}

plot_grid(plotlist = plotgrids, nrow = 4, ncol = 3)
ggsave("producers_all.png", height = 8.267, width = 11.692, bg="transparent")


#-------Plot consumers' energy consumption

files_c = substring(list.files(path_c,
                               pattern = "*.csv"),
                    1, 17)[-c(13, 21, 26, 35, 46, 53, 57, 67, 76, 78, 80, 81)]

#randomcons <- list()
#randomcons <- sample(files_c, 12)
#l <- sort(c(50, 63, 55, 41, 8, 62, 34, 20, 95, 42, 4, 7)) #result from random sampling of 12 consumers


files_c_r = substring(list.files(path_c,
                               pattern = "*.csv"),
                    1, 17)[c(4,  7,  8, 20, 34, 41, 42, 50, 55, 62, 63, 95)]
# Load consumption data per 15-minute time interval
cons = matrix(NA, nrow = 35040, ncol = length(files_c_r))
i = 0

for(id in files_c_r) {
  i = i+1
  cons[, i] = getTargets(path   = path_c,
                         id     = id,
                         return = "consumption",
                         min    = "2017-01-01 00:00",
                         max    = "2018-01-01 00:00")
}





ids = substring(files_c_r, 15, 17)

# Initiate list to save plots for plotting grid
plotgrids = list()

# Loop over specified producers
for(i in 1:length(files_c_r)){
  
  p_title =  ggdraw() + 
    draw_label("Consumer "%&%ids[i],
               size     = 10,
               fontface = "bold")
  
  t = data.frame("time"   = seq.POSIXt(as.POSIXct("2017-01-01 00:00"),
                                       as.POSIXct("2018-01-01 00:00"),
                                       by = 900)[1:nrow(prod)],
                 "value" = cons[, i])
  
  p = ggplot(t, aes(x = time, y = value)) +
    geom_line() +
    scale_y_continuous(limits = c(0, max(cons))) +
    ylab("kWh/15 minutes") +
    xlab("timestamp") +
    #theme_half_open(12)
    theme(
      panel.background = element_rect(fill = "transparent"), # bg of the panel
      plot.background = element_rect(fill = "transparent", color = NA), # bg of the plot
      panel.grid.major = element_blank(), # get rid of major grid
      panel.grid.minor = element_blank(), # get rid of minor grid
      legend.background = element_rect(fill = "transparent"), # get rid of legend bg
      legend.box.background = element_rect(fill = "transparent") # get rid of legend panel bg
    )
  
  plotgrids[[i]] = plot_grid(p_title, p, ncol = 1, rel_heights = c(0.1, 1))
  
}

plot_grid(plotlist = plotgrids, nrow = 4, ncol = 3)
ggsave("consumers_all.png", height = 8.267, width = 11.692, bg="transparent")












#----- Plot Net energy production vs consumption------
path = "../data/prosumer/"

# Load data with consumption or production values
data_cons = getData(path, data = "all", return = "consumption")
data_prod = getData(path, data = "all", return = "production")

datasets_cp = c("p019_prod", "p024_prod", "p026_prod",
                "p030_prod", "p031_prod", "p072_prod", "p075_prod", "p083_prod",
                "p084_prod", "p085_prod", "p086_prod", "p089_prod")

# Specify file format to save plot (.png to facilitate transparent backgrounds)
format = ".png"

# Loop over specified datasets plot and save plots
for(i in 1: length(datasets_cp)) {
  id = datasets_cp[[i]]
  p_title4 = ggdraw() + 
    draw_label("Prosumer "%&%substr(id, 2, 4)%&%
                 ": Net energy production and consumption",
               size     = 20,
               fontface = "bold")
  
  p5 = data_prod[, c("time", eval(id))] %>%
    rename(prod := !!(id)) %>%
    select(time, prod) %>%
    
    ggplot(aes(x      = time,
               y      = prod,
                colour = "net production")) +
    geom_line(alpha = 0.85) +
    geom_line(data = data_cons,
              aes_string("time",
                         eval(gsub("prod", "cons", eval(id))),
                         color = '"net consumption"')) +
    scale_colour_manual("",
                        breaks = c("net production", "net consumption"),
                        values = c("darkblue", "red")) +
    theme(
      panel.background = element_rect(fill = "transparent"), # bg of the panel
      plot.background = element_rect(fill = "transparent", color = NA), # bg of the plot
      panel.grid.major = element_blank(), # get rid of major grid
      panel.grid.minor = element_blank(), # get rid of minor grid
      legend.spacing.y = unit(0, "mm"), 
      axis.title.x = element_text(size=20),
      axis.title.y = element_text(size=20),
      axis.text.x = element_text(size=16),
      axis.text.y = element_text(size=16),
      aspect.ratio = 0.5, axis.text = element_text(colour = 1, size = 6),
      legend.background = element_blank(),
      legend.title = element_blank(),
      legend.position = "none", 
    ) +
    scale_y_continuous(limits = c(0, 4)) +
    ylab("kWh per 3 minutes") +
    xlab("timestamp") 
  
 plotgrids[[i]] = 
    plot_grid(p_title4, p5, ncol = 1, rel_heights = c(0.2, 1))
  i=i+1
}

plot_grid(plotlist = plotgrids, nrow = 4, ncol = 3)
ggsave("net_prod_all.png", height = 16.534, width = 23.384, bg="transparent")

