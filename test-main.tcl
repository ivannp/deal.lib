source lib.ivannp/shapes.tcl
source lib.ivannp/utility.tcl
source lib.ivannp/precision.tcl

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

   if { [ 1c west ] == 0 } { reject }

   incr accepted

   set_board_info $first_hand $vul

   set dir_tricks(north) "N"
   set dir_tricks(east) "E"
   set dir_tricks(south) "S"
   set dir_tricks(west) "W"

   foreach dd_denom { clubs diamonds hearts spades notrump } {
      foreach dd_hand { north east south west } {
         # set first [ string toupper [ string range $dd_hand 0 0 ] ]
         # set str_tricks "$first"
         set tr [deal::tricks $dd_hand $dd_denom]

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

   accept
}
