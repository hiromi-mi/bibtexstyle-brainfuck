ENTRY 
{
    bfinput
    bfcode
}
{}
{}

INTEGERS { bf.var bf.len bf.current bf.newcurrent bf.curreg bf.counter bf.inputcur }
STRINGS { bf.chr bf.reg bf.tmpstr}
% initialized as ""
FUNCTION {bf.save}
{
         % registername begin length
         % retrieve new variable
         % bf.reg .... <bf.cur > bf.reg .... -> bf.reg
         bf.reg #1 
            bf.var #1 -
         substring$
         bf.curreg int.to.chr$ *
         'bf.tmpstr :=

         bf.tmpstr
         bf.reg
            bf.var #1 +
            #3000 % at most 30
         substring$
         *
         'bf.reg :=
}

FUNCTION {brainfuck}
{
  newline$
  "\bibitem{" write$
  cite$ write$
  "}" write$
  newline$
  
  % current register id where register
  #1 'bf.var :=

  % current sourcecode position
  #1 'bf.current :=

  % current input position
  #1 'bf.inputcur :=

  #1 'bf.counter :=
  "" 'bf.reg :=
  #0 'bf.curreg :=

  % initialize bf.reg with zero
  { #3001 bf.counter > }
  {
     bf.reg #0 int.to.chr$ * 'bf.reg :=
     bf.counter #1 + 'bf.counter :=
  }
  while$

  % +1 due to <= is not avaliable
  { #1 bfcode text.length$ + bf.current > }
  {
  % Get First Character of brainfuck code int bf.chr
     bfcode bf.current #1 substring$
     'bf.chr :=

     bf.chr "+" =
     {
        bf.curreg #1 + 'bf.curreg := 
                %":+" write$
        %bf.curreg #1 + 'bf.curreg := 
     } %"hogehoge" write$ }
     'skip$
     if$

      bf.chr "-" =
      {
         %bfvar2 #1 - 'bfvar :=
         bf.curreg #1 - 'bf.curreg := 
         %":-" write$
      % bfvar2 #1 + 'bfvar :=
         %bfvar #1 - 'bfvar :=
         %bf.curreg
      }
      'skip$ if$

      bf.chr "<" =
      {
         bf.save
         bf.var #1 - 'bf.var :=

         % update bf.curreg
         bf.reg bf.var #1 substring$ chr.to.int$ 'bf.curreg :=
         %":<" write$
      }
      'skip$ if$

      bf.chr ">" =
      {
         bf.save

         % get new one to curreg
         bf.var #1 + 'bf.var :=
         bf.reg bf.var #1 substring$ chr.to.int$ 'bf.curreg :=
         %":>" write$
      }
      'skip$ if$

      bf.chr "." =
      {
         bf.curreg int.to.chr$ write$
         %":." write$
      }
      'skip$ if$

      bf.chr "[" =
      {
         % push next one into old current one due to +1
         bf.current #1 -

         % loop variable
         #1 'bf.counter :=

         % assign to find ]
         bf.current 'bf.newcurrent :=
         %#0 :=
         { bf.counter #0 > }
         % where is ] ?
         {
            bf.newcurrent #1 + 'bf.newcurrent :=
            %"fuga" bf.counter bf.newcurrent "hoge" stack$
            bfcode bf.newcurrent #1 substring$ 'bf.tmpstr :=
            bf.tmpstr "[" =
            {
               bf.counter #1 + 'bf.counter :=
            }
            'skip$ if$
            bf.tmpstr "]" =
            {
               bf.counter #1 - 'bf.counter :=
            }
            'skip$ if$
         }
         while$

         bf.curreg #0 =
         {
            bf.newcurrent 'bf.current :=
            pop$ % current of [ will not be used
         }
         'skip$ if$
         %":[" write$
      }
      'skip$ if$

      bf.chr "," =
      {
         %":," write$
         % find EOF
         #1 bfinput text.length$ + bf.inputcur >
         {
            bfinput bf.inputcur #1 substring$ chr.to.int$
            'bf.curreg :=
         }
         {
            % EOF
            #0 % EOF returns 0
            'bf.curreg :=
         }
         if$
         bf.inputcur #1 + 'bf.inputcur := 
      }
      'skip$ if$

      bf.chr "]" =
      {
         bf.curreg #0 =
         {
            % go ahead
            pop$ % current of [ will not be used
         }
         {
            % move to old one
            'bf.current :=
            % will be become +1
         }
         if$
         %":]" write$
      }
      'skip$ if$
      
     %"hoge" bf.chr "fuga" stack$

     % stack's top: current bf character
     #1 bf.current + 'bf.current :=
  }
  while$
}

FUNCTION {begin.bib}
{
   "\begin{thebibliography}{a}" write$ newline$
}

FUNCTION {default.type} { brainfuck }

READ

EXECUTE {begin.bib}


ITERATE {call.type$}

FUNCTION {end.bib}
{
   newline$
   "\end{thebibliography}" write$ newline$
}
EXECUTE {end.bib}
