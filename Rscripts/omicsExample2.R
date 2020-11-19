# omicsExample2.R
#
# Code for Example 2 for QucikIntro2R: 92 protein serum levels for cases and 
# controls, with a quality flag, measured on a chip (synthetic data)
# 
# Alexander.Ploner@ki.se 2020-11-19

# We assume that the data files are in the current working directory
# Use setwd() as required

# Read the phenotypic data from an Excel file
# as.list() is necessary so that R recognizes the stringsAsFactors-flag
library(readxl)
pheno <- as.data.frame( as.list(read_xlsx("covar.xlsx")) , stringsAsFactors = TRUE)
# Read the protein data (delimited text file)
prot  <- read.table("prot.txt", header = TRUE, check.names = FALSE, stringsAsFactors = TRUE)

# Look at the phenotypic data: seems ok
head(pheno)
head(prot)

# Structure of the data: phenotypic data is rows = subjects,
# protein data has columns = subjects
str(pheno)
str(prot)

# Simple numerical summaries of pheno data
summary(pheno)

# Let's look at a heatmap of the protein data
# Note that heatmap requires a matrix, not a data frame,
# so we have to convert
# Proteins come in two distinct clusters, subjects have
# 3-4 main clusters and one outgroup
heatmap(as.matrix(prot))

# Now we run a t-test for all proteins, comparing the means
# of cases and controls (variable tp) via a t-test

# We use a very R-typical technique: we can _apply_ a function 
# (here: t.test) to all rows (1) or all columns (2) of a data 
# matrix or data frame
# Here, each row of prot corresponds to a protein
ttests <- apply(prot, 1, function(x) t.test(x ~ pheno$tp))

# The result is a *list* of t-tests
head(ttests, 3)
ttests[[2]]
ttests$GZMB

# We use _lapply_ to extract the t-statistic and p-value from 
# the list of t-tests
tstat <- unlist( lapply(ttests, function(x) x$statistic) )
pval  <- unlist( lapply(ttests, function(x) x$p.value) )

# Let's look at the results: many large t-statistics, many small p-values
hist(tstat)
hist(pval)

# How many are formally significant at the 5% level?
table(pval < 0.05)
# Clearly, we should do some adjustments here; we choose the 
# false discovery rate (fdr)
pval_adj <- p.adjust(pval, "fdr")
table(pval_adj < 0.05)
# These are the identifiers of the significant proteins
rownames(prot)[pval_adj < 0.05]

# Let's roll this into a data frame
res <- data.frame(Protein = rownames(prot), tStat = tstat, FDR = pval_adj, row.names = NULL)
# Sort by significance
res <- res[order(res$FDR), ]
head(res)
