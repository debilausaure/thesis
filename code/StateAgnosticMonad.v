Require Import String.
From Pip.Model.Meta Require Import StateModel.

Module StateAgnosticMonad (Export State : StateModel).

  Inductive result (A : Type) : Type :=
  | val : A -> result A
  | undef : string -> state -> result A.

  Definition SAM (A : Type) : Type :=
    state -> result (A * state).

  Definition ret {A : Type} (a : A) : SAM A :=
    fun s => val (a , s).

  Definition bind {A B : Type} (m : SAM A)
                               (f : A -> SAM B)
                               : SAM B :=
    fun s => match m s with
    | val (a, s') => f a s'
    | undef msg s' => undef msg s'
    end.

  Notation "'perform' x ':=' m 'in' e" := (bind m (fun x => e))
  (* [...] *)
  Notation "m1 ;; m2" := (bind m1 (fun _ => m2))
  (* [...] *)

  Definition undefined {A : Type} (msg : string) : SAM A :=
    fun s => undef msg s.

  Definition hoareTriple {A : Type} (P : state -> Prop)
                                    (m : SAM A)
                                    (Q : A -> state -> Prop)
                                    : Prop :=
    forall s, P s -> match m s with
    | val (a, s') => Q a s'
    | undef _ _=> False
    end.

  Notation "{{ P }} m {{ Q }}" := (hoareTriple P m Q)
  (* [...] *)

End StateAgnosticMonad.
