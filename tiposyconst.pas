unit tiposYConst;

// Público ---------------------------------------------------------------------
interface
  type
    Juego = Record
              Codigo: DWord;
              Usuario: String[12];
              Fecha: String[10];
              Hora: String[8];
              PtsGanados: QWord;
            end;

    Jugador = Record
                NombreComp: String[25];
                Usuario: String[12];
                Clave: String[10];
                Correo: String[30];
                IndPais: Byte;
              end;

    // Para reporte general global y de pais
    RepGeneral = Record
                   LJugadores: Array of Jugador;
                   LPuntajes: Array of DWord;
                   NArchivo: String;
                 end;

    // Para reporte de jugador
    RepJugador = Record
                   JugSolicitado: Jugador;
                   LJuegos: Array of Juego;
                   NArchivo: String;
                   JugExiste: Boolean;
                 end;

    // Para reportes de top 5
    RepTop5 = Record
                Top: Array of Jugador;
                CantJugadores: Byte;  // En caso de que no hallan 5 jugadores en primer lugar
                LPuntajes: Array of DWord;
                NArchivo: String;
              end;

  const
    // PAISES - PARA EL REGISTRO, JUEGO Y REPORTES
    NomPaises:
      Array[1..13] of String[17] = ( 'Argentina', 'Bolivia', 'Brasil', 'Chile',
                                     'Colombia', 'Ecuador', 'Guyana', 'Paraguay',
                                     'Peru', 'Surinam', 'Trinidad y Tobago',
                                     'Uruguay', 'Venezuela');
    CodPaises:
      Array[1..13] of String[3] = ('ARG', 'BOL', 'BRA', 'CHL', 'COL', 'ECU', 'GUY',
                                   'PRY', 'PER', 'SUR', 'TTO', 'URY', 'VEN');

    // ODS - PARA EL JUEGO PRINCIPAL
    TitulosODS:
      Array[1..17] of String[32] = ('FIN DE LA POBREZA',
                                    'HAMBRE CERO',
                                    'SALUD Y BIENESTAR',
                                    'EDUCACION DE CALIDAD',
                                    'IGUALDAD DE GENERO',
                                    'AGUA LIMPIA',
                                    'ENERGIA ASEQUIBLE Y LIMPIA',
                                    'TRABAJO DECENTE',
                                    'INDUSTRIA E INFRAESTRUCTURA',
                                    'REDUCCION DE DESIGUALDADES',
                                    'COMUNIDADES SOSTENIBLES',
                                    'PRODUCCION Y CONSUMO RESPONSABLE',
                                    'ACCION POR EL CLIMA',
                                    'VIDA SUBMARINA',
                                    'VIDA TERRESTRE',
                                    'PAZ Y JUSTICIA',
                                    'ALIANZAS');
    MensajesODS:
      Array[1..17] of String[67] = ('Todos merecemos los recursos para una vida digna',
                                    'Acabemos con el hambre y la desnutricion en el mundo',
                                    'Luchemos por la cobertura universal de salud',
                                    'La educacion es el motor del desarrollo sostenible',
                                    'El crecimiento se da sin discriminacion de genero',
                                    'El agua potable es indispensable para la vida',
                                    'La energia limpia nos ayuda a nosotros y al medio ambiente',
                                    'Los trabajadores merecen condiciones adecuadas',
                                    'La infraestructura es vital para el desarrollo social y tecnologico',
                                    'Todos merecemos acceso a los mismos recursos basicos',
                                    'Nuestras ciudades pueden ser mas limpias y sostenibles',
                                    'Reciclar y reducir desechos ayuda a disminuir la huella ecologica',
                                    'Podemos adaptarnos y luchar contra el cambio climatico',
                                    'Debemos proteger los ecosistemas marinos',
                                    'Es urgente reducir la perdida de biodiversidad',
                                    'Cuidar los derechos humanos es cuidar a la humanidad',
                                    'Nada se lograra sin trabajo en equipo');
    ImagenesODS:
      Array[1..17] of String[27] = ('img/ods/pobreza.png',
                                    'img/ods/hambrecero.png',
                                    'img/ods/salud.png',
                                    'img/ods/educacion.png',
                                    'img/ods/iggenero.png',
                                    'img/ods/agua.png',
                                    'img/ods/energia.png',
                                    'img/ods/trabajo.png',
                                    'img/ods/infraestructura.png',
                                    'img/ods/desigualdad.png',
                                    'img/ods/comsostenibles.png',
                                    'img/ods/consresponsable.png',
                                    'img/ods/clima.png',
                                    'img/ods/vsubmarina.png',
                                    'img/ods/vterrestre.png',
                                    'img/ods/pazyjusticia.png',
                                    'img/ods/alianzas.png');

    // PIEZAS - PARA EL JUEGO PRINCIPAL
    // La matriz de piezas sigue la estructura: Número de pieza - Fila inicial del bloque - Columna inicial del bloque
    Piezas: Array[1..8, 1..4, 1..2] of Byte = (
                                                ( (1, 3), (1, 4), (1, 5), (1, 6) ),
                                                ( (1, 5), (2, 5), (3, 5), (4, 5) ),
                                                ( (1, 5), (2, 5), (3, 5), (3, 6) ),
                                                ( (1, 5), (2, 5), (3, 5), (3, 4) ),
                                                ( (1, 5), (2, 5), (2, 4), (3, 4) ),
                                                ( (1, 4), (2, 4), (1, 5), (2, 5) ),
                                                ( (1, 4), (1, 5), (2, 5), (2, 6) ),
                                                ( (1, 5), (2, 4), (2, 5), (2, 6) )
                                              );

    AlturaPiezas: Array[1..8] of Byte = ( 1, 4, 3, 3, 3, 2, 2, 2 );


// Privado ---------------------------------------------------------------------
implementation

end.

