local lpeg = require 'lpeg'
local grp = require 'grp'

local KeywordArgument = lpeg.P"--" * lpeg.C(lpeg.P(1)^1)

local helpmsg = [=[

Gas Report Parser

Usage: lua main.lua <command> [args...]

Commands:

  parse [--format <fmt>] [--input <a>] [--output <b>]
    where <fmt> can be: forge, hardhat
    if --input is ommited, stdin is used instead
    if --output is ommited, stdout is used instead

  diff <a> [<b> [--output <c>]]
    where <a> and <b> are paths to Lua files
    if <b> is omitted, stdin is used instead
    if --output is ommited, stdout is used instead

  printdiff [--input <a>] [--output <b>]
    where <a> and <b> are paths to Lua files
    if --input is omitted, stdin is used instead
    if --output is ommited, stdout is used instead
]=]

local function help (s)
    error(s .. '\n' .. helpmsg)
end

local function parseargs (start)
    local argt = {}
    for i = start, #arg, 2 do
        local a = rawget(arg, i)
        local key = KeywordArgument:match(a)
        if not key then help('invalid argument: ' .. a) end
        local value = rawget(arg, i + 1)
        rawset(argt, key, value)
    end
    return argt
end

local function printluatable (t)
    io.write('return ' .. grp.util:serialize(t) .. '\n')
end

local parsers = {
    forge = grp.forge.parse,
    hardhat = grp.hardhat.parse,
}

local function parsereport (report, fmt)
    if fmt == nil then
        local ast
        for fmt, parser in pairs(parsers) do
            ast = parser(report)
            if ast and next(ast) ~= nil then
                return ast
            end
        end
        if ast == nil then
            help('failed parsing')
        end
    else
        local parser = rawget(parsers, fmt)
        if parser == nil then
            help('invalid <fmt>: ' .. fmt)
        else
            local ast = parser(report)
            if ast == nil then
                help('failed parsing')
            else
                return ast
            end
        end
    end
end

if type(arg) == 'table' and (lpeg.P"main.lua" * -1):match(arg[0]) then
    if not arg[1] then
        help('expected <command>')
    end
    if arg[1] == 'parse' then
        local argt = parseargs(2)
        io.input(argt.input)
        io.output(argt.output)
        local rep = io.read('a')
        local t = parsereport(rep, argt.format)
        printluatable(t)
    elseif arg[1] == 'diff' then
        local argt = parseargs(4)
        io.output(argt.output)
        if not arg[2] then
            help('expected <a>')
        end
        local ta = loadfile(arg[2])()
        local tb = loadfile(arg[3])()
        local td = grp.diff:difftables(ta, tb)
        printluatable(td)
    elseif arg[1] == 'printdiff' then
        local argt = parseargs(2)
        io.input(argt.input)
        io.output(argt.output)
        local td = load(io.read('a'))()
        grp.diff:printdiff(td)
    else
        help('invalid <command>: ' .. arg[1])
    end
end
