unit SDL3_keyboard;

interface

uses
  SDL3_stdinc, SDL3_rect, SDL3_scancode, SDL3_keycode, SDL3_video;

  {$IFDEF FPC}
  {$PACKRECORDS C}
  {$ENDIF}

type
  TSDL_KeyboardID = uint32;
  PSDL_KeyboardID = ^TSDL_KeyboardID;

  PSDL_Keysym = ^TSDL_Keysym;

  TSDL_Keysym = record
    scancode: TSDL_Scancode;
    sym: TSDL_Keycode;
    mod_: uint16;
    unused: uint32;
  end;

function SDL_GetKeyboardFocus: PSDL_Window; cdecl; external;
function SDL_GetKeyboardState(numkeys: Plongint): PUint8; cdecl; external;
procedure SDL_ResetKeyboard; cdecl; external;
function SDL_GetModState: TSDL_Keymod; cdecl; external;
procedure SDL_SetModState(modstate: TSDL_Keymod); cdecl; external;
function SDL_GetKeyFromScancode(scancode: TSDL_Scancode): TSDL_Keycode; cdecl; external;
function SDL_GetScancodeFromKey(key: TSDL_Keycode): TSDL_Scancode; cdecl; external;
function SDL_GetScancodeName(scancode: TSDL_Scancode): PChar; cdecl; external;
function SDL_GetScancodeFromName(Name: PChar): TSDL_Scancode; cdecl; external;
function SDL_GetKeyName(key: TSDL_Keycode): PChar; cdecl; external;
function SDL_GetKeyFromName(Name: PChar): TSDL_Keycode; cdecl; external;
procedure SDL_StartTextInput; cdecl; external;
function SDL_TextInputActive: TSDL_bool; cdecl; external;
procedure SDL_StopTextInput; cdecl; external;
procedure SDL_ClearComposition; cdecl; external;
function SDL_TextInputShown: TSDL_bool; cdecl; external;
function SDL_SetTextInputRect(rect: PSDL_Rect): longint; cdecl; external;
function SDL_HasScreenKeyboardSupport: TSDL_bool; cdecl; external;
function SDL_ScreenKeyboardShown(window: PSDL_Window): TSDL_bool; cdecl; external;

implementation

end.
