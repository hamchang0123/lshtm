#raw data
death_1981 <- c(863, 1413, 1318, 535)
pop_1981 <- c(6514368, 7061791, 5799671, 2067840)
death_2007 <- c(783, 1875, 1043, 384)
pop_2007 <- c(6112223, 8685978, 6723833, 2929565)
death_2013 <- c(797, 2104, 1479, 478)
pop_2013 <- c(6344337, 8665423, 7447596, 3295573)

tbl <- data.frame(death_1981, pop_1981, death_2007, pop_2007, death_2013, pop_2013)
rownames(tbl) <- c('15-29', '30-49', '50-69', '70+')
colnames(tbl) <- c('deaths_1981', 'pop_1981', 'deaths_2007', 'pop_2007', 'deaths_2013', 'pop_2013')
tbl <- rbind(tbl, total=colSums(tbl))
tbl

#crude rate
crude <- c(tbl[5,1]/tbl[5,2], tbl[5,3]/tbl[5,4], tbl[5,5]/tbl[5,6])*1E5
crude

#age-specific rates
rate_15_29=c(tbl[1,1]/tbl[1,2], tbl[1,3]/tbl[1,4], tbl[1,5]/tbl[1,6])*1E5
rate_30_49=c(tbl[2,1]/tbl[2,2], tbl[2,3]/tbl[2,4], tbl[2,5]/tbl[2,6])*1E5
rate_50_69=c(tbl[3,1]/tbl[3,2], tbl[3,3]/tbl[3,4], tbl[3,5]/tbl[3,6])*1E5
rate_70=c(tbl[4,1]/tbl[4,2], tbl[4,3]/tbl[4,4], tbl[4,5]/tbl[4,6])*1E5

#rate table
tbl2 <- data.frame(
  crude = round(crude, 2),
  rate_15_19 = round(rate_15_29, 2),
  rate_30_49 = round(rate_30_49, 2),
  rate_50_69 = round(rate_50_69, 2),
  rate_70 = round(rate_70, 2)
)
  #combining the elements by column

tbl2 <- t(tbl2) 
  #transpose so that years go on top

colnames(tbl2) <- c('1981', '2007', '2013')
tbl2

#age-adjusted rates
std_pop <- c(17500, 27500, 25000, 14000)
std_pop[5] <- sum(std_pop)
  # total number of population 
std_pop

adjrate_15_29=c(rate_15_29[1], rate_15_29[2], rate_15_29[3])*std_pop[1]/1E5
adjrate_30_49=c(rate_30_49[1], rate_30_49[2], rate_30_49[3])*std_pop[2]/1E5
adjrate_50_69=c(rate_50_69[1], rate_50_69[2], rate_50_69[3])*std_pop[3]/1E5
adjrate_70=c(rate_70[1], rate_70[2], rate_70[3])*std_pop[4]/1E5

#age-adjusted rate table
tbl3 <- data.frame(
  adjrate_15_29=round(adjrate_15_29, 2),
  adjrate_30_49=round(adjrate_30_49, 2),
  adjrate_50_69=round(adjrate_50_69, 2),
  adjrate_70=round(adjrate_70, 2)
)
tbl3 <- t(tbl3)
colnames(tbl3) <- c('1981', '2007', '2013')

tbl3 <- rbind(tbl3, total=round(colSums(tbl3),3))
tbl3 <- rbind(tbl3, age_adjusted=round((tbl3['total',]/std_pop[5])*1E5, 1))

tbl3
