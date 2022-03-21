Definition kernelDataIsolation s : Prop :=

forall partition1 partition2, 
  In partition1 (getPartitions multiplexer s) ->
  In partition2 (getPartitions multiplexer s) -> 
  disjoint (getAccessibleMappedPages partition1 s) 
           (getConfigPages partition2 s).
