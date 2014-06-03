{ open Parser }

rule token =
  parse [' ' '\t' '\r' '\n'] { token lexbuf }
      | '+'                  { PLUS }
      | '-'                  { MINUS }
      | '*'                  { TIMES }
      | '/'                  { DIVIDE }
      | '('                  { LPAREN }
      | ')'                  { RPAREN }
      | ['0'-'9']+ as lit    { LITERAL(int_of_string lit) }
      | eof                  { EOF }
      | "/*"                 { comment lexbuf }
and comment = 
  parse "*/"                 { token lexbuf }
      | _                    { comment lexbuf }
