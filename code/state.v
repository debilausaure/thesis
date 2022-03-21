Inductive value : Type := 
|PE : Pentry -> value
|VE : Ventry -> value
|PP : page -> value
|VA : vaddr -> value
|I  : index -> value.  

(* Very loooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooong *)

Record state : Type := {
 currentPartition : page;
 memory : list (paddr * value)
}.
