Definition CNat := nat.
Definition CBool := bool.
Definition CRet : Type := (option CNat) * CBool.

Definition scheduler : RT CRet.
