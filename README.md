# Repository overview

This GitHub repository contains all relevant data and code to replicate the results of the paper "[Assessing the emergence time of SARS-CoV-2
zoonotic spillover](https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0301195)".

The structure of this repository follows the following logic:
- **Raw data** : contains the multifasta sequences used for each dataset explored in the paper. The collection date of each genetic sequence used for the temporal analyses are recorded in this folder as well.
  
- **Figures**: contains the relevant inputs and code related to each figure in the publication. Please note that the core Bayesian phylogenetic analyses were performed with the BEAST v2.7.5 software. The relevant outputs used in the generation of the figures are provided in this folder.*
  
- **Supplementary information**: Contains other relevant information related to the methodology of this paper, such as the BEAST2 parameters, the phylogenetic tree parameters and the Marginal likelihood and Bayes factors results.


*Please note that the .trees output of the BEAST analyses combined by LogCombiner are too large to be posted on this repo due to GitHub's file size limits. They are available on demand by contacting the corresponding author of the paper. The .tree files produced by TreeAnnotator are located in Figures/Data/tree. 


# Exact procedure used to reconstruct phylogenetic trees in Figures 3 to 5

