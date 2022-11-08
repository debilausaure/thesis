Definition parentInPartitionList (s : state) := 
forall partition, In partition (getPartitions pageRootPartition s) -> 
forall parent, nextEntryIsPP partition idxParentDesc parent s ->
In parent (getPartitions pageRootPartition s). 
