Definition LLI (A :Type) : Type := state -> result (A * state).

Definition ret {A : Type} (a : A) : LLI A :=
  fun s => val (a , s) .

Definition bind {A B : Type} (m : LLI A)(f : A -> LLI B) : LLI B :=  
  fun s => match m s with
           | val (a, s') => f a s'
           | undef a s' => undef a s'
           end.
