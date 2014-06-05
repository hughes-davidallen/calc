type binop = Add | Sub | Mul | Div | Mod
type fpbinop = FPAdd | FPSub | FPDiv
type prefix = Neg

type expr =
    Binop of expr * binop * expr
  | FPBinop of expr * fpbinop * expr
  | Prefix of prefix * expr
  | Integer of int
  | Float of float
