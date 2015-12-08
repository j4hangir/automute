; coded by Jahângir (me [at] jahangir [dat] ninja)
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#SingleInstance force
; #Warn  ; Enable warnings to assist with detecting common errors.
#NoTrayIcon
#InstallKeybdHook
#InstallMouseHook
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#Include %A_ScriptDir%
;~ #Include routines.ahk
#Include VA21/va.ahk

;~ IniRead, tt, %a_scriptdir%/../autohotkey.ini, Timers, automute
;~ tt *= 1000
tt := 30 * 60 * 1000 ; half an hour

activated := false

SetTimer, AutoMute, 1000
return


is_mpc_playing()
{
	if (winexist("ahk_exe mpc-hc64.exe"))
	{
		WinGetText, txt, ahk_exe mpc-hc64.exe
		if (instr(txt, "Playing"))
			return True
	}
	return false
}

all_conditions_meet()
{
	return !is_mpc_playing()
}

AutoMute:
{
if  (activated)
{
	if (A_TimeIdlePhysical  < tt)
	{
		activated := false
		SendInput, {Volume_Mute}
	}
}
else if (A_TimeIdlePhysical  >= tt)
{
	if (!VA_GetMasterMute() && all_conditions_meet())
	{
		activated := true
		SendInput, {Volume_Mute}
	}
}
return
}
