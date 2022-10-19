Definition partitionsIsolation s : Prop :=  

forall parent child1 child2 : page, 
  In parent (getPartitions multiplexer s) -> 
  In child1 (getChildren parent s) -> 
  In child2 (getChildren parent s) -> 
  child1 <> child2 ->
  disjoint (getUsedPages child1 s)(getUsedPages child2 s).
