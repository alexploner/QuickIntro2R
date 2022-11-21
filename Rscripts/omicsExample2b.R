# omicsExample2b.R
#
# Code for Example 2 for R intro in course Omics Data Analysis: 92 protein
# levels for cases and controls, with a quality flag, measured on a chip
# (synthetic, almost real data)
#
# This is an add-on, and assumes that omicsExample2.R has already been run
# in the same R session (load files etc.)
#
# https://www.bioconductor.org/packages/release/data/annotation/html/Homo.sapiens.html
# for how to install the annotation packages - warning: this is quite a bit of data,
# and download may be slow.
#
# Alexander.Ploner@ki.se 2022-11-20

# These are the protein names (sorted by significance)
pn <- as.character(res$Protein)
pn

# Load the annotated human database
library(Homo.sapiens)
keytypes(Homo.sapiens)  ## What can we map?
select(Homo.sapiens, keys = pn, keytype = "SYMBOL", columns=c("ENTREZID", "GENENAME"))

# Hm, some of these symbols look weird
pn2 <- sub("_", "", pn)
select(Homo.sapiens, keys = pn2, keytype = "SYMBOL", columns=c("ENTREZID", "GENENAME"))

# Add this to the results
ann  <- select(Homo.sapiens, keys = pn2, keytype = "SYMBOL", columns=c("ENTREZID", "GENENAME"))
res2 <- cbind(res, ann)
head(res2)
