Record state : Type := {
    currentPartition : page;
    memory : list (paddr * value)
}.
