unit FTetris;
{$mode objfpc}{$H+}

interface
uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ComCtrls, StdCtrls,
  Grids, Types;

type

  { TTetris }

  TTetris = class(TForm)
    DatosJug: TLabel;
    Pantallas: TPageControl;
    PantJuego: TTabSheet;
    PantPrueba: TTabSheet;
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

{ TTetris }

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
      IndPais := 2;
      PtsAcum := 0;
      Formato := 'Jugador: %0:-S (%1:-S)   Pais: %2:-S   Puntos acumulados: %3-D';
      DatosJug.Caption := Format(Formato, [NombreComp, Usuario, CodPaises[IndPais], PtsAcum]);
    end;
  // Limpiar tablero de Tetris
  for i := 1 to 12 do
    for j := 1 to 9 do
      begin
        Tablero[i,j] := 0;
        // PENDIENTE: Dibujar tablero inicial
      end;
end;


end.

