{ open Parser }

let digit = ['0'-'9']
let fpn = digit+'.'digit+

rule token =
  parse [' ' '\t' '\r' '\n'] { token lexbuf }
      | '+'                  { PLUS }
      | '-'                  { MINUS }
      | '*'                  { TIMES }
      | '/'                  { DIVIDE }
      | '%'                  { MOD }
      | '('                  { LPAREN }
      | ')'                  { RPAREN }
      | fpn as lit           { FLOAT(float_of_string lit) }
      | digit+ as lit        { INTEGER(int_of_string lit) }
      | eof                  { EOF }
      | "/*"                 { comment lexbuf }
and comment = 
  parse "*/"                 { token lexbuf }
      | _                    { comment lexbuf }
