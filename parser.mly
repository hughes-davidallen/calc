%{ open Ast %}

%token PLUS MINUS TIMES DIVIDE MOD LPAREN RPAREN EOF COMMA
%token <int> INTEGER
%token <float> FLOAT

%left PLUS MINUS
%left TIMES DIVIDE MOD
%nonassoc UMINUS

%start seq
%type <Ast.seq> seq
%type <Ast.expr> expr
%type <Ast.iexpr> iexpr
%type <Ast.fpexpr> fpexpr

%%

seq:
  expr                      { TSeq($1) }
| expr COMMA seq            { Seq($1, $3) }

expr:
  iexpr                     { IExpr($1) }
| fpexpr                    { FPExpr($1) }

fpexpr:
  LPAREN fpexpr RPAREN      { $2 }
| fpexpr PLUS fpexpr        { FPBinop($1, FPAdd, $3) }
| iexpr PLUS fpexpr         { FPBinop(CoercedFloat($1), FPAdd, $3) }
| fpexpr PLUS iexpr         { FPBinop($1, FPAdd, CoercedFloat($3)) }
| fpexpr MINUS fpexpr       { FPBinop($1, FPSub, $3) }
| iexpr MINUS fpexpr        { FPBinop(CoercedFloat($1), FPSub, $3) }
| fpexpr MINUS iexpr        { FPBinop($1, FPSub, CoercedFloat($3)) }
| fpexpr TIMES fpexpr       { FPBinop($1, FPMul, $3) }
| iexpr TIMES fpexpr        { FPBinop(CoercedFloat($1), FPMul, $3) }
| fpexpr TIMES iexpr        { FPBinop($1, FPMul, CoercedFloat($3)) }
| fpexpr DIVIDE fpexpr      { FPBinop($1, FPDiv, $3) }
| iexpr DIVIDE fpexpr       { FPBinop(CoercedFloat($1), FPDiv, $3) }
| fpexpr DIVIDE iexpr       { FPBinop($1, FPDiv, CoercedFloat($3)) }
| MINUS fpexpr %prec UMINUS { FPPrefix(FPNeg, $2) }
| FLOAT                     { Float($1) }

iexpr:
  LPAREN iexpr RPAREN       { $2 }
| iexpr PLUS iexpr          { Binop($1, Add, $3) }
| iexpr MINUS iexpr         { Binop($1, Sub, $3) }
| iexpr TIMES iexpr         { Binop($1, Mul, $3) }
| iexpr DIVIDE iexpr        { Binop($1, Div, $3) }
| iexpr MOD iexpr           { Binop($1, Mod, $3) }
| MINUS iexpr %prec UMINUS  { Prefix(Neg, $2) }
| INTEGER                   { Integer($1) }
