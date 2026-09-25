library(ggplot2)
library(ggtree)
library(treeio)
library(ape)
library(dplyr)
library(ggimage)


source('ggtree_functions.R')

#list of tree files paths
gene_s_noVariant_tree <- "../data/tree/Gene_S_NoVariant_lognormal_combined.tree"
gene_s_noVariant_strict_tree <- "../data/tree/Gene_S_NoVariant_strict_combined.tree"
gene_s_Variant_tree <- "../data/tree/Gene_S_Variant_lognormal_combined.tree"

genome_noVariant_tree <- "../data/tree/genome_NoVariant_lognormal_combined.tree"
genome_Variant_tree <- "../data/tree/genome_variant_lognormal_combined.tree"

RBD_noVariant_tree <- "../data/tree/RBD_NoVariant_lognormal_combined.tree"
RBD_Variant_tree <- "../data/tree/RBD_Variant_lognormal_combined.tree"


# This function aggregates all the functions from 'ggtree_functions.R' into a cohesive pipeline to produce a tree
generate_variant_tree <- function(treeFile, scaleRatio, saveOutput, collapse_node, variant, test){
  label_file = '../data/lineage.csv'
  
  if (test == 'variant'){
    mostRecentDateString <- '2022-01-01'
  } else{
    mostRecentDateString <- '2020-07-14'
  }
  
  updated_tree <- update_beast_tree(treeFile, 
                                    mostRecentDateString,
                                    scaleRatio)
  updated_tree <- replace_labels(updated_tree, label_file)
  
  tree_nodes <- show_tree_nodes(updated_tree, mostRecentDateString)
  
  if (variant){
    tree_nodes <- scaleClade(tree_nodes, node = collapse_node, scale = 0.01)
    tree_nodes <- collapse(tree_nodes, node=collapse_node, clade_name = "test", mode = 'min', fill='grey')
  }
  
  tree_plot <- generate_tree(updated_tree, 
                             mostRecentDateString,
                             collapse_node=FALSE,
                             saveOutput)
  
  if (variant){
    tree_plot <- scaleClade(tree_plot, node = collapse_node, scale = 0.01)
    tree_plot <- collapse(tree_plot, node=collapse_node, mode = 'min', fill='grey', alpha=0.5)
  }
  
  tree_plot
}

############################
######### variants######### 
##########################

generate_variant_tree(genome_Variant_tree,
                      scaleRatio = 1,
                      saveOutput = FALSE,
                      collapse_node = FALSE,
                      variant = FALSE,
                      test = 'variant')

generate_variant_tree(gene_s_Variant_tree,
                      scaleRatio = 1,
                      saveOutput = FALSE,
                      collapse_node= FALSE,
                      variant = FALSE,
                      test = 'variant')

generate_variant_tree(RBD_Variant_tree,
                      scaleRatio = 1,
                      saveOutput = FALSE,
                      collapse_node= FALSE,
                      variant = FALSE,
                      test = 'variant')

#################################
#########  no variants ######### 
###############################

generate_variant_tree(genome_noVariant_tree,
                      scaleRatio = 0.001, #0.001
                      saveOutput = FALSE,
                      collapse_node= FALSE,
                      variant = FALSE,
                      test = 'no_variant')

generate_variant_tree(gene_s_noVariant_strict_tree,
                      scaleRatio = 0.0008,
                      saveOutput = FALSE,
                      collapse_node= FALSE,
                      variant = FALSE,
                      test = 'no_variant')

generate_variant_tree(RBD_noVariant_tree,
                      scaleRatio = 0.1,
                      saveOutput = FALSE,
                      collapse_node= FALSE,
                      variant = FALSE,
                      test = 'no_variant')
