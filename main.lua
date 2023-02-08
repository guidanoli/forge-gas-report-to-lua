local lpeg = require 'lpeg'
local grp = require 'grp'

local KeywordArgument = lpeg.P"--" * lpeg.C((1 - lpeg.P"=")^1) * lpeg.P"=" * lpeg.C(lpeg.P(1)^0)

local helpmsg = [=[

Gas Report Parser

Usage: lua main.lua <command> [args...]

Commands:

  parse --format=<fmt> [--input=<a>] [--output=<b>]
    where <fmt> can be: forge, hardhat
    if --input is ommited, stdin is used instead
    if --output is ommited, stdout is used instead

  diff <a> [<b>]
    where <a> and <b> are paths to Lua files
    if <b> is omitted, stdin is used instead
]=]

local function help (s)
    error(s .. '\n' .. helpmsg)
end

local function parseargs (start)
    local argt = {}
    for i = start, #arg do
        local a = rawget(arg, i)
        local key, value = KeywordArgument:match(a)
        if not key then help('invalid argument: ' .. a) end
        rawset(argt, key, value)
    end
    return argt
end

local function printluatable (t)
    io.write('return ' .. grp.util:serialize(t) .. '\n')
end

if type(arg) == 'table' and (lpeg.P"main.lua" * -1):match(arg[0]) then
    if not arg[1] then
        help('expected <command>')
    end
    if arg[1] == 'parse' then
        local argt = parseargs(2)
        io.input(argt.input)
        io.output(argt.output)
        if not argt.format then
            help('expected --format=<fmt> argument')
        elseif argt.format == 'forge' then
            local t = grp.forge.parse(io.read('a'))
            printluatable(t)
        elseif argt.format == 'hardhat' then
            local t = grp.hardhat.parse(io.read('a'))
            printluatable(t)
        else
            help('invalid <fmt>: ' .. argt.format)
        end
    elseif arg[1] == 'diff' then
        if not arg[2] then
            help('expected <a>')
        end
        local ta = loadfile(arg[2])()
        local tb = loadfile(arg[3])()
        local td = grp.diff:difftables(ta, tb)
        printluatable(td)
    else
        help('invalid <command>: ' .. arg[1])
    end
end
