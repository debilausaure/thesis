Lemma kernelDataIsolationActivate (partDesc : page) (s : state) :
    let s' := {| currentPartition := partDesc; memory := memory s |} in
    kernelDataIsolation s -> kernelDataIsolation s'.
