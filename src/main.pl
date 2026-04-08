%Cargar las reglas desde el archivo rules.pl
:- consult('rules.pl').

%! solve(+SudokuName)
% Solves the Sudoku layout corresponding to the given name.

%---DEFINICION DE TABLERO---

% BANCO DE SUDOKUS

% Sudoku Irresoluble
sudokuInvalid([0,0,3,0,2,0,7,0,0,
        5,0,0,0,0,0,4,0,3,
        0,0,0,3,0,0,0,2,5,
        0,0,5,0,1,0,6,0,0,
        0,4,8,0,7,0,0,0,2,
        3,7,6,0,4,8,0,0,0,
        8,0,0,0,2,0,7,0,3,
        0,0,4,0,0,2,0,8,0,
        0,9,0,0,0,0,6,0,0]).

% Sudoku Vacío
sudokuEmpty([0,0,0,0,0,0,0,0,0,
        0,0,0,0,0,0,0,0,0,
        0,0,0,0,0,0,0,0,0,
        0,0,0,0,0,0,0,0,0,
        0,0,0,0,0,0,0,0,0,
        0,0,0,0,0,0,0,0,0,
        0,0,0,0,0,0,0,0,0,
        0,0,0,0,0,0,0,0,0,
        0,0,0,0,0,0,0,0,0]).

%Sudokus de Nivel Básico
sudokuBasic1([1,2,3,4,5,6,7,8,9,
        4,5,6,7,8,9,1,2,3,
        7,8,9,1,2,3,4,5,6,
        2,3,4,5,6,7,8,9,1,
        5,6,7,8,9,1,2,3,4,
        8,9,1,2,3,4,5,6,7,
        3,4,5,6,7,8,9,1,2,
        6,7,8,9,1,2,3,4,5,
        9,1,2,3,4,5,6,7,0]).

sudokuBasic2([5,3,4,6,7,8,9,1,2,
        6,7,2,1,9,5,3,4,8,
        1,9,8,3,4,2,5,6,7,
        8,5,9,7,6,1,4,2,3,
        4,2,6,8,5,3,7,9,1,
        7,1,3,9,2,4,8,5,6,
        9,6,1,5,3,7,2,8,4,
        2,8,7,4,1,9,6,3,5,
        3,4,5,2,8,6,1,7,0]).

sudokuBasic3([1,0,3,4,5,6,7,8,9,
        4,5,6,7,8,9,1,2,3,
        7,8,9,1,2,3,4,5,6,
        2,3,4,5,6,7,8,9,1,
        5,6,7,8,9,1,2,3,4,
        8,9,1,2,3,4,5,6,7,
        3,4,5,6,7,8,9,1,2,
        6,7,8,9,1,2,3,4,5,
        9,1,2,3,4,5,6,7,8]).

sudokuBasic4([1,0,3,0,5,6,0,8,9,
        4,5,6,7,8,9,1,2,3,
        7,8,9,1,2,3,4,5,6,
        2,3,4,5,6,7,8,9,1,
        5,6,7,8,9,1,2,3,4,
        8,9,1,2,3,4,5,6,7,
        3,4,5,6,7,8,9,1,2,
        6,7,8,9,1,2,3,4,5,
        9,1,2,3,4,5,6,7,8]).

sudokuBasic5([0,2,3,4,5,6,7,8,9,
        4,5,6,7,8,9,1,2,3,
        7,8,9,1,2,3,4,5,6,
        2,3,4,5,6,7,8,9,1,
        5,6,7,8,9,1,2,3,4,
        8,9,1,2,3,4,5,6,7,
        3,4,5,6,7,8,9,1,2,
        6,7,8,9,1,2,3,4,5,
        9,1,2,3,4,5,6,7,0]).

sudokuBasic6([5,3,4,6,7,8,9,1,2,
                 6,7,2,1,9,5,3,4,8,
                 1,9,8,3,4,2,5,6,7,
                 8,5,9,7,6,1,4,2,3,
                 4,2,6,8,5,3,7,9,1,
                 7,1,3,9,2,4,8,5,6,
                 9,6,1,5,3,7,2,8,0,
                 2,8,7,4,1,9,6,3,5,
                 3,4,5,2,8,6,1,7,0]).

sudokuBasic7([1,2,3,4,5,6,7,8,0,
                 4,5,6,7,8,9,1,2,3,
                 7,8,9,1,2,3,4,5,6,
                 2,3,4,5,6,7,8,9,1,
                 5,6,7,8,9,1,2,3,4,
                 8,9,1,2,3,4,5,6,7,
                 3,4,5,6,7,8,9,1,2,
                 6,7,8,9,1,2,3,4,5,
                 9,1,2,3,4,5,6,7,8]).

sudokuBasic8([9,1,2,3,4,5,6,7,8,
                 6,7,8,9,1,2,3,4,5,
                 3,4,5,6,7,8,9,1,2,
                 8,9,1,2,3,4,5,6,7,
                 5,6,7,8,9,1,2,3,4,
                 2,3,4,5,6,7,8,9,1,
                 7,8,9,1,2,3,4,5,6,
                 4,5,6,7,8,9,1,2,3,
                 1,2,3,4,5,6,7,8,0]).

% Sudokus de Nivel Intermedio
sudokuIntermediate1([5,3,0,0,7,0,0,0,0,
        6,0,0,1,9,5,0,0,0,
        0,9,8,0,0,0,0,6,0,
        8,0,0,0,6,0,0,0,3,
        4,0,0,8,0,3,0,0,1,
        7,0,0,0,2,0,0,0,6,
        0,6,0,0,0,0,2,8,0,
        0,0,0,4,1,9,0,0,5,
        0,0,0,0,8,0,0,7,9]).

sudokuIntermediate2([0,4,0,0,3,6,1,5,9,
        0,0,0,4,0,5,8,0,0,
        0,0,0,0,0,0,0,0,3,
        0,0,8,0,0,0,0,9,0,
        0,5,0,0,2,4,3,0,0,
        3,0,0,1,5,0,0,0,0,
        0,0,0,0,6,0,4,0,0,
        5,0,4,0,0,0,2,0,0,
        0,6,7,0,0,0,0,0,1]).

sudokuIntermediate3([0,2,0,0,0,0,0,0,0,
        0,0,0,6,0,0,0,0,3,
        0,7,4,0,8,0,0,0,0,
        0,0,0,0,0,3,0,0,2,
        0,8,0,0,4,0,0,1,0,
        6,0,0,5,0,0,0,0,0,
        0,0,0,0,1,0,7,8,0,
        5,0,0,0,0,9,0,0,0,
        0,0,0,0,0,0,0,4,0]).

sudokuIntermediate4([0,0,0,0,0,0,2,0,0,
        0,0,0,6,0,0,0,0,3,
        0,7,4,0,8,0,0,0,0,
        0,0,0,0,0,3,0,0,2,
        0,8,0,0,4,0,0,1,0,
        6,0,0,5,0,0,0,0,0,
        0,0,0,0,1,0,7,8,0,
        5,0,0,0,0,9,0,0,0,
        0,0,0,0,0,0,0,4,0]).

sudokuIntermediate5([1,0,3,0,5,6,0,8,9,
        4,5,6,7,8,9,1,2,3,
        7,8,9,1,2,3,4,5,6,
        2,3,4,5,6,7,8,9,1,
        5,6,7,8,9,1,2,3,4,
        8,9,1,2,3,4,5,6,7,
        3,4,5,6,7,8,9,1,2,
        6,7,8,9,1,2,3,4,5,
        9,1,2,3,4,5,6,7,8]).

sudokuIntermediate6([0,0,4,6,7,8,9,1,2,
                     6,7,0,1,9,5,3,4,0,
                     1,9,8,3,4,2,0,6,7,
                     8,5,9,7,6,0,4,2,3,
                     4,2,6,8,5,3,7,9,1,
                     7,1,3,0,2,4,8,5,6,
                     9,6,0,5,3,7,2,8,4,
                     0,8,7,4,1,9,6,3,5,
                     3,4,5,2,8,6,0,7,9]).

sudokuIntermediate7([5,3,0,0,7,0,0,0,0,
                     6,0,0,1,9,5,0,0,0,
                     0,9,8,0,0,0,0,6,0,
                     8,0,0,0,6,0,0,0,3,
                     4,0,0,8,0,3,0,0,1,
                     7,0,0,0,2,0,0,0,6,
                     0,6,0,0,0,0,2,8,0,
                     0,0,0,4,1,9,0,0,5,
                     0,0,0,0,8,0,0,7,9]).

sudokuIntermediate8([0,4,0,0,3,6,1,5,9,
                     0,0,0,4,0,5,8,0,0,
                     0,0,0,0,0,0,0,0,3,
                     0,0,8,0,0,0,0,9,0,
                     0,5,0,0,2,4,3,0,0,
                     3,0,0,1,5,0,0,0,0,
                     0,0,0,0,6,0,4,0,0,
                     5,0,4,0,0,0,2,0,0,
                     0,6,7,0,0,0,0,0,1]).

%Sudokus de Nivel Avanzado
sudokuAdvanced1([5,3,0,0,7,0,0,0,0,
        6,0,0,1,9,5,0,0,0,
        0,9,8,0,0,0,0,6,0,
        8,0,0,0,6,0,0,0,3,
        4,0,0,8,0,3,0,0,1,
        7,0,0,0,2,0,0,0,6,
        0,6,0,0,0,0,2,8,0,
        0,0,0,4,1,9,0,0,5,
        0,0,0,0,8,0,0,7,9]).

sudokuAdvanced2([0,0,5,3,0,0,0,0,0,
        8,0,0,0,0,0,0,2,0,
        0,7,0,0,1,0,5,0,0,
        4,0,0,0,0,5,3,0,0,
        0,1,0,0,7,0,0,0,6,
        0,0,3,2,0,0,0,8,0,
        0,6,0,5,0,0,0,0,9,
        0,0,4,0,0,0,0,3,0,
        0,0,0,0,0,9,7,0,0]).

sudokuAdvanced3([0,0,0,6,0,0,4,0,0,
        7,0,0,0,0,3,6,0,0,
        0,0,0,0,9,1,0,8,0,
        0,0,0,0,0,0,0,0,0,
        0,5,0,1,8,0,0,0,3,
        0,0,0,3,0,6,0,4,5,
        0,4,0,2,0,0,0,6,0,
        9,0,3,0,0,0,0,0,0,
        0,2,0,0,0,0,1,0,0]).

sudokuAdvanced4([0,0,0,0,0,0,0,0,2,
        0,0,0,0,0,0,0,7,0,
        0,0,0,0,0,0,3,0,5,
        0,0,0,0,0,8,0,0,0,
        0,0,0,0,1,0,0,0,0,
        0,0,0,9,0,0,0,0,0,
        4,0,6,0,0,0,0,0,0,
        0,2,0,0,0,0,0,0,0,
        9,0,0,0,0,0,0,0,0]).

sudokuAdvanced5([8,0,0,0,0,0,0,0,0,
        0,0,3,6,0,0,0,0,0,
        0,7,0,0,9,0,2,0,0,
        0,5,0,0,0,7,0,0,0,
        0,0,0,0,4,5,7,0,0,
        0,0,0,1,0,0,0,3,0,
        0,0,1,0,0,0,0,6,8,
        0,0,8,5,0,0,0,1,0,
        0,9,0,0,0,0,4,0,0]).

sudokuAdvanced6([5,3,0,0,7,0,0,0,0,
                   6,0,0,1,9,5,0,0,0,
                   0,9,8,0,0,0,0,6,0,
                   8,0,0,0,6,0,0,0,3,
                   4,0,0,8,0,3,0,0,1,
                   7,0,0,0,2,0,0,0,6,
                   0,6,0,0,0,0,2,8,0,
                   0,0,0,4,1,9,0,0,5,
                   0,0,0,0,8,0,0,7,9]).

sudokuAdvanced7([0,0,5,3,0,0,0,0,0,
                   8,0,0,0,0,0,0,2,0,
                   0,7,0,0,1,0,5,0,0,
                   4,0,0,0,0,5,3,0,0,
                   0,1,0,0,7,0,0,0,6,
                   0,0,3,2,0,0,0,8,0,
                   0,6,0,5,0,0,0,0,9,
                   0,0,4,0,0,0,0,3,0,
                   0,0,0,0,0,9,7,0,0]).

sudokuAdvanced8([8,0,0,0,0,0,0,0,0,
                   0,0,3,6,0,0,0,0,0,
                   0,7,0,0,9,0,2,0,0,
                   0,5,0,0,0,7,0,0,0,
                   0,0,0,0,4,5,7,0,0,
                   0,0,0,1,0,0,0,3,0,
                   0,0,1,0,0,0,0,6,8,
                   0,0,8,5,0,0,0,1,0,
                   0,9,0,0,0,0,4,0,0]).

%---IMPRESION DE TABLERO---
printBoard(T) :-
    printRows(T, 0). % Llama al predicado auxiliar para imprimir las filas del tablero

% Nueva versión que acepta el nombre del Sudoku
printBoard(NombreSudoku) :-
    call(NombreSudoku, T), % Obtiene el tablero asociado al nombre
    printBoard(T). % Llama a la versión original con el tablero

% Predicado auxiliar para imprimir las filas del tablero
printRows(_, 81) :- !. % Caso base: si hemos llegado al final del tablero, terminamos.
printRows(T, I) :-
    nth0(I, T, X), % Obtenemos el valor de la casilla I en el tablero T
    (is_list(X) -> % Verificamos si X es una lista
        (length(X, 1) -> % Si la longitud de la lista es 1
            nth0(0, X, V), % Obtenemos el valor único
            write(V) % Imprimimos el valor único
        ; % De lo contrario
            write(X) % Imprimimos la lista completa
        )
    ; % Si no es una lista
        (X == 0 -> write('.'); write(X)) % Si la casilla está vacía (0), imprimimos un punto, de lo contrario imprimimos el valor
    ),
    (I mod 9 =:= 8 -> nl; write(' ')), % Después de cada 9 elementos, imprimimos un salto de línea
    NI is I + 1, % Incrementamos el índice
    printRows(T, NI). % Llamamos recursivamente para la siguiente casilla usando el nuevo índice (NI)

%---MOSTRAR POSIBILIDADES---
showPossibilities(T) :- 
    makePossibilities(T, TP), % Obtiene las posibilidades de un tablero T
    printPossibilities(TP). % Imprime las posibilidades obtenidas

% Nueva versión que acepta el nombre del Sudoku
showPossibilities(NombreSudoku) :-
    call(NombreSudoku, T), % Obtiene el tablero asociado al nombre
    showPossibilities(T). % Llama a la versión original con el tablero

makePossibilities(T, TP):- 
    makePossibilities(T, 0, TP). % Llama a la función auxiliar recursiva comenzando en el índice 0.

makePossibilities(_, 81, []). % Caso base: Si llegamos al final del tablero (índice 81), devolvemos una lista vacía.
makePossibilities(T, I, TD):- 
    (I < 81), % Si el índice I es menor que 81 (es decir, no hemos llegado al final).
    (N = [1,2,3,4,5,6,7,8,9]), % Inicializamos la lista de posibles valores para una casilla.
    nth0(I, T, X), % Obtenemos el valor de la casilla I en el tablero T.
    member(X, N), % Si X es un valor válido (de 1 a 9), continuamos.
    (NI is I+1), % Calculamos el siguiente índice.
    makePossibilities(T, NI, TNN), % Llamamos recursivamente para el siguiente índice.
    append([[X]], TNN, TD). % Añadimos X a la lista de soluciones TD y la devolvemos.

makePossibilities(T, I, TD):- 
    (I < 81), % Si el índice I es menor que 81 (todavía estamos dentro del tablero).
    (N = [1,2,3,4,5,6,7,8,9]), % Lista de posibles valores para una casilla.
    (F is I//9), % Calcula la getRow F de la casilla I.
    (C is I mod 9), % Calcula la getColumn C de la casilla I.
    (S is 3 * (F // 3) + C // 3), % Calcula el índice del getBlock 3x3 al que pertenece la casilla I.
    getRow(T, F, Fila), % Obtiene los elementos de la getRow F.
    getColumn(T, C, Columna), % Obtiene los elementos de la getColumn C.
    getBlock(T, S, Cuadro), % Obtiene los elementos del getBlock S.
    subtract(N, Fila, P1), % Elimina los valores que ya están en la getRow F de las posibilidades.
    subtract(P1, Columna, P2), % Elimina los valores que ya están en la getColumn C de las posibilidades.
    subtract(P2, Cuadro, P), % Elimina los valores que ya están en el getBlock S de las posibilidades.
    (NI is I+1), % Calcula el siguiente índice.
    makePossibilities(T, NI, TNN), % Llama recursivamente para el siguiente índice.
    append([P], TNN, TD). % Añade las posibilidades restantes a la lista de soluciones TD.

printPossibilities(TP) :-
    printPossibilitiesAux(TP, 0).

% Nueva versión que acepta el nombre del Sudoku
printPossibilities(NombreSudoku) :-
    call(NombreSudoku, T), % Obtiene el tablero asociado al nombre
    makePossibilities(T, TP), % Obtiene las posibilidades del tablero
    printPossibilities(TP). % Llama a la versión original con las posibilidades

% Predicado auxiliar para imprimir las posibilidades del tablero
printPossibilitiesAux(_, 81) :- !. % Caso base: si hemos llegado al final del tablero, terminamos.
printPossibilitiesAux(TP, I) :-
    nth0(I, TP, P), % Obtenemos las posibilidades de la casilla I en el tablero TP
    (length(P, 1) -> % Si la longitud de la lista de posibilidades es 1
        nth0(0, P, V), % Obtenemos el valor definitivo
        write('Casilla '), write(I), write(': '), write(V), nl % Imprimimos el índice de la casilla y su valor definitivo
    ; % De lo contrario
        write('Casilla '), write(I), write(': '), write(P), nl % Imprimimos el índice de la casilla y sus posibilidades
    ),
    NI is I + 1, % Incrementamos el índice
    printPossibilitiesAux(TP, NI). % Llamamos recursivamente para la siguiente casilla

%---BÁSICOS---
conflictingCells(I, L):- 
    F is (I//9), % Calcula la getRow F de la casilla I.
    C is (I mod 9), % Calcula la getColumn C de la casilla I.
    S is 27 * (F//3) + 3 * (C//3), % Calcula el índice del getBlock 3x3.
    rowIndices(F, LF), % Obtiene los índices de la getRow F.
    colIndices(C, LC), % Obtiene los índices de la getColumn C.
    blockIndices(S, LS), % Obtiene los índices del getBlock 3x3.
    subtract(LC, LF, LDC), % Elimina los índices de la getRow LF de la lista de índices de la getColumn LC.
    append(LF, LDC, LFC), % Combina las listas de la getRow LF y la getColumn LC sin los índices de LF en LFC.
    subtract(LS, LFC, LDS), % Elimina los índices de LFC de la lista de índices del getBlock LS.
    append(LDS, LFC, LL), % Combina LDS con LFC en LL.
    subtract(LL, [I], L). % Elimina el índice I de la lista LL y devuelve la lista final de índices conflictingCells L.

% --- OBTENCIÓN DE ELEMENTOS DE FILA, COLUMNA Y CUADRO ---
removeFromConflicting(TP,[],_,TP). % Base de la recursión: si la lista de índices está vacía, no se hace nada.
removeFromConflicting(TP, [X|Y], E, NTP):- % Si la lista no está vacía, quita el elemento E.
    (nth0(X, TP, L)), % Obtiene la lista L correspondiente a la casilla X del tablero TP.
    (length(L, LL), LL > 1 -> % Solo eliminar el elemento si la longitud de la lista es mayor que 1
        subtract(L, [E], NL), % Elimina el elemento E de la lista L y lo guarda en NL.
        replaceInList(TP, X, NL, NTP1) % Reemplaza la casilla X en el tablero TP por la lista NL.
    ; 
        NTP1 = TP), % Si la longitud es 1, no eliminar el elemento
    removeFromConflicting(NTP1, Y, E, NTP). % Llama recursivamente para eliminar el elemento E de las demás posiciones.

getElementsFromIndices(_,[],L,L). % Si la lista de índices está vacía, devuelve la lista L.
getElementsFromIndices(TP,[X|Y],L,LE):- % Si la lista de índices no está vacía, obtiene los elementos correspondientes.
    nth0(X, TP, E), % Obtiene el elemento E en la posición X del tablero TP.
    append(L, [E], NL), % Añade el elemento E a la lista L, resultando en la nueva lista NL.
    getElementsFromIndices(TP, Y, NL, LE). % Llama recursivamente con el resto de la lista de índices.

getRow(T, I, F) :- 
    rowIndices(I,IF), % Obtiene los índices de la getRow I y los guarda en IF.
    getElementsFromIndices(T,IF,[],F). % Llama a getElementsFromIndices para obtener los elementos de la getRow I.

getColumn(T, I, C) :- 
    colIndices(I, IC), % Obtiene los índices de la getColumn I y los guarda en IC.
    getElementsFromIndices(T, IC, [], C). % Llama a getElementsFromIndices para obtener los elementos de la getColumn I.

getBlock(T, I, S) :- 
    X is I mod 3, % Calcula la posición relativa en el getBlock dentro de un bloque 3x3 (getColumn).
    Y is I // 3, % Calcula la posición relativa en el getBlock dentro de un bloque 3x3 (getRow).
    I1 is (3 * X) + (27 * Y), % Calcula el índice del primer elemento del getBlock 3x3 en base a I.
    blockIndices(I1, IS), % Obtiene los índices del getBlock 3x3 a partir del índice calculado I1.
    getElementsFromIndices(T, IS, [], S). % Llama a getElementsFromIndices para obtener los elementos del getBlock.

rowIndices(F, LF):- 
    F0 is 9*F, F1 is (9*F)+1, F2 is (9*F)+2, F3 is (9*F)+3, F4 is (9*F)+4, F5 is (9*F)+5, F6 is (9*F)+6, F7 is (9*F)+7, F8 is (9*F)+8,
    LF = [F0, F1, F2, F3, F4, F5, F6, F7, F8]. % Calcula los índices de una getRow de 9 casillas en el tablero.

colIndices(C, LC):- 
    C0 is C, C1 is C+9, C2 is C+18, C3 is C+27, C4 is C+36, C5 is C+45, C6 is C+54, C7 is C+63, C8 is C+72,
    LC = [C0, C1, C2, C3, C4, C5, C6, C7, C8]. % Calcula los índices de una getColumn de 9 casillas en el tablero.

blockIndices(S, LS):- 
    S0 is S, S1 is S+1, S2 is S+2, S3 is S+9, S4 is S+10, S5 is S+11, S6 is S+18, S7 is S+19, S8 is S+20,
    LS = [S0, S1, S2, S3, S4, S5, S6, S7, S8]. % Calcula los índices del getBlock 3x3 usando el índice S.

countOccurrences([], _, 0). % Caso base: si la lista está vacía, no hay apariciones.
countOccurrences([X|Y], E, T):- % Si la lista no está vacía, procesamos el primer elemento.
    member(E, X), % Si el elemento E está en la sub-lista X,
    countOccurrences(Y, E, NT), % contamos las apariciones en el resto de la lista,
    T is 1 + NT. % y sumamos 1 a la cuenta total.
countOccurrences([X|Y], E, T):- % Si el elemento E no está en la sub-lista X,
     not(member(E, X)), % verificamos que E no está en X,
     countOccurrences(Y, E, NT), % contamos las apariciones en el resto de la lista,
     T is NT. % y la cuenta total es la misma.

countSimilar([], _, 0). % Caso base: si la lista está vacía, no hay apariciones.
countSimilar([X|Y], E, T):- % Si la lista no está vacía, procesamos el primer elemento.
    X = E, % Si el elemento X es igual a E,
    countSimilar(Y, E, NT), % contamos las apariciones en el resto de la lista,
    T is 1 + NT. % y sumamos 1 a la cuenta total.
countSimilar([X|Y], E, T):- % Si el elemento X no es igual a E,
    not(X = E), % verificamos que X no es igual a E,
    countSimilar(Y, E, NT), % contamos las apariciones en el resto de la lista,
    T is NT. % y la cuenta total es la misma.

replaceInList([_|T], 0, X, [X|T]). % Caso base: si el índice es 0, reemplazamos el primer elemento por X.
replaceInList([H|T], I, X, [H|R]):- % Si el índice es mayor que 0,
    I > 0, % verificamos que el índice es mayor que 0,
    NI is I-1, % decrementamos el índice,
    replaceInList(T, NI, X, R). % llamamos recursivamente con el índice decrementado.

removeList(TP, [], _, TP). % Caso base: si la lista de índices está vacía, devolvemos el tablero tal cual.
removeList(TP, [X|Y], L, NTP):- % Si la lista de índices no está vacía, procesamos el primer índice.
    nth0(X, TP, E), % Obtenemos el valor en la posición X del tablero TP.
    E = L, % Si el valor es igual a L,
    removeList(TP, Y, L, NTP). % llamamos recursivamente con el resto de la lista de índices.

removeList(TP, [X|Y], L, NTP):- % Si el valor no es igual a L,
    nth0(X, TP, E), % obtenemos el valor en la posición X del tablero TP,
    length(E, LE), % calculamos la longitud del valor E,
    length(L, LL), % calculamos la longitud de L,
    LE > LL, % Solo eliminar si la lista de posibilidades es mayor
    subtract(E, L, D), % eliminamos los elementos de L de E,
    replaceInList(TP, X, D, NNTP), % reemplazamos el valor en la posición X del tablero TP por D,
    removeList(NNTP, Y, L, NTP). % llamamos recursivamente con el resto de la lista de índices.

removeList(TP, [X|Y], L, NTP):- % Si la longitud de E es menor que la longitud de L,
    nth0(X, TP, E), % obtenemos el valor en la posición X del tablero TP,
    not(E = L), % verificamos que el valor no es igual a L,
    length(E, LE), % calculamos la longitud del valor E,
    length(L, LL), % calculamos la longitud de L,
    LE < LL, % verificamos que la longitud de E es menor que la longitud de L,
    removeList(TP, Y, L, NTP). % llamamos recursivamente con el resto de la lista de índices.

%ASCII
printBoardAscii(T) :-
    nl, write('+-------+-------+-------+'), nl,
    printRowsAscii(T, 0).

% Nueva versión que acepta el nombre del Sudoku
printBoardAscii(NombreSudoku) :-
    call(NombreSudoku, T), % Obtiene el tablero asociado al nombre
    printBoardAscii(T). % Llama a la versión original con el tablero

printRowsAscii(_, 81) :- write('+-------+-------+-------+'), nl, !. % Caso base
printRowsAscii(T, I) :-
    (I mod 27 =:= 0, I \= 0 -> write('+-------+-------+-------+'), nl ; true), % Línea horizontal cada 3 filas
    (I mod 9 =:= 0 -> write('| ') ; true), % Inicio de getRow o bloque
    nth0(I, T, X), % Obtenemos el valor de la casilla
    (is_list(X) -> 
        (length(X, 1) -> nth0(0, X, V), write(V) ; write('.')) 
    ; 
        (X == 0 -> write('.') ; write(X))
    ),
    ((I mod 3 =:= 2) -> write(' | ') ; write(' ')), % Separación de columnas
    (I mod 9 =:= 8 -> nl ; true), % Nueva línea al final de cada getRow
    NI is I + 1,
    printRowsAscii(T, NI). % Llamado recursivo

testPrintBoardAscii(T) :-
    printBoardAscii(T).

% --- PRUEBAS ---
testRule0(T):- 
    makePossibilities(T, TP), % Obtiene las posibilidades del tablero T
    rule0(TP, 0, [], NTP), % Aplica la regla 0 al tablero de posibilidades TP
    printBoard(NTP). % Imprime el tablero resultante

testRule1(T):- 
    makePossibilities(T, TP), % Obtiene las posibilidades del tablero T
    rule1(TP, 0, NTP), % Aplica la regla 1 al tablero de posibilidades TP
    printBoard(NTP). % Imprime el tablero resultante

testRule0and1(T):- 
    makePossibilities(T, TP), % Obtiene las posibilidades del tablero T
    rule0(TP, 0, [], NTP), % Aplica la regla 0 al tablero de posibilidades TP
    rule1(NTP, 0, NTP1), % Aplica la regla 1 al tablero de posibilidades NTP
    printBoard(NTP1). % Imprime el tablero resultante

testRule2(T):- 
    makePossibilities(T, TP), % Obtiene las posibilidades del tablero T
    rule2(TP, 0, NTP), % Aplica la regla 2 al tablero de posibilidades TP
    printBoard(NTP). % Imprime el tablero resultante

testRule3(T):- 
    makePossibilities(T, TP), % Obtiene las posibilidades del tablero T
    rule3(TP, 0, NTP), % Aplica la regla 3 al tablero de posibilidades TP
    printBoard(NTP). % Imprime el tablero resultante

% COMPROBACIÓN DE VALIDEZ (RESOLUBILIDAD) DE SUDOKU
isImpossible(TP) :-
    (   member([], TP)  % Caso 1: Hay una casilla vacía (sin posibilidades)
    ;   hasDuplicates(TP)  % Caso 2: Hay valores repetidos en filas, columnas o cuadrantes
    ), !.

hasDuplicates(TP) :-
    (   invalidRows(TP)
    ;   invalidCols(TP)
    ;   invalidBlocks(TP)
    ).

invalidRows(TP) :-
    range_custom(0, 8, I),       % Itera sobre las filas usando range_custom/2
    getRow(TP, I, F),       % Obtiene la getRow I
    uniqueValues(F, Valores),
    containsDups(Valores), % Verifica si hay repetidos
    !.

invalidCols(TP) :-
    range_custom(0, 8, I),       % Itera sobre las columnas usando range_custom/2
    getColumn(TP, I, C),    % Obtiene la getColumn I
    uniqueValues(C, Valores),
    containsDups(Valores), % Verifica si hay repetidos
    !.

invalidBlocks(TP) :-
    range_custom(0, 8, I),       % Itera sobre los cuadrantes usando range_custom/2
    getBlock(TP, I, Q),     % Obtiene el cuadrante I
    uniqueValues(Q, Valores),
    containsDups(Valores), % Verifica si hay repetidos
    !.

range_custom(Inicio, Fin, Inicio) :- Inicio =< Fin.
range_custom(Inicio, Fin, X) :-
    Inicio < Fin,
    Siguiente is Inicio + 1,
    range_custom(Siguiente, Fin, X).

containsDups([]) :- false.
containsDups([X|Xs]) :-
    countOccurrences2(Xs, X, N),
    N > 0.  % Si aparece mas de una vez, hay repetidos

countOccurrences2([], _, 0).
countOccurrences2([X|Xs], E, N) :-
    (X == E -> countOccurrences2(Xs, E, N1), N is N1 + 1
    ; countOccurrences2(Xs, E, N)
    ).

uniqueValues([], []).
uniqueValues([X|Xs], L) :-
    (   is_list(X), length(X,1) -> nth0(0, X, V), uniqueValues(Xs, L2), append([V], L2, L)
    ;   number(X), X \= 0 -> uniqueValues(Xs, L2), append([X], L2, L)
    ;   uniqueValues(Xs, L)
    ).

simplifyUntilStable(TP, TPFinal, Paso) :-
    write('ITERACIÓN '), write(Paso), nl,  % Reemplazado format por write
    writeln('Aplicando reglas...'), nl,
    rule0(TP, 0, [], NTP),
    writeln('Se ha aplicado la regla 0:'), 
    printBoardAscii(NTP), nl,
    (isImpossible(NTP) -> 
        writeln('El Sudoku es imposible de solve.'),
        TPFinal = NTP
    ;
        rule1(NTP, 0, NTP1),
        writeln('Se ha aplicado la regla 1:'),
        printBoardAscii(NTP1), nl,
        (isImpossible(NTP1) ->
            writeln('El Sudoku es imposible de solve.'),
            TPFinal = NTP1
        ;
            rule2(NTP1, 0, NTP2),
            writeln('Se ha aplicado la regla 2:'),
            printBoardAscii(NTP2), nl,
            (isImpossible(NTP2) ->
                writeln('El Sudoku es imposible de solve.'),
                TPFinal = NTP2
            ;
                rule3(NTP2, 0, NTP3),
                writeln('Se ha aplicado la regla 3:'),
                printBoardAscii(NTP3), nl,
                (isImpossible(NTP3) ->
                    writeln('El Sudoku es imposible de solve.'),
                    TPFinal = NTP3
                ;
                    writeln('----------------------------------------'),
                    (NTP3 == TP -> 
                        TPFinal = NTP3  % No hay cambios, terminamos
                    ;
                        PasoSiguiente is Paso + 1,
                        simplifyUntilStable(NTP3, TPFinal, PasoSiguiente)
                    )
                )
            )
        )
    ).



% ---PREDICADO PARA RESOLVER EL SUDOKU---
solve(NombreSudoku):- 
    call(NombreSudoku, T), % Obtiene el tablero T asociado al nombre del Sudoku
    makePossibilities(T, TP), % Obtiene las posibilidades iniciales del tablero T
    (isImpossible(TP) ->
        writeln('El Sudoku es imposible de solve o porque hay una casilla vacia (sin posibilidades) o porque hay algun elemento repetido en la misma getRow/getColumn/cuadrante 3x3.')
    ;
        writeln('Sudoku inicial:'), nl,
        printBoard(T), nl,  % Imprimir el sudoku inicial introducido
        writeln('----------------------------------------'),
        writeln('Sudoku inicial con posibilidades en las casillas vacias:'), nl,
        printBoard(TP), nl,  % Imprimir las posibilidades iniciales
        writeln('----------------------------------------'),
        writeln('Sudoku con posibilidades en ASCII:'), nl,
        printBoardAscii(TP), nl,  % Imprimir el Sudoku en ASCII antes de comenzar
        writeln('----------------------------------------'),
        simplifyUntilStable(TP, TPFinal, 1),  % Inicia la resolución con Paso 1
        (isImpossible(TPFinal) ->  
            writeln('El Sudoku es imposible de solve o porque hay una casilla vacia (sin posibilidades) o porque hay algun elemento repetido en la misma getRow/getColumn/cuadrante 3x3.')
        ;
            writeln('Sudoku resuelto:'), nl,
            printBoardAscii(TPFinal), nl
        )
    ).