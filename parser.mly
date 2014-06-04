%{ open Ast %}

%token PLUS MINUS TIMES DIVIDE MOD LPAREN RPAREN EOF
%token <int> INTEGER
%token <float> FLOAT

%left PLUS MINUS
%left TIMES DIVIDE MOD
%nonassoc UMINUS

%start expr
%type <Ast.expr> expr

%%

expr:
  iexpr                    { $1 }
| fexpr                    { $1 }

iexpr:
  LPAREN iexpr RPAREN      { $2 }
| iexpr PLUS iexpr         { Binop($1, Add, $3) }
| iexpr MINUS iexpr        { Binop($1, Sub, $3) }
| iexpr TIMES iexpr        { Binop($1, Mul, $3) }
| iexpr DIVIDE iexpr       { Binop($1, Div, $3) }
| iexpr MOD iexpr          { Binop($1, Mod, $3) }
| MINUS iexpr %prec UMINUS { Unop(Neg, $2) }
| INTEGER                  { Integer($1) }

fexpr:
  LPAREN fexpr RPAREN      { $2 }
| 
| FLOAT                    { Float($1) }
