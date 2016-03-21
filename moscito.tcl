# needs my shapes.tcl
# needs my utility.tcl

proc 1c { hand } {
   # if { [ hcp $hand ] == 16 && [ balanced $hand ] } { return 0 }
   if { [ hcp $hand ] < 16 } { return 0 }
   return 1
}

proc 1c1d { hand } {
   if { [ hcp $hand ] >= 8} { return 0 }
   return 1
}

proc 1c1h { hand } {
   set hcph [ hcp $hand ]

   if { $hcph >= 11 } {
      if { [ anyBalanced $hand ] } { return 1 }
      if { [ spades $hand ] >= 5 } { return 1 }
   } elseif { $hcph >= 8 && $hcph <= 10 } {
      if { [ spades $hand ] >= 7 } { return 1 }
      if { [ diamonds $hand ] >= 5 || [ clubs $hand ] >= 5 || [ hearts $hand ] >= 5 } { return 1 }
   }

   return 0
}

proc 1c1s { hand } {
   if { [ hcp $hand ] >= 8 && [ hearts $hand ] >= 5 } { return 1}
   return 0
}

proc 1c1n { hand } {
   if { [ hcp $hand ] >= 8 } {
      set cc [ clubs $hand ]
      if { $cc > 5 } {
         return 1
      } elseif { $cc == 5 } {
         if { [ diamonds $hand ] > 3 || [ hearts $hand ] > 3 || [ spades $hand ] > 3 } { return 1 }
      }
   }
   return 0
}

proc 1c2c { hand } {
   if { [ hcp $hand ] >= 8 } {
      set dd [ diamonds $hand ]
      if { $dd > 5 } {
         return 1
      } elseif { $dd == 5 } {
         if { [ clubs $hand ] > 3 || [ hearts $hand ] > 3 || [ spades $hand ] > 3 } { return 1 }
      }
   }
   return 0
}

proc 1c2d { hand } {
   set hcph [ hcp $hand ]
   if { $hcph < 8 || $hcph > 10 } { return 0 }
   if { [ anyBalanced $hand ] } { return 1 }
   if { [ clubs $hand ] == 5 && [ diamonds $hand ] < 4 && [ hearts $hand ] < 4 && [ spades $hand ] < 4 } { return 1 }
   if { [ diamonds $hand ] == 5 && [ clubs $hand ] < 4 && [ hearts $hand ] < 4 && [ spades $hand ] < 4 } { return 1 }
   return 0
}

proc 1c2h { hand } {
   set hcph [ hcp $hand ]
   if { $hcph < 8 || $hcph > 10 } { return 0 }
   if { [ spades $hand ] >= 5 && [ hearts $hand ] < 5 && [ diamonds $hand ] < 5 && [ clubs $hand ] < 5} { return 1 }
   return 0
}

proc 1c2s { hand } {
   if { [ hcp $hand ] < 8 } { return 0 }
   if { [ spades $hand ] == 4 && [ hearts $hand ] == 4 } {
      if { [ diamonds $hand ] == 1 || [ clubs $hand ] == 1 } { return 1 }
   }
   return 0
}

proc 1c2n { hand } {
   if { [ hcp $hand ] < 8 } { return 0 }
   if { [ clubs $hand ] == 4 && [ diamonds $hand ] == 4 } {
      if { [ hearts $hand ] == 1 || [ spades $hand ] == 1} { return 1 }
   }
   return 0
}
