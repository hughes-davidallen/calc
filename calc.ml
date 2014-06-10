open Ast

let rec ieval = function
    Integer(x) -> x
  | Prefix(op, e1) ->
      (let v1 = ieval e1 in
      match op with
        Neg -> -v1)
  | Binop(e1, op, e2) ->
      let v1 = ieval e1 and v2 = ieval e2 in
      match op with
        Add -> v1 + v2
      | Sub -> v1 - v2
      | Mul -> v1 * v2
      | Div -> v1 / v2
      | Mod -> v1 mod v2

let rec fpeval = function
    Float(x) -> x
  | CoercedFloat(x) -> float_of_int (ieval x)
  | FPPrefix(op, e1) ->
      (let v1 = fpeval e1 in
      match op with
        FPNeg -> -.v1)
  | FPBinop(e1, op, e2) ->
      let v1 = fpeval e1 and v2 = fpeval e2 in
      match op with
        FPAdd -> v1 +. v2
      | FPSub -> v1 -. v2
      | FPMul -> v1 *. v2
      | FPDiv -> v1 /. v2

let eval = function
    IExpr(e1) ->
      (let result = ieval e1 in
      string_of_int result)
  | FPExpr(e1) ->
      let result = fpeval e1 in
      string_of_float result

let rec exec = function
    TSeq(e1) ->
      [eval e1]
  | Seq(e1, s1) ->
      (eval e1)::(exec s1)

let _ =
  let lexbuf = Lexing.from_channel stdin in
  let seq = Parser.seq Scanner.token lexbuf in
  let result = exec seq in
  List.iter (fun res -> print_endline res) result
