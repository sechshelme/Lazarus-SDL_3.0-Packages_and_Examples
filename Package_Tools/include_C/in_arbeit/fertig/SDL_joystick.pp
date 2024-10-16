
unit SDL_joystick;
interface

{
  Automatically converted by H2Pas 0.99.16 from SDL_joystick.h
  The following command line parameters were used:
    -p
    -T
    -d
    -c
    -e
    SDL_joystick.h
}

Type
PSDL_Joystick = ^TSDL_Joystick;
PSDL_Mutex = ^TSDL_Mutex;
Psingle = ^Tsingle;
PSint16 = ^TSint16;
PUint16 = ^TUint16;

{$IFDEF FPC}
{$PACKRECORDS C}
{$ENDIF}


{
  Simple DirectMedia Layer
  Copyright (C) 1997-2024 Sam Lantinga <slouken@libsdl.org>

  This software is provided 'as-is', without any express or implied
  warranty.  In no event will the authors be held liable for any damages
  arising from the use of this software.

  Permission is granted to anyone to use this software for any purpose,
  including commercial applications, and to alter it and redistribute it
  freely, subject to the following restrictions:

  1. The origin of this software must not be misrepresented; you must not
     claim that you wrote the original software. If you use this software
     in a product, an acknowledgment in the product documentation would be
     appreciated but is not required.
  2. Altered source versions must be plainly marked as such, and must not be
     misrepresented as being the original software.
  3. This notice may not be removed or altered from any source distribution.
 }
{*
 * # CategoryJoystick
 *
 * SDL joystick support.
 *
 * This is the lower-level joystick handling. If you want the simpler option,
 * where what buttons does what is well-defined, you should use the gamepad
 * API instead.
 *
 * The term "instance_id" is the current instantiation of a joystick device in
 * the system, if the joystick is removed and then re-inserted then it will
 * get a new instance_id, instance_id's are monotonically increasing
 * identifiers of a joystick plugged in.
 *
 * The term "player_index" is the number assigned to a player on a specific
 * controller. For XInput controllers this returns the XInput user index. Many
 * joysticks will not be able to supply this information.
 *
 * SDL_GUID is used as a stable 128-bit identifier for a joystick device that
 * does not change over time. It identifies class of the device (a X360 wired
 * controller for example). This identifier is platform dependent.
 *
 * In order to use these functions, SDL_Init() must have been called with the
 * SDL_INIT_JOYSTICK flag. This causes SDL to scan the system for joysticks,
 * and load appropriate drivers.
 *
 * If you would like to receive joystick updates while the application is in
 * the background, you should set the following hint before calling
 * SDL_Init(): SDL_HINT_JOYSTICK_ALLOW_BACKGROUND_EVENTS
  }
{$ifndef SDL_joystick_h_}
{$define SDL_joystick_h_}
{$include <SDL3/SDL_stdinc.h>}
{$include <SDL3/SDL_error.h>}
{$include <SDL3/SDL_guid.h>}
{$include <SDL3/SDL_mutex.h>}
{$include <SDL3/SDL_power.h>}
{$include <SDL3/SDL_properties.h>}
{$include <SDL3/SDL_sensor.h>}
{$include <SDL3/SDL_begin_code.h>}
{ Set up for C function definitions, even when using C++  }
{ C++ extern C conditionnal removed }
{$ifdef SDL_THREAD_SAFETY_ANALYSIS}
{
 * This is not an exported symbol from SDL, this is only in the headers to
 * help Clang's thread safety analysis tools to function. Do not attempt
 * to access this symbol from your app, it will not work!
  }
  var
    SDL_joystick_lock : PSDL_Mutex;cvar;external;
{$endif}
{*
 * The joystick structure used to identify an SDL joystick.
 *
 * This is opaque data.
 *
 * \since This struct is available since SDL 3.0.0.
  }
type
{*
 * This is a unique ID for a joystick for the time it is connected to the
 * system, and is never reused for the lifetime of the application.
 *
 * If the joystick is disconnected and reconnected, it will get a new ID.
 *
 * The value 0 is an invalid ID.
 *
 * \since This datatype is available since SDL 3.0.0.
  }

  PSDL_JoystickID = ^TSDL_JoystickID;
  TSDL_JoystickID = TUint32;
{*
 * An enum of some common joystick types.
 *
 * In some cases, SDL can identify a low-level joystick as being a certain
 * type of device, and will report it through SDL_GetJoystickType (or
 * SDL_GetJoystickTypeForID).
 *
 * This is by no means a complete list of everything that can be plugged into
 * a computer.
 *
 * \since This enum is available since SDL 3.0.0.
  }

  PSDL_JoystickType = ^TSDL_JoystickType;
  TSDL_JoystickType =  Longint;
  Const
    SDL_JOYSTICK_TYPE_UNKNOWN = 0;
    SDL_JOYSTICK_TYPE_GAMEPAD = 1;
    SDL_JOYSTICK_TYPE_WHEEL = 2;
    SDL_JOYSTICK_TYPE_ARCADE_STICK = 3;
    SDL_JOYSTICK_TYPE_FLIGHT_STICK = 4;
    SDL_JOYSTICK_TYPE_DANCE_PAD = 5;
    SDL_JOYSTICK_TYPE_GUITAR = 6;
    SDL_JOYSTICK_TYPE_DRUM_KIT = 7;
    SDL_JOYSTICK_TYPE_ARCADE_PAD = 8;
    SDL_JOYSTICK_TYPE_THROTTLE = 9;
    SDL_JOYSTICK_TYPE_COUNT = 10;
;
{*
 * Possible connection states for a joystick device.
 *
 * This is used by SDL_GetJoystickConnectionState to report how a device is
 * connected to the system.
 *
 * \since This enum is available since SDL 3.0.0.
  }
type
  PSDL_JoystickConnectionState = ^TSDL_JoystickConnectionState;
  TSDL_JoystickConnectionState =  Longint;
  Const
    SDL_JOYSTICK_CONNECTION_INVALID = -(1);
    SDL_JOYSTICK_CONNECTION_UNKNOWN = (-(1))+1;
    SDL_JOYSTICK_CONNECTION_WIRED = (-(1))+2;
    SDL_JOYSTICK_CONNECTION_WIRELESS = (-(1))+3;
;
{*
 * The largest value an SDL_Joystick's axis can report.
 *
 * \since This macro is available since SDL 3.0.0.
 *
 * \sa SDL_JOYSTICK_AXIS_MIN
  }
  SDL_JOYSTICK_AXIS_MAX = 32767;  
{*
 * The smallest value an SDL_Joystick's axis can report.
 *
 * This is a negative number!
 *
 * \since This macro is available since SDL 3.0.0.
 *
 * \sa SDL_JOYSTICK_AXIS_MAX
  }
  SDL_JOYSTICK_AXIS_MIN = -(32768);  
{ Function prototypes  }
{*
 * Locking for atomic access to the joystick API.
 *
 * The SDL joystick functions are thread-safe, however you can lock the
 * joysticks while processing to guarantee that the joystick list won't change
 * and joystick and gamepad events will not be delivered.
 *
 * \since This function is available since SDL 3.0.0.
  }

procedure SDL_LockJoysticks;cdecl;external;
{*
 * Unlocking for atomic access to the joystick API.
 *
 * \since This function is available since SDL 3.0.0.
  }
procedure SDL_UnlockJoysticks;cdecl;external;
{*
 * Return whether a joystick is currently connected.
 *
 * \returns true if a joystick is connected, false otherwise.
 *
 * \since This function is available since SDL 3.0.0.
 *
 * \sa SDL_GetJoysticks
  }
function SDL_HasJoystick:Tbool;cdecl;external;
{*
 * Get a list of currently connected joysticks.
 *
 * \param count a pointer filled in with the number of joysticks returned, may
 *              be NULL.
 * \returns a 0 terminated array of joystick instance IDs or NULL on failure;
 *          call SDL_GetError() for more information. This should be freed
 *          with SDL_free() when it is no longer needed.
 *
 * \since This function is available since SDL 3.0.0.
 *
 * \sa SDL_HasJoystick
 * \sa SDL_OpenJoystick
  }
function SDL_GetJoysticks(count:Plongint):PSDL_JoystickID;cdecl;external;
{*
 * Get the implementation dependent name of a joystick.
 *
 * This can be called before any joysticks are opened.
 *
 * \param instance_id the joystick instance ID.
 * \returns the name of the selected joystick. If no name can be found, this
 *          function returns NULL; call SDL_GetError() for more information.
 *
 * \since This function is available since SDL 3.0.0.
 *
 * \sa SDL_GetJoystickName
 * \sa SDL_GetJoysticks
  }
(* Const before declarator ignored *)
function SDL_GetJoystickNameForID(instance_id:TSDL_JoystickID):Pansichar;cdecl;external;
{*
 * Get the implementation dependent path of a joystick.
 *
 * This can be called before any joysticks are opened.
 *
 * \param instance_id the joystick instance ID.
 * \returns the path of the selected joystick. If no path can be found, this
 *          function returns NULL; call SDL_GetError() for more information.
 *
 * \since This function is available since SDL 3.0.0.
 *
 * \sa SDL_GetJoystickPath
 * \sa SDL_GetJoysticks
  }
(* Const before declarator ignored *)
function SDL_GetJoystickPathForID(instance_id:TSDL_JoystickID):Pansichar;cdecl;external;
{*
 * Get the player index of a joystick.
 *
 * This can be called before any joysticks are opened.
 *
 * \param instance_id the joystick instance ID.
 * \returns the player index of a joystick, or -1 if it's not available.
 *
 * \since This function is available since SDL 3.0.0.
 *
 * \sa SDL_GetJoystickPlayerIndex
 * \sa SDL_GetJoysticks
  }
function SDL_GetJoystickPlayerIndexForID(instance_id:TSDL_JoystickID):longint;cdecl;external;
{*
 * Get the implementation-dependent GUID of a joystick.
 *
 * This can be called before any joysticks are opened.
 *
 * \param instance_id the joystick instance ID.
 * \returns the GUID of the selected joystick. If called with an invalid
 *          instance_id, this function returns a zero GUID.
 *
 * \since This function is available since SDL 3.0.0.
 *
 * \sa SDL_GetJoystickGUID
 * \sa SDL_GUIDToString
  }
function SDL_GetJoystickGUIDForID(instance_id:TSDL_JoystickID):TSDL_GUID;cdecl;external;
{*
 * Get the USB vendor ID of a joystick, if available.
 *
 * This can be called before any joysticks are opened. If the vendor ID isn't
 * available this function returns 0.
 *
 * \param instance_id the joystick instance ID.
 * \returns the USB vendor ID of the selected joystick. If called with an
 *          invalid instance_id, this function returns 0.
 *
 * \since This function is available since SDL 3.0.0.
 *
 * \sa SDL_GetJoystickVendor
 * \sa SDL_GetJoysticks
  }
function SDL_GetJoystickVendorForID(instance_id:TSDL_JoystickID):TUint16;cdecl;external;
{*
 * Get the USB product ID of a joystick, if available.
 *
 * This can be called before any joysticks are opened. If the product ID isn't
 * available this function returns 0.
 *
 * \param instance_id the joystick instance ID.
 * \returns the USB product ID of the selected joystick. If called with an
 *          invalid instance_id, this function returns 0.
 *
 * \since This function is available since SDL 3.0.0.
 *
 * \sa SDL_GetJoystickProduct
 * \sa SDL_GetJoysticks
  }
function SDL_GetJoystickProductForID(instance_id:TSDL_JoystickID):TUint16;cdecl;external;
{*
 * Get the product version of a joystick, if available.
 *
 * This can be called before any joysticks are opened. If the product version
 * isn't available this function returns 0.
 *
 * \param instance_id the joystick instance ID.
 * \returns the product version of the selected joystick. If called with an
 *          invalid instance_id, this function returns 0.
 *
 * \since This function is available since SDL 3.0.0.
 *
 * \sa SDL_GetJoystickProductVersion
 * \sa SDL_GetJoysticks
  }
function SDL_GetJoystickProductVersionForID(instance_id:TSDL_JoystickID):TUint16;cdecl;external;
{*
 * Get the type of a joystick, if available.
 *
 * This can be called before any joysticks are opened.
 *
 * \param instance_id the joystick instance ID.
 * \returns the SDL_JoystickType of the selected joystick. If called with an
 *          invalid instance_id, this function returns
 *          `SDL_JOYSTICK_TYPE_UNKNOWN`.
 *
 * \since This function is available since SDL 3.0.0.
 *
 * \sa SDL_GetJoystickType
 * \sa SDL_GetJoysticks
  }
function SDL_GetJoystickTypeForID(instance_id:TSDL_JoystickID):TSDL_JoystickType;cdecl;external;
{*
 * Open a joystick for use.
 *
 * The joystick subsystem must be initialized before a joystick can be opened
 * for use.
 *
 * \param instance_id the joystick instance ID.
 * \returns a joystick identifier or NULL on failure; call SDL_GetError() for
 *          more information.
 *
 * \since This function is available since SDL 3.0.0.
 *
 * \sa SDL_CloseJoystick
  }
function SDL_OpenJoystick(instance_id:TSDL_JoystickID):PSDL_Joystick;cdecl;external;
{*
 * Get the SDL_Joystick associated with an instance ID, if it has been opened.
 *
 * \param instance_id the instance ID to get the SDL_Joystick for.
 * \returns an SDL_Joystick on success or NULL on failure or if it hasn't been
 *          opened yet; call SDL_GetError() for more information.
 *
 * \since This function is available since SDL 3.0.0.
  }
function SDL_GetJoystickFromID(instance_id:TSDL_JoystickID):PSDL_Joystick;cdecl;external;
{*
 * Get the SDL_Joystick associated with a player index.
 *
 * \param player_index the player index to get the SDL_Joystick for.
 * \returns an SDL_Joystick on success or NULL on failure; call SDL_GetError()
 *          for more information.
 *
 * \since This function is available since SDL 3.0.0.
 *
 * \sa SDL_GetJoystickPlayerIndex
 * \sa SDL_SetJoystickPlayerIndex
  }
function SDL_GetJoystickFromPlayerIndex(player_index:longint):PSDL_Joystick;cdecl;external;
{*
 * The structure that describes a virtual joystick touchpad.
 *
 * \since This struct is available since SDL 3.0.0.
 *
 * \sa SDL_VirtualJoystickDesc
  }
{*< the number of simultaneous fingers on this touchpad  }
type
  PSDL_VirtualJoystickTouchpadDesc = ^TSDL_VirtualJoystickTouchpadDesc;
  TSDL_VirtualJoystickTouchpadDesc = record
      nfingers : TUint16;
      padding : array[0..2] of TUint16;
    end;
{*
 * The structure that describes a virtual joystick sensor.
 *
 * \since This struct is available since SDL 3.0.0.
 *
 * \sa SDL_VirtualJoystickDesc
  }
{*< the type of this sensor  }
{*< the update frequency of this sensor, may be 0.0f  }

  PSDL_VirtualJoystickSensorDesc = ^TSDL_VirtualJoystickSensorDesc;
  TSDL_VirtualJoystickSensorDesc = record
      _type : TSDL_SensorType;
      rate : single;
    end;
{*
 * The structure that describes a virtual joystick.
 *
 * This structure should be initialized using SDL_INIT_INTERFACE(). All
 * elements of this structure are optional.
 *
 * \since This struct is available since SDL 3.0.0.
 *
 * \sa SDL_AttachVirtualJoystick
 * \sa SDL_INIT_INTERFACE
 * \sa SDL_VirtualJoystickSensorDesc
 * \sa SDL_VirtualJoystickTouchpadDesc
  }
{*< the version of this interface  }
{*< `SDL_JoystickType`  }
{*< unused  }
{*< the USB vendor ID of this joystick  }
{*< the USB product ID of this joystick  }
{*< the number of axes on this joystick  }
{*< the number of buttons on this joystick  }
{*< the number of balls on this joystick  }
{*< the number of hats on this joystick  }
{*< the number of touchpads on this joystick, requires `touchpads` to point at valid descriptions  }
{*< the number of sensors on this joystick, requires `sensors` to point at valid descriptions  }
{*< unused  }
{*< A mask of which buttons are valid for this controller
                             e.g. (1 << SDL_GAMEPAD_BUTTON_SOUTH)  }
{*< A mask of which axes are valid for this controller
                             e.g. (1 << SDL_GAMEPAD_AXIS_LEFTX)  }
(* Const before declarator ignored *)
{*< the name of the joystick  }
(* Const before declarator ignored *)
{*< A pointer to an array of touchpad descriptions, required if `ntouchpads` is > 0  }
(* Const before declarator ignored *)
{*< A pointer to an array of sensor descriptions, required if `nsensors` is > 0  }
{*< User data pointer passed to callbacks  }
{*< Called when the joystick state should be updated  }
{*< Called when the player index is set  }
{*< Implements SDL_RumbleJoystick()  }
{*< Implements SDL_RumbleJoystickTriggers()  }
{*< Implements SDL_SetJoystickLED()  }
(* Const before declarator ignored *)
{*< Implements SDL_SendJoystickEffect()  }
{*< Implements SDL_SetGamepadSensorEnabled()  }
{*< Cleans up the userdata when the joystick is detached  }

  PSDL_VirtualJoystickDesc = ^TSDL_VirtualJoystickDesc;
  TSDL_VirtualJoystickDesc = record
      version : TUint32;
      _type : TUint16;
      padding : TUint16;
      vendor_id : TUint16;
      product_id : TUint16;
      naxes : TUint16;
      nbuttons : TUint16;
      nballs : TUint16;
      nhats : TUint16;
      ntouchpads : TUint16;
      nsensors : TUint16;
      padding2 : array[0..1] of TUint16;
      button_mask : TUint32;
      axis_mask : TUint32;
      name : Pansichar;
      touchpads : PSDL_VirtualJoystickTouchpadDesc;
      sensors : PSDL_VirtualJoystickSensorDesc;
      userdata : pointer;
      Update : procedure (userdata:pointer);cdecl;
      SetPlayerIndex : procedure (userdata:pointer; player_index:longint);cdecl;
      Rumble : function (userdata:pointer; low_frequency_rumble:TUint16; high_frequency_rumble:TUint16):Tbool;cdecl;
      RumbleTriggers : function (userdata:pointer; left_rumble:TUint16; right_rumble:TUint16):Tbool;cdecl;
      SetLED : function (userdata:pointer; red:TUint8; green:TUint8; blue:TUint8):Tbool;cdecl;
      SendEffect : function (userdata:pointer; data:pointer; size:longint):Tbool;cdecl;
      SetSensorsEnabled : function (userdata:pointer; enabled:Tbool):Tbool;cdecl;
      Cleanup : procedure (userdata:pointer);cdecl;
    end;
{ Check the size of SDL_VirtualJoystickDesc
 *
 * If this assert fails, either the compiler is padding to an unexpected size,
 * or the interface has been updated and this should be updated to match and
 * the code using this interface should be updated to handle the old version.
  }
{*
 * Attach a new virtual joystick.
 *
 * \param desc joystick description, initialized using SDL_INIT_INTERFACE().
 * \returns the joystick instance ID, or 0 on failure; call SDL_GetError() for
 *          more information.
 *
 * \since This function is available since SDL 3.0.0.
 *
 * \sa SDL_DetachVirtualJoystick
  }
(* Const before declarator ignored *)

function SDL_AttachVirtualJoystick(desc:PSDL_VirtualJoystickDesc):TSDL_JoystickID;cdecl;external;
{*
 * Detach a virtual joystick.
 *
 * \param instance_id the joystick instance ID, previously returned from
 *                    SDL_AttachVirtualJoystick().
 * \returns true on success or false on failure; call SDL_GetError() for more
 *          information.
 *
 * \since This function is available since SDL 3.0.0.
 *
 * \sa SDL_AttachVirtualJoystick
  }
function SDL_DetachVirtualJoystick(instance_id:TSDL_JoystickID):Tbool;cdecl;external;
{*
 * Query whether or not a joystick is virtual.
 *
 * \param instance_id the joystick instance ID.
 * \returns true if the joystick is virtual, false otherwise.
 *
 * \since This function is available since SDL 3.0.0.
  }
function SDL_IsJoystickVirtual(instance_id:TSDL_JoystickID):Tbool;cdecl;external;
{*
 * Set the state of an axis on an opened virtual joystick.
 *
 * Please note that values set here will not be applied until the next call to
 * SDL_UpdateJoysticks, which can either be called directly, or can be called
 * indirectly through various other SDL APIs, including, but not limited to
 * the following: SDL_PollEvent, SDL_PumpEvents, SDL_WaitEventTimeout,
 * SDL_WaitEvent.
 *
 * Note that when sending trigger axes, you should scale the value to the full
 * range of Sint16. For example, a trigger at rest would have the value of
 * `SDL_JOYSTICK_AXIS_MIN`.
 *
 * \param joystick the virtual joystick on which to set state.
 * \param axis the index of the axis on the virtual joystick to update.
 * \param value the new value for the specified axis.
 * \returns true on success or false on failure; call SDL_GetError() for more
 *          information.
 *
 * \since This function is available since SDL 3.0.0.
  }
function SDL_SetJoystickVirtualAxis(joystick:PSDL_Joystick; axis:longint; value:TSint16):Tbool;cdecl;external;
{*
 * Generate ball motion on an opened virtual joystick.
 *
 * Please note that values set here will not be applied until the next call to
 * SDL_UpdateJoysticks, which can either be called directly, or can be called
 * indirectly through various other SDL APIs, including, but not limited to
 * the following: SDL_PollEvent, SDL_PumpEvents, SDL_WaitEventTimeout,
 * SDL_WaitEvent.
 *
 * \param joystick the virtual joystick on which to set state.
 * \param ball the index of the ball on the virtual joystick to update.
 * \param xrel the relative motion on the X axis.
 * \param yrel the relative motion on the Y axis.
 * \returns true on success or false on failure; call SDL_GetError() for more
 *          information.
 *
 * \since This function is available since SDL 3.0.0.
  }
function SDL_SetJoystickVirtualBall(joystick:PSDL_Joystick; ball:longint; xrel:TSint16; yrel:TSint16):Tbool;cdecl;external;
{*
 * Set the state of a button on an opened virtual joystick.
 *
 * Please note that values set here will not be applied until the next call to
 * SDL_UpdateJoysticks, which can either be called directly, or can be called
 * indirectly through various other SDL APIs, including, but not limited to
 * the following: SDL_PollEvent, SDL_PumpEvents, SDL_WaitEventTimeout,
 * SDL_WaitEvent.
 *
 * \param joystick the virtual joystick on which to set state.
 * \param button the index of the button on the virtual joystick to update.
 * \param down true if the button is pressed, false otherwise.
 * \returns true on success or false on failure; call SDL_GetError() for more
 *          information.
 *
 * \since This function is available since SDL 3.0.0.
  }
function SDL_SetJoystickVirtualButton(joystick:PSDL_Joystick; button:longint; down:Tbool):Tbool;cdecl;external;
{*
 * Set the state of a hat on an opened virtual joystick.
 *
 * Please note that values set here will not be applied until the next call to
 * SDL_UpdateJoysticks, which can either be called directly, or can be called
 * indirectly through various other SDL APIs, including, but not limited to
 * the following: SDL_PollEvent, SDL_PumpEvents, SDL_WaitEventTimeout,
 * SDL_WaitEvent.
 *
 * \param joystick the virtual joystick on which to set state.
 * \param hat the index of the hat on the virtual joystick to update.
 * \param value the new value for the specified hat.
 * \returns true on success or false on failure; call SDL_GetError() for more
 *          information.
 *
 * \since This function is available since SDL 3.0.0.
  }
function SDL_SetJoystickVirtualHat(joystick:PSDL_Joystick; hat:longint; value:TUint8):Tbool;cdecl;external;
{*
 * Set touchpad finger state on an opened virtual joystick.
 *
 * Please note that values set here will not be applied until the next call to
 * SDL_UpdateJoysticks, which can either be called directly, or can be called
 * indirectly through various other SDL APIs, including, but not limited to
 * the following: SDL_PollEvent, SDL_PumpEvents, SDL_WaitEventTimeout,
 * SDL_WaitEvent.
 *
 * \param joystick the virtual joystick on which to set state.
 * \param touchpad the index of the touchpad on the virtual joystick to
 *                 update.
 * \param finger the index of the finger on the touchpad to set.
 * \param down true if the finger is pressed, false if the finger is released.
 * \param x the x coordinate of the finger on the touchpad, normalized 0 to 1,
 *          with the origin in the upper left.
 * \param y the y coordinate of the finger on the touchpad, normalized 0 to 1,
 *          with the origin in the upper left.
 * \param pressure the pressure of the finger.
 * \returns true on success or false on failure; call SDL_GetError() for more
 *          information.
 *
 * \since This function is available since SDL 3.0.0.
  }
function SDL_SetJoystickVirtualTouchpad(joystick:PSDL_Joystick; touchpad:longint; finger:longint; down:Tbool; x:single; 
           y:single; pressure:single):Tbool;cdecl;external;
{*
 * Send a sensor update for an opened virtual joystick.
 *
 * Please note that values set here will not be applied until the next call to
 * SDL_UpdateJoysticks, which can either be called directly, or can be called
 * indirectly through various other SDL APIs, including, but not limited to
 * the following: SDL_PollEvent, SDL_PumpEvents, SDL_WaitEventTimeout,
 * SDL_WaitEvent.
 *
 * \param joystick the virtual joystick on which to set state.
 * \param type the type of the sensor on the virtual joystick to update.
 * \param sensor_timestamp a 64-bit timestamp in nanoseconds associated with
 *                         the sensor reading.
 * \param data the data associated with the sensor reading.
 * \param num_values the number of values pointed to by `data`.
 * \returns true on success or false on failure; call SDL_GetError() for more
 *          information.
 *
 * \since This function is available since SDL 3.0.0.
  }
(* Const before declarator ignored *)
function SDL_SendJoystickVirtualSensorData(joystick:PSDL_Joystick; _type:TSDL_SensorType; sensor_timestamp:TUint64; data:Psingle; num_values:longint):Tbool;cdecl;external;
{*
 * Get the properties associated with a joystick.
 *
 * The following read-only properties are provided by SDL:
 *
 * - `SDL_PROP_JOYSTICK_CAP_MONO_LED_BOOLEAN`: true if this joystick has an
 *   LED that has adjustable brightness
 * - `SDL_PROP_JOYSTICK_CAP_RGB_LED_BOOLEAN`: true if this joystick has an LED
 *   that has adjustable color
 * - `SDL_PROP_JOYSTICK_CAP_PLAYER_LED_BOOLEAN`: true if this joystick has a
 *   player LED
 * - `SDL_PROP_JOYSTICK_CAP_RUMBLE_BOOLEAN`: true if this joystick has
 *   left/right rumble
 * - `SDL_PROP_JOYSTICK_CAP_TRIGGER_RUMBLE_BOOLEAN`: true if this joystick has
 *   simple trigger rumble
 *
 * \param joystick the SDL_Joystick obtained from SDL_OpenJoystick().
 * \returns a valid property ID on success or 0 on failure; call
 *          SDL_GetError() for more information.
 *
 * \since This function is available since SDL 3.0.0.
  }
function SDL_GetJoystickProperties(joystick:PSDL_Joystick):TSDL_PropertiesID;cdecl;external;
const
  SDL_PROP_JOYSTICK_CAP_MONO_LED_BOOLEAN = 'SDL.joystick.cap.mono_led';  
  SDL_PROP_JOYSTICK_CAP_RGB_LED_BOOLEAN = 'SDL.joystick.cap.rgb_led';  
  SDL_PROP_JOYSTICK_CAP_PLAYER_LED_BOOLEAN = 'SDL.joystick.cap.player_led';  
  SDL_PROP_JOYSTICK_CAP_RUMBLE_BOOLEAN = 'SDL.joystick.cap.rumble';  
  SDL_PROP_JOYSTICK_CAP_TRIGGER_RUMBLE_BOOLEAN = 'SDL.joystick.cap.trigger_rumble';  
{*
 * Get the implementation dependent name of a joystick.
 *
 * \param joystick the SDL_Joystick obtained from SDL_OpenJoystick().
 * \returns the name of the selected joystick. If no name can be found, this
 *          function returns NULL; call SDL_GetError() for more information.
 *
 * \since This function is available since SDL 3.0.0.
 *
 * \sa SDL_GetJoystickNameForID
  }
(* Const before declarator ignored *)

function SDL_GetJoystickName(joystick:PSDL_Joystick):Pansichar;cdecl;external;
{*
 * Get the implementation dependent path of a joystick.
 *
 * \param joystick the SDL_Joystick obtained from SDL_OpenJoystick().
 * \returns the path of the selected joystick. If no path can be found, this
 *          function returns NULL; call SDL_GetError() for more information.
 *
 * \since This function is available since SDL 3.0.0.
 *
 * \sa SDL_GetJoystickPathForID
  }
(* Const before declarator ignored *)
function SDL_GetJoystickPath(joystick:PSDL_Joystick):Pansichar;cdecl;external;
{*
 * Get the player index of an opened joystick.
 *
 * For XInput controllers this returns the XInput user index. Many joysticks
 * will not be able to supply this information.
 *
 * \param joystick the SDL_Joystick obtained from SDL_OpenJoystick().
 * \returns the player index, or -1 if it's not available.
 *
 * \since This function is available since SDL 3.0.0.
 *
 * \sa SDL_SetJoystickPlayerIndex
  }
function SDL_GetJoystickPlayerIndex(joystick:PSDL_Joystick):longint;cdecl;external;
{*
 * Set the player index of an opened joystick.
 *
 * \param joystick the SDL_Joystick obtained from SDL_OpenJoystick().
 * \param player_index player index to assign to this joystick, or -1 to clear
 *                     the player index and turn off player LEDs.
 * \returns true on success or false on failure; call SDL_GetError() for more
 *          information.
 *
 * \since This function is available since SDL 3.0.0.
 *
 * \sa SDL_GetJoystickPlayerIndex
  }
function SDL_SetJoystickPlayerIndex(joystick:PSDL_Joystick; player_index:longint):Tbool;cdecl;external;
{*
 * Get the implementation-dependent GUID for the joystick.
 *
 * This function requires an open joystick.
 *
 * \param joystick the SDL_Joystick obtained from SDL_OpenJoystick().
 * \returns the GUID of the given joystick. If called on an invalid index,
 *          this function returns a zero GUID; call SDL_GetError() for more
 *          information.
 *
 * \since This function is available since SDL 3.0.0.
 *
 * \sa SDL_GetJoystickGUIDForID
 * \sa SDL_GUIDToString
  }
function SDL_GetJoystickGUID(joystick:PSDL_Joystick):TSDL_GUID;cdecl;external;
{*
 * Get the USB vendor ID of an opened joystick, if available.
 *
 * If the vendor ID isn't available this function returns 0.
 *
 * \param joystick the SDL_Joystick obtained from SDL_OpenJoystick().
 * \returns the USB vendor ID of the selected joystick, or 0 if unavailable.
 *
 * \since This function is available since SDL 3.0.0.
 *
 * \sa SDL_GetJoystickVendorForID
  }
function SDL_GetJoystickVendor(joystick:PSDL_Joystick):TUint16;cdecl;external;
{*
 * Get the USB product ID of an opened joystick, if available.
 *
 * If the product ID isn't available this function returns 0.
 *
 * \param joystick the SDL_Joystick obtained from SDL_OpenJoystick().
 * \returns the USB product ID of the selected joystick, or 0 if unavailable.
 *
 * \since This function is available since SDL 3.0.0.
 *
 * \sa SDL_GetJoystickProductForID
  }
function SDL_GetJoystickProduct(joystick:PSDL_Joystick):TUint16;cdecl;external;
{*
 * Get the product version of an opened joystick, if available.
 *
 * If the product version isn't available this function returns 0.
 *
 * \param joystick the SDL_Joystick obtained from SDL_OpenJoystick().
 * \returns the product version of the selected joystick, or 0 if unavailable.
 *
 * \since This function is available since SDL 3.0.0.
 *
 * \sa SDL_GetJoystickProductVersionForID
  }
function SDL_GetJoystickProductVersion(joystick:PSDL_Joystick):TUint16;cdecl;external;
{*
 * Get the firmware version of an opened joystick, if available.
 *
 * If the firmware version isn't available this function returns 0.
 *
 * \param joystick the SDL_Joystick obtained from SDL_OpenJoystick().
 * \returns the firmware version of the selected joystick, or 0 if
 *          unavailable.
 *
 * \since This function is available since SDL 3.0.0.
  }
function SDL_GetJoystickFirmwareVersion(joystick:PSDL_Joystick):TUint16;cdecl;external;
{*
 * Get the serial number of an opened joystick, if available.
 *
 * Returns the serial number of the joystick, or NULL if it is not available.
 *
 * \param joystick the SDL_Joystick obtained from SDL_OpenJoystick().
 * \returns the serial number of the selected joystick, or NULL if
 *          unavailable.
 *
 * \since This function is available since SDL 3.0.0.
  }
(* Const before declarator ignored *)
function SDL_GetJoystickSerial(joystick:PSDL_Joystick):Pansichar;cdecl;external;
{*
 * Get the type of an opened joystick.
 *
 * \param joystick the SDL_Joystick obtained from SDL_OpenJoystick().
 * \returns the SDL_JoystickType of the selected joystick.
 *
 * \since This function is available since SDL 3.0.0.
 *
 * \sa SDL_GetJoystickTypeForID
  }
function SDL_GetJoystickType(joystick:PSDL_Joystick):TSDL_JoystickType;cdecl;external;
{*
 * Get the device information encoded in a SDL_GUID structure.
 *
 * \param guid the SDL_GUID you wish to get info about.
 * \param vendor a pointer filled in with the device VID, or 0 if not
 *               available.
 * \param product a pointer filled in with the device PID, or 0 if not
 *                available.
 * \param version a pointer filled in with the device version, or 0 if not
 *                available.
 * \param crc16 a pointer filled in with a CRC used to distinguish different
 *              products with the same VID/PID, or 0 if not available.
 *
 * \since This function is available since SDL 3.0.0.
 *
 * \sa SDL_GetJoystickGUIDForID
  }
procedure SDL_GetJoystickGUIDInfo(guid:TSDL_GUID; vendor:PUint16; product:PUint16; version:PUint16; crc16:PUint16);cdecl;external;
{*
 * Get the status of a specified joystick.
 *
 * \param joystick the joystick to query.
 * \returns true if the joystick has been opened, false if it has not; call
 *          SDL_GetError() for more information.
 *
 * \since This function is available since SDL 3.0.0.
  }
function SDL_JoystickConnected(joystick:PSDL_Joystick):Tbool;cdecl;external;
{*
 * Get the instance ID of an opened joystick.
 *
 * \param joystick an SDL_Joystick structure containing joystick information.
 * \returns the instance ID of the specified joystick on success or 0 on
 *          failure; call SDL_GetError() for more information.
 *
 * \since This function is available since SDL 3.0.0.
  }
function SDL_GetJoystickID(joystick:PSDL_Joystick):TSDL_JoystickID;cdecl;external;
{*
 * Get the number of general axis controls on a joystick.
 *
 * Often, the directional pad on a game controller will either look like 4
 * separate buttons or a POV hat, and not axes, but all of this is up to the
 * device and platform.
 *
 * \param joystick an SDL_Joystick structure containing joystick information.
 * \returns the number of axis controls/number of axes on success or -1 on
 *          failure; call SDL_GetError() for more information.
 *
 * \since This function is available since SDL 3.0.0.
 *
 * \sa SDL_GetJoystickAxis
 * \sa SDL_GetNumJoystickBalls
 * \sa SDL_GetNumJoystickButtons
 * \sa SDL_GetNumJoystickHats
  }
function SDL_GetNumJoystickAxes(joystick:PSDL_Joystick):longint;cdecl;external;
{*
 * Get the number of trackballs on a joystick.
 *
 * Joystick trackballs have only relative motion events associated with them
 * and their state cannot be polled.
 *
 * Most joysticks do not have trackballs.
 *
 * \param joystick an SDL_Joystick structure containing joystick information.
 * \returns the number of trackballs on success or -1 on failure; call
 *          SDL_GetError() for more information.
 *
 * \since This function is available since SDL 3.0.0.
 *
 * \sa SDL_GetJoystickBall
 * \sa SDL_GetNumJoystickAxes
 * \sa SDL_GetNumJoystickButtons
 * \sa SDL_GetNumJoystickHats
  }
function SDL_GetNumJoystickBalls(joystick:PSDL_Joystick):longint;cdecl;external;
{*
 * Get the number of POV hats on a joystick.
 *
 * \param joystick an SDL_Joystick structure containing joystick information.
 * \returns the number of POV hats on success or -1 on failure; call
 *          SDL_GetError() for more information.
 *
 * \since This function is available since SDL 3.0.0.
 *
 * \sa SDL_GetJoystickHat
 * \sa SDL_GetNumJoystickAxes
 * \sa SDL_GetNumJoystickBalls
 * \sa SDL_GetNumJoystickButtons
  }
function SDL_GetNumJoystickHats(joystick:PSDL_Joystick):longint;cdecl;external;
{*
 * Get the number of buttons on a joystick.
 *
 * \param joystick an SDL_Joystick structure containing joystick information.
 * \returns the number of buttons on success or -1 on failure; call
 *          SDL_GetError() for more information.
 *
 * \since This function is available since SDL 3.0.0.
 *
 * \sa SDL_GetJoystickButton
 * \sa SDL_GetNumJoystickAxes
 * \sa SDL_GetNumJoystickBalls
 * \sa SDL_GetNumJoystickHats
  }
function SDL_GetNumJoystickButtons(joystick:PSDL_Joystick):longint;cdecl;external;
{*
 * Set the state of joystick event processing.
 *
 * If joystick events are disabled, you must call SDL_UpdateJoysticks()
 * yourself and check the state of the joystick when you want joystick
 * information.
 *
 * \param enabled whether to process joystick events or not.
 *
 * \since This function is available since SDL 3.0.0.
 *
 * \sa SDL_JoystickEventsEnabled
 * \sa SDL_UpdateJoysticks
  }
procedure SDL_SetJoystickEventsEnabled(enabled:Tbool);cdecl;external;
{*
 * Query the state of joystick event processing.
 *
 * If joystick events are disabled, you must call SDL_UpdateJoysticks()
 * yourself and check the state of the joystick when you want joystick
 * information.
 *
 * \returns true if joystick events are being processed, false otherwise.
 *
 * \since This function is available since SDL 3.0.0.
 *
 * \sa SDL_SetJoystickEventsEnabled
  }
function SDL_JoystickEventsEnabled:Tbool;cdecl;external;
{*
 * Update the current state of the open joysticks.
 *
 * This is called automatically by the event loop if any joystick events are
 * enabled.
 *
 * \since This function is available since SDL 3.0.0.
  }
procedure SDL_UpdateJoysticks;cdecl;external;
{*
 * Get the current state of an axis control on a joystick.
 *
 * SDL makes no promises about what part of the joystick any given axis refers
 * to. Your game should have some sort of configuration UI to let users
 * specify what each axis should be bound to. Alternately, SDL's higher-level
 * Game Controller API makes a great effort to apply order to this lower-level
 * interface, so you know that a specific axis is the "left thumb stick," etc.
 *
 * The value returned by SDL_GetJoystickAxis() is a signed integer (-32768 to
 * 32767) representing the current position of the axis. It may be necessary
 * to impose certain tolerances on these values to account for jitter.
 *
 * \param joystick an SDL_Joystick structure containing joystick information.
 * \param axis the axis to query; the axis indices start at index 0.
 * \returns a 16-bit signed integer representing the current position of the
 *          axis or 0 on failure; call SDL_GetError() for more information.
 *
 * \since This function is available since SDL 3.0.0.
 *
 * \sa SDL_GetNumJoystickAxes
  }
function SDL_GetJoystickAxis(joystick:PSDL_Joystick; axis:longint):TSint16;cdecl;external;
{*
 * Get the initial state of an axis control on a joystick.
 *
 * The state is a value ranging from -32768 to 32767.
 *
 * The axis indices start at index 0.
 *
 * \param joystick an SDL_Joystick structure containing joystick information.
 * \param axis the axis to query; the axis indices start at index 0.
 * \param state upon return, the initial value is supplied here.
 * \returns true if this axis has any initial value, or false if not.
 *
 * \since This function is available since SDL 3.0.0.
  }
function SDL_GetJoystickAxisInitialState(joystick:PSDL_Joystick; axis:longint; state:PSint16):Tbool;cdecl;external;
{*
 * Get the ball axis change since the last poll.
 *
 * Trackballs can only return relative motion since the last call to
 * SDL_GetJoystickBall(), these motion deltas are placed into `dx` and `dy`.
 *
 * Most joysticks do not have trackballs.
 *
 * \param joystick the SDL_Joystick to query.
 * \param ball the ball index to query; ball indices start at index 0.
 * \param dx stores the difference in the x axis position since the last poll.
 * \param dy stores the difference in the y axis position since the last poll.
 * \returns true on success or false on failure; call SDL_GetError() for more
 *          information.
 *
 * \since This function is available since SDL 3.0.0.
 *
 * \sa SDL_GetNumJoystickBalls
  }
function SDL_GetJoystickBall(joystick:PSDL_Joystick; ball:longint; dx:Plongint; dy:Plongint):Tbool;cdecl;external;
{*
 * Get the current state of a POV hat on a joystick.
 *
 * The returned value will be one of the `SDL_HAT_*` values.
 *
 * \param joystick an SDL_Joystick structure containing joystick information.
 * \param hat the hat index to get the state from; indices start at index 0.
 * \returns the current hat position.
 *
 * \since This function is available since SDL 3.0.0.
 *
 * \sa SDL_GetNumJoystickHats
  }
function SDL_GetJoystickHat(joystick:PSDL_Joystick; hat:longint):TUint8;cdecl;external;
const
  SDL_HAT_CENTERED = $00;  
  SDL_HAT_UP = $01;  
  SDL_HAT_RIGHT = $02;  
  SDL_HAT_DOWN = $04;  
  SDL_HAT_LEFT = $08;  
  SDL_HAT_RIGHTUP = SDL_HAT_RIGHT or SDL_HAT_UP;  
  SDL_HAT_RIGHTDOWN = SDL_HAT_RIGHT or SDL_HAT_DOWN;  
  SDL_HAT_LEFTUP = SDL_HAT_LEFT or SDL_HAT_UP;  
  SDL_HAT_LEFTDOWN = SDL_HAT_LEFT or SDL_HAT_DOWN;  
{*
 * Get the current state of a button on a joystick.
 *
 * \param joystick an SDL_Joystick structure containing joystick information.
 * \param button the button index to get the state from; indices start at
 *               index 0.
 * \returns true if the button is pressed, false otherwise.
 *
 * \since This function is available since SDL 3.0.0.
 *
 * \sa SDL_GetNumJoystickButtons
  }

function SDL_GetJoystickButton(joystick:PSDL_Joystick; button:longint):Tbool;cdecl;external;
{*
 * Start a rumble effect.
 *
 * Each call to this function cancels any previous rumble effect, and calling
 * it with 0 intensity stops any rumbling.
 *
 * This function requires you to process SDL events or call
 * SDL_UpdateJoysticks() to update rumble state.
 *
 * \param joystick the joystick to vibrate.
 * \param low_frequency_rumble the intensity of the low frequency (left)
 *                             rumble motor, from 0 to 0xFFFF.
 * \param high_frequency_rumble the intensity of the high frequency (right)
 *                              rumble motor, from 0 to 0xFFFF.
 * \param duration_ms the duration of the rumble effect, in milliseconds.
 * \returns true, or false if rumble isn't supported on this joystick.
 *
 * \since This function is available since SDL 3.0.0.
  }
function SDL_RumbleJoystick(joystick:PSDL_Joystick; low_frequency_rumble:TUint16; high_frequency_rumble:TUint16; duration_ms:TUint32):Tbool;cdecl;external;
{*
 * Start a rumble effect in the joystick's triggers.
 *
 * Each call to this function cancels any previous trigger rumble effect, and
 * calling it with 0 intensity stops any rumbling.
 *
 * Note that this is rumbling of the _triggers_ and not the game controller as
 * a whole. This is currently only supported on Xbox One controllers. If you
 * want the (more common) whole-controller rumble, use SDL_RumbleJoystick()
 * instead.
 *
 * This function requires you to process SDL events or call
 * SDL_UpdateJoysticks() to update rumble state.
 *
 * \param joystick the joystick to vibrate.
 * \param left_rumble the intensity of the left trigger rumble motor, from 0
 *                    to 0xFFFF.
 * \param right_rumble the intensity of the right trigger rumble motor, from 0
 *                     to 0xFFFF.
 * \param duration_ms the duration of the rumble effect, in milliseconds.
 * \returns true on success or false on failure; call SDL_GetError() for more
 *          information.
 *
 * \since This function is available since SDL 3.0.0.
 *
 * \sa SDL_RumbleJoystick
  }
function SDL_RumbleJoystickTriggers(joystick:PSDL_Joystick; left_rumble:TUint16; right_rumble:TUint16; duration_ms:TUint32):Tbool;cdecl;external;
{*
 * Update a joystick's LED color.
 *
 * An example of a joystick LED is the light on the back of a PlayStation 4's
 * DualShock 4 controller.
 *
 * For joysticks with a single color LED, the maximum of the RGB values will
 * be used as the LED brightness.
 *
 * \param joystick the joystick to update.
 * \param red the intensity of the red LED.
 * \param green the intensity of the green LED.
 * \param blue the intensity of the blue LED.
 * \returns true on success or false on failure; call SDL_GetError() for more
 *          information.
 *
 * \since This function is available since SDL 3.0.0.
  }
function SDL_SetJoystickLED(joystick:PSDL_Joystick; red:TUint8; green:TUint8; blue:TUint8):Tbool;cdecl;external;
{*
 * Send a joystick specific effect packet.
 *
 * \param joystick the joystick to affect.
 * \param data the data to send to the joystick.
 * \param size the size of the data to send to the joystick.
 * \returns true on success or false on failure; call SDL_GetError() for more
 *          information.
 *
 * \since This function is available since SDL 3.0.0.
  }
(* Const before declarator ignored *)
function SDL_SendJoystickEffect(joystick:PSDL_Joystick; data:pointer; size:longint):Tbool;cdecl;external;
{*
 * Close a joystick previously opened with SDL_OpenJoystick().
 *
 * \param joystick the joystick device to close.
 *
 * \since This function is available since SDL 3.0.0.
 *
 * \sa SDL_OpenJoystick
  }
procedure SDL_CloseJoystick(joystick:PSDL_Joystick);cdecl;external;
{*
 * Get the connection state of a joystick.
 *
 * \param joystick the joystick to query.
 * \returns the connection state on success or
 *          `SDL_JOYSTICK_CONNECTION_INVALID` on failure; call SDL_GetError()
 *          for more information.
 *
 * \since This function is available since SDL 3.0.0.
  }
function SDL_GetJoystickConnectionState(joystick:PSDL_Joystick):TSDL_JoystickConnectionState;cdecl;external;
{*
 * Get the battery state of a joystick.
 *
 * You should never take a battery status as absolute truth. Batteries
 * (especially failing batteries) are delicate hardware, and the values
 * reported here are best estimates based on what that hardware reports. It's
 * not uncommon for older batteries to lose stored power much faster than it
 * reports, or completely drain when reporting it has 20 percent left, etc.
 *
 * \param joystick the joystick to query.
 * \param percent a pointer filled in with the percentage of battery life
 *                left, between 0 and 100, or NULL to ignore. This will be
 *                filled in with -1 we can't determine a value or there is no
 *                battery.
 * \returns the current battery state or `SDL_POWERSTATE_ERROR` on failure;
 *          call SDL_GetError() for more information.
 *
 * \since This function is available since SDL 3.0.0.
  }
function SDL_GetJoystickPowerInfo(joystick:PSDL_Joystick; percent:Plongint):TSDL_PowerState;cdecl;external;
{ Ends C function definitions when using C++  }
{ C++ end of extern C conditionnal removed }
{$include <SDL3/SDL_close_code.h>}
{$endif}
{ SDL_joystick_h_  }

implementation


end.
