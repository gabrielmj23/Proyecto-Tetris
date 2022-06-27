unit tiposYConst;

// Público ---------------------------------------------------------------------
interface
  type
    Juego = Record
              Codigo: DWord;
              Usuario: String[12];
              Fecha: String[10];
              Hora: String[8];
              PtsGanados: DWord;
            end;

    Jugador = Record
                NombreComp: String[25];
                Usuario: String[12];
                Clave: String[10];
                Correo: String[30];
                IndPais: Byte;
                PtsAcum: DWord;
              end;

  const
    NomPaises:
      Array[1..13] of String[17] = ( 'Argentina', 'Bolivia', 'Brasil', 'Chile',
                                     'Colombia', 'Ecuador', 'Guyana', 'Paraguay',
                                     'Peru', 'Surinam', 'Trinidad y Tobago',
                                     'Uruguay', 'Venezuela');

    CodPaises:
      Array[1..13] of String[3] = ('ARG', 'BOL', 'BRA', 'CHL', 'COL', 'ECU', 'GUY',
                                   'PRY', 'PER', 'SUR', 'TTO', 'URY', 'VEN');


// Privado ---------------------------------------------------------------------
implementation

end.

