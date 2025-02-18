program Project1;

uses
  ctypes,
  SDL3;

const
  Width = 800;
  heigt = 600;

var
  window: PSDL_Window;
  renderer: PSDL_Renderer;

  procedure SDLMain;
  const
    step = 0.01;
  var
    e: TSDL_Event;
    quit: boolean = False;
    rDest: TSDL_FRect;
    time: extended;
    red, green, blue: single;
    keyStat: PBoolean;
    motion: TSDL_MouseMotionEvent;

  begin
    rDest.w := 100;
    rDest.h := 100;
    rDest.x := (Width - rDest.w) / 2;
    rDest.y := (heigt - rDest.h) / 2;
    while not quit do begin
      keyStat := SDL_GetKeyboardState(nil);
      if keyStat[SDL_SCANCODE_SPACE] then begin
      end;

      if keyStat[SDL_SCANCODE_RIGHT] then begin
        if keyStat[SDL_SCANCODE_LSHIFT] then begin
          rDest.x -= step;
          rDest.w += step * 2;
        end else begin
          rDest.x += step;
        end;
      end;
      if keyStat[SDL_SCANCODE_LEFT] then begin
        if keyStat[SDL_SCANCODE_LSHIFT] then begin
          if rDest.w > 1 then begin
            rDest.x += step;
            rDest.w -= step * 2;
          end;
        end else begin
          rDest.x -= step;
        end;
      end;
      if keyStat[SDL_SCANCODE_DOWN] then begin
        if keyStat[SDL_SCANCODE_LSHIFT] then begin
          rDest.y -= step;
          rDest.h += step * 2;
        end else begin
          rDest.y += step;
        end;
      end;
      if keyStat[SDL_SCANCODE_UP] then begin
        if keyStat[SDL_SCANCODE_LSHIFT] then begin
          if rDest.h > 1 then begin
            rDest.y += step;
            rDest.h -= step * 2;
          end;
        end else begin
          rDest.y -= step;
        end;
      end;

      while SDL_PollEvent(@e) do begin
        case e._type of
          SDL_EVENT_MOUSE_MOTION:begin
            motion:=e.motion;
          end;

          SDL_EVENT_KEY_DOWN: begin
            case e.key.key of

              SDLK_ESCAPE: begin
                quit := True;
              end;
            end;
          end;
          SDL_EVENT_QUIT: begin
            quit := True;
          end;
        end;
      end;

      time := SDL_GetTicks / 1000;
      red := (SDL_sinf(time) + 1) / 2.0;
      green := (SDL_sinf(time / 2) + 1) / 2.0;
      blue := (SDL_sinf(time / 3) + 1) / 2.0;

      SDL_SetRenderDrawColorFloat(renderer, red, green, blue, SDL_ALPHA_OPAQUE);
      SDL_RenderClear(renderer);

      SDL_SetRenderDrawColorFloat(renderer, 0.0, 1.0, 0.0, SDL_ALPHA_OPAQUE_FLOAT);
      SDL_RenderFillRect(renderer, @rDest);

      SDL_SetRenderDrawColorFloat(renderer, 1.0, 1.0, 1.0, SDL_ALPHA_OPAQUE_FLOAT);
      SDL_RenderDebugText(renderer, 10, 10, 'Lines 1');
      SDL_RenderDebugText(renderer, 10, 30, 'Lines 2');
      SDL_RenderDebugTextFormat(renderer, 10, 50, 'X: %6.2f Y: %6.2f W: %6.2f H: %6.2f  ', rDest.x, rDest.y, rDest.w, rDest.h);
      SDL_RenderDebugTextFormat(renderer, 10, 70, 'Mouse Pos: %6.2f x %6.2f  Real Pos:  %6.2f x %6.2f', motion.x,motion.y, motion.xrel,motion.yrel);
      SDL_RenderPresent(renderer);
    end;
  end;

begin
  SDL_init(SDL_INIT_VIDEO);

  SDL_CreateWindowAndRenderer('Debug Text', Width, heigt, SDL_WINDOW_HIDDEN, @window, @renderer);

  SDL_ShowWindow(window);

  SDLMain;

  SDL_DestroyRenderer(renderer);
  SDL_DestroyWindow(window);

  SDL_Quit;
end.
