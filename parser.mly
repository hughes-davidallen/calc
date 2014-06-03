%{ open Ast %}

%token PLUS MINUS TIMES DIVIDE EOF
%token <int> LITERAL

%left PLUS MINUS
%left TIMES DIVIDE
%nonassoc UMINUS

%start expr
%type <Ast.expr> expr

%%

expr:
  expr PLUS expr          { Binop($1, Add, $3) }
| expr MINUS expr         { Binop($1, Sub, $3) }
| expr TIMES expr         { Binop($1, Mul, $3) }
| expr DIVIDE expr        { Binop($1, Div, $3) }
| MINUS expr %prec UMINUS { Unop(Neg, $2) }
| LITERAL                 { Lit($1) }
