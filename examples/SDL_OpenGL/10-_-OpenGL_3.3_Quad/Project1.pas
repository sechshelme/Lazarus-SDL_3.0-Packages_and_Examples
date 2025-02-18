program Project1;

uses
  SDL3,
  oglglad_gl,
  oglVector,
  oglMatrix,
  //  oglTextur,
  oglShader;

  {$ifdef LCL}
  //ShowMessage('Error');
  {$else}
  //Writeln('Error');
  {$endif}

const
  Screen_Widht = 320;
  Screen_Height = 240;

var
  // SDL
  glcontext: TSDL_GLContext;
  gWindow: PSDL_Window;

  quit: boolean = False;
  e: TSDL_Event;

  // OpenGL
  MyShader: TShader;
  ModelMatrix: Tmat4x4;

  VAOs: array [(vaQuad)] of TGLuint;
  Mesh_Buffers: array [(mbVector)] of TGLuint;

const
  QuadVertex: array of TVector3f =
    ((-0.6, -0.6, 0.0), (0.6, 0.6, 0.0), (-0.6, 0.6, 0.0),
    (-0.6, -0.6, 0.0), (0.6, -0.6, 0.0), (0.6, 0.6, 0.0));

  vertex_shader_text: string =
    '#version 330 core' + #10 +
    '' + #10 +
    'layout (location = 0) in vec3 vPosition;' + #10 +
    '' + #10 +
    'uniform mat4x4 matrix;' + #10 +
    '' + #10 +
    'void main()' + #10 +
    '{' + #10 +
    '  gl_Position = matrix * vec4(vPosition, 1);' + #10 +
    '}';

  fragment_shader_text =
    '#version 330 core' + #10 +
    '' + #10 +
    'out vec4 fColor;' + #10 +
    '' + #10 +
    'void main()' + #10 +
    '{' + #10 +
    '  fColor = vec4(1.0, 0.5, 0.0, 1.0);' + #10 +
    '}';


  procedure Init_SDL_and_OpenGL;
  begin
    // --- SDL inizialisieren
    if not SDL_Init(SDL_INIT_VIDEO) then begin
      WriteLn('SDL could not initialize! SDL_Error: ', SDL_GetError);
      Halt(1);
    end;

    // --- Context für OpenGL erzeugen
    SDL_GL_SetAttribute(SDL_GL_CONTEXT_MAJOR_VERSION, 3);
    SDL_GL_SetAttribute(SDL_GL_CONTEXT_MINOR_VERSION, 3);
    SDL_GL_SetAttribute(SDL_GL_CONTEXT_PROFILE_MASK, SDL_GL_CONTEXT_PROFILE_CORE);

    gwindow := SDL_CreateWindow('SDL3 Window', Screen_Widht, Screen_Height, SDL_WINDOW_OPENGL or SDL_WINDOW_RESIZABLE);
    glcontext := SDL_GL_CreateContext(gWindow);
    if glcontext = nil then begin
      Writeln('OpenGL context could not be created! SDL Error: ', SDL_GetError);
      Halt(1);
    end;

    if not SDL_GL_SetSwapInterval(1) then begin
      WriteLn('Warning: Unable to set VSync! SDL Error: ', SDL_GetError);
    end;

    Load_GLADE;
    ModelMatrix.Identity;
  end;

  procedure CreateScene;
  begin
    glGenVertexArrays(Length(VAOs), VAOs);
    glGenBuffers(Length(Mesh_Buffers), Mesh_Buffers);

    glBindVertexArray(VAOs[vaQuad]);

    // Vector
    glBindBuffer(GL_ARRAY_BUFFER, Mesh_Buffers[mbVector]);
    glBufferData(GL_ARRAY_BUFFER, Length(QuadVertex) * sizeof(TVector3f), PVector3f(QuadVertex), GL_STATIC_DRAW);

    glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 0, nil);
    glEnableVertexAttribArray(0);

    glBindVertexArray(0);

    // Shader
    MyShader := TShader.Create;
    MyShader.LoadShaderObject(GL_VERTEX_SHADER, vertex_shader_text);
    MyShader.LoadShaderObject(GL_FRAGMENT_SHADER, fragment_shader_text);
    MyShader.LinkProgram;
    MyShader.UseProgram;
  end;


  procedure DrawScene;
  const
    black: TVector4f = (0.3, 0.0, 0.2, 1.0);
  var
    mat_id: GLint;
  begin
    glClearBufferfv(GL_COLOR, 0, black);

    ModelMatrix.RotateC(0.01);
    mat_id := MyShader.UniformLocation('matrix');
    ModelMatrix.Uniform(mat_id);

    glBindVertexArray(VAOs[vaQuad]);
    glDrawArrays(GL_TRIANGLES, 0, Length(QuadVertex));

    SDL_GL_SwapWindow(gWindow);
  end;

  procedure Destroy_SDL_and_OpenGL;
  begin
    glDeleteVertexArrays(Length(VAOs), VAOs);
    glDeleteBuffers(Length(Mesh_Buffers), Mesh_Buffers);

    MyShader.Free;

    SDL_GL_DestroyContext(glcontext);
    SDL_DestroyWindow(gWindow);
    SDL_Quit();
  end;

  procedure RunScene;
  var
    w, h: int32;
  begin
    while not quit do begin
      while SDL_PollEvent(@e) do begin
        case e._type of
          SDL_EVENT_KEY_DOWN: begin
            case e.key.key of
              SDLK_ESCAPE: begin
                quit := True;
              end;
            end;
          end;
          SDL_EVENT_WINDOW_RESIZED: begin
            w := e.window.data1;
            h := e.window.data2;
            glViewport(0, 0, w, h);
          end;
          SDL_EVENT_QUIT: begin
            quit := True;
          end;
        end;
      end;
      DrawScene;
    end;
  end;

begin
  Init_SDL_and_OpenGL;
  CreateScene;
  RunScene;
  Destroy_SDL_and_OpenGL;
end.
