unit guardarJuegos;

// Público ---------------------------------------------------------------------
interface
  function generarCodigoJuego(): DWord;

  procedure guardarJuego(Participante: String; PtsJuego: QWord);

// Privado ---------------------------------------------------------------------
implementation
  uses tiposYConst, sysutils;

  var
    Juegos: File of Juego;
    JuegoAct: Juego;

  function generarCodigoJuego(): DWord;
  begin
    // Abrir archivo
    assignFile(Juegos, 'Juegos.dat');
    if FileExists('Juegos.dat') then
      reset(Juegos)
    else
      rewrite(Juegos);

    // Generar código según el último guardado
    generarCodigoJuego := 1;
    while not eof(Juegos) do
      begin
        read(Juegos, JuegoAct);
        generarCodigoJuego := JuegoAct.Codigo + 1;
      end;

    closeFile(Juegos);
  end;

  procedure guardarJuego(Participante: String; PtsJuego: QWord);
  var
    CodJuego: DWord;
    FechaAct: String[10];
    HoraAct: String[8];
  begin
    // Generar código para guardar la partida
    CodJuego := generarCodigoJuego();

    // Abrir archivo
    assignFile(Juegos, 'Juegos.dat');
    if FileExists('Juegos.dat') then
      reset(Juegos)
    else
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

