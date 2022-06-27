unit guardarJuegos;

// Público ---------------------------------------------------------------------
interface
  function generarCodigoJuego(): DWord;

  procedure guardarJuego(Participante: String; PtsJuego: DWord);

// Privado ---------------------------------------------------------------------
implementation
  uses tiposYConst, sysutils;

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

  procedure guardarJuego(Participante: String; PtsJuego: DWord);
  var
    CodJuego: DWord;
    FechaAct: String[10];
    HoraAct: String[8];
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

    // Determinar fecha y hora actual
    FechaAct := FormatDateTime('dd/mm/yyyy', Now);
    HoraAct := FormatDateTime('hh:nn:ss', Now);

    // Almacenar partida
    seek(Juegos, filesize(Juegos));
    with JuegoAct do
      begin
        Codigo := CodJuego;
        Usuario := Participante;
        Fecha := FechaAct;
        Hora := HoraAct;
        PtsGanados := PtsJuego;
        write(Juegos, JuegoAct);
      end;

    closeFile(Juegos);
  end;

end.

