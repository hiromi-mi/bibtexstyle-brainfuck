# (Maybe) Brainfuck Interpreter Written in BiBTeX Style File

`brainfuck.bst` introduces bibliography style `brainfuck`, and enables us to write your brainfuck program as bibliography.
After compiling, The program result is avaliable in the References section in your output.

You can open [example.pdf](https://github.com/hiromi-mi/bibtexstyle-brainfuck/blob/main/example.pdf) or can compile as follows:
```
$ latex example
$ bibtex example
$ latex example
$ latex example
$ dvipdfmx example
```

## Specification

```
@brainfuck{code,
    bfinput="standard input",
    bfcode="source code"}
```

* `bfinput` : Standard input
* `bfcode` : Brainfuck source code

## Restriction
* `\n` and `\r` are currently treated as space, potentially due to BiBTeX's restriction.
* Interactive input/output will be not avaliable.
* The length of cell array is currently 3000. You can extend the length by substitute `#3000` in `brainfuck.bst`.
* The cell has unsigned 8bit value.
* When reached end of standard input, `,` will return 0.
* Multibyte input probably does not work as expected.

## License
The Unlicense

Example cat program in `example.bib` is retrieved from [esolang.org](https://esolangs.org/wiki/Brainfuck#Cat) (licensed under CC0-1.0).
