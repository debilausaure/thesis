Lemma currentPartitionInPartitionsListActivate (partDesc : page) (s : state) :
    let s' := {|
        currentPartition := partDesc;
        memory := memory s
    |} in
    currentPartitionInPartitionsList s /\
    In partDesc (getPartitions multiplexer s) -> 
    currentPartitionInPartitionsList s'.

Proof.
intro.
intro.
destruct H.
unfold currentPartitionInPartitionsList.
simpl.
unfold s'.
rewrite <- partitionTreeRemains with partDesc s multiplexer.
assumption.
Qed.
