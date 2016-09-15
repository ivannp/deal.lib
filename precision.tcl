
# needs my shapes.tcl
# needs my utility.tcl

proc 1n { hand } {
   # if { ![ semibalanced $hand ] } { return 0 }
   # if { [ hcp $hand ] > 17 } { return 0 }
   # if { [ hcp $hand ] < 15 } { return 0 }
   if {[ntDef $hand 15 17]} {return 1}
   return 0
}

proc 2n { hand } {
   # if { ![ semibalanced $hand ] } { return 0 }
   # if { [ hcp $hand ] > 22 } { return 0 }
   # if { [ hcp $hand ] < 20 } { return 0 }

   if {[ntDef $hand 20 22]} {return 1}
   return 0
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
   if { [ hcp $hand ] < 16 } { return 0 }
   return 1
}

defvector weak2quality 2 2 2 1 1
defvector suithcp 4 3 2 1

proc multi2d { hand } {
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

proc 2h { hand } {
   set hcph [ hcp $hand ]
   set cc [ clubs $hand ]
   set dd [ diamonds $hand ]
   set hh [ hearts $hand ]
   set ss [ spades $hand ]

   if {$hcph < 10 || $hcph > 15} { reject }

   if {$ss == 3 && $hh == 4 && $dd == 1} {accept}
   if {$ss == 4 && $hh == 3 && $dd == 1} {accept}
   if {$ss == 4 && $hh == 4 && $dd == 1} {accept}
   if {$ss == 4 && $hh == 4 && $dd == 0} {accept}

   reject
}

proc 2s { hand } {
   set hcph [ hcp $hand ]
   set cc [ clubs $hand ]
   set dd [ diamonds $hand ]
   set ss [ spades $hand ]

   if {$hcph < 5 || $hcph > 10} { reject }
   if {$ss == 5} {
      if {$cc >= 5 || $dd >= 5} { accept }
   }

   reject
}

proc 1c1d { hand } {
   if { [ hcp $hand ] < 8 } { return 1 }
   return 0
}

proc 1c1h { hand } {
   set hcph [ hcp $hand ]
   if { $hcph > 7 && [ heartShape $hand ] } { return 1 }
   if { $hcph > 13 } {
      if { [ anyBalanced $hand ] } { return 1 }
      if { [ any5m332 $hand ] } { return 1 }
      if { $hcph < 17 } {
         if { [ any5m422 $hand ] } { return 1 }
      }
   }
   return 0
}

proc 1c1s { hand } {
   set hcph [ hcp $hand ]
   if { $hcph > 7 && [ spadeShape $hand ] } { return 1 }
   return 0
}

proc 1c1n { hand } {
   set hcph [ hcp $hand ]
   if { $hcph < 8 || $hcph > 13 } { return 0 }
   if { [ anyBalanced $hand ] } { return 1 }
   if { [ any5m332 $hand ] } { return 1 }
   if { [ any5m422 $hand ] && $hcph < 11 } { return 1 }
   return 0
}

# Works only if the balanced hands are already excluded (1c 1h/n)
proc 1c2c { hand } {
   set hcph [ hcp $hand ]
   if { $hcph < 8 } { return 0 }
   if { [ clubShape $hand ] } { return 1 }
   return 0
}

# Works only if the balanced hands are already excluded (1c 1h/n)
proc 1c2d { hand } {
   set hcph [ hcp $hand ]
   if { $hcph < 8 } { return 0 }
   if { [ diamondShape $hand ] } { return 1 }
   return 0
}

proc 1c2h { hand } {
   set hcph [ hcp $hand ]
   if { $hcph < 8 } { return 0 }
   if { [ hearts $hand ] == 4 && [ diamonds $hand ] == 4 } {
      if { [ spades $hand ] == 4 || [ clubs $hand ] == 4 } {
         return 1
      }
   }
   return 0
}

proc 1c2s { hand } {
   set hcph [ hcp $hand ]
   if { $hcph < 8 } { return 0 }
   if { [ spades $hand ] == 4 && [ clubs $hand ] == 4 } {
      if { [ hearts $hand ] == 4 || [ diamonds $hand ] == 4 } {
         return 1
      }
   }
   return 0
}

proc 1cBalPos { hand min max } {

   set hcph [ hcp $hand ]

   if { $hcph < $min } { return 0 }
   if { $hcph > $max } { return 0 }

   set heh [hearts $hand ]
   if { $heh > 4 } { return 0 }
   set sph [spades $hand ]
   if { $sph > 4 } { return 0 }
   set clh [clubs $hand ]
   if { $clh > 5 } { return 0 }
   set dih [diamonds $hand ]
   if { $dih > 5 } { return 0 }

   if { $clh == 5 } {
      if { $sph > 3 || $heh > 3 || $dih > 3 } { return 0 }
      if { $sph < 2 || $heh < 2 || $dih < 2 } { return 0 }
   }

   if { $dih == 5 } {
      if { $sph > 3 || $heh > 3 || $clh > 3 } { return 0 }
      if { $sph < 2 || $heh < 2 || $clh < 2 } { return 0 }
   }

   return 1
}
