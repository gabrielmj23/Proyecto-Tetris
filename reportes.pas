unit reportes;

// Público ---------------------------------------------------------------------
interface
  function puntosJugador(Usuario: String): DWord;

// Privado ---------------------------------------------------------------------
implementation
  uses tiposYConst, sysutils;

  function puntosJugador(Usuario: String): DWord;
  var
    Juegos: File of Juego;
    JuegoAct: Juego;
  begin
    puntosJugador := 0;
    // Abrir archivo
    assignFile(Juegos,'Juegos.dat');
    if FileExists('Juegos.dat') then
      reset(Juegos)
    else
      rewrite(Juegos);

    // Buscar juegos del usuario indicado y acumular puntajes
    while not eof(Juegos) do
      begin
        read(Juegos, JuegoAct);
        if JuegoAct.Usuario = Usuario then
          puntosJugador := puntosJugador + JuegoAct.PtsGanados;
      end;

    // Cerrar archivo
    closeFile(Juegos);
  end;

end.

