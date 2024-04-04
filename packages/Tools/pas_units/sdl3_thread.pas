unit SDL3_thread;

interface

{$IFDEF FPC}
{$PACKRECORDS C}
{$ENDIF}

type
  PSDL_Thread = ^TSDL_Thread;
  TSDL_Thread = Pointer;      {undefined structure}

  PSDL_ThreadID = ^TSDL_ThreadID;
  TSDL_ThreadID = uint64;

  PSDL_TLSID = ^TSDL_TLSID;
  TSDL_TLSID = uint32;

  PSDL_ThreadPriority = ^TSDL_ThreadPriority;
  TSDL_ThreadPriority = longint;

const
  SDL_THREAD_PRIORITY_LOW = 0;
  SDL_THREAD_PRIORITY_NORMAL = 1;
  SDL_THREAD_PRIORITY_HIGH = 2;
  SDL_THREAD_PRIORITY_TIME_CRITICAL = 3;

type
  TSDL_ThreadFunction = function(Data: pointer): longint; cdecl;
  funcfunc = function(para1: pointer): DWord;
  TpfnSDL_CurrentBeginThread = function(para1: pointer; para2: dword; func: funcfunc; para4: pointer; para5: dword; para6: Pdword): PtrUInt; cdecl;
  TpfnSDL_CurrentEndThread = procedure(code: dword); cdecl;

function SDL_CreateThread(fn: TSDL_ThreadFunction; Name: PChar; Data: pointer; pfnBeginThread: TpfnSDL_CurrentBeginThread; pfnEndThread: TpfnSDL_CurrentEndThread): PSDL_Thread; cdecl; external sdl3_lib;
function SDL_CreateThreadWithStackSize(fn: TSDL_ThreadFunction; Name: PChar; stacksize: SizeInt; Data: pointer; pfnBeginThread: TpfnSDL_CurrentBeginThread;
  pfnEndThread: TpfnSDL_CurrentEndThread): PSDL_Thread; cdecl; external sdl3_lib;
function SDL_CreateThread(fn: TSDL_ThreadFunction; Name: PChar; Data: pointer): PSDL_Thread; cdecl; external sdl3_lib;
function SDL_CreateThreadWithStackSize(fn: TSDL_ThreadFunction; Name: PChar; stacksize: SizeInt; Data: pointer): PSDL_Thread; cdecl; external sdl3_lib;
function SDL_GetThreadName(thread: PSDL_Thread): PChar; cdecl; external sdl3_lib;
function SDL_GetCurrentThreadID: TSDL_ThreadID; cdecl; external sdl3_lib;
function SDL_GetThreadID(thread: PSDL_Thread): TSDL_ThreadID; cdecl; external sdl3_lib;
function SDL_SetThreadPriority(priority: TSDL_ThreadPriority): longint; cdecl; external sdl3_lib;
procedure SDL_WaitThread(thread: PSDL_Thread; status: Plongint); cdecl; external sdl3_lib;
procedure SDL_DetachThread(thread: PSDL_Thread); cdecl; external sdl3_lib;
function SDL_CreateTLS: TSDL_TLSID; cdecl; external sdl3_lib;
function SDL_GetTLS(id: TSDL_TLSID): pointer; cdecl; external sdl3_lib;

type
  destructor_func = procedure(para1: pointer);

function SDL_SetTLS(id: TSDL_TLSID; Value: pointer; destructor_: destructor_func): longint; cdecl; external sdl3_lib;

implementation

end.
