unit FormTetris;
{$mode objfpc}{$H+}

interface
uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ComCtrls, StdCtrls,
  ExtCtrls, Types;

type

  { TTetris }
  TTetris = class(TForm)
    ImgODS: TImage;
    ImgSigPieza: TImage;
    MensajeODS: TLabel;
    BordeTab: TShape;
    TxtSiguiente: TLabel;
    TextoPuntaje: TLabel;
    Pantallas: TPageControl;
    PantJuego: TTabSheet;
    PantPrueba: TTabSheet;
    DatosJug: TStaticText;
    procedure PantJuegoShow(Sender: TObject);
  private

  public

  end;

var
  Tetris: TTetris;

implementation
{$R *.lfm}

uses
  tiposYConst, guardarJuegos;

var
  JugActual: Jugador;
  Tablero: Array[1..12, 1..9] of Byte;
  GrafTablero: Array[1..12, 1..9] of TImage;
  Puntaje: DWord;
  IdSigPieza: Byte;

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

procedure MostrarSigPieza();
var
  ArchivoImg: String;
begin
  ArchivoImg := 'img/piezas/';
  // Seleccionar archivo
  case IdSigPieza of
    1: ArchivoImg := ArchivoImg + 'pieza1.png';
    2: ArchivoImg := ArchivoImg + 'pieza2.png';
    3: ArchivoImg := ArchivoImg + 'pieza3.png';
    4: ArchivoImg := ArchivoImg + 'pieza4.png';
    5: ArchivoImg := ArchivoImg + 'pieza5.png';
    6: ArchivoImg := ArchivoImg + 'pieza6.png';
    7: ArchivoImg := ArchivoImg + 'pieza7.png';
    8: ArchivoImg := ArchivoImg + 'pieza8.png';
  end;
  // Cargar imagen
  Tetris.ImgSigPieza.Picture.LoadFromFile(ArchivoImg);
  // PENDIENTE: Mostrar ODS asociado con su imagen respectiva
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
  // PARA PRUEBAS: Inicializar jugador
  with JugActual do
    begin
      NombreComp := 'Nombre';
      Usuario := 'Usuario';
      IndPais := 3;
      PtsAcum := 0;
      Formato := 'Jugador: %0:-S (%1:-S)   Pais: %2:-S   Puntos acumulados: %3-D';
      DatosJug.Caption := Format(Formato, [NombreComp, Usuario, CodPaises[IndPais], PtsAcum]);
    end;
  // Limpiar tablero de Tetris y mostrar
  for i := 1 to 12 do
    for j := 1 to 9 do
        Tablero[i,j] := 1;
  Tablero[1,1] := 2;
  Tablero[1,2] := 3;
  Tablero[1,3] := 4;
  Tablero[1,4] := 5;
  Tablero[1,5] := 6;
  Tablero[1,6] := 7;
  Tablero[1,7] := 8;
  Tablero[1,8] := 0;
  MostrarCeldas();
  //Inicializar puntaje
  Puntaje := 0;
  TextoPuntaje.Caption := 'Puntaje: ' + IntToStr(Puntaje);
  // PRUEBAS: Generar primera pieza y siguiente pieza
  IdSigPieza := 8;
  MostrarSigPieza();
end;


end.
