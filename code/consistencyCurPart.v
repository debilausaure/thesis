Definition currentPartitionInPartitionsList (s : state) := 
    In (currentPartition s) (getPartitions pageRootPartition s).

Definition currentPartitionIsNotDefaultPage (s : state) :=
    (currentPartition s) <> pageDefault. 
