Record state : Type := {
  currentPartition : page;
  memory : list (paddr * value)
}.

Inductive result (A : Type) : Type :=
| val : A -> result A
| undef : nat -> state -> result A.
