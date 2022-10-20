Lemma partitionTreeRemains (newCurrentPartition : page) (s : state) :
    let s' := {|
        currentPartition := newCurrentPartition;
        memory := memory s
    |} in
    forall (root : page),
    getPartitions root s = getPartitions root s'.

Proof.
intro.
unfold getPartitions.
induction (nbPage + 1); trivial.
cbn.
f_equal.
unfold s'.
intro.
rewrite <- getChildrenActivate with newCurrentPartition s root.
fold s'.
f_equal.
induction (getChildren root s); simpl; trivial.
rewrite <- IHn.
f_equal.
apply IHl.
Qed.
