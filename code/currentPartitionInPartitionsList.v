Definition currentPartitionInPartitionsList (s : state) := 
    In (currentPartition s) (getPartitions pageRootPartition s).
