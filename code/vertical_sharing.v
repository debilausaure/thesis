Definition verticalSharing s : Prop := 

forall parent child : page ,
  In parent (getPartitions pageRootPartition s) -> 
  In child (getChildren parent s) ->  
  incl (getUsedPages child s) (getMappedPages parent s).
