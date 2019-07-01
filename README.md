# sudoku_backtrack

a heuristic based, backtracking sudoku solver, supporting any subgrid-divisible puzzle



## backtrack & heuristic

let's introduce a concept of a tree representing decisions, such that every branch represents a unique order of filling   
the spots onto the grid, then picking a spot with the least branches on each step leads to 
quick pruning of dead branches, and as a result quick shortening of remaining branches 

## state

currently beta, core features are present and ready to use, here is a short roadmap of future plans and changes:

- [ ] replace standard library with `core`, refactor
- [ ] tests
- [ ] bench
- [ ] docs

## build

`dune` is required for building the project, `core` is used as a replacement for standard library,
 `ounit` and `odoc`, are required for running tests and generating documentation, using `flambda` is strongly recommended

```
  opam switch 4.07.1+flambda
  opam install core ounit odoc dune
  dune build bin/run.exe
```

## usage

default executable `run` reads from `stdin` and writes to `stdout`, leaving read and write operation to the user,
here is an example result of __[16 x 16]__ sudoku solving

```
dune exec bin/run.exe < ...
```
```
7  13 1  15 3  12 11 10 5  4  8  9  6  2  14 16 
9  12 11 10 2  8  13 5  14 16 6  3  1  4  15 7  
6  14 16 5  9  4  1  15 7  13 2  12 8  3  11 10 
2  8  3  4  6  14 16 7  11 10 1  15 5  13 12 9  
13 15 9  2  5  11 8  16 4  12 7  6  14 10 3  1  
8  3  14 16 4  1  15 12 10 9  13 2  7  5  6  11 
11 5  12 6  10 13 7  2  1  3  14 8  15 9  16 4  
10 1  4  7  14 6  3  9  15 11 16 5  13 8  2  12 
16 7  5  3  11 10 2  4  6  14 12 13 9  15 1  8  
1  4  13 9  15 16 6  3  2  8  5  11 10 12 7  14 
15 2  10 14 8  9  12 13 16 7  3  1  4  11 5  6  
12 6  8  11 7  5  14 1  9  15 4  10 2  16 13 3  
5  16 2  12 1  15 4  11 8  6  9  14 3  7  10 13 
4  9  15 1  13 7  10 6  3  2  11 16 12 14 8  5  
3  11 6  8  12 2  9  14 13 5  10 7  16 1  4  15 
14 10 7  13 16 3  5  8  12 1  15 4  11 6  9  2  
 ```

## tests & bench & docs

```
  dune runtest
  dune runbench
  dune build @doc
```
