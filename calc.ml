open Ast

let rec eval = function
    Integer(x) -> x
  | Float(x) -> x
  | Unop(op, e1) ->
      (let v1 = eval e1 in
      match op with
        Neg -> -v1)
  | Binop(e1, op, e2) ->
      let v1 = eval e1 and v2 = eval e2 in
      match op with
        Add -> v1 + v2
      | Sub -> v1 - v2
      | Mul -> v1 * v2
      | Div -> v1 / v2
      | Mod -> v1 mod v2

let _ =
  let lexbuf = Lexing.from_channel stdin in
  let expr = Parser.expr Scanner.token lexbuf in
  let result = eval expr in
  print_endline (string_of_int result)
