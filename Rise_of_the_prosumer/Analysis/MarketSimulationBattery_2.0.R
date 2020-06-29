

rm(list=ls())
# Function for easy string pasting
"%&%"     = function(x, y) {paste(x, y, sep = "")}

#determine SDR at every time step

path = "output/actual"

files <- list.files(path, pattern="*.csv", full.names=TRUE)
list2env(
  lapply(setNames(files, make.names(substr(gsub("*.csv$", "", files), 15, 50))), 
         read.csv), envir = .GlobalEnv)

size <- c(100, 200, 500, 1000, 2000, 1090
          #5000, 10000
)




#interaction with the grid

grid = matrix(NA, nrow = 35040, ncol = length(size))
# <0 means sold to grid, >0 means bought from grid
for (s in 1:length(size)){
  q = 3*s+1
  for (i in 1:nrow(grid)) {
    grid[i,s] = netload[i,2] + battery_simulation[i, q]
  }
}

write.csv(grid, "output/actual/interaction_with_grid.csv")



#demand covered by production of the microgrid

E_M = matrix(NA, nrow = 35040, ncol = length(size))
for (s in 1:length(size)){
  q = 3*s+1
  for (i in 1:nrow(E_M)) {
    if (netload[i, 2]>=0) {E_M[i,s] = aggregate_production_and_consumption[i,2]}
    else {E_M[i,s] = aggregate_production_and_consumption[i,3] + aggregate_production_and_consumption[i,4]}
  }
}

write.csv(E_M, "output/actual/demand_covered_by_community_grid.csv")


#battery charging power

P_BC = matrix(NA, nrow = 35040, ncol = length(size))
for (s in 1:length(size)){
  q = 3*s+1
  for (i in 1:nrow(P_BC)) {
    if (battery_simulation[i,q]<=0) {P_BC[i,s] = 0}
    else {P_BC[i,s] = battery_simulation[i,q]}
  }
}

write.csv(P_BC, "output/actual/charging_power.csv")


#battery discharging  power

P_DC = matrix(NA, nrow = 35040, ncol = length(size))
for (s in 1:length(size)){
  q = 3*s+1
  for (i in 1:nrow(P_DC)) {
    if (battery_simulation[i,q]>=0) {P_DC[i,s] = 0}
    else {P_DC[i,s] = -battery_simulation[i,q]}
  }
}

write.csv(P_DC, "output/actual/discharging_power.csv")


SDR = matrix(NA, nrow = 35040, ncol = length(size))

for (s in 1:length(size)){
  q = 3*s+1
  for (i in 1:nrow(netload)) {
    num = aggregate_production_and_consumption[i,2]-P_BC[i,s]+P_DC[i,s]
    denum = aggregate_production_and_consumption[i,3]+aggregate_production_and_consumption[i,4]
    SDR[i,s] = num/denum
    if (num == 0) {SDR[i,s]=0}
    else if (denum == 0) {SDR[i,s]=0}
    else {SDR[i,s]}
  }
}

write.csv(SDR, "output/actual/SDR.csv")

# Determine Prices
# first column: Pr_sell at time t
# second column: Pr_buy at time t


price = matrix(NA, nrow = 35040, ncol = 2*length(size))
lambda_buy = 0.3137 #typical price for buying one kWh from the grid in Germany
lambda_sell = 0.1196 # feed in tariff for one kWh to the grid in Germany
lambda = 0.01 #compensation for prosumers

for (s in 1: length(size)){
  sell = 2*s-1
  buy = 2*s
  for (i in 1:nrow(price)) {
    if (SDR[i,s] >= 1) {
      price[i,sell] = lambda_sell + lambda / SDR[i,s]
      price[i,buy] = lambda_sell + lambda
    }
    else {
      price[i,sell] = ((lambda_sell + lambda)*lambda_buy)/((lambda_buy - lambda_sell - lambda) * SDR[i,s] + lambda_sell + lambda)
      price[i,buy] = price[i,sell] * SDR[i,s] + lambda_buy * (1-SDR[i,s])
    }
  }
}

write.csv(price, "output/actual/Sell_Buy_Price.csv")











#Self-consumption of the grid
#The community’s self-consumption is defined as the ratio between the PV energy which is used by the community 
#(including the electric loads and energy used for charging batteries) and the overall PV generation

self_cons = matrix(NA, nrow = 35040, ncol = length(size))
for (s in 1:length(size)){
  q = 3*s+1
  for (i in 1:nrow(self_cons)) {
    num = E_M[i,s] + P_BC[i,s]
    denum = aggregate_production_and_consumption[i,2]
    self_cons [i,s] = num/ denum
  }
}

write.csv(self_cons, "output/actual/self_consumption.csv")


plotgrids = list()
i = 1
for(i in 1: length(size)) {
  id = size[[i]]
  p_title = ggdraw() + 
    draw_label("Battery size of "%&% id %&%
                 "kWh: self-consumption rate",
               size     = 16,
               fontface = "bold")
  
  t = data.frame("time"   = seq.POSIXt(as.POSIXct("2017-01-01 00:00"),
                                       as.POSIXct("2018-01-01 00:00"),
                                       by = 900)[1:nrow(self_cons)],
                 "value" = self_cons[,i])
  
  p = ggplot(t, aes(x = time, y = value)) +
    geom_line() +
    geom_smooth()+
    scale_y_continuous(limits = c(0, 1)) +
    ylab("self-consumption rate") +
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
ggsave("output/actual/graphs/smoothed_self-consumption_rate_2.png", height = 16.534, width = 23.384, bg="transparent")


#Self-sufficiency of the grid

#Self-sufficiency of a community describes the share of load that is supplied by the PV battery systems. 
#This includes the load supplied by the PV systems and the energy discharged from batteries.

self_suff = matrix(NA, nrow = 35040, ncol = length(size))
for (s in 1:length(size)){
  q = 3*s+1
  for (i in 1:nrow(self_suff)) {
    num = E_M[i,s] + P_DC[i,s]
    denum = aggregate_production_and_consumption[i,3] + aggregate_production_and_consumption[i,4]
    self_suff [i,s] = num/ denum
  }
}

write.csv(self_suff, "output/actual/self_sufficiency.csv")


plotgrids = list()
i = 1
for(i in 1: length(size)) {
  id = size[[i]]
  p_title = ggdraw() + 
    draw_label("Battery size of "%&% id %&%
                 "kWh: self-sufficiency rate",
               size     = 16,
               fontface = "bold")
  
  t = data.frame("time"   = seq.POSIXt(as.POSIXct("2017-01-01 00:00"),
                                       as.POSIXct("2018-01-01 00:00"),
                                       by = 900)[1:nrow(self_suff)],
                 "value" = self_suff[,i])
  
  p = ggplot(t, aes(x = time, y = value)) +
    geom_line() +
    geom_smooth()+
    scale_y_continuous(limits = c(0, 1)) +
    ylab("self-sufficiency rate") +
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
ggsave("output/actual/graphs/smoothed_self-sufficiency_rate_2.png", height = 16.534, width = 23.384, bg="transparent")



# Cost of community energy

C_P2P = matrix(NA, nrow = 35040, ncol = 2*length(size))
for (s in 1:length(size)){
  q = 3*s+1
  l = 2*s-1
  r = 2*s
  if (grid[i,s] <= 0) {C_P2P[,l] = lambda_buy*(- grid[i,s])}
  else {C_P2P[,l] = -lambda_sell* grid[i,s]}
  for (i in 1:nrow(C_P2P)) {
    if (i==1) {C_P2P[i,r]=C_P2P[i,l]}
    else {
      prev = C_P2P[i-1,r]
      nl = C_P2P[i,l]
      C_P2P[i,r]=prev+nl}
  }
}


write.csv(C_P2P, "output/actual/community_cost_P2P.csv") 


#Energy bills of individual customers








consumption = matrix(NA, nrow = 35040, ncol = 1)
consumption[,1] = aggregate_production_and_consumption[,3] + aggregate_production_and_consumption[,4]

plotgrids = list()
i = 1
for(i in 1: length(size)) {
  id = size[[i]]
  p_title = ggdraw() + 
    draw_label("Battery size of "%&% id %&%
                 "kWh",
               size     = 16,
               fontface = "bold")
  
  q = 3*i-1
  
  t = data.frame("time"   = seq.POSIXt(as.POSIXct("2017-01-01 00:00"),
                                       as.POSIXct("2017-01-02 00:00"),
                                       by = 900)[1:96],
                 "value" = consumption[,1])
  
  p = ggplot(t, aes(x = time)) +
    geom_area( aes(y = E_M[,s]+P_BC[,s]), color="green") +
    geom_area( aes(y = E_M[,s]+P_DC[,s]), color="blue") +
    geom_area( aes(y = grid[,s]), color="grey") +
    geom_line( aes(y = value), color="black") +
    geom_area( aes(y = E_M[,s]), color="yellow") +
    scale_y_continuous(limits = c(0, 30)) +
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
ggsave("output/actual/graphs/P2P_energy_sharing.png", height = 16.534, width = 23.384, bg="transparent")










