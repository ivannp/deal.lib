source lib.ivannp/shapes.tcl
source lib.ivannp/utility.tcl
source lib.ivannp/moscito.tcl

set accepted 0
set deals 0

main {

    incr deals
    
    set to_reject 0
    
    set hcpn [ hcp north ]
    set cln [ clubs north ]
    set din [ diamonds north ]
    set hen [ hearts north ]
    set spn [ spades north ]
    
    reject if {$hcpn < 9 || $hcpn > 14}
    reject if {$spn > 4}
    reject if {$hen > 4}
    reject if {$cln < 5 && $din < 5 }
    
    if { $din > 5 } {
        if { $spn == 4 || $hen == 4 } {
            reject if { [ top5 north diamonds ] < 3 || [ top2 north diamonds ] < 1 }
        }
    } elseif { $din == 5 } {
        reject if { $cln < 4 }
        reject if { $spn > 3 }
        reject if { $hen > 3 }
    } elseif { $din == 4 } {
        reject if { $cln < 5 }
        reject if { $spn > 3 }
        reject if { $hen > 3 }
    } else {
        reject
    }

    incr accepted

    accept
}

deal_finished {
   puts "1s opening: [expr round((($accepted + 0.0 ) / $deals ) * 10000.0)/100.0]%"
}
