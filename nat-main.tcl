# Adds double-dummy analysis to the output
#     ./deal -i lib.ivannp/test-main.tcl 5

source lib.ivannp/shapes.tcl
source lib.ivannp/utility.tcl
source lib.ivannp/parscore2.tcl

set accepted 0

set dealers [ list east west ]
set num_dealers 2

set vuls [list None NS EW All NS EW All None EW All None NS All None NS EW]

proc next_hand { hand } {
   if { $hand == "west" } { return north }
   if { $hand == "north" } { return east }
   if { $hand == "east" } { return south }
   if { $hand == "south" } { return west }
}

proc leading_upcase { word } {
    set first [ string toupper [ string range $word 0 0 ] ]
    set rest [ string range $word 1 end ]
    append first $rest
}

proc set_board_info { dealer vul } {
   global accepted

   append_board_info "Board $accepted"
   append_board_info "Dealer: [ leading_upcase $dealer ]"
   append_board_info "Vul: [ leading_upcase $vul ]"
}

defvector weak2quality 2 2 2 1 1

#
# Major two suited overcall
proc michaels { hand } {
   if { [ hearts $hand ] < 5 || [ spades $hand ] < 5 } { return 0 }

   set hh [ hcp $hand ]
   if { $hh < 6 || ( $hh > 11 && $hh < 15 ) } { return 0 }
   # if { [ weak2quality $hand spades ] < 2 } { return 0 }
   # if { [ weak2quality $hand hearts ] < 2 } { return 0 }

   return 1
}

#
# Major suit overcall
proc majorOvercall { hand suit } {
   upvar $suit l_suit

   set hh [ hcp $hand ]
   if { $hh < 8 || $hh > 16 } { return 0 }

   if { [ spades $hand ] >= 5 && [ hearts $hand ] <= [ spades $hand ] } {
      if { $hh < 10 && [ weak2quality $hand spades ] < 3 } { return 0 }
      set l_suit spades
      return 1
   } elseif { [ hearts $hand ] >= 5 } {
      if { $hh < 10 && [ weak2quality $hand hearts ] < 3 } { return 0 }
      set l_suit hearts
      return 1
   }
   return 0
}

main {
   global first_hand
   global second_hand
   global third_hand
   global fourth_hand
   global accepted

   clear_comments
   clear_board_info

   set rn [ expr int(rand()*$num_dealers) ]
   set first_hand [ lindex $dealers $rn ]
   set second_hand [ next_hand $first_hand ]
   set third_hand [ next_hand $second_hand ]
   set fourth_hand [ next_hand $third_hand ]

   set rn [ expr int(rand()*16) ]
   set vul [ lindex $vuls $rn ]

   if { ! [ntDef $first_hand 18 19] } { reject }
   set overcall_suit "none"
   if { ! [majorOvercall $second_hand $overcall_suit] && ! [michaels $second_hand] } { reject }

   incr accepted

   set_board_info $first_hand $vul

   set par_score [ parscore2 $first_hand "$vul" tricks ]

   set dir_tricks(north) "N"
   set dir_tricks(east) "E"
   set dir_tricks(south) "S"
   set dir_tricks(west) "W"

   foreach dd_denom { clubs diamonds hearts spades notrump } {
      foreach dd_hand { north east south west } {
         # set tr [deal::tricks $dd_hand $dd_denom]
         set tr $tricks($dd_hand:$dd_denom)

         if { $tr > 9 } {
            set dir_tricks($dd_hand) "$dir_tricks($dd_hand) $tr"
         } else {
            set dir_tricks($dd_hand) "$dir_tricks($dd_hand)  $tr"
         }
      }
   }

   append_comment ""
   append_comment "   C  D  H  S NT"
   append_comment "----------------"
   append_comment "$dir_tricks(north)"
   append_comment "$dir_tricks(east)"
   append_comment "$dir_tricks(south)"
   append_comment "$dir_tricks(west)"
   append_comment "----------------"

   append_comment ""

   append_comment "parscore: $par_score"

   accept
}
