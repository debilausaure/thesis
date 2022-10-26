Definition updateCurPartition (phyPartition : page) : LLI unit := 
    modify (fun s => {| 
        currentPartition := phyPartition;
        memory := s.(memory)
    |}).
