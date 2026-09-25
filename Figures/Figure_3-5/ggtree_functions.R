
update_beast_tree <- function(fileName, mostRecentDateString, scaleRatio = 1) {
  #setup variables
  mostRecentDateString = as.Date(mostRecentDateString)
  recentYear = as.numeric(format(mostRecentDateString, format='%Y'))
  julianDay = as.POSIXlt(mostRecentDateString)$yday
  dateFloat = recentYear + (julianDay/365)
  
  
  #load tree
  beast <- read.beast(fileName)
  
  # transform tree to dataframe
  x <- as_tibble(beast)
  
  # apply transformations on the now tree dataframe
  x$height = format(round((dateFloat - (x$height * scaleRatio)), 2), nsmall = 2)
  x$branch.length = x$branch.length * scaleRatio
  
  
  updated_tree = as.treedata(x)
  
  return(updated_tree)
  
}

replace_labels <- function(updated_tree, label_file){
  label_df <- read.csv(label_file, header = TRUE)
  
  # transform tree to dataframe
  x <- as_tibble(updated_tree)
  original_labels <- as.vector(x$label)
  
  original_labels<-original_labels[!is.na(original_labels)]
  
  keeps <- apply(label_df, 1, function(x) any(x %in% original_labels))
  
  filtered_label_df <- label_df[keeps,]
  
  print(filtered_label_df)
  
  label_df = dplyr::mutate(filtered_label_df, newlab = paste(name, accession, sep=' | '))

 
  renamed_tree = rename_taxa(updated_tree, label_df, label, newlab)
  
  return(renamed_tree)
  
  
  
  
}

generate_tree <- function(updated_tree, mostRecentDateString,collapse_node=FALSE, saveOutput = FALSE) {
  # plot
  
  if (collapse_node != FALSE){
    plot= ggtree(updated_tree, mrsd=mostRecentDateString) + 
      geom_nodelab(geom='label', aes(label=height)) +
      theme_tree2(plot.margin=unit(c(20,100,20,20), "mm")) +
      coord_cartesian(clip = 'off') +
      geom_tiplab()
    plot <- collapse(plot, node=collapse_node)
    
  } else{
    plot= ggtree(updated_tree, mrsd=mostRecentDateString) + 
      geom_nodelab(geom='label', aes(label=height)) +
      theme_tree2(plot.margin=unit(c(20,100,20,20), "mm")) +
      coord_cartesian(clip = 'off') +
      geom_tiplab()
  }
  
  #return(plot)
  
  
  
  if (saveOutput){
    ggsave("output.svg", 
           plot = plot,
           width = 50,
           height = 50,
           units = 'cm',
           limitsize = FALSE)
  } else {
    plot
  }
  return(plot)
}

show_tree_nodes <- function(updated_tree, mostRecentDateString, saveOutput = FALSE) {
  # plot
  plot= ggtree(updated_tree, mrsd=mostRecentDateString) + 
    #geom_text(aes(label=node), hjust=-.3) +
    geom_label2(aes(subset=!isTip, label=node), size=2, color="black", alpha=1) +
    geom_tiplab()
  
  return(plot)
}