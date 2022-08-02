unit FormTetris;
{$mode objfpc}{$H+}

interface
uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ComCtrls, StdCtrls,
  ExtCtrls, CheckLst, Types, LCLType, EditBtn, TAGraph;

type

  { TTetris }
  TTetris = class(TForm)
    BAtrasConf: TImage;
    BConfirmar: TImage;
    BEstadResumen: TImage;
    BEstadisticas: TImage;
    BFinal: TImage;
    BGenReporte: TImage;
    BGenRJugador: TImage;
    BGenTop5: TImage;
    BInicioSesion: TImage;
    BJugarOtra: TImage;
    BotonJugar: TImage;
    BRegistrar: TImage;
    BRegistrarse: TImage;
    BReporteGlobal: TImage;
    BReporteJug: TImage;
    BReportePais: TImage;
    BSalir: TImage;
    BTop5Global: TImage;
    BTop5Pais: TImage;
    Bvolver: TImage;
    Bvolver1: TImage;
    Bvolver2: TImage;
    CajaPaises1: TComboBox;
    CajaPaises2: TComboBox;
    campo_usuario: TEdit;
    Campo_clave: TEdit;
    Campo_NombreC: TEdit;
    campo_UsuarioR: TEdit;
    campo_correo: TEdit;
    Campo_claveR: TEdit;
    CeroTxt: TLabel;
    CajaPaises: TComboBox;
    FondoRJug: TImage;
    FondoMenu: TImage;
    FondoTops: TImage;
    BAtrasEst: TImage;
    BJugarM: TImage;
    BEstadisticasM: TImage;
    BCerrarSesion: TImage;
    ImgParche1: TImage;
    ImgPais: TImage;
    ImgParche2: TImage;
    ErrorSesion: TLabel;
    ErrorReg: TLabel;
    ImgParche3: TImage;
    MsjBienv: TLabel;
    MenuJug: TTabSheet;
    TituloSesion: TImage;
    ImgParche: TImage;
    ImgRepJugador: TImage;
    IngJugador: TEdit;
    FondoRepG: TImage;
    TituloReg: TImage;
    TituloEstadisticas: TImage;
    TituloTop: TLabel;
    LabelNComp: TLabel;
    LabelPtsJuego: TLabel;
    LabelUsuario: TLabel;
    LabelCorreo: TLabel;
    LabelPais: TLabel;
    LabelPuntos: TLabel;
    CajaDatos: TPanel;
    MsjDirectorio2: TLabel;
    MsjSalida2: TLabel;
    ResultTop5: TPanel;
    PTop5: TTabSheet;
    SelDirectorio2: TDirectoryEdit;
    SelPaisTop: TLabel;
    TituloJuegos: TLabel;
    LabelCodigo: TLabel;
    LabelF: TLabel;
    LabelH: TLabel;
    MsjDirectorio1: TLabel;
    MsjSalida1: TLabel;
    CajaJuegos: TScrollBox;
    SelDirectorio1: TDirectoryEdit;
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
    PRepJugador: TTabSheet;
    SelJugador: TLabel;
    TxtErrorRep: TLabel;
    TxtErrorRep1: TLabel;
    TxtErrorRep2: TLabel;
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
    ImgClave: TImage;
    ImgNombre: TImage;
    ImgUser: TImage;
    ImgCorreo: TImage;
    ImgClaveR: TImage;
    ImgUsuario: TImage;
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
    procedure BAtrasConfClick(Sender: TObject);
    procedure BCerrarSesionClick(Sender: TObject);
    procedure BCerrarSesionMouseEnter(Sender: TObject);
    procedure BCerrarSesionMouseLeave(Sender: TObject);
    procedure BConfirmarClick(Sender: TObject);
    procedure BConfirmarMouseEnter(Sender: TObject);
    procedure BEstadisticasClick(Sender: TObject);
    procedure BEstadisticasMouseEnter(Sender: TImage);
    procedure BEstadisticasMouseLeave(Sender: TImage);
    procedure BGenReporteClick(Sender: TObject);
    procedure BGenReporteMouseEnter(Sender: TImage);
    procedure BGenReporteMouseLeave(Sender: TImage);
    procedure BGenRJugadorClick(Sender: TObject);
    procedure BGenTop5Click(Sender: TObject);
    procedure BInicioSesionClick(Sender: TObject);
    procedure BInicioSesionMouseEnter(Sender: TImage);
    procedure BInicioSesionMouseLeave(Sender: TImage);
    procedure BJugarMClick(Sender: TObject);
    procedure BJugarMMouseEnter(Sender: TImage);
    procedure BJugarMMouseLeave(Sender: TImage);
    procedure BJugarOtraClick(Sender: TObject);
    procedure BJugarOtraMouseEnter(Sender: TObject);
    procedure BJugarOtraMouseLeave(Sender: TObject);
    procedure BotonJugarClick(Sender: TObject);
    procedure BRegistrarClick(Sender: TObject);
    procedure BRegistrarseClick(Sender: TObject);
    procedure BRegistrarseMouseEnter(Sender: TImage);
    procedure BRegistrarseMouseLeave(Sender: TImage);
    procedure BReporteGlobalClick(Sender: TObject);
    procedure BReporteGlobalMouseEnter(Sender: TObject);
    procedure BReporteGlobalMouseLeave(Sender: TObject);
    procedure BReporteJugClick(Sender: TObject);
    procedure BReporteJugMouseEnter(Sender: TObject);
    procedure BReporteJugMouseLeave(Sender: TObject);
    procedure BReportePaisClick(Sender: TObject);
    procedure BReportePaisMouseEnter(Sender: TObject);
    procedure BReportePaisMouseLeave(Sender: TObject);
    procedure BSalirClick(Sender: TObject);
    procedure BSalirMouseEnter(Sender: TImage);
    procedure BSalirMouseLeave(Sender: TImage);
    procedure BTop5GlobalClick(Sender: TObject);
    procedure BTop5GlobalMouseEnter(Sender: TObject);
    procedure BTop5GlobalMouseLeave(Sender: TObject);
    procedure BTop5PaisClick(Sender: TObject);
    procedure BTop5PaisMouseEnter(Sender: TObject);
    procedure BTop5PaisMouseLeave(Sender: TObject);
    procedure BvolverClick(Sender: TObject);
    procedure BvolverMouseEnter(Sender: TImage);
    procedure BvolverMouseLeave(Sender: TImage);
    procedure ConfJuegoShow(Sender: TObject);
    procedure BAtrasEstMouseEnter(Sender: TImage);
    procedure BAtrasEstMouseLeave(Sender: TImage);
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
    procedure MenuJugShow(Sender: TObject);
    procedure PantallasChange(Sender: TObject);
    procedure PantJuegoShow(Sender: TObject);
    procedure PRepGeneralShow(Sender: TObject);
    procedure PRepJugadorShow(Sender: TObject);
    procedure PTop5Show(Sender: TObject);
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
  tiposYConst, usuarios, guardarJuegos, reportes, MMSystem;

var
  // Uso General
  EstadoMusica, SesionAct: Boolean;
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
  SesionAct := False;
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

// Procedimiento que maneja la selección de ODS
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

// Mostrar pantalla de Jugar-Estadísticas-Cerrar sesión
procedure TTetris.MenuJugShow(Sender: TObject);
begin
  MsjBienv.Caption := 'Bienvenido, ' + JugActual.NombreComp;
end;

procedure TTetris.BInicioSesionClick(Sender: TObject);
begin
 inicioSesion.show;
 Pantallas.OnChange(Pantallas);
end;

procedure TTetris.BInicioSesionMouseEnter(Sender: TImage);
begin
  Sender.picture.LoadFromFile('img/botones/BinicioS2.png');
end;

procedure TTetris.BInicioSesionMouseLeave(Sender: TImage);
begin
  Sender.picture.loadfromfile('img/botones/BinicioS1.png');
end;

procedure TTetris.BJugarMClick(Sender: TObject);
begin
  ConfJuego.Show;
  Pantallas.OnChange(Pantallas);
end;

procedure TTetris.BJugarMMouseEnter(Sender: TImage);
begin
  Sender.Picture.LoadFromFile('img/botones/Bjugar2.png');
end;

procedure TTetris.BJugarMMouseLeave(Sender: TImage);
begin
  Sender.Picture.LoadFromFile('img/botones/Bjugar1.png');
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
      PantJuego.Show;
      Pantallas.OnChange(Pantallas);
    end;
end;

procedure TTetris.BRegistrarClick(Sender: TObject);
var
  ResUsuario, ResCorreo: Boolean;
  ResClave: Byte;
begin
  with JugActual do
    begin
      NombreComp := Campo_NombreC.Text;
      Usuario := campo_UsuarioR.Text;
      Correo := campo_correo.Text;
      Clave := Campo_claveR.Text;
      IndPais := CajaPaises2.ItemIndex+1;
    end;
  ResUsuario := validarUsuario(JugActual);
  ResCorreo := validarCorreo(JugActual);
  ResClave := validarClave(JugActual);
  // Revisar errores de validación
  if trim(JugActual.NombreComp) = '' then
    begin
      ErrorReg.Caption := 'El nombre no puede estar vacío';
      ErrorReg.Visible := True;
    end
  else if not ResUsuario then
    begin
      ErrorReg.Caption := 'El usuario ya existe o no se ingresó';
      ErrorReg.Visible := True;
    end
  else if not ResCorreo then
    begin
      ErrorReg.Caption := 'El correo no es válido o no se ingresó';
      ErrorReg.Visible := True;
    end
  else if ResClave <> 0 then
    begin
      case ResClave of
        1: ErrorReg.Caption := 'Longitud de clave inválida, debe estar entre 8 y 10';
        2: ErrorReg.Caption := 'La clave debe contener al menos una minúscula';
        3: ErrorReg.Caption := 'La clave debe contener al menos una mayúscula';
        4: ErrorReg.Caption := 'La clave debe contener al menos un número';
        5: ErrorReg.Caption := 'Su clave no tiene caracteres especiales, o son inválidos';
        6: ErrorReg.Caption := 'Su clave contiene caracteres inválidos (acento o ñ)';
        7: ErrorReg.Caption := 'La clave no puede tener más de 3 caracteres consecutivos iguales';
      end;
      ErrorReg.Visible := True;
    end
  else
    begin
      ErrorReg.Visible := False;
      registro(JugActual);
      SesionAct := True;
      MenuJug.Show;
      Pantallas.OnChange(Pantallas);
    end;
end;

procedure TTetris.BRegistrarseClick(Sender: TObject);
begin
  registracion.show;
  Pantallas.OnChange(Pantallas);
end;

procedure TTetris.BRegistrarseMouseEnter(Sender: TImage);
begin
  Sender.picture.loadfromfile('img/botones/Bregistrarse2.png');
end;

procedure TTetris.BRegistrarseMouseLeave(Sender: TImage);
begin
  Sender.picture.loadfromfile('img/botones/Bregistrarse1.png');
end;

procedure TTetris.BReporteGlobalClick(Sender: TObject);
begin
  ModoReporte := 1;
  PRepGeneral.Show;
  Pantallas.OnChange(Pantallas);
end;

procedure TTetris.BReporteGlobalMouseEnter(Sender: TObject);
begin
  BReporteGlobal.picture.loadfromfile('img/botones/BreporteG2.png');
end;

procedure TTetris.BReporteGlobalMouseLeave(Sender: TObject);
begin
  BReporteGlobal.picture.loadfromfile('img/botones/BreporteG1.png');
end;

procedure TTetris.BReporteJugClick(Sender: TObject);
begin
  ModoReporte := 3;
  PRepJugador.Show;
  Pantallas.OnChange(Pantallas);
end;

procedure TTetris.BReporteJugMouseEnter(Sender: TObject);
begin
  BReporteJug.picture.loadfromfile('img/botones/BreporteJ2.png');

end;

procedure TTetris.BReporteJugMouseLeave(Sender: TObject);
begin
  BReporteJug.picture.loadfromfile('img/botones/BreporteJ1.png');
end;

procedure TTetris.BReportePaisClick(Sender: TObject);
begin
  ModoReporte := 2;
  PRepGeneral.Show;
  Pantallas.OnChange(Pantallas);
end;

procedure TTetris.BReportePaisMouseEnter(Sender: TObject);
begin
  BReportePais.picture.loadfromfile('img/botones/BreporteP2.png');
end;

procedure TTetris.BReportePaisMouseLeave(Sender: TObject);
begin
  BReportePais.picture.loadfromfile('img/botones/BreporteP1.png');
end;

procedure TTetris.BSalirClick(Sender: TObject);
begin
  Tetris.Close;
end;

procedure TTetris.BSalirMouseEnter(Sender: TImage);
begin
  Sender.picture.loadfromfile('img/botones/BSalir2.png');
end;

procedure TTetris.BSalirMouseLeave(Sender: TImage);
begin
  Sender.picture.loadfromfile('img/botones/BSalir1.png');
end;

procedure TTetris.BTop5GlobalClick(Sender: TObject);
begin
  ModoReporte := 4;
  PTop5.Show;
  Pantallas.OnChange(Pantallas);
end;

procedure TTetris.BTop5GlobalMouseEnter(Sender: TObject);
begin
  BTop5Global.picture.loadfromfile('img/botones/BTop5G2.png');
end;

procedure TTetris.BTop5GlobalMouseLeave(Sender: TObject);
begin
  BTop5Global.picture.loadfromfile('img/botones/BTop5G1.png');
end;

procedure TTetris.BTop5PaisClick(Sender: TObject);
begin
  ModoReporte := 5;
  PTop5.Show;
  Pantallas.OnChange(Pantallas);
end;

procedure TTetris.BTop5PaisMouseEnter(Sender: TObject);
begin
  BTop5Pais.picture.loadfromfile('img/botones/BTop5P2.png');
end;

procedure TTetris.BTop5PaisMouseLeave(Sender: TObject);
begin
  BTop5Pais.picture.loadfromfile('img/botones/BTop5P1.png')
end;

procedure TTetris.BvolverClick(Sender: TObject);
begin
 if SesionAct then
   MenuJug.Show
 else
   PantallaInicial.show;
 Pantallas.OnChange(Pantallas);
end;

procedure TTetris.BvolverMouseEnter(Sender: TImage);
begin
  Sender.picture.loadfromfile('img/botones/Bvolver2.png');
end;

procedure TTetris.BvolverMouseLeave(Sender: TImage);
begin
  Sender.picture.loadfromfile('img/botones/Bvolver1.png');
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

procedure TTetris.BAtrasEstMouseEnter(Sender: TImage);
begin
  Sender.Picture.LoadFromFile('img/botones/Batras2.png');
end;

procedure TTetris.BAtrasEstMouseLeave(Sender: TImage);
begin
  Sender.Picture.LoadFromFile('img/botones/Batras1.png');
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
              AltMax[j] := i-1;
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
  if Tetris.Pantallas.ActivePage = Tetris.PantJuego then
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
  ArchBloque, ArchSig: String;
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
    begin
      Tablero[PiezaActual[i,1], PiezaActual[i,2]] := PtsPiezaAct;
      ArchBloque := 'img/bloques/bloque' + IntToStr(PtsPiezaAct) + '.png';
      GrafTablero[PiezaActual[i,1], PiezaActual[i,2]].Picture.LoadFromFile(ArchBloque);
      GrafTablero[PiezaActual[i,1], PiezaActual[i,2]].Visible := True;
    end;

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
      Tetris.ResumenJuego.Show;
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
  if Pantallas.ActivePage = PantJuego then
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
  MostrarCeldas();
end;

// Procedimiento que maneja la gravedad de la pieza
procedure TTetris.TimerGravTimer(Sender: TObject);
var
  i: Byte;
  Colision: Boolean;
  ArchBloque: String;
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
        begin
          Tablero[PiezaActual[i,1], PiezaActual[i,2]] := 0;
          GrafTablero[PiezaActual[i,1], PiezaActual[i,2]].Visible := False;
        end;

      // Movimiento
      for i := 1 to 4 do
        begin
          PiezaActual[i,1] := PiezaActual[i,1] + 1;
          Tablero[PiezaActual[i,1], PiezaActual[i,2]] := PtsPiezaAct;
          ArchBloque := 'img/bloques/bloque' + IntToStr(PtsPiezaAct) + '.png';
          GrafTablero[PiezaActual[i,1], PiezaActual[i,2]].Picture.LoadFromFile(ArchBloque);
          GrafTablero[PiezaActual[i,1], PiezaActual[i,2]].Visible := True;
        end;
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
  Formato: String[63];
  i, j: Byte;
begin
  // Mostrar datos del jugador
  with JugActual do
    begin
      Formato := 'Jugador: %0:-S (%1:-S)   País: %2:-S   Puntos acumulados: %3-D';
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
        GrafTablero[i,j] := TImage.Create(Self);
        GrafTablero[i,j].Left := 240 + (j-1)*50;
        GrafTablero[i,j].Top := 140 + (i-1)*50;
        GrafTablero[i,j].Height := 50;
        GrafTablero[i,j].Width := 50;
        GrafTablero[i,j].Proportional := True;
        GrafTablero[i,j].Parent := Tetris.PantJuego;
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
      ResumenJuego.Show;
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
  ConfJuego.Show;
  Pantallas.OnChange(Pantallas);
end;

procedure TTetris.BJugarOtraMouseEnter(Sender: TObject);
begin
  BJugarOtra.Picture.LoadFromFile('img/botones/BOtraVez2.png');
end;

procedure TTetris.BJugarOtraMouseLeave(Sender: TObject);
begin
  BJugarOtra.Picture.LoadFromFile('img/botones/BOtraVez1.png');
end;

procedure TTetris.BConfirmarMouseEnter(Sender: TObject);
begin
  BConfirmar.picture.loadfromfile('img/botones/BinicioS2.png');
end;

procedure TTetris.BConfirmarClick(Sender: TObject);
begin
  JugActual.Usuario := campo_usuario.Text;
  JugActual.Clave := Campo_clave.Text;
  if validarSesion(JugActual) then
    begin
      SesionAct := True;
      ErrorSesion.Visible := False;
      MenuJug.Show;
      Pantallas.OnChange(Pantallas);
    end
  else
    ErrorSesion.Visible := True;
end;

procedure TTetris.BAtrasConfClick(Sender: TObject);
begin
  MenuJug.Show;
  Pantallas.OnChange(Pantallas);
end;

procedure TTetris.BCerrarSesionClick(Sender: TObject);
begin
  SesionAct := False;
  PantallaInicial.Show;
  Pantallas.OnChange(Pantallas);
end;

procedure TTetris.BCerrarSesionMouseEnter(Sender: TObject);
begin
  BCerrarSesion.Picture.LoadFromFile('img/botones/Bcerrarsesion2.png');
end;

procedure TTetris.BCerrarSesionMouseLeave(Sender: TObject);
begin
  BCerrarSesion.Picture.LoadFromFile('img/botones/Bcerrarsesion1.png');
end;

procedure TTetris.BEstadisticasClick(Sender: TObject);
begin
  estadisticas.show;
  Pantallas.OnChange(Pantallas);
end;

procedure TTetris.BEstadisticasMouseEnter(Sender: TImage);
begin
  Sender.picture.loadfromfile('img/botones/BEstadisticas2.png');
end;

procedure TTetris.BEstadisticasMouseLeave(Sender: TImage);
begin
  Sender.picture.loadfromfile('img/botones/BEstadisticas1.png');
end;

procedure TTetris.PRepGeneralShow(Sender: TObject);
begin
  BAtrasEst.Parent := PRepGeneral;
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
      TxtErrorRep.Top := 160;
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
  LeftFig = 205;
  TopFig = 38;
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
          CeroTxt.Visible := False;
          PMax.Visible := False;
          DiagramaG.Visible := False;
        end
      else
        begin
          MsjSalida.Visible := True;
          MsjSalida.Caption := 'Se generó el reporte como ' + RGeneral.NArchivo;
          // Determinar mayor puntaje
          NJugadores := length(RGeneral.LJugadores);
          PtsMax := 0;
          for i := 0 to NJugadores-1 do
            if RGeneral.LPuntajes[i] > PtsMax then
              PtsMax := RGeneral.LPuntajes[i];
          CeroTxt.Visible := True;
          PMax.Caption := IntToStr(PtsMax);
          PMax.Visible := True;
          // Generar uno a uno los elementos del diagrama
          while DiagramaG.ControlCount > 0 do
            DiagramaG.Controls[0].Free;
          for i := 0 to NJugadores-1 do
            begin
              // Crear label con usuario
              LabelNom := TLabel.Create(Self);
              LabelNom.Parent := DiagramaG;
              LabelNom.Left := LeftLab;
              LabelNom.Top := TopLab * (i+1) + 30 * i;
              LabelNom.Font.Size := 11;
              LabelNom.Font.Name := 'OCR A Extended';
              LabelNom.Caption := RGeneral.LJugadores[i].Usuario;
              // Crear barra que indique el puntaje
              RectJug := TShape.Create(Self);
              RectJug.Parent := DiagramaG;
              RectJug.Brush.Color := clLime;
              RectJug.Shape := stRectangle;
              RectJug.Left := LeftFig;
              RectJug.Top := TopFig * (i+1) + 30 * i;
              RectJug.Height := 28;
              RectJug.Width := round(MaxW * (RGeneral.LPuntajes[i] / PtsMax));
            end;
          DiagramaG.Visible := True;
        end;
    end;
end;

procedure TTetris.BGenReporteMouseEnter(Sender: TImage);
begin
  Sender.Picture.LoadFromFile('img/botones/Bgenerar2.png');
end;

procedure TTetris.BGenReporteMouseLeave(Sender: TImage);
begin
  Sender.Picture.LoadFromFile('img/botones/Bgenerar1.png');
end;

procedure TTetris.PRepJugadorShow(Sender: TObject);
begin
  BAtrasEst.Parent := PRepJugador;
  TxtErrorRep1.Visible := False;
  MsjSalida1.Visible := False;
  CajaDatos.Visible := False;
  CajaJuegos.Visible := False;
end;

// Manejar petición para reporte de jugador
procedure TTetris.BGenRJugadorClick(Sender: TObject);
const
  TopLinea = 94;
  Lefts: Array[1..4] of Word = (210, 360, 496, 640);
var
  RJugador: RepJugador;
  NJuegos, i, j: DWord;
  LineaDatos: Array[1..4] of TLabel;
begin
  // Verificar que seleccionó directorio
  if (SelDirectorio1.Directory = '(Sin seleccionar)') or (SelDirectorio1.Directory = '') then
    begin
      MsjSalida1.Visible := False;
      CajaJuegos.Visible := False;
      TxtErrorRep1.Caption := 'Debe seleccionar una carpeta';
      TxtErrorRep1.Visible := True;
    end
  // Verificar que seleccionó jugador
  else if (trim(IngJugador.Text) = '') then
    begin
      MsjSalida1.Visible := False;
      CajaDatos.Visible := False;
      CajaJuegos.Visible := False;
      TxtErrorRep1.Caption := 'Debe ingresar un usuario';
      TxtErrorRep1.Visible := True;
    end
  else
    begin
      TxtErrorRep.Visible := False;
      RJugador := reporteJugador(SelDirectorio1.Directory, IngJugador.Text);
      // Dar mensaje si no existe el usuario
      if not RJugador.JugExiste then
        begin
          MsjSalida1.Caption := 'El jugador ingresado no se encontró';
          MsjSalida1.Visible := True;
          CajaDatos.Visible := False;
          CajaJuegos.Visible := False;
        end
      else
        begin
          MsjSalida1.Caption := 'Se generó el reporte como ' + RJugador.NArchivo;
          MsjSalida1.Visible := True;
          // Cargar datos en la caja de datos
          with RJugador.JugSolicitado do
            begin
              LabelNComp.Caption := 'Nombre completo: ' + NombreComp;
              LabelUsuario.Caption := 'Usuario: ' + Usuario;
              LabelCorreo.Caption := 'Correo: ' + Correo;
              LabelPais.Caption := 'País de origen: ' + NomPaises[IndPais];
              LabelPuntos.Caption := 'Puntos acumulados: ' + IntToStr(puntosJugador(Usuario));
            end;
          CajaDatos.Visible := True;
          // Limpiar juegos anteriores
          while CajaJuegos.ControlCount > 5 do
            CajaJuegos.Controls[5].Free;
          // Cargar juegos en la caja de juegos
          NJuegos := length(RJugador.LJuegos);
          for i := 0 to NJuegos-1 do
            for j := 1 to 4 do
              begin
                LineaDatos[j] := TLabel.Create(Self);
                LineaDatos[j].Parent := CajaJuegos;
                LineaDatos[j].Left := Lefts[j];
                LineaDatos[j].Top := TopLinea + 30 * i;
                LineaDatos[j].Font.Size := 11;
                LineaDatos[j].Font.Name := 'OCR A Extended';
                case j of
                  1: LineaDatos[j].Caption := IntToStr(RJugador.LJuegos[i].Codigo);
                  2: LineaDatos[j].Caption := RJugador.LJuegos[i].Fecha;
                  3: LineaDatos[j].Caption := RJugador.LJuegos[i].Hora;
                  4: LineaDatos[j].Caption := IntToStr(RJugador.LJuegos[i].PtsGanados);
                end;
              end;
          CajaJuegos.Visible := True;
        end;
    end;
end;

procedure TTetris.PTop5Show(Sender: TObject);
begin
  BAtrasEst.Parent := PTop5;
  TxtErrorRep2.Visible := False;
  MsjSalida2.Visible := False;
  ResultTop5.Visible := False;
  if ModoReporte = 4 then
    begin
      SelPaisTop.Visible := False;
      CajaPaises1.Visible := False;
      BGenTop5.Top := 96;
      TxtErrorRep2.Top := 104;
      MsjSalida2.Top := 148;
    end
  else
    begin
      SelPaisTop.Visible := True;
      CajaPaises1.Visible := True;
      BGenTop5.Top := 152;
      TxtErrorRep2.Top := 160;
      MsjSalida2.Top := 208;
    end;
end;

// Manejar petición para top 5
procedure TTetris.BGenTop5Click(Sender: TObject);
const
  TopElem = 72;
  Lefts: Array[1..3] of Word = (280, 376, 592);
var
  RTop5: RepTop5;
  i, j: Byte;
  LineaTop: Array[1..3] of TLabel;
begin
  if (SelDirectorio2.Directory = '(Sin seleccionar)') or (SelDirectorio2.Directory = '') then
    begin
      MsjSalida2.Visible := False;
      ResultTop5.Visible := False;
      TxtErrorRep2.Caption := 'Debe seleccionar una carpeta';
      TxtErrorRep2.Visible := True;
    end
  else
    begin
      TxtErrorRep2.Visible := False;
      if ModoReporte = 4 then
        RTop5 := topGlobal(SelDirectorio2.Directory)
      else
        RTop5 := topPais(SelDirectorio2.Directory, CajaPaises1.Text);
      if RTop5.CantJugadores = 0 then
        // Mostrar mensaje si no hay jugadores
        begin
          MsjSalida2.Caption := 'No hay jugadores disponibles';
          MsjSalida2.Visible := True;
          ResultTop5.Visible := False;
        end
      else
        begin
          MsjSalida2.Caption := 'Se generó el reporte como ' + RTop5.NArchivo;
          MsjSalida2.Visible := True;
          TituloTop.Caption := 'TOP ' + IntToStr(RTop5.CantJugadores);
          // Limpiar resultados de top
          while ResultTop5.ControlCount > 1 do
            ResultTop5.Controls[1].Free;
          // Mostrar resultados
          for i := 0 to RTop5.CantJugadores-1 do
            for j := 1 to 3 do
              begin
                LineaTop[j] := TLabel.Create(Self);
                LineaTop[j].Parent := ResultTop5;
                LineaTop[j].Left := Lefts[j];
                LineaTop[j].Top := TopElem + 30 * i;
                LineaTop[j].Font.Size := 11;
                LineaTop[j].Font.Name := 'OCR A Extended';
                case j of
                  1: LineaTop[j].Caption := IntToStr(i+1) + '.';
                  2: LineaTop[j].Caption := RTop5.Top[i].Usuario;
                  3: LineaTop[j].Caption := IntToStr(RTop5.LPuntajes[i]) + ' puntos';
                end;
              end;
          ResultTop5.Visible := True;
        end;
    end;
end;

end.

