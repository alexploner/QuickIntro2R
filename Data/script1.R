# script1.R
#
# Example script for Omics course
#
# Alexander.Ploner@ki.se 2020-11-19

# Setup
setwd("Z:/OmicsDataAnalysis/Data")
ex1 <- read.table("qPCR.txt", header = TRUE, stringsAsFactors = TRUE)

# Check: seems to have worked
summary(ex1)

# There seems to be a difference, but also one rather large 
# control value
boxplot(DeltaCt ~ Sample, ex1)

# The mean difference seen in the boxplots is statisticall
# highly signficant
t.test(DeltaCt ~ Sample, ex1)

# Sensitivity analysis: what happens if we exclude the 
# potential outlier? Actually, even more significant:
# the mean difference is smaller, but also the standard
# deviation in the control group, leading to a larger
# test statistic!
ex2 <- subset(ex1, DeltaCt < 4)
summary(ex2)
t.test(DeltaCt ~ Sample, ex2)
