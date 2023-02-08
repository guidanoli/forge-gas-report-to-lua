# Gas Report Parser

Parses gas reports in different formats and outputs a Lua table in the same format. These Lua tables can be later used to produce diffs and other analysis.

## Dependencies

* [Lua](https://www.lua.org) 5.4
* [LPEG](https://www.inf.puc-rio.br/~roberto/lpeg/) 1.0.2

## Usage

### Parsing gas reports

On the repository root, run the following command, where `<fmt>` is either `forge` or `hardhat`.

```sh
lua main.lua parse --format=<fmt>
```

The program reads the gas report from the standard input and prints the Lua table to the standard output.
You can redirect these streams to files either through operating system pipes or through the `--input` and `--output` command line options.

### Comparing gas reports

You can compare two gas reports that have been already parsed into Lua tables with the following command. Here, we don't need to discriminate the source of the gas report, since they all use the same Lua table scheme. Because we need two inputs, we cannot use standard input anymore. Instead, we need to read such Lua tables from files `<a>` and `<b>`.

```sh
lua main.lua diff <a> <b>
```

The output of this program is another Lua table which computes the absolute difference (`b - a`) and the relative difference (`(b - a) / a`) of every entry. If the absolute difference is zero, it is discarded. Also, if a table gets empty because all of its entries were discarded, the table itself also gets discarded. This is simply to minimize the size of the output and to make the end result more conscise. After all, we are only interested in what were the gas costs changes.

### Exporting diffs to Markdown tables

In the context of GitHub repositories, Markdown in the primary markup language. Because of this, we commonly format our tables using Markdown syntax. To make the process of exporting this information to Markdown simpler, you can run the following command.

```sh
lua main.lua printdiff
```

Similar to `parse`, this program reads to `stdin` and writes to `stdout`. These streams can be overriden by options `--input` and `--output`.

## Tests

If you want to see the program in action, you can simply run the `runtests.sh` Shell script. The test inputs and outputs are stored in the `test/` folder. If, after running such script, none of the files were change, it is a good sign that your program is working as expected on your machine.
