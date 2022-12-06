Record page := { 
  p :> nat;
  Hp : p < nbPage }.

Record interruptMask := {
 m :> list bool;
 Hm : length m = maxVint+1;
}.

Definition contextAddr := nat.

Inductive yield_checks : Type :=
(* Autres éléments de l'enum omis 
| [...] *)
| SUCCESS_Cons.

Definition SUCCESS := SUCCESS_Cons.
