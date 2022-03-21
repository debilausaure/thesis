Lemma compareVAddrToNull (va : vaddr) (P : state -> Prop) : 
{{ fun s => P s }}                              (** Precondition *)
compareVAddrToNull va                           (** Code *)
{{ fun (result : bool) (s : state) => P s /\    (** Postcondition *)
(beqVAddr defaultVAddr va) = result }}.
