type binop = Add | Sub | Mul | Div
type unop = Neg

type expr =
    Binop of expr * binop * expr
  | Unop of unop * expr
  | Lit of int
