# Repository overview

This GitHub repository contains all relevant data and code to replicate the results of the paper "[Assessing the emergence time of SARS-CoV-2
zoonotic spillover](https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0301195)".

The structure of this repository follows the following logic:
- **Raw data** : contains the multifasta sequences used for each dataset explored in the paper. The collection date of each genetic sequence used for the temporal analyses are recorded in this folder as well.
  
- **Figures**: contains the relevant inputs and code related to each figure in the publication. Please note that the core Bayesian phylogenetic analyses were performed with the BEAST v2.7.5 software. The relevant outputs used in the generation of the figures are provided in this folder.*
  
- **Supplementary information**: Contains other relevant information related to the methodology of this paper, such as the BEAST2 parameters, the phylogenetic tree parameters and the Marginal likelihood and Bayes factors results.


*Please note that the .trees output of the BEAST analyses combined by LogCombiner are too large to be posted on this repo due to GitHub's file size limits. They are available on demand by contacting the corresponding author of the paper. The .tree files produced by TreeAnnotator are located in Figures/Data/tree. 


# Exact procedure used to reconstruct phylogenetic trees in Figures 3 to 5

## phylogenetic tree generation
1. Select a multiple sequence Fasta file from the [Raw data/fasta](https://github.com/Stephane-S/Paper_emergence_time_SARS-CoV-2/tree/main/Raw%20data/fasta) folder.
2. Find the corresponding BEAST model parameters located in the supplementary tables ([here](https://github.com/Stephane-S/Paper_emergence_time_SARS-CoV-2/tree/main/Supplementary%20information))
3. If using sequence dates for the analysis, the collection date for every sequence may be found [here](https://github.com/Stephane-S/Paper_emergence_time_SARS-CoV-2/tree/main/Raw%20data/sequences_collection_date)
4. We ran three sets of computations with BEASTv2.7.5 for the models, each consisting of 20 millions steps.
5. Following those runs, the results obtained were then combined using the LogCombiner v2.6.7 and we verified that the effective sampling size of key parameters was over 200.
6. The TreeAnnotator software has been used to obtain the Maximum Clade Credibility (MCC) tree.

## Tree visualisation
An R script is provided [here](https://github.com/Stephane-S/Paper_emergence_time_SARS-CoV-2/tree/main/Figures/Figure_3-5) to obtain the phylogenetic tree images. Please note that the SVG outputs were improved with an SVG editor software to add the finishing touches manually (legends, colors, etc.)


![Figure 3](https://github.com/Stephane-S/Paper_emergence_time_SARS-CoV-2/blob/main/Figures/Output_figures/fig3.jpg)
<sub>
**Fig 3. Maximum clade credibility (MCC) trees of the whole-genome datasets.**
Posterior probability values are shown for the main clades. A) The MCC tree for the datasets without SARS-CoV-2 variants, and B) The MCC tree for the dataset with SARS-CoV-2 variants. Divergence times (decimal years) for each event of interest are indicated on the internal nodes of Tree B.


![Figure 4](https://github.com/Stephane-S/Paper_emergence_time_SARS-CoV-2/blob/main/Figures/Output_figures/fig4.jpg)
<sub>
**Fig 4. Maximum clade credibility (MCC) trees of the gene S datasets.**
Posterior probability values are shown for the main clades. A) The MCC tree for the datasets without SARS-CoV-2 variants, and B) The MCC tree for the dataset with SARS-CoV-2 variants. Divergence times (decimal years) for each event of interest are indicated on the internal nodes of Tree B.


![Figure 5](https://github.com/Stephane-S/Paper_emergence_time_SARS-CoV-2/blob/main/Figures/Output_figures/fig5.jpg)
<sub>
**Fig 5. Maximum clade credibility (MCC) trees of the receptor-binding domain (RBD) datasets.**
Posterior probability values are shown for the main clades. A) The MCC tree for the datasets without SARS-CoV-2 variants, and B) The MCC tree for the dataset with SARS-CoV-2 variants. Divergence times (decimal years) for each event of interest are indicated on the internal nodes of Tree B.
