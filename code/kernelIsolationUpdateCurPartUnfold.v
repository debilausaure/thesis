Lemma kernelDataIsolationActivate (partDesc : page) (s : state) :
    let s' := {| currentPartition := partDesc; memory := memory s |} in

    (forall partition1 partition2 : page,
    In partition1 (getPartitions pageRootPartition s) ->
    In partition2 (getPartitions pageRootPartition s) ->
    Lib.disjoint (getAccessibleMappedPages partition1 s)
                 (getConfigPages partition2 s))
    ->
    forall partition1 partition2 : page,
    In partition1 (getPartitions pageRootPartition s') ->
    In partition2 (getPartitions pageRootPartition s') ->
    Lib.disjoint (getAccessibleMappedPages partition1 s')
                 (getConfigPages partition2 s')
