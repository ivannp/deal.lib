source lib.ivannp/shapes.tcl
source lib.ivannp/utility.tcl
source lib.ivannp/precision.tcl

main {

   if { [ ntDef south 14 16 ] } { reject }
   if { ![ 1c south ] } { reject }
   if { [ clubs south ] < 1 } { reject }
   if { [ diamonds south ] < 1 } { reject }
   if { [ hearts south ] < 1 } { reject }
   if { [ spades south ] < 1 } { reject }

   if { ![ 1c2c north ] } { reject }

   set helen [ expr [ hearts south ] + [ hearts north ] ]
   set splen [ expr [ spades south ] + [ spades north ] ]
   set cllen [ expr [ clubs south ] + [ clubs north ] ]
   set dilen [ expr [ diamonds south ] + [ diamonds north ] ]

   if { $helen > 7 } { reject }
   if { $splen > 7 } { reject }
   if { $dilen > 10 } { reject }
   if { $cllen > 10 } { reject }

   set totalhcp [ expr [ hcp south ] + [ hcp north ] ]
   if { $totalhcp > 32 } { reject }

   accept
}
