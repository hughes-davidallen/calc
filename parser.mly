%{ open Ast %}

%token PLUS MINUS TIMES DIVIDE MOD LPAREN RPAREN EOF
%token <int> INTEGER
%token <float> FLOAT

%left PLUS MINUS
%left TIMES DIVIDE MOD
%nonassoc UMINUS

%start expr
%type <Ast.iexpr> iexpr
%type <Ast.expr> expr

%%

expr:
  LPAREN expr RPAREN       { $2 }
| expr PLUS expr           { FPBinop($1, FPAdd, $3) }
| iexpr PLUS expr          { FPBinop(CoercedFloat($1), FPAdd, $3) }
| expr MINUS expr          { FPBinop($1, FPSub, $3) }
| iexpr MINUS expr         { FPBinop(CoercedFloat($1), FPSub, $3) }
| expr TIMES expr          { FPBinop($1, FPMul, $3) }
| iexpr TIMES expr         { FPBinop(CoercedFloat($1), FPMul, $3) }
| expr DIVIDE expr         { FPBinop($1, FPDiv, $3) }
| iexpr DIVIDE expr        { FPBinop(CoercedFloat($1), FPDiv, $3) }
| FLOAT                    { Float($1) }
| iexpr                    { CoercedFloat($1) }

iexpr:
  LPAREN iexpr RPAREN      { $2 }
| iexpr PLUS iexpr         { Binop($1, Add, $3) }
| iexpr MINUS iexpr        { Binop($1, Sub, $3) }
| iexpr TIMES iexpr        { Binop($1, Mul, $3) }
| iexpr DIVIDE iexpr       { Binop($1, Div, $3) }
| iexpr MOD iexpr          { Binop($1, Mod, $3) }
| MINUS iexpr %prec UMINUS { Prefix(Neg, $2) }
| INTEGER                  { Integer($1) }
