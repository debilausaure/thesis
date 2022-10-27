Lemma partitionTreeRemains (partDesc : page) (s : state) :
    let s' := {| currentPartition := partDesc; memory := memory s |} in
    forall (root : page),
        getPartitions root s = getPartitions root s'.
