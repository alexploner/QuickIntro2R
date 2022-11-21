# omicsExample2.R
#
# Code for Example 2 for R intro in course Omics Data Analysis: 92 protein
# levels for cases and controls, with a quality flag, measured on a chip
# (synthetic, almost real data)
#
# Alexander.Ploner@ki.se 2022-11-20

# We assume that the data files are in the working directory
library(readxl)
pheno <- as.data.frame( read_xlsx("covar.xlsx") )
prot  <- read.table("prot.txt", header = TRUE, check.names = FALSE, stringsAsFactors = TRUE)

# Look at the top of the phenotypic data: seems ok
head(pheno)

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

# Flip the rows & columns of the protein matrix so
# that they are in the same order as the phenotypic data
# Not necessary, but easier to visualize
flip_prot <- t(prot)
str(flip_prot)

# Now we run a t-test for all proteins, comparing the means
# of cases and controls (variable tp) via a t-test

# We use a very R-typical technique: we can _apply_ a function
# (here: t.test) to each row or column of a data matrix or data frame
ttests <- apply(flip_prot, 2, function(x) t.test(x ~ pheno$tp))
# The result is a *list* of t-tests
head(ttests)
# We use _lapply_ to extract the t-statistic and p-value from
# the list of t-tests
tstat <- unlist( lapply(ttests, function(x) x$statistic))
pval  <- unlist( lapply(ttests, function(x) x$p.value))

# Let's look at the results
summary(tstat)
summary(pval)

# How many are formally significant at the 5% level?
table(pval < 0.05)
# Clearly, we should do some adjustments here; we choose the
# false discovery rate (fdr)
pval_adj <- p.adjust(pval, "fdr")
table(pval_adj < 0.05)
# These are the identifiers of the significant proteins
rownames(prot)[pval_adj < 0.05]

#' Let's roll this into a data frame, sorted by significance
res <- data.frame(Protein = rownames(prot), tStat = tstat, FDR = pval_adj)
res <- res[order(res$FDR), ]
# Remove ugly row names (optional)
rownames(res) <- 1:nrow(res)
head(res)

