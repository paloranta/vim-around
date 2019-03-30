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
CapsLock::Suspend

;------------VI-like MOVEMENT KEYS-------------
; Toggle the script with Caps Lock for vi-like movement any application.
j::Send {Down}
k::Send {Up}
h::Send {Left}
l::Send {Right}
0::Send {Home}
$::Send {End}
å::Send {End} ; Using the otherwise useless (for me) "å" -key for this instead of the vi-default "$", which is awkward for my kb layout.

; Jump words with b (previous) and w (next)
b::Send {Ctrl Down}{Left}{Ctrl Up}
w::Send {Ctrl Down}{Right}{Ctrl Up}

;------------VI-like INTERACTION KEYS-------------

; d for deleting a selection
; d-w for deleting the next word (the next continuous block of text)
; d-b for deleting previous word (the previous continuous block of text)
; d-d for deleting entire line from current cursor position (might be buggy)

d & w::Send {Ctrl Down}{Shift Down}{Right}{Ctrl Up}{Shift Up}{Del}
d & b::Send {Ctrl Down}{Shift Down}{Left}{Ctrl Up}{Shift Up}{Del}

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