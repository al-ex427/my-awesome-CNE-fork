package funkin.backend.utils;

import funkin.options.Options;

//your free to use it in your dlls, just credit me in the mod --alex


@:buildXml('
<compilerflag value="/DelayLoad:ComCtl32.dll"/>

<target id="haxe">
    <lib name="dwmapi.lib" if="windows" />
    <lib name="shell32.lib" if="windows" />
    <lib name="gdi32.lib" if="windows" />
</target>
')
#if windows
@:cppFileCode('
#include <Windows.h>
#include <windowsx.h>
#include <cstdio>
#include <iostream>
#include <tchar.h>
#include <dwmapi.h>
#include <winuser.h>
#include <winternl.h>
#include <Shlobj.h>
#include <commctrl.h>
#include <string>

#include <chrono>
#include <thread>

#define UNICODE

#pragma comment(lib, "Dwmapi")
#pragma comment(lib, "ntdll.lib")
#pragma comment(lib, "user32.lib")
#pragma comment(lib, "Shell32.lib")
#pragma comment(lib, "gdi32.lib")

')
#end

class WindowsUtil {

	@:functionCode('MessageBoxA(GetActiveWindow(), message, caption, buttons | icon);')
    public static function ShowMessageBox(caption:String, message:String, icon:MessageBoxIconType = MSG_NONE, buttons:MessageBoxButtonType = MSGBTN_OK) { }

	@:functionCode('
	auto color = RGB(r, g, b); 

	if (S_OK != DwmSetWindowAttribute(GetActiveWindow(), 35, &color, sizeof(COLORREF))) {
        DwmSetWindowAttribute(GetActiveWindow(), 35, &color, sizeof(COLORREF));
    }')
	public static function ChangeWindowBarColor(r:Int, g:Int, b:Int) { }

	@:functionCode('
	auto color = RGB(r, g, b); 

	if (S_OK != DwmSetWindowAttribute(GetActiveWindow(), 34, &color, sizeof(COLORREF))) {
         DwmSetWindowAttribute(GetActiveWindow(), 34, &color, sizeof(COLORREF));
     }')
	public static function ChangeWindowBorderColor(r:Int, g:Int, b:Int) { }

	public static function LinkedChangeWindowColors(r:Int, g:Int, b:Int) { ChangeWindowBarColor(r, g, b); ChangeWindowBorderColor(r, g, b); }

	

/**
 * use ndlls to add extra stuff im not giving you all of it -alex
 */
}

/**
 * Enums used for messagebox. Refer to https://learn.microsoft.com/en-us/windows/win32/api/winuser/nf-winuser-messageboxa for more info about theese
 * btw these arent actually colors, it shows it like that for some users -alex
 */
 enum abstract MessageBoxButtonType(Int) {
	var MSGBTN_ARI = 0x00000002; //MB_ABORTRETRYIGNORE
	var MSGBTN_CTC = 0x00000006; //MSGBTN_ARI
	var MSGBTN_HELP = 0x00004000; //MB_HELP 
	var MSGBTN_OK = 0x00000000; //MB_OK
	var MSGBTN_OKCANCEL = 0x00000001; //MB_OKCANCEL
	var MSGBTN_RETRYCANCEL = 0x00000005; //MB_RETRYCANCEL
	var MSGBTN_YESNO = 0x00000004; //MB_YESNO
	var MSGBTN_YNC = 0x00000003; //MB_YESNOCANCEL
	
}

enum abstract MessageBoxIconType(Int) {
	var MSG_NONE = 0x00000000; // NO ICON
	var MSG_WARNING = 0x00000030; // MB_ICONWARNING | MB_ICONEXCLAMATION
	var MSG_INFORMATION = 0x00000040; // MB_ICONINFORMATION | MB_ICONASTERISK
	var MSG_QUESTION = 0x00000020; // MB_ICONQUESTION
	var MSG_ERROR = 0x00000010; // MB_ICONSTOP | MB_ICONERROR | MB_ICONHAND
}