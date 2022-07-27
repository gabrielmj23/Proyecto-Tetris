unit FormTetris;
{$mode objfpc}{$H+}

interface
uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ComCtrls, StdCtrls,
  ExtCtrls, CheckLst, Types, LCLType, EditBtn, TAGraph;

type

  { TTetris }
  TTetris = class(TForm)
    BRegistrar: TButton;
    BInicioSesion: TButton;
    BRegistrarse: TButton;
    BEstadisticas: TButton;
    BReportePais: TButton;
    BReporteJug: TButton;
    BTop5Global: TButton;
    BTop5Pais: TButton;
    BSalir: TButton;
    BReporteGlobal: TButton;
    BotonJugar: TButton;
    BJugarOtra: TButton;
    BEstad: TButton;
    BFinal: TButton;
    BGenReporte: TButton;
    Bvolver: TButton;
    BConfirmar: TButton;
    Bvolver1: TButton;
    Bvolver2: TButton;
    campo_usuario: TEdit;
    Campo_clave: TEdit;
    Campo_NombreC: TEdit;
    campo_UsuarioR: TEdit;
    campo_correo: TEdit;
    Campo_claveR: TEdit;
    CeroTxt: TLabel;
    CajaPaises: TComboBox;
    FondoRepG: TImage;
    SelPaisR: TLabel;
    PMax: TLabel;
    MsjSalida: TLabel;
    DiagramaG: TScrollBox;
    SelDirectorio: TDirectoryEdit;
    FondoTab: TImage;
    FondoResumen: TImage;
    ImgSonido: TImage;
    ImgFondoConf: TImage;
    ImgTiempo: TImage;
    ImgJugadas: TImage;
    JuegoConcluido: TLabel;
    MsjDirectorio: TLabel;
    PRepGeneral: TTabSheet;
    TxtErrorRep: TLabel;
    TxtPuntajeRes: TLabel;
    ResumenJuego: TTabSheet;
    TimerGrav: TTimer;
    TxtError: TLabel;
    ListaODS: TCheckListBox;
    IngCantidad: TEdit;
    FondoSesion: TImage;
    FondoRegistro: TImage;
    FondoReportes: TImage;
    ImgPieza8: TImage;
    ImgPieza7: TImage;
    ImgPieza6: TImage;
    ImgPieza5: TImage;
    ImgPieza4: TImage;
    ImgPieza3: TImage;
    ImgPieza2: TImage;
    ImgPieza1: TImage;
    ImgInicio: TImage;
    TxtODS: TLabel;
    TxtCantidad: TLabel;
    TxtPiezas: TLabel;
    TxtModo: TLabel;
    ListaPaises: TCheckListBox;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    Image5: TImage;
    i_USUARIO: TImage;
    FondoJuego: TImage;
    ImgODS: TImage;
    ImgSigPieza: TImage;
    NRest: TLabel;
    BordeCont: TShape;
    ConfJuego: TTabSheet;
    TimerJuego: TTimer;
    TxtRestante: TLabel;
    MensajeODS: TLabel;
    TituloODS: TLabel;
    TxtSiguiente: TLabel;
    TextoPuntaje: TLabel;
    Pantallas: TPageControl;
    PantallaInicial: TTabSheet;
    inicioSesion: TTabSheet;
    Registracion: TTabSheet;
    Estadisticas: TTabSheet;
    PantJuego: TTabSheet;
    DatosJug: TLabel;
    procedure BEstadClick(Sender: TObject);
    procedure BFinalClick(Sender: TObject);
    procedure BGenReporteClick(Sender: TObject);
    procedure BInicioSesionClick(Sender: TObject);
    procedure BJugarOtraClick(Sender: TObject);
    procedure BotonJugarClick(Sender: TObject);
    procedure BRegistrarseClick(Sender: TObject);
    procedure BvolverClick(Sender: TObject);
    procedure ConfJuegoShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ImgJugadasClick(Sender: TObject);
    procedure ImgPieza1Click(Sender: TObject);
    procedure ImgPieza2Click(Sender: TObject);
    procedure ImgPieza3Click(Sender: TObject);
    procedure ImgPieza4Click(Sender: TObject);
    procedure ImgPieza5Click(Sender: TObject);
    procedure ImgPieza6Click(Sender: TObject);
    procedure ImgPieza7Click(Sender: TObject);
    procedure ImgPieza8Click(Sender: TObject);
    procedure ImgSonidoClick(Sender: TObject);
    procedure ImgTiempoClick(Sender: TObject);
    procedure ListaODSItemClick(Sender: TObject; Index: integer);
    procedure ListaPaisesItemClick(Sender: TObject; Index: integer);
    procedure PantallasChange(Sender: TObject);
    procedure PantJuegoShow(Sender: TObject);
    procedure PRepGeneralShow(Sender: TObject);
    procedure ResumenJuegoShow(Sender: TObject);
    procedure TimerGravTimer(Sender: TObject);
    procedure TimerJuegoTimer(Sender: TObject);
  private

  public

  end;

var
  Tetris: TTetris;

implementation
{$R *.lfm}

uses
  tiposYConst, guardarJuegos, reportes, MMSystem;

var
  // Uso General
  EstadoMusica: Boolean;
  JugActual: Jugador;
  // Juego principal
  Tablero: Array[1..12, 1..9] of Byte;
  GrafTablero: Array[1..12, 1..9] of TImage;
  Puntaje: QWord;
  IdActPieza, IdSigPieza: Byte;
  ModoJ: Char;
  CtRest: Integer;
  JuegoActivo: Boolean;
  AltMax: Array[1..9] of Byte;
  TableroColision: Array[1..13, 1..9] of Byte;
  MoverFila, MoverCol: SmallInt;
  PiezaActual: Array[1..4, 1..2] of Byte;
  PtsPiezaAct: Byte;
  // Configuración de juego
  IdSelPieza, IdSelODS, NumPiezas, NumODS: Byte;
  PiezasDisp: Array[1..5] of Byte;
  ODSDisp: Array[1..5] of Byte;
  // Reportes
  ModoReporte: Byte;

procedure TTetris.FormCreate(Sender: TObject);
begin
  Pantallas.ActivePageIndex := 0;
  sndPlaySound('musica/MusicaTetris.wav', snd_async or snd_loop);
  EstadoMusica := True;
end;

// Procedimiento para encender/apagar sonido
procedure TTetris.ImgSonidoClick(Sender: TObject);
begin
  if EstadoMusica then
    begin
      sndPlaySound(nil, snd_async or snd_loop);
      ImgSonido.Picture.LoadFromFile('img/variados/sonidoOff.png');
    end
  else
    begin
      sndPlaySound('musica/MusicaTetris.wav', snd_async or snd_loop);
      ImgSonido.Picture.LoadFromFile('img/variados/sonido.png');
    end;
  EstadoMusica := not EstadoMusica
end;

procedure TTetris.PantallasChange(Sender: TObject);
begin
  ImgSonido.Parent := Pantallas.ActivePage;
  ImgSonido.BringToFront;
end;

// Procedimiento para sustituir imagen de pieza seleccionada en configuración de juego
procedure EliminarSelPieza();
begin
  case PiezasDisp[IdSelPieza] of
    1: Tetris.ImgPieza1.Picture.LoadFromFile('img/piezas/pieza1.png');
    2: Tetris.ImgPieza2.Picture.LoadFromFile('img/piezas/pieza2.png');
    3: Tetris.ImgPieza3.Picture.LoadFromFile('img/piezas/pieza3.png');
    4: Tetris.ImgPieza4.Picture.LoadFromFile('img/piezas/pieza4.png');
    5: Tetris.ImgPieza5.Picture.LoadFromFile('img/piezas/pieza5.png');
    6: Tetris.ImgPieza6.Picture.LoadFromFile('img/piezas/pieza6.png');
    7: Tetris.ImgPieza7.Picture.LoadFromFile('img/piezas/pieza7.png');
    8: Tetris.ImgPieza8.Picture.LoadFromFile('img/piezas/pieza8.png');
  end;
end;

// Procedimiento que maneja la selección de una pieza en configuración de juego
procedure ManejarSelPieza(Pieza: TImage; NPieza: Byte);
var
  i, IdArr: Byte;
  YaEsta: Boolean;
begin
  // Verificar que no esté ya seleccionada la pieza
  YaEsta := False;
  for i := 1 to 5 do
    if PiezasDisp[i] = NPieza then
      begin
        YaEsta := True;
        IdArr := i;
      end;
  if YaEsta then
    begin
      // Eliminar selección moviendo todos los elementos del arreglo de selección a la izquierda
      for i := IdArr to 4 do
        PiezasDisp[i] := PiezasDisp[i+1];
      PiezasDisp[5] := 0;
      IdSelPieza := IdSelPieza - 1;
      Pieza.Picture.LoadFromFile('img/piezas/pieza' + IntToStr(NPieza) + '.png');
    end
  else
    begin
      // Si ya hay 5 seleccionadas, reiniciar índice de selección
      if IdSelPieza = 6 then
        IdSelPieza := 1;
      if PiezasDisp[IdSelPieza] <> 0 then
        EliminarSelPieza();
      // Indicar que se seleccionó y guardar
      Pieza.Picture.LoadFromFile('img/piezas/piezaSel' + IntToStr(NPieza) + '.png');
      PiezasDisp[IdSelPieza] := NPieza;
      IdSelPieza := IdSelPieza + 1;
    end;
end;

procedure TTetris.ImgPieza1Click(Sender: TObject);
begin
  ManejarSelPieza(ImgPieza1, 1);
end;

procedure TTetris.ImgPieza2Click(Sender: TObject);
begin
  ManejarSelPieza(ImgPieza2, 2);
end;

procedure TTetris.ImgPieza3Click(Sender: TObject);
begin
  ManejarSelPieza(ImgPieza3, 3);
end;

procedure TTetris.ImgPieza4Click(Sender: TObject);
begin
  ManejarSelPieza(ImgPieza4, 4);
end;

procedure TTetris.ImgPieza5Click(Sender: TObject);
begin
  ManejarSelPieza(ImgPieza5, 5);
end;

procedure TTetris.ImgPieza6Click(Sender: TObject);
begin
  ManejarSelPieza(ImgPieza6, 6);
end;

procedure TTetris.ImgPieza7Click(Sender: TObject);
begin
  ManejarSelPieza(ImgPieza7, 7);
end;

procedure TTetris.ImgPieza8Click(Sender: TObject);
begin
  ManejarSelPieza(ImgPieza8, 8);
end;

procedure TTetris.ImgTiempoClick(Sender: TObject);
begin
  // Cambiar modo de juego a "por tiempo"
  ModoJ := 'T';
  ImgTiempo.Picture.LoadFromFile('img/variados/tiempoAct.png');
  ImgJugadas.Picture.LoadFromFile('img/variados/jugadas.png');
  TxtCantidad.Caption := 'Cantidad de segundos (90 - 180) para jugar';
end;

procedure TTetris.ImgJugadasClick(Sender: TObject);
begin
  // Cambiar modo de juego a "por jugadas"
  ModoJ := 'J';
  ImgJugadas.Picture.LoadFromFile('img/variados/jugadasAct.png');
  ImgTiempo.Picture.LoadFromFile('img/variados/tiempo.png');
  TxtCantidad.Caption := 'Cantidad de jugadas (20 - 50) para jugar';
end;

procedure TTetris.ListaODSItemClick(Sender: TObject; Index: integer);
var
  i, Seleccionados, IdAntiguo, IdArr: Byte;
begin
  // Manejar cuando se elimina una selección
  if ListaODS.Checked[Index] = False then
    begin
      // Determinar índice en arreglo de selecciones
      for i := 1 to 5 do
        if ODSDisp[i] = Index+1 then
          IdArr := i;
      // Eliminar selección moviendo a la izquierda cada elemento
      for i := IdArr to 4 do
        ODSDisp[i] := ODSDisp[i+1];
      ODSDisp[5] := 0;
      IdSelODS := IdSelODS - 1;
    end
  else
    // Manejar cuando se agrega un ODS
    begin
      // Determinar cuántos se han seleccionado
      Seleccionados := 0;
      for i := 0 to ListaODS.Items.Count-1 do
        if ListaODS.Checked[i] then
          Seleccionados := Seleccionados + 1;
      if Seleccionados <= 5 then
        begin
          // Guardar ODS seleccionado
          ODSDisp[IdSelODS] := Index+1;
        end
      else
        begin
          // Sustituir ODS más antiguo
          if IdSelODS = 6 then
            IdSelODS := 1;
          IdAntiguo := ODSDisp[IdSelODS]-1;
          ListaODS.Checked[IdAntiguo] := False;
          ODSDisp[IdSelODS] := Index+1;
        end;
      IdSelODS := IdSelODS + 1;
    end;
end;

procedure TTetris.BInicioSesionClick(Sender: TObject);
begin
 inicioSesion.show;
end;

// Procedimiento que valida configuración de juego y devuelve mensaje de error si hay algo mal
procedure validarConfig(VAR MsjError: String; VAR TotPiezas, TotODS: Byte);
var
  i: Byte;
begin
  MsjError := '';
  // Determinar cuántas piezas y ODS se tomaron
  TotPiezas := 0;
  TotODS := 0;
  for i := 1 to 5 do
    begin
      if PiezasDisp[i] <> 0 then
        TotPiezas := TotPiezas + 1;
      if ODSDisp[i] <> 0 then
        TotODS := TotODS + 1;
    end;
  // Devolver error si no hubo selección de alguno
  if TotPiezas = 0 then
    MsjError := 'No ha elegido ninguna pieza';
  if TotODS = 0 then
    MsjError := 'No ha elegido ningún ODS';
  // Devolver error si hay distinta cantidad de piezas y ODS
  if TotPiezas <> TotODS then
    MsjError := 'Debe elegir igual cantidad de piezas y ODS';
  // Devolver error si el campo de cantidad de tiempo/jugadas está vacío
  if Tetris.IngCantidad.Text = '' then
    MsjError := 'No ha elegido cantidad de tiempo/jugadas'
  else
    begin
      // Verificar validez de la cantidad según el modo de juego
      CtRest := StrToInt(Tetris.IngCantidad.Text);
      if (ModoJ = 'T') and ((CtRest < 90) or (CtRest > 180)) then
        MsjError := 'El tiempo ingresado no está en el rango';
      if (ModoJ = 'J') and ((CtRest < 20) or (CtRest > 50)) then
        MsjError := 'Las jugadas ingresadas no están en el rango';
    end;
end;

procedure TTetris.BotonJugarClick(Sender: TObject);
var
  MsjError: String;
begin
  // Validar configuraciones
  MsjError := '';
  validarConfig(MsjError, NumPiezas, NumODS);
  if MsjError <> '' then
    begin
      // Mostrar error en pantalla
      TxtError.Caption := MsjError;
      TxtError.Visible := True;
    end
  else
    begin
      // Ocultar error si está visible y llevar a juego principal
      TxtError.Visible := False;
      Pantallas.ActivePageIndex := 4;
      Pantallas.OnChange(Pantallas);
    end;
end;

procedure TTetris.BRegistrarseClick(Sender: TObject);
begin
  registracion.show;
end;

procedure TTetris.BvolverClick(Sender: TObject);
begin
 PantallaInicial.show;
end;

procedure TTetris.ConfJuegoShow(Sender: TObject);
var
  i: Byte;
begin
  // Reiniciar configuraciones de juego
  for i := 1 to 5 do
    begin
      PiezasDisp[i] := 0;
      ODSDisp[i] := 0;
    end;
  for i := 1 to 17 do
    ListaODS.Checked[i-1] := False;
  ModoJ := 'T';
  TxtCantidad.Caption := 'Cantidad de segundos (90 - 180) para jugar';
  CtRest := 90;
  IngCantidad.Text := '90';
  IdSelPieza := 1;
  IdSelODS := 1;
  // Reiniciar imágenes
  ImgTiempo.Picture.LoadFromFile('img/variados/tiempoAct.png');
  ImgJugadas.Picture.LoadFromFile('img/variados/jugadas.png');
  ImgPieza1.Picture.LoadFromFile('img/piezas/pieza1.png');
  ImgPieza2.Picture.LoadFromFile('img/piezas/pieza2.png');
  ImgPieza3.Picture.LoadFromFile('img/piezas/pieza3.png');
  ImgPieza4.Picture.LoadFromFile('img/piezas/pieza4.png');
  ImgPieza5.Picture.LoadFromFile('img/piezas/pieza5.png');
  ImgPieza6.Picture.LoadFromFile('img/piezas/pieza6.png');
  ImgPieza7.Picture.LoadFromFile('img/piezas/pieza7.png');
  ImgPieza8.Picture.LoadFromFile('img/piezas/pieza8.png');
end;

procedure TTetris.ListaPaisesItemClick(Sender: TObject; Index: integer);
  var
  Contador : integer;
begin
  ListaPaises:=TCheckListBox(Sender);
  for Contador:= 0 to ListaPaises.Items.Count-1 do
    begin
      if (Contador<>Index) then
        ListaPaises.Checked[Contador]:= false;
    end;
end;

// Procedimiento que, para cada columna, halla la altura máxima de la pieza que puede ir ahí
procedure DeterminarAltMax();
var
  i, j: Byte;
  Cambiado: Boolean;
begin
  // Inicializar
  for i := 1 to 9 do
    AltMax[i] := 13;
  // Revisar el nivel de cada columna
  for j := 1 to 9 do
    begin
      Cambiado := False;
      i := 1;
      while (i <= 12) and (not Cambiado) do
        begin
          if TableroColision[i,j] <> 0 then
            begin
              AltMax[j] := i;
              Cambiado := True;
            end;
          i := i+1;
        end;
    end;
end;

// Procedimiento que carga imagen de cada celda del tablero de juego
procedure MostrarCeldas();
var
  i, j: Byte;
  ArchivoImg: String[23];
begin
  if Tetris.Pantallas.ActivePageIndex = 4 then
    for i := 1 to 12 do
      for j := 1 to 9 do
        begin
          // Cargar imagen según valor en tablero
          if Tablero[i,j] = 0 then
            GrafTablero[i,j].Visible := False
          else
            begin
              ArchivoImg := 'img/bloques/bloque' + IntToStr(Tablero[i,j]) + '.png';
              GrafTablero[i,j].Picture.LoadFromFile(ArchivoImg);
              GrafTablero[i,j].Visible := True;
            end;
        end;
end;

// Procedimiento que genera siguientes 2 piezas y las carga en el juego
procedure GenPiezas(ModoJ: Char; VAR IdAct, IdSig: Byte);
var
  i: Byte;
  ArchSig: String;
begin
  if ModoJ = 'J' then
    begin
      // Está en modo por jugadas
      if CtRest = -1 then
        JuegoActivo := False
      else
        begin
          // Modificar cantidad restante cada vez que se genera
          CtRest := CtRest - 1;
          Tetris.NRest.Caption := intToStr(CtRest);
        end;
    end;
  // Determinar alturas máximas
  DeterminarAltMax();

  if IdAct = 0 then
    // Generar pieza actual de forma aleatoria
    IdAct := random(NumPiezas) + 1
  else
    // Sustituir pieza actual por la seleccionada anteriormente
    IdAct := IdSig;
  IdSig := random(NumPiezas) + 1;

  // Almacenar datos de la pieza actual
  PiezaActual := Piezas[PiezasDisp[IdAct]];
  PtsPiezaAct := PiezasDisp[IdAct];

  // Cargar pieza en tablero
  for i := 1 to 4 do
    Tablero[PiezaActual[i,1], PiezaActual[i,2]] := PtsPiezaAct;
  MostrarCeldas();

  // Seleccionar archivos de imagen de la siguiente pieza
  ArchSig := 'img/piezas/pieza' + IntToStr(PiezasDisp[IdSig]) + '.png';

  // Cargar imagen de siguiente pieza
  Tetris.ImgSigPieza.Picture.LoadFromFile(ArchSig);

  // Cargar datos del ODS de la siguiente pieza
  Tetris.ImgODS.Picture.LoadFromFile(ImagenesODS[ODSDisp[IdSig]]);
  Tetris.TituloODS.Caption := TitulosODS[ODSDisp[IdSig]];
  Tetris.MensajeODS.Caption := MensajesODS[ODSDisp[IdSig]];

  // Verificar si choca con el límite superior
  for i := 1 to 4 do
    if AltMax[PiezaActual[i,2]] < AlturaPiezas[PiezasDisp[IdAct]] then
      JuegoActivo := False;

  // El juego ha terminado, almacenar datos y pasar a resumen de partida
  if not JuegoActivo then
    begin
      Tetris.Pantallas.ActivePageIndex := 5;
      Tetris.Pantallas.OnChange(Tetris.Pantallas);
      Tetris.TimerGrav.Enabled := False;
      Tetris.TimerJuego.Enabled := False;
      guardarJuego(JugActual.Usuario, Puntaje);
    end;
end;

// Procedimiento que maneja el movimiento de la pieza
procedure MoverPieza(MoverFila, MoverCol: SmallInt);
var
  i: Byte;
  PosicionVal: Boolean;
  ArchivoImg: String[23];
begin
  // Revisar colisiones para cada bloque de la pieza
  PosicionVal := True;
  for i := 1 to 4 do
    if (PiezaActual[i,2] + MoverCol < 1) or (PiezaActual[i,2] + MoverCol > 9) or (TableroColision[PiezaActual[i,1]+MoverFila, PiezaActual[i,2]+MoverCol] <> 0) then
      PosicionVal := False;

  if PosicionVal then
    begin
      // Eliminar valores anteriores de la pieza del tablero
      for i := 1 to 4 do
        begin
          Tablero[PiezaActual[i,1], PiezaActual[i,2]] := 0;
          GrafTablero[PiezaActual[i,1], PiezaActual[i,2]].Visible := False;
        end;

      // Mover la pieza y actualizar tablero
      for i := 1 to 4 do
        begin
          PiezaActual[i,1] := PiezaActual[i,1] + MoverFila;
          PiezaActual[i,2] := PiezaActual[i,2] + MoverCol;
          Tablero[PiezaActual[i,1], PiezaActual[i,2]] := PtsPiezaAct;
          // Reflejar movimiento en tablero de imágenes
          ArchivoImg := 'img/bloques/bloque' + IntToStr(PtsPiezaAct) + '.png';
          GrafTablero[PiezaActual[i,1], PiezaActual[i,2]].Picture.LoadFromFile(ArchivoImg);
          GrafTablero[PiezaActual[i,1], PiezaActual[i,2]].Visible := True;
        end;
    end;
end;

// Procedimiento que lee la tecla ingresada para el movimiento de la pieza
procedure TTetris.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Pantallas.ActivePageIndex = 4 then
    begin
      MoverFila := 0;
      MoverCol := 0;
      case Key of
        VK_DOWN: MoverFila := 1;
        VK_LEFT: MoverCol := -1;
        VK_RIGHT: MoverCol := 1;
      end;
      Key := 0;
      MoverPieza(MoverFila, MoverCol);
    end;
end;

// Función que limpia filas del tablero y devuelve el puntaje ganado de ese movimiento
function LimpiarFilas(): QWord;
var
  i, j, k, PuntosFil: Byte;
  Completa: Boolean;
begin
  LimpiarFilas := 0;
  i := 12;
  // Revisar cada fila
  while i > 0 do
    begin
      PuntosFil := 0;
      Completa := True;
      for j := 1 to 9 do
        begin
          PuntosFil := PuntosFil + Tablero[i,j];
          if Tablero[i,j] = 0 then
            Completa := False;
        end;
      if Completa then
        begin
          // Bajar filas superiores
          for j := i downto 1 do
            for k := 1 to 9 do
              if j = 1 then
                Tablero[j,k] := 0
              else
                Tablero[j,k] := Tablero[j-1,k];
          // Aumentar puntaje total a sumar
          LimpiarFilas := LimpiarFilas + PuntosFil * 100;
        end
      else
        i := i - 1;
    end;
  // Actualizar tablero de colisiones
  for i := 1 to 12 do
    for j := 1 to 9 do
      TableroColision[i,j] := Tablero[i,j];
end;

// Procedimiento que maneja la gravedad de la pieza
procedure TTetris.TimerGravTimer(Sender: TObject);
var
  i: Byte;
  Colision: Boolean;
begin
  // Verificar si la pieza ha chocado
  Colision := False;
  for i := 1 to 4 do
    if TableroColision[PiezaActual[i,1]+1, PiezaActual[i,2]] <> 0 then
      Colision := True;

  // Mover pieza hacia abajo si no chocó
  if not Colision then
    begin
      // Eliminar valores antiguos del tablero
      for i := 1 to 4 do
        Tablero[PiezaActual[i,1], PiezaActual[i,2]] := 0;

      // Movimiento
      for i := 1 to 4 do
        begin
          PiezaActual[i,1] := PiezaActual[i,1] + 1;
          Tablero[PiezaActual[i,1], PiezaActual[i,2]] := PtsPiezaAct;
        end;
      MostrarCeldas();
    end
  else
    begin
      // Actualizar puntaje en caso de que se haya formado una línea
      Puntaje := Puntaje + LimpiarFilas();
      TextoPuntaje.Caption := 'Puntaje: ' + IntToStr(Puntaje);
      // Generar nueva pieza
      GenPiezas(ModoJ, IdActPieza, IdSigPieza);
    end;
end;

// Procedimiento para iniciar el juego
procedure TTetris.PantJuegoShow(Sender: TObject);
var
  Formato: String;
  i, j: Byte;
begin
  // PARA PRUEBAS: Inicializar jugador
  with JugActual do
    begin
      NombreComp := 'Nombre';
      Usuario := 'Usuario';
      IndPais := 3;
      Formato := 'Jugador: %0:-S (%1:-S)   Pais: %2:-S   Puntos acumulados: %3-D';
      DatosJug.Caption := Format(Formato, [NombreComp, Usuario, CodPaises[IndPais], puntosJugador(Usuario)]);
    end;
  // Mostrar tiempo o contador de jugadas
  NRest.Caption := IntToStr(CtRest);
  case ModoJ of
    'T': begin
           TxtRestante.Caption := 'Tiempo restante:';
           TimerJuego.Enabled := True;
         end;
    'J': begin
           TxtRestante.Caption := 'Jugadas restantes:';
         end;
  end;
  // Inicializar tablero de colisiones
  for i := 1 to 13 do
    for j := 1 to 9 do
      if i < 13 then
        TableroColision[i,j] := 0
      else
        TableroColision[i,j] := 1;
  // Limpiar tablero de Tetris y mostrar
  for i := 1 to 12 do
    for j := 1 to 9 do
      Tablero[i,j] := 0;
  for i := 1 to 12 do
    for j := 1 to 9 do
      begin
        // Inicializar cada imagen, posición y tamaño
        FreeAndNil(GrafTablero[i,j]);
        GrafTablero[i,j] := TImage.Create(Tetris.Pantallas.ActivePage);
        GrafTablero[i,j].Left := 240 + (j-1)*50;
        GrafTablero[i,j].Top := 140 + (i-1)*50;
        GrafTablero[i,j].Height := 50;
        GrafTablero[i,j].Width := 50;
        GrafTablero[i,j].Proportional := True;
        GrafTablero[i,j].Parent := Tetris.Pantallas.ActivePage;
        GrafTablero[i,j].Visible := False;
      end;
  //Inicializar puntaje
  Puntaje := 0;
  TextoPuntaje.Caption := 'Puntaje: ' + IntToStr(Puntaje);
  // Generar primera pieza y siguiente pieza
  JuegoActivo := True;
  randomize;
  IdActPieza := 0;
  IdSigPieza := 0;
  GenPiezas(ModoJ, IdActPieza, IdSigPieza);
  TimerGrav.Enabled := True;
end;

// Procedimiento que controla el modo por tiempo
procedure TTetris.TimerJuegoTimer(Sender: TObject);
begin
  NRest.Caption := intToStr(CtRest);
  CtRest := CtRest - 1;
  // El juego ha terminado, guardar información y pasar a resumen de partida
  if (ModoJ = 'T') and (CtRest = -1) then
    begin
      TimerJuego.Enabled := False;
      JuegoActivo := False;
      TimerGrav.Enabled := False;
      Pantallas.ActivePageIndex := 5;
      Pantallas.OnChange(Pantallas);
      guardarJuego(JugActual.Usuario, Puntaje);
    end;
end;

procedure TTetris.ResumenJuegoShow(Sender: TObject);
begin
  TxtPuntajeRes.Caption := 'Puntaje obtenido: ' + IntToStr(Puntaje);
end;

procedure TTetris.BJugarOtraClick(Sender: TObject);
begin
  Pantallas.ActivePageIndex := 3;
end;

procedure TTetris.BEstadClick(Sender: TObject);
begin
  Pantallas.ActivePageIndex := 6;
end;

procedure TTetris.BFinalClick(Sender: TObject);
begin
  Tetris.Close;
end;

procedure TTetris.PRepGeneralShow(Sender: TObject);
begin
  TxtErrorRep.Visible := False;
  MsjSalida.Visible := False;
  DiagramaG.Visible := False;
  CeroTxt.Visible := False;
  PMax.Visible := False;
  if ModoReporte = 1 then
    begin
      // Configurar pantalla para reporte global
      SelPaisR.Visible := False;
      CajaPaises.Visible := False;
      BGenReporte.Top := 96;
      TxtErrorRep.Top := 104;
      MsjSalida.Top := 148;
      DiagramaG.Top := 224;
      DiagramaG.Height := 500;
      CeroTxt.Top := 200;
      PMax.Top := 200;
    end
  else
    begin
      // Configurar pantalla para reporte de país
      SelPaisR.Visible := True;
      CajaPaises.Visible := True;
      BGenReporte.Top := 152;
      TxtErrorRep.Top := 152;
      MsjSalida.Top := 208;
      DiagramaG.Top := 272;
      DiagramaG.Height := 464;
      CeroTxt.Top := 240;
      PMax.Top := 240;
    end;
end;

// Manejar petición para reporte global o de país
procedure TTetris.BGenReporteClick(Sender: TObject);
const
  LeftLab = 24;
  TopLab = 40;
  LeftFig = 200;
  TopFig = 32;
  MaxW = 823;
var
  RGeneral: RepGeneral;
  PtsMax: QWord;
  NJugadores, i: DWord;
  LabelNom: TLabel;
  RectJug: TShape;
begin
  if (SelDirectorio.Directory = '(Sin seleccionar)') or (SelDirectorio.Directory = '') then
    begin
      MsjSalida.Visible := False;
      CeroTxt.Visible := False;
      PMax.Visible := False;
      DiagramaG.Visible := False;
      TxtErrorRep.Caption := 'Debe seleccionar una carpeta';
      TxtErrorRep.Visible := True;
    end
  else
    begin
      TxtErrorRep.Visible := False;
      if ModoReporte = 1 then
        RGeneral := reporteGlobal(SelDirectorio.Directory)
      else
        RGeneral := reportePais(SelDirectorio.Directory, CajaPaises.Text);
      if length(RGeneral.LJugadores) = 0 then
        begin
          // No hay jugadores disponibles
          MsjSalida.Caption := 'No hay jugadores disponibles';
          MsjSalida.Visible := True;
        end
      else
        begin
          MsjSalida.Visible := True;
          MsjSalida.Caption := 'Se generó el reporte como ' + RGeneral.NArchivo;
          // Determinar mayor puntaje
          NJugadores := length(RGeneral.LJugadores);
          PtsMax := 0;
          for i := 1 to NJugadores do
            if RGeneral.LPuntajes[i] > PtsMax then
              PtsMax := RGeneral.LPuntajes[i];
          CeroTxt.Visible := True;
          PMax.Caption := IntToStr(PtsMax);
          PMax.Visible := True;
          // Generar uno a uno los elementos del diagrama
          for i := 1 to NJugadores do
            begin
              // Crear label con usuario
              LabelNom := TLabel.Create(Self);
              LabelNom.Parent := DiagramaG;
              LabelNom.Left := LeftLab;
              LabelNom.Top := TopLab * i + 30 * (i-1);
              LabelNom.Font.Size := 11;
              LabelNom.Font.Name := 'OCR A Extended';
              LabelNom.Caption := RGeneral.LJugadores[i].Usuario;
              // Crear barra que indique el puntaje
              RectJug := TShape.Create(Self);
              RectJug.Parent := DiagramaG;
              RectJug.Brush.Color := clLime;
              RectJug.Shape := stRectangle;
              RectJug.Left := LeftFig;
              RectJug.Top := TopFig * i + 30 * (i-1);
              RectJug.Height := 20;
              RectJug.Width := round(MaxW * (RGeneral.LPuntajes[i] / PtsMax));
            end;
          DiagramaG.Visible := True;
        end;
    end;
end;



end.

