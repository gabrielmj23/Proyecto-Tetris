unit usuarios;

// Público ---------------------------------------------------------------------
interface
  uses tiposYConst;

  function validarUsuario(JugEntrada: Jugador): Boolean;
  function validarClave(JugEntrada: Jugador): byte;
  function validarCorreo(JugEntrada: Jugador): boolean;
  procedure registro(JugEntrada: Jugador);
  function validarSesion(var JugEntrada: Jugador): Boolean;

// Privado ---------------------------------------------------------------------
implementation
uses sysutils;

var
  Jugadores: file of Jugador;

//VALIDACIÓN DEL USUARIO A REGISTRAR
function validarUsuario(JugEntrada: Jugador): Boolean;
var
  JugArc: Jugador;
begin
  assignFile(Jugadores, 'Jugadores.dat');
  if fileExists('Jugadores.dat') then
    reset(Jugadores)
  else
    rewrite(Jugadores);

  // Revisar que no exista ya el usuario
  validarUsuario := True;
  while (not eof(Jugadores)) and (validarUsuario) do
    begin
      read(Jugadores, JugArc);
      if (JugArc.Usuario = JugEntrada.Usuario) then
        validarUsuario := False;
    end;
  closeFile(Jugadores);
end;

//VALIDACIÓN DE LA CLAVE A REGISTRAR
function validarClave(JugEntrada: Jugador): byte;
var
  Ultletra: char;
  i, contig: byte;
  Min, May, Num, CarEsp: boolean;
begin
  validarClave := 0;
  // Validar longitud
  if (length(JugEntrada.Clave)>=8) and (length(JugEntrada.Clave)<=10) then
    begin
      // Validar que se utilicen caracteres adecuados
      for i:=1 to length(JugEntrada.Clave) do
        begin
          if (JugEntrada.Clave[i]>='a') and (JugEntrada.Clave[i]<='z') then
            Min:= true;
          if (JugEntrada.Clave[i]>='A') and (JugEntrada.Clave[i]<='Z') then
            May:= true;
          if (JugEntrada.Clave[i]>='0') and (JugEntrada.Clave[i]<='9') then
            Num:= true;
          if (JugEntrada.Clave[i]='=') or (JugEntrada.Clave[i]='*') or (JugEntrada.Clave[i]='-') or (JugEntrada.Clave[i]='_') or (JugEntrada.Clave[i]='.') then
            CarEsp:= true;
        end;
      if not Min then
        validarClave := 2;
      if not May then
        validarClave := 3;
      if not Num then
        validarClave := 4;
      if not CarEsp then
        validarClave := 5;
      // Validar que no aparezcan más de tres teclas iguales seguidas
      Contig:= 1;
      Ultletra:=' ';
      for i:=1 to length(JugEntrada.Clave) do
        begin
          if (JugEntrada.Clave[i]=Ultletra) then
            Contig:= Contig+1
          else
            Contig:=1;
          if (Contig>3) then
            ValidarClave:=6;
          Ultletra:=JugEntrada.Clave[i];
        end;
    end
  else
    // Longitud de clave inválida
    validarClave := 1;
end;

//VALIDACIÓN DEL CORREO A REGISTRAR
function validarCorreo(JugEntrada: Jugador): boolean;
VAR
  i, cont: byte;
  arroba, pto: boolean;
begin
  cont:=0;
  validarCorreo:=false;
  arroba:=false;
  pto:=false;
  for i:=1 to length(JugEntrada.Correo) do
    begin
      cont:=cont+1;
      // Validar que esté el @
      if (JugEntrada.Correo[i]='@') and (cont>1) then
        begin
          cont:=0;
          arroba:=true;
        end;
      // Validar que esté el . luego del @
      if (JugEntrada.Correo[i]='.') and (arroba=True) and (cont>1) then
        begin
          cont:=0;
          pto:=true;
        end;
      // Validar que haya algo luego del .
      if (cont>0) and (pto=True) then
        validarCorreo:=true;
    end;
end;

// REGISTRAR JUGADOR
procedure registro(JugEntrada: Jugador);
begin
  assignFile(Jugadores, 'Jugadores.dat');
  reset(jugadores);
  seek(Jugadores, filesize(Jugadores));
  write(Jugadores, JugEntrada);
  closeFile(Jugadores);
end;

// VALIDACIÓN DE LA SESIÓN DEL JUGADOR
function validarSesion(var JugEntrada: Jugador): Boolean;
var
  JugArc: Jugador;
begin
  validarSesion := False;
  // Solo intentar si existe archivo de jugadores
  if fileExists('Jugadores.dat') then
    begin
      assignFile(Jugadores, 'Jugadores.dat');
      reset(Jugadores);
      while (not eof(Jugadores)) and (not validarSesion) do
        begin
          read(Jugadores, JugArc);
          // Validar si existe el usuario y si su clave guardada es igual a la ingresada
          if (JugArc.Usuario = JugEntrada.Usuario) then
            if (JugArc.Clave = JugEntrada.Clave) then
              begin
                validarSesion:=true;
                JugEntrada := JugArc;
              end;
        end;
      closeFile(Jugadores);
    end;
end;

end.
