unit guardarJuegos;

// Público ---------------------------------------------------------------------
interface
  function generarCodigoJuego(): DWord;

  procedure guardarJuego(Usuario: String; PtsGanados: DWord);

// Privado ---------------------------------------------------------------------
implementation
  uses tiposYConst;

  var
    Juegos: File of Juego;
    JuegoAct: Juego;

  function generarCodigoJuego(): DWord;
  var
    HayGuardados: Boolean;
  begin
    // Abrir archivo
    assignFile(Juegos, 'Juegos.dat');
    {$I-}
    reset(Juegos);
    {$I+}
    HayGuardados := True;
    if IOResult <> 0 then
      begin
        rewrite(Juegos);
        HayGuardados := False;
      end;

    // Generar código según el último guardado
    if HayGuardados then
      begin
        seek(Juegos, filesize(Juegos)-1);
        read(Juegos, JuegoAct);
        generarCodigoJuego := JuegoAct.Codigo + 1;
      end
    else
      generarCodigoJuego := 1;

    closeFile(Juegos);
  end;

  procedure guardarJuego(Usuario: String; PtsGanados: DWord);
  var
    CodJuego: DWord;
  begin
    // Generar código para guardar la partida
    CodJuego := generarCodigoJuego();

    // Abrir archivo
    assignFile(Juegos, 'Juegos.dat');
    {$I-}
    reset(Juegos);
    {$I+}
    if IOResult <> 0 then
      rewrite(Juegos);

    // Almacenar partida
    seek(Juegos, filesize(Juegos));
    with JuegoAct do
      begin
        Codigo := CodJuego;
        Usuario := Usuario;
        PtsGanados := PtsGanados;
        write(Juegos, JuegoAct);
      end;

    closeFile(Juegos);
  end;

end.

