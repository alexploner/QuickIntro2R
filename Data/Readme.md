# Example data for QuickIntro2R

## Example 1: qPCR in A. thaliana

Filename: qPCR.txt

Relative gene expression of an (unspecified) target gene relative to a
reference gene, for 12 treated and 12 untreated plants, measured in 
three replicates at four concentrations each.

Table 2 in <https://www.ncbi.nlm.nih.gov/pmc/articles/PMC1395339>

Variables:

* Sample:   treated / control indicator
* Con:      concentration
* DeltaCt:  measured DeltaCt between target and reference
  
  
## Example 2: protein serum levels in pancreatitis patients and controls

Filenames:

* prot.txt
* covar.xlsx
  
Case-control study in 192 participants, who either suffer from 
pancreatitis or are healthy controls. Investigators recorded for all
participants a unique study ID, age, sex, serum levels of 92 proteins,
and a quality flag for the serum sample (I to V, with I best).

Protein levels are recorded in prot.txt, a blank-separated text file
with rows corresponding to proteins and columns to participants. The 
first row contains the unique study ID, the first column the protein
name.

Demographic and quality variables are recorded in covar.xlsx, an Excel
file with one sheet. Rows correspond to participants, with columns

* uenr: study ID
* tp: case-control indicator
* age: participant age at serum collection in years
* sex: participant sex as male (m) and female (f)
* flag: quality flag for the serum sample
