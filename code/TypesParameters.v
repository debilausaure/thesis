Module Type TypesModel.

  Parameter page : Type.
  Parameter page_d : page.
  Parameter contextAddr : Type.
  Parameter interruptMask : Type.
  Parameter int_mask_d : interruptMask.

  Inductive yield_checks : Type :=
  (* [...] *)
  | SUCCESS.

End TypesModel.
