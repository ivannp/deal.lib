
# needs my shapes.tcl
# needs my utility.tcl

proc 1n { hand } {
   if { ![ semibalanced $hand ] } { return 0 }
   if { [ hcp $hand ] > 17 } { return 0 }
   if { [ hcp $hand ] < 15 } { return 0 }

   return 1
}

proc 2n { hand } {
   if { ![ semibalanced $hand ] } { return 0 }
   if { [ hcp $hand ] > 22 } { return 0 }
   if { [ hcp $hand ] < 20 } { return 0 }

   return 1
}

# 1d opening assuming 15-17 NT
proc 1d { hand } {
    if { [ hcp $hand ] < 11 } { return 0 }
    if { [ hcp $hand ] > 15 } { return 0 }

    if { [ spades $hand ] > 4 && [ diamonds $hand ] <= [ spades $hand ] } { return 0 }
    if { [ hearts $hand ] > 4 && [ diamonds $hand ] <= [ hearts $hand ] } { return 0 }

    if { [ clubs $hand ] > 5 && [ diamonds $hand ] < [ clubs $hand ] } { return 0 }

    if { [ semibalanced $hand ] && [ hcp $hand ] >= 15 } { return 0 }

    return 1
}

proc 1h { hand } {
    if { [ hcp $hand ] < 11 } { return 0 }
    if { [ hcp $hand ] > 15 } { return 0 }

    if { [ hearts $hand ] < 5 } { return 0 }

    if { [ spades $hand ] >= [ hearts $hand ] } { return 0 }

    return 1
}

proc 1s { hand } {
    if { [ hcp $hand ] < 11 } { return 0 }
    if { [ hcp $hand ] > 15 } { return 0 }

    if { [ spades $hand ] < 5 } { return 0 }

    return 1
}

proc 2c { hand } {
   if { [ hcp $hand ] < 10 } { return 0 }
   if { [ hcp $hand ] > 15 } { return 0 }

   set cc [ clubs $hand ]
   set dd [ diamonds $hand ]
   set hh [ hearts $hand ]
   set ss [ spades $hand ]

   if { $cc < 5 } { return 0 }

   if { $ss >= $cc } { return 0 }
   if { $hh >= $cc } { return 0 }
   if { $dd >= $cc } { return 0 }

   if { $cc == 5 } {
      if { $ss == 4 } {
         if { $hh == 3 } { return 0 }
      } elseif { $hh == 4 } {
         if { $ss == 3 } { return 0 }
      } else {
         return 0
      }
   }

   return 1
}

proc 1c { hand } {
   if { [ hcp $hand ] == 16 && [ balanced $hand ] } { return 0 }
   if { [ hcp $hand ] < 16 } { return 0 }
   return 1
}

defvector weak2quality 2 2 2 1 1
defvector suithcp 4 3 2 1

proc multi2D { hand } {
   if { [ hcp $hand ] < 4 || [ hcp $hand ] > 10 } { return 0 }

   set s [ spades $hand ]
   set h [ hearts $hand ]

   if { $h < 5 && $s < 5 } { return 0 }
   if { $h > 6 || $s > 6 } { return 0 }

   if { $h >= 5 } {
      if { [ clubs $hand ] > $h } { return 0 }
      if { [ diamonds $hand ] > $h } { return 0 }

      if { [ weak2quality $hand hearts ] < 4 } { return 0 }

      if { [ clubs $hand ] == 0 } { return 0 }
      if { [ diamonds $hand ] == 0 } { return 0 }
      if { [ spades $hand ] == 0 } { return 0 }

      if { $s > 4 } { return 0 }

      if { $s == 4 && [ suithcp $hand spades ] > 4 } { return 0 }
   }

   if { $s >= 5 } {
      if { $s == 5 } {
          if { [ clubs $hand ] > 3 } { return 0 }
          if { [ diamonds $hand ] > 3 } { return 0 }
      }

      if { [ clubs $hand ] > $s } { return 0 }
      if { [ diamonds $hand ] > $s } { return 0 }

      if { [ weak2quality $hand spades ] < 4 } { return 0 }

      if { [ clubs $hand ] == 0 } { return 0 }
      if { [ diamonds $hand ] == 0 } { return 0 }
      if { [ hearts $hand ] == 0 } { return 0 }

      if { $h > 4 } { return 0 }

      if { $h == 4 && [ suithcp $hand hearts  ] > 4 } { return 0 }
   }

   return 1
}
