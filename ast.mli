type binop = Add | Sub | Mul | Div | Mod
type fpbinop = FPAdd | FPSub | FPMul | FPDiv
type prefix = Neg
type fpprefix = FPNeg

type iexpr =
    Binop of iexpr * binop * iexpr
  | Prefix of prefix * iexpr
  | Integer of int

type fpexpr =
    FPBinop of fpexpr * fpbinop * fpexpr
  | FPPrefix of fpprefix * fpexpr
  | Float of float
  | CoercedFloat of iexpr

type expr =
    IExpr of iexpr
  | FPExpr of fpexpr
