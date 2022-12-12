Require Import List Arith.
Require Import Coq.Program.Tactics.

From Pip.Model.Meta Require Import TypesModel.

Module IsolationTypes <: TypesModel.

  Record page_s := { 
    p :> nat;
    Hp : p < nbPage
  }.

  Definition contextAddr := nat.

  Record interruptMask_s := {
    m :> list bool;
    Hm : length m = maxVint+1;
  }.

  Definition interruptMask := interruptMask_s.

  Inductive yield_checks : Type :=
  (* [...] *)
  | SUCCESS.

End IsolationTypes.
