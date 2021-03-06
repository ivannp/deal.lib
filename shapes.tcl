shapecond any1minus { $s <= 1 || $h <= 1 || $d <= 1 || $c <= 1 }

shapecond any5plus {$s>=5 || $h>=5 || $d>=5 || $c>=5}
shapecond any54plus {($s>=5 && ($h>=4 || $d>=4 || $c>=4)) ||
			            ($h>=5 && ($d>=4 || $c>=4 || $s>=4)) ||
			            ($d>=5 && ($c>=4 || $s>=4 || $h>=4)) ||
			            ($c>=5 && ($s>=4 || $h>=4 || $d>=4)) }
shapecond anyUnbalanced {$s<2 || $h<2 || $c<2 || $d<2}

shapecond any4333 {$s>=3 && $h>=3 && $d>=3 && $c>=3}
shapecond any6	{$s == 6 || $h == 6 || $d == 6 || $c == 6}
shapecond any6plus {$s >= 6 || $h >= 6 || $d >= 6 || $c >= 6}
shapecond any5431 {($s==5 && ($h==4 && ($d==3 || $d==1) ||
			           $d==4 && ($h==3 || $h==1) ||
			           $c==4 && ($h==3 || $h==1))) ||
		             ($h==5 && ($s==4 && ($d==3 || $d==1) ||
			           $d==4 && ($s==3 || $s==1) ||
			           $c==4 && ($s==3 || $s==1))) ||
		             ($d==5 && ($s==4 && ($h==3 || $h==1) ||
			           $h==4 && ($c==3 || $c==1) ||
			           $c==4 && ($s==3 || $s==1))) ||
		             ($c==5 && ($s==4 && ($d==3 || $d==1) ||
			           $h==4 && ($d==3 || $d==1) ||
			           $d==4 && ($s==3 || $s==1))) }

shapecond any6M {($s==6 && $h<6 && $d<6 && $c<6) || ($h==6 && $s<6 && $d<6 && $c<6)}
shapecond any6322 {($s==6 && $h > 1 && $d > 1 && $c > 1) ||
                   ($h==6 && $s > 1 && $d > 1 && $c > 1) ||
                   ($c==6 && $h > 1 && $d > 1 && $s > 1) ||
                   ($d==6 && $h > 1 && $d > 1 && $s > 1)}

shapecond any5332 {($s==5 && (($h==3 && $d==2) || ($h==2 && $d == 3) || $h==3 && $d==3)) ||
		   ($h==5 && (($d==3 && $c==2) || ($d==2 && $c == 3) || $d==3 && $c==3)) ||
		   ($d==5 && (($s==3 && $h==2) || ($s==2 && $h == 3) || $s==3 && $h==3)) ||
		   ($c==5 && (($s==3 && $h==2) || ($s==2 && $h == 3) || $s==3 && $h==3)) }

shapecond any4333or4432 {$s>1 && $s<5 && $h>1 && $h<5 && $d>1 && $d<5 && $c>1 && $c<5}

shapecond any5m4M22 {($s==4 && (($c==5 && $h==2) || ($d==5 && $h==2))) ||
                     ($h==4 && (($c==5 && $s==2) || ($d==5 && $s==2)))}

shapecond spadeShape {$s >= 5 && $s >= $h && $s >= $d && $s >= $c}
shapecond heartShape {$h >= 5 && $s < $h && $h >= $d && $h >= $c}
shapecond diamondShape {$d >= 5 && $s < $d && $h < $d && $d >= $c}
shapecond clubShape {$c >= 5 && $s < $c && $h < $c && $d < $c}

shapecond any5m332 {($c == 5 && $d < 4 && $h < 4 && $s < 4) ||
                    ($d == 5 && $c < 4 && $h < 4 && $s < 4)}

shapecond any5m4m22 {($c == 5 && $d == 4 && $s == 2) || (c == 4 && $d == 5 && $s == 2)}
shapecond any5m422 {($c == 5 && (($d == 4 && $h == 2) || ($h == 4 && $d == 2) || ($s == 4 && $h == 2))) ||
                    ($d == 5 && (($c == 4 && $h == 2) || ($h == 4 && $c == 2) || ($s == 4 && $h == 2)))}

proc anyBalanced {hand} {
   if {[any4333or4432 $hand]} {return 1}
   if {[any5332 $hand]} {return 1}
   return 0
}
