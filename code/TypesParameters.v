Module Type TypesModel.

  Parameter page : Type.
  Parameter contextAddr : Type.
  Parameter interruptMask : Type.

  Inductive yield_checks : Type :=
  (* [...] *)
  | SUCCESS.

End TypesModel.
