Definition partitionDescriptorEntry s := 
forall (partition : page),  
In partition (getPartitions pageRootPartition s) -> 
forall (idxroot : index), 
( (* disjonction de cas sur la valeur de idxroot *)
    (*[...]*) \/
    idxroot = idxParentDesc
) ->
(*[...]*) /\
exists entry,
	nextEntryIsPP partition idxroot entry s /\
	entry <> pageDefault.
