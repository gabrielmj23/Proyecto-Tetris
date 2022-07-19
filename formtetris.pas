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
    ImgInicio: TImage;
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
    procedure BEstadisticasClick(Sender: TObject);
    procedure BInicioSesionClick(Sender: TObject);
    procedure BRegistrarseClick(Sender: TObject);
    procedure BvolverClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
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
  JuegoActivo: Boolean;

procedure TTetris.FormCreate(Sender: TObject);
begin
  Pantallas.ActivePageIndex := 0;
end;

procedure TTetris.BInicioSesionClick(Sender: TObject);
begin
 inicioSesion.show;
end;

procedure TTetris.BEstadisticasClick(Sender: TObject);
begin
  estadisticas.show;
end;

procedure TTetris.BRegistrarseClick(Sender: TObject);
begin
  registracion.show;
end;

procedure TTetris.BvolverClick(Sender: TObject);
begin
 PantallaInicial.show;
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
        case Tablero[i,j] of
          0: ArchivoImg := ArchivoImg + 'vacio.png';
          1: ArchivoImg := ArchivoImg + 'bloque1.png';
          2: ArchivoImg := ArchivoImg + 'bloque2.png';
          3: ArchivoImg := ArchivoImg + 'bloque3.png';
          4: ArchivoImg := ArchivoImg + 'bloque4.png';
          5: ArchivoImg := ArchivoImg + 'bloque5.png';
          6: ArchivoImg := ArchivoImg + 'bloque6.png';
          7: ArchivoImg := ArchivoImg + 'bloque7.png';
          8: ArchivoImg := ArchivoImg + 'bloque8.png';
        end;
        GrafTablero[i,j].Picture.LoadFromFile(ArchivoImg);
      end;
end;

procedure GenPiezas(VAR IdAct, IdSig: Byte);
var
  ArchSig: String;
begin
  if CtRest = 0 then
    JuegoActivo := False
  else
    begin
      CtRest := CtRest - 1;
      Tetris.NRest.Caption := intToStr(CtRest);
      if IdAct = 0 then
        // Generar pieza actual de forma aleatoria
        IdAct := random(8) + 1
      else
        // Actualizar pieza actual por la seleccionada anteriormente
        IdAct := IdSig;
      IdSig := random(8) + 1;

      // Seleccionar archivos de imagen de la siguiente pieza
      ArchSig := 'img/piezas/';
      case IdSig of
        1: ArchSig := ArchSig + 'pieza1.png';
        2: ArchSig := ArchSig + 'pieza2.png';
        3: ArchSig := ArchSig + 'pieza3.png';
        4: ArchSig := ArchSig + 'pieza4.png';
        5: ArchSig := ArchSig + 'pieza5.png';
        6: ArchSig := ArchSig + 'pieza6.png';
        7: ArchSig := ArchSig + 'pieza7.png';
        8: ArchSig := ArchSig + 'pieza8.png';
      end;
      // Cargar imagen de siguiente pieza
      Tetris.ImgSigPieza.Picture.LoadFromFile(ArchSig);

      // Cargar datos del ODS de la pieza actual
      Tetris.ImgODS.Picture.LoadFromFile(ImagenesODS[IdAct]);
      Tetris.TituloODS.Caption := TitulosODS[IdAct];
      Tetris.MensajeODS.Caption := MensajesODS[IdAct];
    end;
end;

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
  ModoJ := 'T';
  case ModoJ of
    'T': begin
           TxtRestante.Caption := 'Tiempo restante:';
           CtRest := 10;
           NRest.Caption := '10';
           TimerJuego.Enabled := True;
         end;
    'J': begin
           TxtRestante.Caption := 'Jugadas restantes:';
           CtRest := 10;
           NRest.Caption := '10';
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
  GenPiezas(IdActPieza, IdSigPieza);
end;

procedure TTetris.TimerJuegoTimer(Sender: TObject);
begin
  NRest.Caption := intToStr(CtRest);
  CtRest := CtRest - 1;
  if CtRest = -1 then
    TimerJuego.Enabled := False;
end;


end.

