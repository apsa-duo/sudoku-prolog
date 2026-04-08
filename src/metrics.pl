:- consult('main.pl').

%! calculateMetrics(+Sudoku, -TotalEmpty, -SolvedR0, -SolvedR1, -SolvedR2, -SolvedR3, -SolvedNormal, -SolvedInverse, -ItersNormal, -ItersInverse, -IsSolvedNormal, -IsSolvedInverse)
% Calculates all solving metrics for a single Sudoku instance without printing step-by-step.
calculateMetrics(Sudoku, TotalEmpty, SolvedR0FINAL, SolvedR1FINAL, SolvedR2FINAL, SolvedR3FINAL, SolvedNormalFlow, SolvedInverseFlow, ItersNormal, ItersInverse, IsSolvedNormal, IsSolvedInverse) :-
    makePossibilities(Sudoku, BoardPossibilities),
    countEmpty(Sudoku, TotalEmpty),
    measureRule(BoardPossibilities, 0, SolvedR0),
    measureRule(BoardPossibilities, 1, SolvedR1),
    measureRule(BoardPossibilities, 2, SolvedR2),
    measureRule(BoardPossibilities, 3, SolvedR3),
    SolvedR0FINAL is SolvedR0 - (81 - TotalEmpty),
    SolvedR1FINAL is SolvedR1 - (81 - TotalEmpty),
    SolvedR2FINAL is SolvedR2 - (81 - TotalEmpty),
    SolvedR3FINAL is SolvedR3 - (81 - TotalEmpty),
    % Normal Flow (R0->R1->R2->R3)
    (isImpossible(BoardPossibilities) -> 
        SolvedNormalFlow = 0,
        ItersNormal = 0,
        IsSolvedNormal = 0
    ;
        simplifyUntilStableMetrics(BoardPossibilities, FinalBoardNormal, 1, ItersNormal),
        countTotalSolved(BoardPossibilities, FinalBoardNormal, GrossSolvedNormal),
        SolvedNormalFlow is GrossSolvedNormal - (81 - TotalEmpty),
        (isSolved(FinalBoardNormal) -> IsSolvedNormal = 1 ; IsSolvedNormal = 0)
    ),
    % Inverse Flow (R3->R2->R1->R0)
    (isImpossible(BoardPossibilities) -> 
        SolvedInverseFlow = 0,
        ItersInverse = 0,
        IsSolvedInverse = 0
    ;
        simplifyUntilStableInverse(BoardPossibilities, FinalBoardInverse, 1, ItersInverse),
        countTotalSolved(BoardPossibilities, FinalBoardInverse, GrossSolvedInverse),
        SolvedInverseFlow is GrossSolvedInverse - (81 - TotalEmpty),
        (isSolved(FinalBoardInverse) -> IsSolvedInverse = 1 ; IsSolvedInverse = 0)
    ).

%! testMetrics(+Name)
% Evaluates and prints metrics of a specific Sudoku layout by its predicate name.
testMetrics(Name) :-
    call(Name, Sudoku),
    write('Metrics for '), write(Name), writeln(':'),
    calculateMetrics(Sudoku, TotalEmpty, SolvedR0, SolvedR1, SolvedR2, SolvedR3, SolvedNormal, SolvedInverse, ItersNormal, ItersInverse, IsSolvedNormal, IsSolvedInverse),
    write('Total initial empty cells: '), writeln(TotalEmpty),
    (TotalEmpty > 0 ->
        PctR0 is (SolvedR0 / TotalEmpty) * 100, PctR1 is (SolvedR1 / TotalEmpty) * 100,
        PctR2 is (SolvedR2 / TotalEmpty) * 100, PctR3 is (SolvedR3 / TotalEmpty) * 100,
        PctNorm is (SolvedNormal / TotalEmpty) * 100, PctInv is (SolvedInverse / TotalEmpty) * 100,
        write('Cells solved Rule 0 only: '), write(SolvedR0), write(' ('), write(PctR0), writeln('%)'),
        write('Cells solved Rule 1 only: '), write(SolvedR1), write(' ('), write(PctR1), writeln('%)'),
        write('Cells solved Rule 2 only: '), write(SolvedR2), write(' ('), write(PctR2), writeln('%)'),
        write('Cells solved Rule 3 only: '), write(SolvedR3), write(' ('), write(PctR3), writeln('%)'),
        write('Cells solved normal flow (R0->R3): '), write(SolvedNormal), write(' ('), write(PctNorm), writeln('%)'),
        write('Cells solved inverse flow (R3->R0): '), write(SolvedInverse), write(' ('), write(PctInv), writeln('%)')
    ;   
        writeln('No empty cells left, cannot calculate percentages.'), nl
    ),
    write('Iterations (normal flow): '), writeln(ItersNormal),
    write('Iterations (inverse flow): '), writeln(ItersInverse),
    write('Solved (normal flow): '), (IsSolvedNormal = 1 -> writeln('Yes') ; writeln('No')),
    write('Solved (inverse flow): '), (IsSolvedInverse = 1 -> writeln('Yes') ; writeln('No')).

%! calculateMetricsGlobal(+SudokuList)
calculateMetricsGlobal(SudokuList) :-
    calculateMetricsList(SudokuList, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
                         TotalEmpty, TotalR0, TotalR1, TotalR2, TotalR3, 
                         TotalItersNorm, TotalNorm, TotalInv, TotalItersInv, 
                         TotalSudokus, TotalSolvedNorm, TotalSolvedInv),
    writeln('=== Global Metrics ==='),
    write('Sudokus analyzed: '), writeln(TotalSudokus),
    write('Total initial empty cells: '), writeln(TotalEmpty).

calculateMetricsList([], TV, TR0, TR1, TR2, TR3, TIN, TFN, TFI, TIIN, TS, TRSN, TRSI, TV, TR0, TR1, TR2, TR3, TIN, TFN, TFI, TIIN, TS, TRSN, TRSI).
calculateMetricsList([Name|Rest], AccV, AccR0, AccR1, AccR2, AccR3, AccIN, AccFN, AccFI, AccII, AccS, AccSN, AccSI, 
                     TV, TR0, TR1, TR2, TR3, TIN, TFN, TFI, TIIN, TS, TRSN, TRSI) :-
    call(Name, Sudoku),
    calculateMetrics(Sudoku, V, R0, R1, R2, R3, FN, FI, IN, II, SN, SI),
    NV is AccV + V, NR0 is AccR0 + R0, NR1 is AccR1 + R1, NR2 is AccR2 + R2, NR3 is AccR3 + R3,
    NIN is AccIN + IN, NFN is AccFN + FN, NFI is AccFI + FI, NII is AccII + II,
    NS is AccS + 1, NSN is AccSN + SN, NSI is AccSI + SI,
    calculateMetricsList(Rest, NV, NR0, NR1, NR2, NR3, NIN, NFN, NFI, NII, NS, NSN, NSI, 
                         TV, TR0, TR1, TR2, TR3, TIN, TFN, TFI, TIIN, TS, TRSN, TRSI).

%! countEmpty(+Sudoku, -Total)
countEmpty(Sudoku, Total) :- countEmptyAux(Sudoku, 0, Total).
countEmptyAux([], T, T).
countEmptyAux([X|Xs], Acc, Total) :-
    (X = 0 -> Acc1 is Acc + 1 ; Acc1 is Acc),
    countEmptyAux(Xs, Acc1, Total).

%! measureRule(+Board, +RuleIdx, -SolvedCells)
measureRule(Board, 0, Solved) :- rule0(Board, 0, [], NextBoard), countSolved(Board, NextBoard, Solved).
measureRule(Board, 1, Solved) :- rule1(Board, 0, NextBoard), countSolved(Board, NextBoard, Solved).
measureRule(Board, 2, Solved) :- rule2(Board, 0, NextBoard), countSolved(Board, NextBoard, Solved).
measureRule(Board, 3, Solved) :- rule3(Board, 0, NextBoard), countSolved(Board, NextBoard, Solved).

countSolved(BIn, BOut, Total) :- countSolvedAux(BIn, BOut, 0, Total).
countSolvedAux([], [], T, T).
countSolvedAux([In|BIn], [Out|BOut], Acc, Total) :-
    ((is_list(In); In = 0), is_list(Out), length(Out, 1) -> Acc1 is Acc + 1; Acc1 is Acc),
    countSolvedAux(BIn, BOut, Acc1, Total).

simplifyUntilStableMetrics(Board, FinalBoard, Step, Iterations) :-
    rule0(Board, 0, [], NBoard),
    (isImpossible(NBoard) -> FinalBoard = NBoard, Iterations = Step ;
        rule1(NBoard, 0, NBoard1),
        (isImpossible(NBoard1) -> FinalBoard = NBoard1, Iterations = Step ;
            rule2(NBoard1, 0, NBoard2),
            (isImpossible(NBoard2) -> FinalBoard = NBoard2, Iterations = Step ;
                rule3(NBoard2, 0, NBoard3),
                (isImpossible(NBoard3) -> FinalBoard = NBoard3, Iterations = Step ;
                    (NBoard3 == Board -> FinalBoard = NBoard3, Iterations = Step ;
                        NextStep is Step + 1,
                        simplifyUntilStableMetrics(NBoard3, FinalBoard, NextStep, Iterations)
                    )
                )
            )
        )
    ).

simplifyUntilStableInverse(Board, FinalBoard, Step, Iterations) :-
    rule3(Board, 0, NBoard),
    (isImpossible(NBoard) -> FinalBoard = NBoard, Iterations = Step ;
        rule2(NBoard, 0, NBoard1),
        (isImpossible(NBoard1) -> FinalBoard = NBoard1, Iterations = Step ;
            rule1(NBoard1, 0, NBoard2),
            (isImpossible(NBoard2) -> FinalBoard = NBoard2, Iterations = Step ;
                rule0(NBoard2, 0, [], NBoard3),
                (isImpossible(NBoard3) -> FinalBoard = NBoard3, Iterations = Step ;
                    (NBoard3 == Board -> FinalBoard = NBoard3, Iterations = Step ;
                        NextStep is Step + 1,
                        simplifyUntilStableInverse(NBoard3, FinalBoard, NextStep, Iterations)
                    )
                )
            )
        )
    ).

countTotalSolved(In, Out, Total) :- countTotalSolvedAux(In, Out, 0, Total).
countTotalSolvedAux([], [], T, T).
countTotalSolvedAux([In|BIn], [Out|BOut], Acc, Total) :-
    ((is_list(In) ; In = 0), is_list(Out), length(Out, 1) -> Acc1 is Acc + 1 ; Acc1 is Acc),
    countTotalSolvedAux(BIn, BOut, Acc1, Total).

isSolved([]).
isSolved([Cell|Rest]) :- is_list(Cell), length(Cell, 1), isSolved(Rest).

%! testGlobalMetricsBasics
testGlobalMetricsBasics :-
    List = [sudokuBasic1, sudokuBasic2, sudokuBasic3, sudokuBasic4, sudokuBasic5, sudokuBasic6, sudokuBasic7, sudokuBasic8],
    calculateMetricsGlobal(List).
