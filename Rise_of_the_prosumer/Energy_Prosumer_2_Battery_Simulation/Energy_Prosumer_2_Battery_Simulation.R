# Calculate Net Energy Production by Prosumers vs. Consumption by Consumers
# Aggregate and determine Net Load (= Consumption - Production) to find optimal battery size
# Description: net energy load is calculated by subtracting aggregate consumption from aggregate production by prosumers. Then, a simulation of six different plausible battery sizes is done.


setwd("~/Documents/DEDA/Rise_of_the_prosumer/Energy_Prosumer_2_Battery_Simulation") #adjust working directory accordingly to folder file is located in

#get data from https://github.com/QuantLet/BLEM/tree/master/data and add as subfolder to "Rise_of_the_prosumer" folder, i.e. same level as "Analysis" folder




rm(list=ls())



# Load packages
packages = c("cowplot",
             "purrr", "ggplot2", "lubridate")
invisible(lapply(packages, library, character.only = TRUE))

# Source user-defined functions

functions = c("FUN_getTargets.R", "FUN_getData.R") #from https://github.com/QuantLet/BLEM/tree/master/BLEMevaluateMarketSim

invisible(lapply(functions, source))

# Function for easy string pasting
"%&%"     = function(x, y) {paste(x, y, sep = "")}

# Specify paths to directories containing consumer and prosumer datasets
path_c    = "../data/consumer/"
path_p    = "../data/prosumer/"

# load all plausible consumer data sets
files_c = substring(list.files(path_c,
                               pattern = "*.csv"),
                    1, 17)[-c(13, 21, 26, 35, 46, 53, 57, 67, 76, 78, 80, 81)]

# Balanced supply and demand
files_p = substring(list.files(path_p, pattern = "*.csv"),
                    1, 17)[c(19, 24, 26, 30, 72, 75, 83, 89)]


# Load production data per 15-minute time interval
p_prod = matrix(NA, nrow = 35040, ncol = length(files_p))
i = 0

for(id in files_p) {
  i = i+1
  p_prod[, i] = getTargets(path_p,
                         id,
                         return = "production",
                         min = "2017-01-01 00:00",
                         max = "2018-01-01 00:00")
}
write.csv(p_prod, "../output/actual/p_prod.csv")
 
  
# Load consumption data per 15-minute time interval

# selfconsumption of prosumers
p_cons = matrix(NA, nrow = 35040, ncol = length(files_p))
i = 0

for(id in files_p) {
  i = i+1
  p_cons[, i] = getTargets(path_p,
                           id,
                           return = "consumption",
                           min = "2017-01-01 00:00",
                           max = "2018-01-01 00:00")
}
write.csv(p_cons, "../output/actual/p_cons.csv")



netprod = matrix(NA, nrow = 35040, ncol = length(files_p))
i = 0
for(id in files_p) {
  i = i+1
  netprod[, i] = p_prod[,i]-p_cons[,i]
}
write.csv(netprod, "../output/actual/netprod.csv")

# consumption of consumers
cons = matrix(NA, nrow = 35040, ncol = length(files_c))
i = 0

for(id in files_c) {
  i = i+1
  cons[, i] = getTargets(path   = path_c,
                         id     = id,
                         return = "consumption",
                         min    = "2017-01-01 00:00",
                         max    = "2018-01-01 00:00")
}
write.csv(cons, "../output/actual/cons.csv")


# Calculate aggregate production at every timestep (column 1), 
# aggregate prosumer consumption (column 2), 
# aggregate consumer consumption (column 3)

agg = matrix(NA, nrow = 35040, ncol = 3)
agg[,1] = rowSums(p_prod, na.rm = TRUE)
agg[,2] = rowSums(p_cons, na.rm = TRUE)
agg[,3] = rowSums(cons, na.rm = TRUE)
write.csv(agg, "../output/actual/aggregate_production_and_consumption.csv")




# Compute net load at every time step (column 1), accumulated over time (col2) to determine max 

netload = matrix(NA, nrow = 35040, ncol = 2)
netload[,1] = agg[,2] + agg[,3] - agg[,1]

for (i in 1:nrow(netload)) {
  if (i==1) {netload[i,2]=netload[i,1]}
  else {
    prev = netload[i-1,2]
    nl = netload[i,1]
    netload[i,2]=prev+nl}
}
write.csv(netload, "../output/actual/netload.csv")

summary(netload) #to determine plausible battery size -> let's try different battery sizes of 100, 200, 500, 1000, 2000, 1090 kWh


# Battery  simulation with 6 different sizes

size <- c(100, 200, 500, 1000, 2000, 1090)

battery = matrix(NA, nrow = 35040, ncol = 3*length(size))

for (s in 1:length(size)){
  l= 3*s-2 #left column: number of kWh battery is charged with
  m= 3*s-1 #middle:      SOC = number of kWh/ total size of battery
  r= 3*s   #right:       number of kWh battery was charged (+), discharged (-)
  beg= size[s]/2            # assumption: beginning SOC of battery is 50%
  min_size = 0.05*size[s]   # assumption: battery does not get discharged to less than 5% of total battery capacity
  max_size = 0.95*size[s]   # assumption: battery does not get charged to more than 95% of total battery capacity
  for (i in 1:nrow(battery)) {
    if (i==1) {battery[i,l]=beg-netload[i,1]
        if (battery[i,l] >= max_size) {battery[i,l]=max_size} 
          else if (battery[i,l] <= min_size) {battery[i,l]=min_size}
          else {battery[i,l]}          
      }
    else {
      prev = battery[i-1,l]
      nl = netload[i,1]
      battery[i,l]=prev-nl
        if (battery[i,l] >= max_size) {battery[i,l]=max_size} 
          else if (battery[i,l] <= min_size) {battery[i,l]=min_size}
          else {battery[i,l]}}
  battery[i,m] = battery[i,l]/size[s]
  
  if (i==1) {battery[i,r]=-netload[i,1]}
  else {battery[i,r]= battery[i,l] - battery[i-1,l]}
}}


write.csv(battery, "../output/actual/battery_simulation.csv")


plotgrids = list()
i = 1
for(i in 1: length(size)) {
  id = size[[i]]
  p_title = ggdraw() + 
    draw_label("Battery size of "%&% id %&%
                 "kWh: State of Charge (SOC)",
               size     = 16,
               fontface = "bold")

  q = 3*i-1
  
  t = data.frame("time"   = seq.POSIXt(as.POSIXct("2017-01-01 00:00"),
                                       as.POSIXct("2018-01-01 00:00"),
                                       by = 900)[1:nrow(battery)],
                 "value" = battery[, q])
  
  p = ggplot(t, aes(x = time, y = value)) +
    geom_line() +
    geom_smooth()+
    scale_y_continuous(limits = c(0, 1)) +
    ylab("SOC") +
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

plot_grid(plotlist = plotgrids, nrow = 4, ncol = 2)
ggsave("battery_SOC_smooth.png", height = 16.534, width = 23.384, bg="transparent")





