source lib.ivannp/shapes.tcl
source lib.ivannp/utility.tcl
source lib.ivannp/precision.tcl

# opening counts 1c, 1d, ...
set openingCounts(1) 0
set openingCounts(2) 0
set openingCounts(3) 0
set openingCounts(4) 0
set openingCounts(5) 0
set openingCounts(6) 0
set openingCounts(7) 0
set openingCounts(8) 0
set openingCounts(9) 0
set openingCounts(10) 0

set accepted 0

main {
   global openingCounts

   # The oder is important. For example, check the balanced hands first - to
   # exclude them from other openings if there is an overlap.
   if { [1n west] } {
      incr openingCounts(5)
   } elseif { [2n west] } {
      incr openingCounts(10)
   } elseif { [1d west] } {
      incr openingCounts(2)
   } elseif { [1h west] } {
      incr openingCounts(3)
   } elseif { [1s west] } {
      incr openingCounts(4)
   } elseif { [2c west] } {
      incr openingCounts(6)
   } elseif { [2s west] } {
      incr openingCounts(9)
   } elseif { [multi2d west] } {
      incr openingCounts(7)
   } elseif { [2h west] } {
      incr openingCounts(8)
   } elseif { [1c west] } {
      incr openingCounts(1)
   }

   incr accepted

   accept
}

deal_finished {
   global openingCounts

   puts "1c: [expr round((($openingCounts(1) + 0.0 ) / $accepted ) * 10000.0)/100.0]% ($openingCounts(1)) times"
   puts "1d: [expr round((($openingCounts(2) + 0.0 ) / $accepted ) * 10000.0)/100.0]% ($openingCounts(2)) times"
   puts "1h: [expr round((($openingCounts(3) + 0.0 ) / $accepted ) * 10000.0)/100.0]% ($openingCounts(3)) times"
   puts "1n: [expr round((($openingCounts(5) + 0.0 ) / $accepted ) * 10000.0)/100.0]% ($openingCounts(5)) times"
   puts "1s: [expr round((($openingCounts(4) + 0.0 ) / $accepted ) * 10000.0)/100.0]% ($openingCounts(4)) times"
   puts "2c: [expr round((($openingCounts(6) + 0.0 ) / $accepted ) * 10000.0)/100.0]% ($openingCounts(6)) times"
   puts "2d: [expr round((($openingCounts(7) + 0.0 ) / $accepted ) * 10000.0)/100.0]% ($openingCounts(7)) times"
   puts "2h: [expr round((($openingCounts(8) + 0.0 ) / $accepted ) * 10000.0)/100.0]% ($openingCounts(8)) times"
   puts "2s: [expr round((($openingCounts(9) + 0.0 ) / $accepted ) * 10000.0)/100.0]% ($openingCounts(9)) times"
   puts "2n: [expr round((($openingCounts(10) + 0.0 ) / $accepted ) * 10000.0)/100.0]% ($openingCounts(10)) times"
}
