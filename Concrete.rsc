module lang::ql::Concrete

extend lang::std::Layout; // extend

// Declarations

start syntax Prog    // start symbol
  = prog: Exp* exps // production
  | prog: {Exp ","}* expsSep;
   

syntax Exp
  = var: Id \ Reserved  // subtract keywords
  | left mul: Exp l "*" Exp r // associativity
  > left add: Exp l "+" Exp r // priority
  | bracket "(" Exp ")"; 

  
keyword Reserved // keyword class
  = "if" | "else"; // finite langs

lexical Id
  = [a-zA-Z] !<< // look behind restriction
    ([a-zA-Z][a-zA-Z0-9_]*) // character classes
    !>> [a-zA-Z0-9_]; // lookahead restriction
  
void concrete() {
  Exp e1 = (Exp)`x * y`; // concrete syntax value
  Exp e2 = (Exp)`a + (<Exp e1>)`; // interpolation
  {Exp ","}* exps = p.expsSep; // symbols are types
  (Exp)`<Exp a> + <Exp b>` := e2; // matching
  (Prog)`x, <{Exp ","}* es>` := p; // list matching
  Id x = [Id]"abc"; 
}




