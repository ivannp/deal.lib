
set otherMajor(spades) hearts
set otherMajor(hearts) spades
set otherMinor(diamonds) clubs
set otherMinor(clubs) diamonds

defvector tenaceVec(1) 1 0 1 0 0
defvector tenaceVec(2) 1 0 0 1 0
defvector tenaceVec(3) 1 0 0 0 1
defvector tenaceVec(4) 0 1 0 1 0
defvector tenaceVec(5) 0 1 0 0 1
defvector tenaceVec(6) 0 0 1 0 1

defvector top5 1 1 1 1 1
defvector top4 1 1 1 1
defvector top3 1 1 1
defvector top2 1 1

# needs shapes.tcl
proc ntDef { hand min max } {
   set hcph [ hcp $hand ]

   if { $hcph < $min || $hcph > $max } {
      return 0
   }

   if { [ anyBalanced $hand ] } {
      return 1
   }

   return 0
}

proc hasTenace { hand suit } {
   for {set ii 1} {$ii <= 6} {incr ii} {
      if {[tenaceVec($ii) $hand $suit] == 2} {return 1}
   }

   return 0
}
