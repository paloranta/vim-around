; https://github.com/paloranta/vim-around
; For Reference:
;
; Hotkey Modifiers
; # - Windows key
; ! - Alt
; ^ - Control
; + - Shift

;------------INIT--------------
#SingleInstance force
SendMode Input 
#KeyHistory 0 

^!r::Reload  ; Assign Ctrl-Alt-R as a hotkey to restart the script.
^e::ExitApp  ; Ctrl-E to end the script.

;------------CAPSLOCK AS TOGGLE--------------
; This sets Caps Lock to toggle the script on an off
; Shift-CapsLock for normal Caps Lock
; TODO: add double-tapping or long-pressing Caps Lock as Esc

SetCapsLockState, AlwaysOff
CapsLock::
  Suspend
  if A_IsSuspended {	
    ToolTip, Edit mode, 4, 4
    SetTimer RemoveToolTip, 1000
  } else {
    #Persistent
    ToolTip, Vim mode, 4, 4
    SetTimer RemoveToolTip, Off
  }
return

RemoveToolTip:
  ToolTip
return

------------VI-like MOVEMENT KEYS-------------
; Toggle the script with Caps Lock for vi-like movement any application.
j::Send {Down}
k::Send {Up}
h::Send {Left} 
l::Send {Right}
0::Send {Home}
$::Send {End}
;å::Send {End} ; Using the otherwise useless (for me) "å" -key for this instead of the vi-default "$", which is awkward for my kb layout.

; Jump words with b (previous) and w (next)
b::Send {Ctrl Down}{Left}{Ctrl Up}
w::Send {Ctrl Down}{Right}{Ctrl Up}

;------------VI-like INTERACTION KEYS-------------

; i for edit mode
; d for deleting a selection
; d-w for deleting the next word (the next continuous block of text)
; d-b for deleting previous word (the previous continuous block of text)
; d-d for deleting entire line from current cursor position (might be buggy)
; c-w for changing the word from current cursor position
; c-b for changing the word from current cursor position
; Shift-a for appending to end of line and swapping to edit mode
; a for appending to end of word
; o for starting a new line and swapping to edit mode

i::
  if A_IsSuspended {
    Send i
  } else {
    Suspend
    ToolTip, Edit mode, 4, 4
    SetTimer RemoveToolTip, 1000
  }
return

d & w::Send {Ctrl Down}{Shift Down}{Right}{Ctrl Up}{Shift Up}{Del}
Return
d & b::Send {Ctrl Down}{Shift Down}{Left}{Ctrl Up}{Shift Up}{Del}
Return
c & w::
Send {Ctrl Down}{Shift Down}{Right}{Ctrl Up}{Shift Up}{Del}
  Suspend
  ToolTip, Edit mode, 4, 4	
  SetTimer RemoveToolTip, 1000
return

c & b::
Send {Ctrl Down}{Shift Down}{Left}{Ctrl Up}{Shift Up}{Del}
  Suspend
  ToolTip, Edit mode, 4, 4	
  SetTimer RemoveToolTip, 1000
return

$d::
KeyWait, d, T0.1	
  if (ErrorLevel)
	Send {Del}
  else {
	KeyWait, d, D T0.1
	if (ErrorLevel)
		Send {Del}
	else
		Send {Home}{Shift Down}{End}{Shift Up}{Del}
	}
KeyWait, d
return

u::Send ^z ; Ctrl-u for undoing

a::
  Send {Ctrl Down}{Right}{Ctrl Up}
  Suspend
  ToolTip, Edit mode, 4, 4	
  SetTimer RemoveToolTip, 1000
return
+a::
  Send {End}
  Suspend
  ToolTip, Edit mode, 4, 4	
  SetTimer RemoveToolTip, 1000
return

o::
  Send {End}{Enter}
  Suspend
  ToolTip, Edit mode, 4, 4	
  SetTimer RemoveToolTip, 1000
return
