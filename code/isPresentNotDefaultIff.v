Definition isPresentNotDefaultIff s :=
forall table idx , 
    readPresent  table idx (memory s) = Some false <-> 
    readPhyEntry table idx (memory s) = Some pageDefault.
