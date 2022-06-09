# Tetris en Pascal 👾
La meta del proyecto es recrear el videojuego "Tetris" en el lenguaje de programación Pascal, añadiendo elementos sobre los Objetivos de Desarrollo Sostenible de la ONU.

Además, cuenta con distintas características para hacerlo un juego más completo:

## Registro de usuarios 😎
Los usuarios están conformados por un nombre, un usuario, una clave de seguridad, un correo electrónico y un país de procedencia.

Los usuarios deben ser únicos y las claves poseen entre 8 y 10 carácteres, con números, mayúsculas, minúsculas y al menos un caracter especial entre '=', '*', '-', '_' o '.'. Además, no pueden tener más de 3 caracteres iguales consecutivos.

La información de usuario se almacena en un archivo 'Jugadores.dat'.

## Modos de juego 🎮
Cuenta con dos modos: contrarreloj y por jugadas. En el primero, se busca obtener la mayor cantidad de puntos en un tiempo establecido. En el segundo, se cuenta con una cantidad limitada de piezas.

## Mensajes sobre los ODS 🌎
Cuando aparece la siguiente pieza a utilizarse, se muestra en pantalla un mensaje de un Objetivo de Desarrollo Sostenible, ligado a la pieza específica.

## Almacenamiento y visualización de estadísticas 📊
Al finalizar cada partida, su información se almacena en un archivo 'Juegos.dat', y puede ser visualizada de distintas formas en un menú adicional.