# omicsExample1.R
#
# Code for Example 1 for R intro in course Omics Data Analysis: a simple 
# qPCR data set (not very omic, but we have to start somewhere)
# 
# Alexander.Ploner@ki.se 2020-11-19

# We assume that the file is in the same directory as the script
setwd("~/Desktop/OmicsDataAnalysis/Data/")
dat <- read.table("qPCR.txt", header = TRUE, stringsAsFactors = TRUE)

# Look at the top of the data: seems ok
head(dat)

# Structure of the data: one grouping variable, four numeric variables
str(dat)

# Simple numerical summaries of the data
summary(dat)

# We want to study how DeltaCt (difference in time until detection threshold
# between sequence of interest and reference sequence) differs between
# treated / controls
# Let's start by looking at the distribution of DeltaCt
# Hm, seems like we have a fairly large value
hist(dat$DeltaCt)

# Direct comparison: treatment vs controls
# Looks like treated samples have lower DeltaCt, 
# ergo higher level of SOI
boxplot(DeltaCt ~ Sample, data = dat)

# Statistical test: is DeltaCt on average the same?
# t-test without equal variance assumption (i.e. Welch t-test)
# Null hypothesis: same average DeltaCt in both groups
# Based on p-value and confidence interval, we can reject this
t.test(DeltaCt ~ Sample, data = dat)

# Sensitivity analysis: does our result depend on the one 
# large values among the controls? We re-run without that 
# observation
dat2 <- subset(dat, DeltaCt < 4)
str(dat2) # We removed exactly one observation
# Yes, this holds up well; the original result (to be reported)
# is not unduly affected by just one observation
t.test(DeltaCt ~ Sample, data = dat2)

