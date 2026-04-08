%! rule0(+Board, +Index, +Visited, -ResultBoard)
% Simplifies the board using Rule 0: if a cell has only one possibility, remove it from the possibilities of its conflicting cells (same row, col, block)
rule0(Board, 81, _, Board) :- !. % Base case: reached the end of the board.
rule0(Board, Index, Visited, ResultBoard) :- 
    not(member(Index, Visited)),
    nth0(Index, Board, CellPossibilities),
    length(CellPossibilities, Len),
    1 is Len,
    nth0(0, CellPossibilities, Value),
    conflictingCells(Index, ConflictingIndices),
    removeFromConflicting(Board, ConflictingIndices, Value, NewBoard),
    rule0(NewBoard, 0, [Index|Visited], ResultBoard).
rule0(Board, Index, Visited, ResultBoard) :- 
    NextIndex is Index + 1,
    rule0(Board, NextIndex, Visited, ResultBoard).

%! rule1(+Board, +Index, -ResultBoard)
% Simplifies using Rule 1: if a possibility appears only once in a row, column, or block, it must be the value.
rule1(Board, 81, Board) :- !.
rule1(Board, Index, ResultBoard) :- 
    nth0(Index, Board, CellPossibilities),
    subRule1(Board, Index, CellPossibilities, NextBoard),
    NextIndex is Index + 1,
    rule1(NextBoard, NextIndex, ResultBoard).

%! subRule1(+Board, +Index, +Possibilities, -ResultBoard)
% Applies Rule 1 logic to a single cell checking row, col, and block
subRule1(Board, _, [], Board) :- !.
subRule1(Board, Index, [Value|_], ResultBoard) :- 
    RowIndex is Index // 9,
    getRow(Board, RowIndex, Row),
    countOccurrences(Row, Value, Count),
    1 is Count, !,
    replaceInList(Board, Index, [Value], ResultBoard).
subRule1(Board, Index, [Value|_], ResultBoard) :- 
    ColIndex is Index mod 9,
    getColumn(Board, ColIndex, Col),
    countOccurrences(Col, Value, Count),
    1 is Count, !,
    replaceInList(Board, Index, [Value], ResultBoard).
subRule1(Board, Index, [Value|_], ResultBoard) :- 
    RowIndex is Index // 9,
    ColIndex is Index mod 9,
    BlockIndex is 3 * (RowIndex // 3) + (ColIndex // 3),
    getBlock(Board, BlockIndex, Block),
    countOccurrences(Block, Value, Count),
    1 is Count, !,
    replaceInList(Board, Index, [Value], ResultBoard).
subRule1(Board, Index, [_|RestPossibilities], ResultBoard) :- 
    subRule1(Board, Index, RestPossibilities, ResultBoard).

%! rule2(+Board, +Index, -ResultBoard)
% Simplifies using Rule 2: if a pair of possibilities appears exactly twice in a row, col or block, remove them from other cells in that unit.
rule2(Board, 81, Board) :- !. 
rule2(Board, Index, ResultBoard) :- 
    nth0(Index, Board, CellPossibilities),
    subRule2(Board, Index, CellPossibilities, NextBoard),
    NextIndex is Index + 1,
    rule2(NextBoard, NextIndex, ResultBoard).

%! subRule2(+Board, +Index, +Possibilities, -ResultBoard)
subRule2(Board, Index, Possibilities, ResultBoard) :- 
    length(Possibilities, Len), 2 is Len,
    RowIndex is Index // 9,
    getRow(Board, RowIndex, Row),
    countSimilar(Row, Possibilities, Count),
    2 is Count,
    rowIndices(RowIndex, RIndices),
    removeList(Board, RIndices, Possibilities, ResultBoard), !.
subRule2(Board, Index, Possibilities, ResultBoard) :- 
    length(Possibilities, Len), 2 is Len,
    ColIndex is Index mod 9,
    getColumn(Board, ColIndex, Col),
    countSimilar(Col, Possibilities, Count),
    2 is Count,
    colIndices(ColIndex, CIndices),
    removeList(Board, CIndices, Possibilities, ResultBoard), !.
subRule2(Board, Index, Possibilities, ResultBoard) :- 
    length(Possibilities, Len), 2 is Len,
    RowIndex is Index // 9,
    ColIndex is Index mod 9,
    BlockIndex is 3 * (RowIndex // 3) + (ColIndex // 3),
    getBlock(Board, BlockIndex, Block),
    countSimilar(Block, Possibilities, Count),
    2 is Count,
    blockIndices(BlockIndex, BIndices),
    removeList(Board, BIndices, Possibilities, ResultBoard), !.
subRule2(Board, _, _, Board).

%! rule3(+Board, +Index, -ResultBoard)
% Simplifies using Rule 3: handles triplets of possibilities.
rule3(Board, 81, Board) :- !.
rule3(Board, Index, ResultBoard) :-
    nth0(Index, Board, CellPossibilities),
    length(CellPossibilities, Len),
    Len < 4, Len > 1,
    subRule3(Board, Index, CellPossibilities, NextBoard),
    NextIndex is Index + 1,
    rule3(NextBoard, NextIndex, ResultBoard), !.
rule3(Board, Index, ResultBoard) :-
    NextIndex is Index + 1,
    rule3(Board, NextIndex, ResultBoard).

%! checkRule3Combinations(+Board, +Index, +Possibilities, +AvailableNumbers, -ResultBoard)
checkRule3Combinations(Board, _, _, [], Board) :- !.
checkRule3Combinations(Board, Index, Possibilities, [Num|RestNums], ResultBoard) :-
    append(Possibilities, [Num], NewPossibilities),
    subRule3(Board, Index, NewPossibilities, NextBoard),
    checkRule3Combinations(NextBoard, Index, Possibilities, RestNums, ResultBoard).

%! subRule3(+Board, +Index, +Possibilities, -ResultBoard)
subRule3(Board, Index, Possibilities, ResultBoard) :-
    length(Possibilities, Len), 2 is Len,
    AllNums = [1,2,3,4,5,6,7,8,9],
    subtract(AllNums, Possibilities, Diff),
    checkRule3Combinations(Board, Index, Possibilities, Diff, ResultBoard), !.
subRule3(Board, Index, Possibilities, ResultBoard) :-
    RowIndex is Index // 9,
    getRow(Board, RowIndex, Row),
    countOccurrencesRule3(Row, Possibilities, Count),
    3 is Count,
    rowIndices(RowIndex, RIndices),
    removeListRule3(Board, RIndices, Possibilities, ResultBoard), !.
subRule3(Board, Index, Possibilities, ResultBoard) :-
    ColIndex is Index mod 9,
    getColumn(Board, ColIndex, Col),
    countOccurrencesRule3(Col, Possibilities, Count),
    3 is Count,
    colIndices(ColIndex, CIndices),
    removeListRule3(Board, CIndices, Possibilities, ResultBoard), !.
subRule3(Board, Index, Possibilities, ResultBoard) :-
    RowIndex is Index // 9,
    ColIndex is Index mod 9,
    BlockIndex is 3 * (RowIndex // 3) + (ColIndex // 3),
    getBlock(Board, BlockIndex, Block),
    countOccurrencesRule3(Block, Possibilities, Count),
    3 is Count,
    FirstBlockIndex is 27 * (RowIndex // 3) + 3 * (ColIndex // 3),
    blockIndices(FirstBlockIndex, BIndices),
    removeListRule3(Board, BIndices, Possibilities, ResultBoard), !.
subRule3(Board, _, _, Board).

%! removeListRule3(+Board, +Indices, +TargetList, -ResultBoard)
removeListRule3(Board, [], _, Board) :- !.
removeListRule3(Board, [Index|RestIndices], TargetList, ResultBoard) :- 
    nth0(Index, Board, Element),
    subtract(Element, TargetList, Diff),
    Diff = [], !,
    removeListRule3(Board, RestIndices, TargetList, ResultBoard).
removeListRule3(Board, [Index|RestIndices], TargetList, ResultBoard) :- 
    nth0(Index, Board, Element),
    subtract(Element, TargetList, Diff),
    Diff \= [],
    replaceInList(Board, Index, Diff, NextBoard),
    removeListRule3(NextBoard, RestIndices, TargetList, ResultBoard).

%! countOccurrencesRule3(+ListToSearch, +TargetList, -Count)
countOccurrencesRule3([], _, 0) :- !.
countOccurrencesRule3([Element|RestElements], TargetList, Count) :- 
    length(Element, Len), Len > 1,
    subtract(Element, TargetList, Diff), Diff = [], !,
    countOccurrencesRule3(RestElements, TargetList, NextCount),
    Count is 1 + NextCount.
countOccurrencesRule3([_|RestElements], TargetList, Count) :- 
    countOccurrencesRule3(RestElements, TargetList, Count).
