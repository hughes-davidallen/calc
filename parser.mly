%{ open Ast %}

%token PLUS MINUS TIMES DIVIDE MOD LPAREN RPAREN EOF
%token <int> LITERAL

%left PLUS MINUS
%left TIMES DIVIDE MOD
%nonassoc UMINUS

%start expr
%type <Ast.expr> expr

%%

expr:
  LPAREN expr RPAREN      { $2 }
| expr PLUS expr          { Binop($1, Add, $3) }
| expr MINUS expr         { Binop($1, Sub, $3) }
| expr TIMES expr         { Binop($1, Mul, $3) }
| expr DIVIDE expr        { Binop($1, Div, $3) }
| expr MOD expr           { Binop($1, Mod, $3) }
| MINUS expr %prec UMINUS { Prefix(Neg, $2) }
| LITERAL                 { Lit($1) }
