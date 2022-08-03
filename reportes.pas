unit reportes;

// Público ---------------------------------------------------------------------
interface
  uses tiposYConst;

  function puntosJugador(Usuario: String): QWord;

  function reporteGlobal(Directorio: String): RepGeneral;

  function reportePais(Directorio, Pais: String): RepGeneral;

  function reporteJugador(Directorio, UsuarioJ: String): RepJugador;

  function topGlobal(Directorio: String): RepTop5;

  function topPais(Directorio, Pais: String): RepTop5;

// Privado ---------------------------------------------------------------------
implementation
  uses sysutils;

  function puntosJugador(Usuario: String): QWord;
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

  // Función que rellena extremos de un mensaje para centrarlo
  function llenarBlancos(Mensaje: String; Longitud: Byte): String;
  var
    i, TotBlancos, AColocar: Byte;
  begin
    TotBlancos := Longitud - length(Mensaje);
    AColocar := TotBlancos div 2;
    llenarBlancos := '';
    // Agregar espacios a la izquierda
    for i := 1 to AColocar do
      llenarBlancos := llenarBlancos + ' ';

    // Agregar mensaje de entrada
    llenarBlancos := llenarBlancos + Mensaje;

    if TotBlancos mod 2 <> 0 then
      AColocar := AColocar + 1;
    // Agregar espacios a la derecha
    for i := 1 to AColocar do
      llenarBlancos := llenarBlancos + ' ';
  end;

  function reporteGlobal(Directorio: String): RepGeneral;
  var
    CantJugadores, i: Word;
    Jugadores: File of Jugador;
    Reporte: Text;
    NomArch: String;
    JActual: Jugador;
    PtsJug: DWord;
  begin
    // Verificar que el archivo existe
    if not fileExists('Jugadores.dat') then
      begin
        setLength(reporteGlobal.LJugadores, 0);
        setLength(reporteGlobal.LPuntajes, 0);
        reporteGlobal.NArchivo := '';
      end
    else
      begin
        // Abrir archivo de jugadores
        assignFile(Jugadores, 'Jugadores.dat');
        reset(Jugadores);
        // Establecer tamaños de arreglos
        CantJugadores := fileSize(Jugadores);
        setLength(reporteGlobal.LJugadores, CantJugadores);
        setLength(reporteGlobal.LPuntajes, CantJugadores);
        // Abrir archivo de reporte
        NomArch := Directorio + '\ReporteGlobal_' + FormatDateTime('dd-mm-yyyy_hh-mm', Now) + '.txt';
        reporteGlobal.NArchivo := NomArch;
        assignFile(Reporte, NomArch);
        rewrite(Reporte);

        // Escribir presentación de archivo
        write(Reporte, '--------------------------------------------------- REPORTE GLOBAL -------------------------- ');
        writeln(Reporte, FormatDateTime('dd/mm/yyyy hh:mm', Now));
        writeln(Reporte, '');
        writeln(Reporte, '         NOMBRE            |    USUARIO    |             CORREO             |     PAIS      |    PUNTAJE');

        // Recorrer archivo de jugadores, escribir y almacenar
        i := 0;
        while not eof(Jugadores) do
          begin
            read(Jugadores, JActual);
            PtsJug := puntosJugador(JActual.Usuario);
            // Almacenar en registro para usar en formulario
            reporteGlobal.LJugadores[i] := JActual;
            reporteGlobal.LPuntajes[i] := PtsJug;
            i := i+1;
            // Escribir al archivo de reporte
            with JActual do
              begin
                write(Reporte, llenarBlancos(NombreComp, 27) + '|');
                write(Reporte, llenarBlancos(Usuario, 15) + '|');
                write(Reporte, llenarBlancos(Correo, 32) + '|');
                write(Reporte, llenarBlancos(NomPaises[IndPais], 15) + '|');
                writeln(Reporte, llenarBlancos(IntToStr(PtsJug), 15));
              end;
          end;

        // Cerrar archivos
        closeFile(Reporte);
        closeFile(Jugadores);
      end;
  end;

  function reportePais(Directorio, Pais: String): RepGeneral;
  var
    CantJugadores, i: Word;
    Jugadores: File of Jugador;
    Reporte: Text;
    NomArch: String;
    JActual: Jugador;
    PtsJug: DWord;
  begin
    // Verificar que el archivo existe
    if not fileExists('Jugadores.dat') then
      begin
        setLength(reportePais.LJugadores, 0);
        setLength(reportePais.LPuntajes, 0);
        reportePais.NArchivo := '';
      end
    else
      begin
        // Abrir archivo de jugadores
        assignFile(Jugadores, 'Jugadores.dat');
        reset(Jugadores);
        // Establecer tamaño inicial de arreglos
        CantJugadores := fileSize(Jugadores);
        setLength(reportePais.LJugadores, CantJugadores);
        setLength(reportePais.LPuntajes, CantJugadores);
        // Abrir archivo de reporte
        NomArch := Directorio + '\Reporte' + Pais + '_' + FormatDateTime('dd-mm-yyyy_hh-mm', Now) + '.txt';
        reportePais.NArchivo := NomArch;
        assignFile(Reporte, NomArch);
        rewrite(Reporte);

        // Escribir presentación de archivo
        write(Reporte, '------------------------------ REPORTE DE ' + UpperCase(Pais) + ' ----------------------------- ');
        writeln(Reporte, FormatDateTime('dd/mm/yyyy hh:mm', Now));
        writeln(Reporte, '');
        writeln(Reporte, '          NOMBRE          |    USUARIO    |             CORREO             |    PUNTAJE');

        // Recorrer archivo de jugadores, escribir y almacenar los del pais especificado
        i := 0;
        while not eof(Jugadores) do
          begin
            read(Jugadores, JActual);
            if NomPaises[JActual.IndPais] = Pais then
              begin
                // El país es correcto
                PtsJug := puntosJugador(JActual.Usuario);
                reportePais.LJugadores[i] := JActual;
                reportePais.LPuntajes[i] := PtsJug;
                i := i+1;
                // Escribir en reporte
                with JActual do
                  begin
                    write(Reporte, llenarBlancos(NombreComp, 27) + '|');
                    write(Reporte, llenarBlancos(Usuario, 15) + '|');
                    write(Reporte, llenarBlancos(Correo, 32) + '|');
                    writeln(Reporte, llenarBlancos(IntToStr(PtsJug), 15));
                  end;
              end;
          end;
        // Ajustar longitudes de arreglos
        setLength(reportePais.LJugadores, i);
        setLength(reportePais.LPuntajes, i);

        // Cerrar archivos
        closeFile(Reporte);
        closeFile(Jugadores);
      end;
  end;

  function reporteJugador(Directorio, UsuarioJ: String): RepJugador;
  var
    CantJuegos, i: Word;
    NomArch: String;
    Jugadores: File of Jugador;
    JugActual: Jugador;
    Juegos: File of Juego;
    JuegoActual: Juego;
    Reporte: Text;
    Existe: Boolean;
  begin
    // Verificar que el archivo existe
    if not fileExists('Jugadores.dat') then
      begin
        setLength(reporteJugador.LJuegos, 0);
        reporteJugador.NArchivo := '';
      end
    else
      begin
        // Abrir archivo de jugadores
        assignFile(Jugadores, 'Jugadores.dat');
        reset(Jugadores);
        // Buscar que exista el jugador
        Existe := False;
        while (not eof(Jugadores)) and (not Existe) do
          begin
            read(Jugadores, JugActual);
            if JugActual.Usuario = UsuarioJ then
              begin
                Existe := True;
                reporteJugador.JugSolicitado := JugActual;
              end;
          end;
        reporteJugador.JugExiste := Existe;
        setLength(reporteJugador.LJuegos, 0);
        closeFile(Jugadores);

        if Existe then
          begin
            // Abrir archivo de reporte
            NomArch := Directorio + '\ReporteJugador_' + FormatDateTime('dd-mm-yyyy_hh-mm', Now) + '.txt';
            reporteJugador.NArchivo := NomArch;
            assignFile(Reporte, NomArch);
            rewrite(Reporte);

            // Escribir presentación de reporte
            write(Reporte, '----------------------------------------------- REPORTE DE JUGADOR -------------------------- ');
            writeln(Reporte, FormatDateTime('dd/mm/yyyy hh:mm', Now));
            writeln(Reporte, '');
            writeln(Reporte, '         NOMBRE            |    USUARIO    |             CORREO             |     PAIS      |    PUNTAJE');
            // Escribir datos de jugador
            write(Reporte, llenarBlancos(JugActual.NombreComp, 27) + '|');
            write(Reporte, llenarBlancos(JugActual.Usuario, 15) + '|');
            write(Reporte, llenarBlancos(JugActual.Correo, 32) + '|');
            write(Reporte, llenarBlancos(NomPaises[JugActual.IndPais], 15) + '|');
            writeln(Reporte, llenarBlancos(IntToStr(puntosJugador(JugActual.Usuario)), 15));
            writeln(Reporte, '');
            writeln(Reporte, '                               --- PARTIDAS JUGADAS ---');

            // Verificar que existe el archivo de juegos y abrirlo
            CantJuegos := 0;
            if fileExists('Juegos.dat') then
              begin
                assignFile(Juegos, 'Juegos.dat');
                reset(Juegos);
                // Contar juegos del usuario ingresado
                while not eof(Juegos) do
                  begin
                    read(Juegos, JuegoActual);
                    if JuegoActual.Usuario = UsuarioJ then
                      CantJuegos := CantJuegos + 1;
                  end;
                closeFile(Juegos);

                if CantJuegos > 0 then
                  begin
                    // El usuario ha jugado. Volver a recorrer archivo de juegos y mostrar en reporte
                    writeln(Reporte, '                  CODIGO      |     FECHA     |   HORA   |    PUNTAJE');
                    reset(Juegos);
                    i := 0;
                    setLength(reporteJugador.LJuegos, CantJuegos);
                    while not eof(Juegos) do
                      begin
                        read(Juegos, JuegoActual);
                        if JuegoActual.Usuario = UsuarioJ then
                          begin
                            with JuegoActual do
                              begin
                                write(Reporte, '            ' + llenarBlancos(IntToStr(Codigo), 18) + '|');
                                write(Reporte, llenarBlancos(Fecha, 15) + '|');
                                write(Reporte, llenarBlancos(Hora, 10) + '|');
                                writeln(Reporte, llenarBlancos(IntToStr(PtsGanados), 15));
                              end;
                            // Agregar a arreglo de juegos para el registro
                            reporteJugador.LJuegos[i] := JuegoActual;
                            i := i+1;
                          end;
                      end;
                    closeFile(Juegos);
                  end;
              end;
            // Indicar si no se han jugado juegos (en general o solo el usuario)
            if CantJuegos = 0 then
              write(Reporte, '                                El usuario no ha jugado');
            closeFile(Reporte);
          end;
      end;
  end;

  function topGlobal(Directorio: String): RepTop5;
  var
    Jugadores: File of Jugador;
    Reporte: Text;
    CtJugadores, PtsJug: DWord;
    NomArch: String;
    i, j: Byte;
    JugActual: Jugador;
    JugEntra: Boolean;
  begin
    CtJugadores := 0;
    // Verificar que el archivo existe
    if not fileExists('Jugadores.dat') then
      begin
        setLength(topGlobal.Top, 0);
        setLength(topGlobal.LPuntajes, 0);
        topGlobal.CantJugadores := 0;
      end
    else
      begin
        // Abrir archivo de jugadores y determinar cantidad
        assignFile(Jugadores, 'Jugadores.dat');
        reset(Jugadores);
        CtJugadores := fileSize(Jugadores);
        if CtJugadores > 5 then
          CtJugadores := 5;
        topGlobal.CantJugadores := CtJugadores;

        // Abrir archivo de reporte y escribir presentación
        NomArch := Directorio + '\Top5Global_' + FormatDateTime('dd-mm-yyyy_hh-mm', Now) + '.txt';
        topGlobal.NArchivo := NomArch;
        assignFile(Reporte, NomArch);
        rewrite(Reporte);
        write(Reporte, '------------------------------------------------- TOP 5 GLOBAL -------------------------------------- ');
        writeln(Reporte, FormatDateTime('dd/mm/yyyy hh:mm', Now));
        writeln(Reporte, '');
        // Escribir mensaje si no hay jugadores registrados
        if CtJugadores = 0 then
          write(Reporte, '                                No hay jugadores disponibles')
        else
          begin
            // Inicializar arreglos
            setLength(topGlobal.Top, CtJugadores);
            setLength(topGlobal.LPuntajes, CtJugadores);
            for i := 0 to CtJugadores-1 do
              topGlobal.LPuntajes[i] := 0;
            // Recorrer archivo de jugadores y crear top
            while not eof(Jugadores) do
              begin
                read(Jugadores, JugActual);
                i := 0;
                JugEntra := False;
                PtsJug := puntosJugador(JugActual.Usuario);
                while (i <= CtJugadores-1) and (not JugEntra) do
                  begin
                    if PtsJug >= topGlobal.LPuntajes[i] then
                      begin
                        JugEntra := True;
                        for j := CtJugadores-1 downto i+1 do
                          begin
                            // Bajar jugadores del top
                            topGlobal.Top[j] := topGlobal.Top[j-1];
                            topGlobal.LPuntajes[j] := topGlobal.LPuntajes[j-1];
                          end;
                        // Actualizar posición en la que se inserta el jugador
                        topGlobal.Top[i] := JugActual;
                        topGlobal.LPuntajes[i] := PtsJug;
                      end;
                    i := i+1;
                  end;
              end;
            closeFile(Jugadores);
            // Escribir top en el reporte
            writeln(Reporte, ' POSICION |         NOMBRE            |    USUARIO    |             CORREO             |     PAIS      |    PUNTAJE');
            for i := 0 to CtJugadores-1 do
              with topGlobal.Top[i] do
                begin
                  write(Reporte, llenarBlancos(IntToStr(i+1), 10) + '|');
                  write(Reporte, llenarBlancos(NombreComp, 27) + '|');
                  write(Reporte, llenarBlancos(Usuario, 15) + '|');
                  write(Reporte, llenarBlancos(Correo, 32) + '|');
                  write(Reporte, llenarBlancos(NomPaises[IndPais], 15) + '|');
                  writeln(Reporte, llenarBlancos(intToStr(puntosJugador(Usuario)), 15));
                end;
            if CtJugadores < 5 then
              write(Reporte, '                              No hay suficientes para un top 5');
          end;
        // Cerrar reporte
        closeFile(Reporte);
      end;
  end;

  function topPais(Directorio, Pais: String): RepTop5;
  var
    Jugadores: File of Jugador;
    Reporte: Text;
    CtJugadores, PtsJug, i, j: DWord;
    JugAct: Jugador;
    NomArch: String;
    JugEntra: Boolean;
  begin
    // Verificar que el archivo exista
    if not fileExists('Jugadores.dat') then
      begin
        setLength(topPais.Top, 0);
        setLength(topPais.LPuntajes, 0);
        topPais.CantJugadores := 0;
      end
    else
      begin
        // Abrir archivo de jugadores y contar los del país
        CtJugadores := 0;
        assignFile(Jugadores, 'Jugadores.dat');
        reset(Jugadores);
        while not eof(Jugadores) do
          begin
            read(Jugadores, JugAct);
            if NomPaises[JugAct.IndPais] = Pais then
              CtJugadores := CtJugadores + 1;
          end;
        if CtJugadores > 5 then
          CtJugadores := 5;
        topPais.CantJugadores := CtJugadores;
        closeFile(Jugadores);
        // Abrir archivo de reporte y escribir presentación
        NomArch := Directorio + '\Top5' + Pais + '_' + FormatDateTime('dd-mm-yyyy_hh-mm', Now) + '.txt';
        topPais.NArchivo := NomArch;
        assignFile(Reporte, NomArch);
        rewrite(Reporte);
        write(Reporte, '-------------------------------------- TOP 5 ' + UpperCase(Pais) + ' ------------------------------ ');
        writeln(Reporte, FormatDateTime('dd/mm/yyyy hh:mm', Now));
        writeln(Reporte, '');
        // Escribir mensaje si el país no tiene jugadores
        if CtJugadores = 0 then
          write(Reporte, '                                  Este país no tiene jugadores')
        else
          begin
            // Inicializar arreglos
            setLength(topPais.Top, CtJugadores);
            setLength(topPais.LPuntajes, CtJugadores);
            for i := 0 to CtJugadores-1 do
              topPais.LPuntajes[i] := 0;
            // Abrir archivo de jugadores y recorrerlo para generar top
            reset(Jugadores);
            while not eof(Jugadores) do
              begin
                read(Jugadores, JugAct);
                // Solo considerar si pertenece al país
                if NomPaises[JugAct.IndPais] = Pais then
                  begin
                    i := 0;
                    JugEntra := False;
                    PtsJug := puntosJugador(JugAct.Usuario);
                    while (i <= CtJugadores-1) and (not JugEntra) do
                      begin
                        if PtsJug >= topPais.LPuntajes[i] then
                          begin
                            JugEntra := True;
                            for j := CtJugadores-1 downto i+1 do
                              begin
                                // Bajar jugadores del top
                                topPais.Top[j] := topPais.Top[j-1];
                                topPais.LPuntajes[j] := topPais.LPuntajes[j-1];
                              end;
                            // Actualizar posición en la que se inserta el jugador
                            topPais.Top[i] := JugAct;
                            topPais.LPuntajes[i] := PtsJug;
                          end;
                        i := i+1;
                      end;
                  end;
              end;
            closeFile(Jugadores);
            // Escribir top en el reporte
            writeln(Reporte, ' POSICION |          NOMBRE          |    USUARIO    |             CORREO             |    PUNTAJE');
            for i := 0 to CtJugadores-1 do
              with topPais.Top[i] do
                begin
                  write(Reporte, llenarBlancos(IntToStr(i+1), 10) + '|');
                  write(Reporte, llenarBlancos(NombreComp, 27) + '|');
                  write(Reporte, llenarBlancos(Usuario, 15) + '|');
                  write(Reporte, llenarBlancos(Correo, 32) + '|');
                  writeln(Reporte, llenarBlancos(intToStr(puntosJugador(Usuario)), 15));
                end;
            if CtJugadores < 5 then
              write(Reporte, '                               No hay suficientes para un top 5');
          end;
        // Cerrar reporte
        closeFile(Reporte);
      end;
  end;

end.

