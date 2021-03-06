#include <ScreenCapture.au3>

$HWnD = WinGetHandle (WinGetTitle ("BlueStacks App Player"))

;==============================================================================================================
;===Main Function==============================================================================================
;--------------------------------------------------------------------------------------------------------------
;Checks if the color components exceed $sVari and returns true if they are below $sVari.
;--------------------------------------------------------------------------------------------------------------

Func getGold($x_start, $y_start)
   Global $hDll = DllOpen("gdi32.dll")
   Global $vDC = _PixelGetColor_CreateDC($hDll)
   _PixelGetColor_CaptureRegion($vDC, 0, 0, $x_start + 90, $y_start + 20)
   ;-----------------------------------------------------------------------------
   Local $x = $x_start, $y = $y_start
   Local $Gold, $i = 0
   While getDigit($x, $y + $i, "Gold") = ""
	  If $i >= 15 Then ExitLoop
	  $i += 1
   WEnd
   $x = $x_start
   $Gold &= getDigit($x, $y + $i, "Gold")
   $Gold &= getDigit($x, $y + $i, "Gold")
   $Gold &= getDigit($x, $y + $i, "Gold")
   $x += 6
   $Gold &= getDigit($x, $y + $i, "Gold")
   $Gold &= getDigit($x, $y + $i, "Gold")
   $Gold &= getDigit($x, $y + $i, "Gold")
   Return $Gold
EndFunc

Func getElixir($x_start, $y_start)
   Global $hDll = DllOpen("gdi32.dll")
   Global $vDC = _PixelGetColor_CreateDC($hDll)
   _PixelGetColor_CaptureRegion($vDC, 0, 0, $x_start + 90, $y_start + 20)
   ;-----------------------------------------------------------------------------
   Local $x = $x_start, $y = $y_start
   Local $Elixir, $i = 0
   While getDigit($x, $y + $i, "Elixir") = ""
	  If $i >= 15 Then ExitLoop
	  $i += 1
   WEnd
   $x = $x_start
   $Elixir &= getDigit($x, $y + $i, "Elixir")
   $Elixir &= getDigit($x, $y + $i, "Elixir")
   $Elixir &= getDigit($x, $y + $i, "Elixir")
   $x += 6
   $Elixir &= getDigit($x, $y + $i, "Elixir")
   $Elixir &= getDigit($x, $y + $i, "Elixir")
   $Elixir &= getDigit($x, $y + $i, "Elixir")
   Return $Elixir
EndFunc

Func getDarkElixir($x_start, $y_start)
	Global $hDll = DllOpen("gdi32.dll")
	Global $vDC = _PixelGetColor_CreateDC($hDll)
	_PixelGetColor_CaptureRegion($vDC, 0, 0, $x_start + 90, $y_start + 20)
	;-----------------------------------------------------------------------------
	Local $x = $x_start, $y = $y_start
	Local $DarkElixir, $i = 0
    While getDigit($x, $y + $i, "DarkElixir") = ""
	   If $i >= 15 Then ExitLoop
	   $i += 1
    WEnd
    $x = $x_start
	$DarkElixir &= getDigit($x, $y + $i, "DarkElixir")
	$DarkElixir &= getDigit($x, $y + $i, "DarkElixir")
	$DarkElixir &= getDigit($x, $y + $i, "DarkElixir")
	$x += 6
	$DarkElixir &= getDigit($x, $y + $i, "DarkElixir")
	$DarkElixir &= getDigit($x, $y + $i, "DarkElixir")
	$DarkElixir &= getDigit($x, $y + $i, "DarkElixir")
	Return $DarkElixir
EndFunc

Func getTrophy($x_start, $y_start)
	Global $hDll = DllOpen("gdi32.dll")
	Global $vDC = _PixelGetColor_CreateDC($hDll)
	_PixelGetColor_CaptureRegion($vDC, 0, 0, $x_start + 90, $y_start + 20)
	;-----------------------------------------------------------------------------
	Local $x = $x_start, $y = $y_start
	Local $Trophy, $i = 0
    While getDigit($x, $y + $i, "Trophy") = ""
	   If $i >= 15 Then ExitLoop
	   $i += 1
    WEnd
    $x = $x_start
	$Trophy &= getDigit($x, $y + $i, "Trophy")
	$Trophy &= getDigit($x, $y + $i, "Trophy")
	Return $Trophy
EndFunc

;==============================================================================================================
;==============================================================================================================
;===Color Variation============================================================================================
;--------------------------------------------------------------------------------------------------------------
;Checks if the color components exceed $sVari and returns true if they are below $sVari.
;--------------------------------------------------------------------------------------------------------------

Func _ColorCheckVariation($nColor1, $nColor2, $sVari=5)
	$Red1 = Dec(StringMid(String($nColor1), 1, 2))
	$Blue1 = Dec(StringMid(String($nColor1), 3, 2))
	$Green1 = Dec(StringMid(String($nColor1), 5, 2))

	$Red2 = Dec(StringMid(String($nColor2), 1, 2))
	$Blue2 = Dec(StringMid(String($nColor2), 3, 2))
	$Green2 = Dec(StringMid(String($nColor2), 5, 2))

	If abs($Blue1 - $Blue2) > $sVari Then Return False
	If abs($Green1 - $Green2) > $sVari Then Return False
	If abs($Red1 - $Red2) > $sVari Then Return False
	Return True
EndFunc

;==============================================================================================================
;===Check Pixels============================================================================================
;--------------------------------------------------------------------------------------------------------------
;Using _ColorCheckVariation, checks compares multiple pixels and returns true if they all pass _ColorCheckVariation.
;--------------------------------------------------------------------------------------------------------------

Func boolPixelSearch($pixel1, $pixel2, $pixel3)
	Local $Color1 = _PixelGetColor_GetPixel($vDC, $pixel1[0], $pixel1[1])
	Local $Color2 =	_PixelGetColor_GetPixel($vDC, $pixel2[0], $pixel2[1])
	Local $Color3 = _PixelGetColor_GetPixel($vDC, $pixel3[0], $pixel3[1])
	If _ColorCheckVariation($Color1, $pixel1[2], 10) And _ColorCheckVariation($Color2, $pixel2[2], 10) And _ColorCheckVariation($Color3, $pixel3[2], 10) Then Return True
	Return False
EndFunc

;==============================================================================================================
;===Get Digit Gold=============================================================================================
;--------------------------------------------------------------------------------------------------------------
;Finds pixel color pattern of specific X and Y values, returns digit if pixel color pattern found.
;--------------------------------------------------------------------------------------------------------------

Func getDigit(ByRef $x, $y, $type)
	Local $width = 0

	;Search for digit 0
	$width = 13
	Select
		Case $type = "Gold"
			Local $c1 = Hex(0x989579, 6), 	$c2 = Hex(0x39382E, 6), $c3 = Hex(0x272720, 6)
		Case $type = "Elixir"
			Local $c1 = Hex(0x978A96, 6), 	$c2 = Hex(0x393439, 6), $c3 = Hex(0x272427, 6)
		Case $type = "DarkElixir"
			Local $c1 = Hex(0x909090, 6), 	$c2 = Hex(0x363636, 6), $c3 = Hex(0x262626, 6)
		Case $type = "Trophy"
			Local $c1 = Hex(0x979797, 6), 	$c2 = Hex(0x393939, 6), $c3 = Hex(0x272727, 6)
	EndSelect
	Local $pixel1[3] = [$x+6, $y+4, $c1], $pixel2[3] = [$x+7, $y+7, $c2], $pixel3[3] = [$x+10, $y+13, $c3]
	If boolPixelSearch($pixel1, $pixel2, $pixel3) Then
	  $x += $width ;Adds to x coordinate to get the next digit
	  Return 0
	Else
	  $x -= 1 ;Solves the problem when the spaces between the middle goes from 6 to 5 pixels
	  Local $pixel1[3] = [$x+6, $y+4, $c1], $pixel2[3] = [$x+7, $y+7, $c2], $pixel3[3] = [$x+10, $y+13, $c3]
	  If boolPixelSearch($pixel1, $pixel2, $pixel3) Then
		 $x += $width ;Changes x coordinate for the next digit.
		 Return 0
	  Else
		 $x += 2 ;Solves the problem when there is 1 pixel space between a set of numbers
		 Local $pixel1[3] = [$x+6, $y+4, $c1], $pixel2[3] = [$x+7, $y+7, $c2], $pixel3[3] = [$x+10, $y+13, $c3]
		 If boolPixelSearch($pixel1, $pixel2, $pixel3) Then
			$x += $width
			Return 0
		 Else
			$x -= 1
		 EndIf
	  EndIf
	EndIf

	;Search for digit 1
	$width = 6
	Select
		Case $type = "Gold"
			Local $c1 = Hex(0x979478, 6), 	$c2 = Hex(0x313127, 6), $c3 = Hex(0xD7D4AC, 6)
		Case $type = "Elixir"
			Local $c1 = Hex(0x968895, 6), 	$c2 = Hex(0x312D31, 6), $c3 = Hex(0xD8C4D6, 6)
		Case $type = "DarkElixir"
			Local $c1 = Hex(0x8F8F8F, 6), 	$c2 = Hex(0x2F2F2F, 6), $c3 = Hex(0xCDCDCD, 6)
		Case $type = "Trophy"
			Local $c1 = Hex(0x969696, 6), 	$c2 = Hex(0x313131, 6), $c3 = Hex(0xD8D8D8, 6)
	EndSelect
	Local $pixel1[3] = [$x+1, $y+1, $c1], $pixel2[3] = [$x+1, $y+12, $c2], $pixel3[3] = [$x+4, $y+12, $c3]
	If boolPixelSearch($pixel1, $pixel2, $pixel3) Then
	  $x += $width
	  Return 1
	Else
	  $x -= 1
	  Local $pixel1[3] = [$x+1, $y+1, $c1], $pixel2[3] = [$x+1, $y+12, $c2], $pixel3[3] = [$x+4, $y+12, $c3]
	  If boolPixelSearch($pixel1, $pixel2, $pixel3) Then
		 $x += $width
		 Return 1
	  Else
		 $x += 2
		 Local $pixel1[3] = [$x+1, $y+1, $c1], $pixel2[3] = [$x+1, $y+12, $c2], $pixel3[3] = [$x+4, $y+12, $c3]
		 If boolPixelSearch($pixel1, $pixel2, $pixel3) Then
			$x += $width
			Return 1
		 Else
			$x -= 1
		 EndIf
	  EndIf
	EndIf

	;Search for digit 2
	$width = 10
	Select
		Case $type = "Gold"
			Local $c1 = Hex(0xA09E80, 6), 	$c2 = Hex(0xD8D4AC, 6), $c3 = Hex(0x979579, 6)
		Case $type = "Elixir"
			Local $c1 = Hex(0xA0919F, 6), 	$c2 = Hex(0xD8C4D6, 6), $c3 = Hex(0x978A96, 6)
		Case $type = "DarkElixir"
			Local $c1 = Hex(0x989898, 6), 	$c2 = Hex(0xCDCDCD, 6), $c3 = Hex(0x909090, 6)
		Case $type = "Trophy"
			Local $c1 = Hex(0xA0A0A0, 6), 	$c2 = Hex(0xD8D8D8, 6), $c3 = Hex(0x979797, 6)
	EndSelect
	Local $pixel1[3] = [$x+1, $y+7, $c1], $pixel2[3] = [$x+3, $y+6, $c2], $pixel3[3] = [$x+7, $y+7, $c3]
	If boolPixelSearch($pixel1, $pixel2, $pixel3) Then
	  $x += $width
	  Return 2
	Else
	  $x -= 1
	  Local $pixel1[3] = [$x+1, $y+7, $c1], $pixel2[3] = [$x+3, $y+6, $c2], $pixel3[3] = [$x+7, $y+7, $c3]
	  If boolPixelSearch($pixel1, $pixel2, $pixel3) Then
		 $x += $width
		 Return 2
	  Else
		 $x += 2
		 Local $pixel1[3] = [$x+1, $y+7, $c1], $pixel2[3] = [$x+3, $y+6, $c2], $pixel3[3] = [$x+7, $y+7, $c3]
		 If boolPixelSearch($pixel1, $pixel2, $pixel3) Then
			$x += $width
			Return 2
		 Else
			$x -= 1
		 EndIf
	  EndIf
	EndIf

	;Search for digit 3
	$width = 10
	Select
		Case $type = "Gold"
			Local $c1 = Hex(0x7F7D65, 6), 	$c2 = Hex(0x070706, 6), $c3 = Hex(0x37362C, 6)
		Case $type = "Elixir"
			Local $c1 = Hex(0x7F737E, 6), 	$c2 = Hex(0x070607, 6), $c3 = Hex(0x373236, 6)
		Case $type = "DarkElixir"
			Local $c1 = Hex(0x797979, 6), 	$c2 = Hex(0x070707, 6), $c3 = Hex(0x343434, 6)
		Case $type = "Trophy"
			Local $c1 = Hex(0x7F7F7F, 6), 	$c2 = Hex(0x070707, 6), $c3 = Hex(0x373737, 6)
	EndSelect
	Local $pixel1[3] = [$x+2, $y+3, $c1], $pixel2[3] = [$x+4, $y+8, $c2], $pixel3[3] = [$x+5, $y+13, $c3]
	If boolPixelSearch($pixel1, $pixel2, $pixel3) Then
	  $x += $width
	  Return 3
	Else
	  $x -= 1
	  Local $pixel1[3] = [$x+2, $y+3, $c1], $pixel2[3] = [$x+4, $y+8, $c2], $pixel3[3] = [$x+5, $y+13, $c3]
	  If boolPixelSearch($pixel1, $pixel2, $pixel3) Then
		 $x += $width
		 Return 3
	  Else
		 $x += 2
		 Local $pixel1[3] = [$x+2, $y+3, $c1], $pixel2[3] = [$x+4, $y+8, $c2], $pixel3[3] = [$x+5, $y+13, $c3]
		 If boolPixelSearch($pixel1, $pixel2, $pixel3) Then
			$x += $width
			Return 3
		 Else
			   $x -= 1
		 EndIf
	  EndIf
	EndIf

	;Search for digit 4
	$width = 12
	Select
		Case $type = "Gold"
			Local $c1 = Hex(0x282720, 6), 	$c2 = Hex(0x080806, 6), $c3 = Hex(0x403F33, 6)
		Case $type = "Elixir"
			Local $c1 = Hex(0x282428, 6), 	$c2 = Hex(0x080708, 6), $c3 = Hex(0x403A40, 6)
		Case $type = "DarkElixir"
			Local $c1 = Hex(0x262626, 6), 	$c2 = Hex(0x070707, 6), $c3 = Hex(0x3D3D3D, 6)
		Case $type = "Trophy"
			Local $c1 = Hex(0x282828, 6), 	$c2 = Hex(0x080808, 6), $c3 = Hex(0x404040, 6)
	EndSelect
	Local $pixel1[3] = [$x+2, $y+3, $c1], $pixel2[3] = [$x+3, $y+1, $c2], $pixel3[3] = [$x+1, $y+5, $c3]
	If boolPixelSearch($pixel1, $pixel2, $pixel3) Then
	  $x += $width
	  Return 4
	Else
	  $x -= 1
	  Local $pixel1[3] = [$x+2, $y+3, $c1], $pixel2[3] = [$x+3, $y+1, $c2], $pixel3[3] = [$x+1, $y+5, $c3]
	  If boolPixelSearch($pixel1, $pixel2, $pixel3) Then
		 $x += $width
		 Return 4
	  Else
		 $x += 2
		 Local $pixel1[3] = [$x+2, $y+3, $c1], $pixel2[3] = [$x+3, $y+1, $c2], $pixel3[3] = [$x+1, $y+5, $c3]
		 If boolPixelSearch($pixel1, $pixel2, $pixel3) Then
			$x += $width
			Return 4
		 Else
			$x -= 1
		 EndIf
	  EndIf
	EndIf

	;Search for digit 5
	$width = 10
	Select
		Case $type = "Gold"
			Local $c1 = Hex(0x060604, 6), 	$c2 = Hex(0x040403, 6), $c3 = Hex(0xB7B492, 6)
		Case $type = "Elixir"
			Local $c1 = Hex(0x060606, 6), 	$c2 = Hex(0x040404, 6), $c3 = Hex(0xB7A7B6, 6)
		Case $type = "DarkElixir"
			Local $c1 = Hex(0x060606, 6), 	$c2 = Hex(0x040404, 6), $c3 = Hex(0xAFAFAF, 6)
		Case $type = "Trophy"
			Local $c1 = Hex(0x060606, 6), 	$c2 = Hex(0x040404, 6), $c3 = Hex(0xB7B7B7, 6)
	EndSelect
	Local $pixel1[3] = [$x+5, $y+4, $c1], $pixel2[3] = [$x+4, $y+9, $c2], $pixel3[3] = [$x+6, $y+12, $c3]
	If boolPixelSearch($pixel1, $pixel2, $pixel3) Then
	  $x += $width
	  Return 5
	Else
	  $x -= 1
	  Local $pixel1[3] = [$x+5, $y+4, $c1], $pixel2[3] = [$x+4, $y+9, $c2], $pixel3[3] = [$x+6, $y+12, $c3]
	  If boolPixelSearch($pixel1, $pixel2, $pixel3) Then
		 $x += $width
		 Return 5
	  Else
		 $x += 2
		 Local $pixel1[3] = [$x+5, $y+4, $c1], $pixel2[3] = [$x+4, $y+9, $c2], $pixel3[3] = [$x+6, $y+12, $c3]
		 If boolPixelSearch($pixel1, $pixel2, $pixel3) Then
			$x += $width
			Return 5
		 Else
			$x -= 1
		 EndIf
	  EndIf
	EndIf

	;Search for digit 6
	$width = 11
	Select
		Case $type = "Gold"
			Local $c1 = Hex(0x070605, 6), 	$c2 = Hex(0x040403, 6), $c3 = Hex(0x181713, 6)
		Case $type = "Elixir"
			Local $c1 = Hex(0x070707, 6), 	$c2 = Hex(0x040404, 6), $c3 = Hex(0x181618, 6)
		Case $type = "DarkElixir"
			Local $c1 = Hex(0x060606, 6), 	$c2 = Hex(0x030303, 6), $c3 = Hex(0x161616, 6)
		Case $type = "Trophy"
			Local $c1 = Hex(0x070707, 6), 	$c2 = Hex(0x040404, 6), $c3 = Hex(0x181818, 6)
	EndSelect
	Local $pixel1[3] = [$x+5, $y+4, $c1], $pixel2[3] = [$x+5, $y+9, $c2], $pixel3[3] = [$x+8, $y+5, $c3]
	If boolPixelSearch($pixel1, $pixel2, $pixel3) Then
	  $x += $width
	  Return 6
	Else
	  $x -= 1
	  Local $pixel1[3] = [$x+5, $y+4, $c1], $pixel2[3] = [$x+5, $y+9, $c2], $pixel3[3] = [$x+8, $y+5, $c3]
	  If boolPixelSearch($pixel1, $pixel2, $pixel3) Then
		 $x += $width
		 Return 6
	  Else
		 $x += 2
		 Local $pixel1[3] = [$x+5, $y+4, $c1], $pixel2[3] = [$x+5, $y+9, $c2], $pixel3[3] = [$x+8, $y+5, $c3]
		 If boolPixelSearch($pixel1, $pixel2, $pixel3) Then
			$x += $width
			Return 6
		 Else
			$x -= 1
		 EndIf
	  EndIf
	EndIf

	;Search for digit 7
	$width = 10
	Select
		Case $type = "Gold"
			Local $c1 = Hex(0x5E5C4B, 6), 	$c2 = Hex(0x87856C, 6), $c3 = Hex(0x5D5C4B, 6)
		Case $type = "Elixir"
			Local $c1 = Hex(0x5F565E, 6), 	$c2 = Hex(0x877B86, 6), $c3 = Hex(0x5F565E, 6)
		Case $type = "DarkElixir"
			Local $c1 = Hex(0x5A5A5A, 6), 	$c2 = Hex(0x818181, 6), $c3 = Hex(0x5A5A5A, 6)
		Case $type = "Trophy"
			Local $c1 = Hex(0x5F5F5F, 6), 	$c2 = Hex(0x878787, 6), $c3 = Hex(0x5F5F5F, 6)
	EndSelect
	Local $pixel1[3] = [$x+5, $y+11, $c1], $pixel2[3] = [$x+4, $y+3, $c2], $pixel3[3] = [$x+7, $y+7, $c3]
	If boolPixelSearch($pixel1, $pixel2, $pixel3) Then
	  $x += $width
	  Return 7
	Else
	  $x -= 1
	  Local $pixel1[3] = [$x+5, $y+11, $c1], $pixel2[3] = [$x+4, $y+3, $c2], $pixel3[3] = [$x+7, $y+7, $c3]
	  If boolPixelSearch($pixel1, $pixel2, $pixel3) Then
		 $x += $width
		 Return 7
	  Else
		 $x += 2
		 Local $pixel1[3] = [$x+5, $y+11, $c1], $pixel2[3] = [$x+4, $y+3, $c2], $pixel3[3] = [$x+7, $y+7, $c3]
		 If boolPixelSearch($pixel1, $pixel2, $pixel3) Then
			$x += $width
			Return 7
		 Else
			$x -= 1
		 EndIf
	  EndIf
	EndIf

	;Search for digit 8
	$width = 11
	Select
		Case $type = "Gold"
			Local $c1 = Hex(0x27261F, 6), 	$c2 = Hex(0x302F26, 6), $c3 = Hex(0x26261F, 6)
		Case $type = "Elixir"
			Local $c1 = Hex(0x272427, 6), 	$c2 = Hex(0x302B2F, 6), $c3 = Hex(0x26261F, 6)
		Case $type = "DarkElixir"
			Local $c1 = Hex(0x252525, 6), 	$c2 = Hex(0x2D2D2D, 6), $c3 = Hex(0x242424, 6)
		Case $type = "Trophy"
			Local $c1 = Hex(0x272727, 6), 	$c2 = Hex(0x303030, 6), $c3 = Hex(0x262626, 6)
	EndSelect
	Local $pixel1[3] = [$x+5, $y+3, $c1], $pixel2[3] = [$x+5, $y+10, $c2], $pixel3[3] = [$x+1, $y+6, $c3]
	If boolPixelSearch($pixel1, $pixel2, $pixel3) Then
	  $x += $width
	  Return 8
	Else
	  $x -= 1
	  Local $pixel1[3] = [$x+5, $y+3, $c1], $pixel2[3] = [$x+5, $y+10, $c2], $pixel3[3] = [$x+1, $y+6, $c3]
	  If boolPixelSearch($pixel1, $pixel2, $pixel3) Then
		 $x += $width
		 Return 8
	  Else
		 $x += 2
		 Local $pixel1[3] = [$x+5, $y+3, $c1], $pixel2[3] = [$x+5, $y+10, $c2], $pixel3[3] = [$x+1, $y+6, $c3]
		 If boolPixelSearch($pixel1, $pixel2, $pixel3) Then
			$x += $width
			Return 8
		 Else
			$x -= 1
		 EndIf
	  EndIf
	EndIf

	;Search for digit 9
	$width = 11
	Select
		Case $type = "Gold"
			Local $c1 = Hex(0x302F26, 6), 	$c2 = Hex(0x050504, 6), $c3 = Hex(0x272720, 6)
		Case $type = "Elixir"
			Local $c1 = Hex(0x302C30, 6), 	$c2 = Hex(0x050505, 6), $c3 = Hex(0x282427, 6)
		Case $type = "DarkElixir"
			Local $c1 = Hex(0x2E2E2E, 6), 	$c2 = Hex(0x050505, 6), $c3 = Hex(0x262626, 6)
		Case $type = "Trophy"
			Local $c1 = Hex(0x303030, 6), 	$c2 = Hex(0x050505, 6), $c3 = Hex(0x272727, 6)
	EndSelect
	Local $pixel1[3] = [$x+5, $y+5, $c1], $pixel2[3] = [$x+5, $y+9, $c2], $pixel3[3] = [$x+8, $y+12, $c3]
	If boolPixelSearch($pixel1, $pixel2, $pixel3) Then
	  $x += $width
	  Return 9
	Else
	  $x -= 1
	  Local $pixel1[3] = [$x+5, $y+5, $c1], $pixel2[3] = [$x+5, $y+9, $c2], $pixel3[3] = [$x+8, $y+12, $c3]
	  If boolPixelSearch($pixel1, $pixel2, $pixel3) Then
		 $x += $width
		 Return 9
	  Else
		 $x += 2
		 Local $pixel1[3] = [$x+5, $y+5, $c1], $pixel2[3] = [$x+5, $y+9, $c2], $pixel3[3] = [$x+8, $y+12, $c3]
		 If boolPixelSearch($pixel1, $pixel2, $pixel3) Then
			$x += $width
			Return 9
		 Else
			$x -= 1
		 EndIf
	  EndIf
	EndIf
	Return ""
EndFunc

;==============================================================================================================
;===Other Functions============================================================================================
;==============================================================================================================

Func _PixelGetColor_CreateDC($hDll = "gdi32.dll")
	$iPixelGetColor_MemoryContext = DllCall($hDll, "int", "CreateCompatibleDC", "int", 0)
	If @error Then Return SetError(@error,0,0)
	Return $iPixelGetColor_MemoryContext[0]
EndFunc

Func _PixelGetColor_CaptureRegion($iPixelGetColor_MemoryContext, $iLeft = 0, $iTop = 0, $iRight = -1, $iBottom = -1, $fCursor = False, $hDll = "gdi32.dll")
	$HBITMAP = _ScreenCapture_Capture("", $iLeft, $iTop, $iRight, $iBottom, $fCursor)
	DllCall($hDll, "hwnd", "SelectObject", "int", $iPixelGetColor_MemoryContext, "hwnd", $HBITMAP)
	Return $HBITMAP
EndFunc

Func _PixelGetColor_GetPixel($iPixelGetColor_MemoryContext,$iX,$iY, $hDll = "gdi32.dll")
	$iColor = DllCall($hDll,"int","GetPixel","int",$iPixelGetColor_MemoryContext,"int",$iX,"int",$iY)
	If $iColor[0] = -1 then Return SetError(1,0,-1)
	$sColor = Hex($iColor[0],6)
	Return StringRight($sColor,2) & StringMid($sColor,3,2) & StringLeft($sColor,2)
EndFunc