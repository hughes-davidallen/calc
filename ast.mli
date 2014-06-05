type binop = Add | Sub | Mul | Div | Mod
type prefix = Neg

type expr =
    Binop of expr * binop * expr
  | Prefix of prefix * expr
  | Lit of int
