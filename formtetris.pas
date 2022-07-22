unit FormTetris;
{$mode objfpc}{$H+}

interface
uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ComCtrls, StdCtrls,
  ExtCtrls, CheckLst, Types;

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
    ImgFondoConf: TImage;
    ImgTiempo: TImage;
    ImgJugadas: TImage;
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
    procedure BInicioSesionClick(Sender: TObject);
    procedure BotonJugarClick(Sender: TObject);
    procedure BRegistrarseClick(Sender: TObject);
    procedure BvolverClick(Sender: TObject);
    procedure ConfJuegoShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ImgJugadasClick(Sender: TObject);
    procedure ImgPieza1Click(Sender: TObject);
    procedure ImgPieza2Click(Sender: TObject);
    procedure ImgPieza3Click(Sender: TObject);
    procedure ImgPieza4Click(Sender: TObject);
    procedure ImgPieza5Click(Sender: TObject);
    procedure ImgPieza6Click(Sender: TObject);
    procedure ImgPieza7Click(Sender: TObject);
    procedure ImgPieza8Click(Sender: TObject);
    procedure ImgTiempoClick(Sender: TObject);
    procedure ListaODSItemClick(Sender: TObject; Index: integer);
    procedure ListaPaisesItemClick(Sender: TObject; Index: integer);
    procedure PantJuegoShow(Sender: TObject);
    procedure TimerJuegoTimer(Sender: TObject);
  private

  public

  end;

var
  Tetris: TTetris;

implementation
{$R *.lfm}

uses
  tiposYConst, guardarJuegos, reportes;

var
  JugActual: Jugador;
  Tablero: Array[1..12, 1..9] of Byte;
  GrafTablero: Array[1..12, 1..9] of TImage;
  Puntaje: DWord;
  IdActPieza, IdSigPieza: Byte;
  ModoJ: Char;
  CtRest: Integer;
  IdSelPieza, IdSelODS, NumPiezas, NumODS: Byte;
  PiezasDisp: Array[1..5] of Byte;
  ODSDisp: Array[1..5] of Byte;
  JuegoActivo: Boolean;

procedure TTetris.FormCreate(Sender: TObject);
begin
  Pantallas.ActivePageIndex := 0;
end;

// Procedimiento para susituir imagen de pieza seleccionada en configuración de juego
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

procedure TTetris.ImgPieza1Click(Sender: TObject);
var
  i: Byte;
  YaEsta: Boolean;
begin
  // Verificar que no esté ya seleccionada la pieza
  YaEsta := False;
  for i := 1 to 5 do
    if PiezasDisp[i] = 1 then
      YaEsta := True;

  if not YaEsta then
    begin
      // Si ya hay 5 seleccionadas, reiniciar índice de selección
      if IdSelPieza = 6 then
        IdSelPieza := 1;
      if PiezasDisp[IdSelPieza] <> 0 then
        EliminarSelPieza();
      // Indicar que se seleccionó y guardar
      ImgPieza1.Picture.LoadFromFile('img/piezas/piezaSel1.png');
      PiezasDisp[IdSelPieza] := 1;
      IdSelPieza := IdSelPieza + 1;
    end;
end;

procedure TTetris.ImgPieza2Click(Sender: TObject);
var
  i: Byte;
  YaEsta: Boolean;
begin
  // Verificar que no esté ya seleccionada la pieza
  YaEsta := False;
  for i := 1 to 5 do
    if PiezasDisp[i] = 2 then
      YaEsta := True;

  if not YaEsta then
    begin
      // Si ya hay 5 seleccionadas, reiniciar índice de selección
      if IdSelPieza = 6 then
        IdSelPieza := 1;
      if PiezasDisp[IdSelPieza] <> 0 then
        EliminarSelPieza();
      // Indicar que se seleccionó y guardar
      ImgPieza2.Picture.LoadFromFile('img/piezas/piezaSel2.png');
      PiezasDisp[IdSelPieza] := 2;
      IdSelPieza := IdSelPieza + 1;
    end;
end;

procedure TTetris.ImgPieza3Click(Sender: TObject);
var
  i: Byte;
  YaEsta: Boolean;
begin
  // Verificar que no esté ya seleccionada la pieza
  YaEsta := False;
  for i := 1 to 5 do
    if PiezasDisp[i] = 3 then
      YaEsta := True;

  if not YaEsta then
    begin
      // Si ya hay 5 seleccionadas, reiniciar índice de selección
      if IdSelPieza = 6 then
        IdSelPieza := 1;
      if PiezasDisp[IdSelPieza] <> 0 then
        EliminarSelPieza();
      // Indicar que se seleccionó y guardar
      ImgPieza3.Picture.LoadFromFile('img/piezas/piezaSel3.png');
      PiezasDisp[IdSelPieza] := 3;
      IdSelPieza := IdSelPieza + 1;
    end;
end;

procedure TTetris.ImgPieza4Click(Sender: TObject);
var
  i: Byte;
  YaEsta: Boolean;
begin
  // Verificar que no esté ya seleccionada la pieza
  YaEsta := False;
  for i := 1 to 5 do
    if PiezasDisp[i] = 4 then
      YaEsta := True;

  if not YaEsta then
    begin
      // Si ya hay 5 seleccionadas, reiniciar índice de pieza
      if IdSelPieza = 6 then
        IdSelPieza := 1;
      if PiezasDisp[IdSelPieza] <> 0 then
        EliminarSelPieza();
      // Indicar que se seleccionó y guardar
      ImgPieza4.Picture.LoadFromFile('img/piezas/piezaSel4.png');
      PiezasDisp[IdSelPieza] := 4;
      IdSelPieza := IdSelPieza + 1;
    end;
end;

procedure TTetris.ImgPieza5Click(Sender: TObject);
var
  i: Byte;
  YaEsta: Boolean;
begin
  // Verificar que no esté ya seleccionada la pieza
  YaEsta := False;
  for i := 1 to 5 do
    if PiezasDisp[i] = 5 then
      YaEsta := True;

  if not YaEsta then
    begin
      // Si ya hay 5 seleccionadas, reiniciar índice de selección
      if IdSelPieza = 6 then
        IdSelPieza := 1;
      if PiezasDisp[IdSelPieza] <> 0 then
        EliminarSelPieza();
      // Indicar que se seleccionó y guardar
      ImgPieza5.Picture.LoadFromFile('img/piezas/piezaSel5.png');
      PiezasDisp[IdSelPieza] := 5;
      IdSelPieza := IdSelPieza + 1;
    end;
end;

procedure TTetris.ImgPieza6Click(Sender: TObject);
var
  i: Byte;
  YaEsta: Boolean;
begin
  // Verificar que no esté ya seleccionada la pieza
  YaEsta := False;
  for i := 1 to 5 do
    if PiezasDisp[i] = 6 then
      YaEsta := True;

  if not YaEsta then
    begin
      // Si ya hay 5 seleccionadas, reiniciar índice de selección
      if IdSelPieza = 6 then
        IdSelPieza := 1;
      if PiezasDisp[IdSelPieza] <> 0 then
        EliminarSelPieza();
      // Indicar que se seleccionó y guardar
      ImgPieza6.Picture.LoadFromFile('img/piezas/piezaSel6.png');
      PiezasDisp[IdSelPieza] := 6;
      IdSelPieza := IdSelPieza + 1;
    end;
end;

procedure TTetris.ImgPieza7Click(Sender: TObject);
var
  i: Byte;
  YaEsta: Boolean;
begin
  // Verificar que no esté ya seleccionada la pieza
  YaEsta := False;
  for i := 1 to 5 do
    if PiezasDisp[i] = 7 then
      YaEsta := True;

  if not YaEsta then
    begin
      // Si ya hay 5 seleccionadas, reiniciar índice de selección
      if IdSelPieza = 6 then
        IdSelPieza := 1;
      if PiezasDisp[IdSelPieza] <> 0 then
        EliminarSelPieza();
      // Indicar que se seleccionó y guardar
      ImgPieza7.Picture.LoadFromFile('img/piezas/piezaSel7.png');
      PiezasDisp[IdSelPieza] := 7;
      IdSelPieza := IdSelPieza + 1;
    end;
end;

procedure TTetris.ImgPieza8Click(Sender: TObject);
var
  i: Byte;
  YaEsta: Boolean;
begin
  // Verificar que no esté ya seleccionada la pieza
  YaEsta := False;
  for i := 1 to 5 do
    if PiezasDisp[i] = 8 then
      YaEsta := True;

  if not YaEsta then
    begin
      // Si ya hay 5 seleccionadas, reiniciar índice de selección
      if IdSelPieza = 6 then
        IdSelPieza := 1;
      if PiezasDisp[IdSelPieza] <> 0 then
        EliminarSelPieza();
      // Indicar que se seleccionó y guardar
      ImgPieza8.Picture.LoadFromFile('img/piezas/piezaSel8.png');
      PiezasDisp[IdSelPieza] := 8;
      IdSelPieza := IdSelPieza + 1;
    end;
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
  i, Seleccionados, IdAntiguo: Byte;
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

// Procedimiento que carga imagen de cada celda del tablero de juego
procedure MostrarCeldas();
const
  LeftEsquina = 240;
  TopEsquina = 140;
var
  i, j: Byte;
  ArchivoImg: String[23];
begin
  for i := 1 to 12 do
    for j := 1 to 9 do
      begin
        // Inicializar imagen, posición y tamaño
        FreeAndNil(GrafTablero[i,j]);
        GrafTablero[i,j] := TImage.Create(Tetris.Pantallas.ActivePage);
        GrafTablero[i,j].Left := LeftEsquina + (j-1)*50;
        GrafTablero[i,j].Top := TopEsquina + (i-1)*50;
        GrafTablero[i,j].Height := 50;
        GrafTablero[i,j].Width := 50;
        GrafTablero[i,j].Proportional := True;
        GrafTablero[i,j].Parent := Tetris.Pantallas.ActivePage;
        // Cargar imagen según valor en tablero
        ArchivoImg := 'img/bloques/';
        if Tablero[i,j] = 0 then
          ArchivoImg := ArchivoImg + 'vacio.png'
        else
          ArchivoImg := ArchivoImg + 'bloque' + IntToStr(Tablero[i,j]) + '.png';
        GrafTablero[i,j].Picture.LoadFromFile(ArchivoImg);
      end;
end;

// Procedimiento que genera siguientes 2 piezas y las carga en el juego
procedure GenPiezas(ModoJ: Char; VAR IdAct, IdSig: Byte);
var
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
  if JuegoActivo then
    if IdAct = 0 then
      // Generar pieza actual de forma aleatoria
      IdAct := random(NumPiezas) + 1
    else
      // Sustituir pieza actual por la seleccionada anteriormente
      IdAct := IdSig;
    IdSig := random(NumPiezas) + 1;

    // PENDIENTE: Cargar pieza en tablero

    // Seleccionar archivos de imagen de la siguiente pieza
    ArchSig := 'img/piezas/pieza' + IntToStr(PiezasDisp[IdSig]) + '.png';
    // Cargar imagen de siguiente pieza
    Tetris.ImgSigPieza.Picture.LoadFromFile(ArchSig);

    // Cargar datos del ODS de la pieza actual
    Tetris.ImgODS.Picture.LoadFromFile(ImagenesODS[ODSDisp[IdAct]]);
    Tetris.TituloODS.Caption := TitulosODS[ODSDisp[IdAct]];
    Tetris.MensajeODS.Caption := MensajesODS[ODSDisp[IdAct]];
end;

// Función que limpia filas del tablero y devuelve el puntaje ganado de ese movimiento
function LimpiarFilas(): DWord;
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
end;

procedure TTetris.PantJuegoShow(Sender: TObject);
var
  Formato: String;
  i, j: Byte;
begin
  JuegoActivo := True;
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
  // Limpiar tablero de Tetris y mostrar
  for i := 1 to 12 do
    for j := 1 to 9 do
      Tablero[i,j] := 0;
  MostrarCeldas();
  //Inicializar puntaje
  Puntaje := 0;
  TextoPuntaje.Caption := 'Puntaje: ' + IntToStr(Puntaje);
  // PRUEBAS: Generar primera pieza y siguiente pieza
  randomize;
  IdActPieza := 0;
  IdSigPieza := 0;
  GenPiezas(ModoJ, IdActPieza, IdSigPieza);
end;

procedure TTetris.TimerJuegoTimer(Sender: TObject);
begin
  NRest.Caption := intToStr(CtRest);
  CtRest := CtRest - 1;
  if CtRest = -1 then
    TimerJuego.Enabled := False;
end;


end.

