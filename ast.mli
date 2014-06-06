type binop = Add | Sub | Mul | Div | Mod
type fpbinop = FPAdd | FPSub | FPMul | FPDiv
type prefix = Neg

type iexpr =
    Binop of iexpr * binop * iexpr
  | Prefix of prefix * iexpr
  | Integer of int

type expr =
    FPBinop of expr * fpbinop * expr
  | Float of float
  | CoercedFloat of iexpr
