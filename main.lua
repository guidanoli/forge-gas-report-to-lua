local lpeg = require 'lpeg'
local grp = require 'grp'

local KeywordArgument = lpeg.P"--" * lpeg.C((1 - lpeg.P"=")^1) * lpeg.P"=" * lpeg.C(lpeg.P(1)^0)

local helpmsg = [[

Gas Report Parser

Usage: lua main.lua <command> [args...]

Commands:

  parse --format=<fmt>
    where <fmt> can be: forge
]]

local function help (s)
    error(s .. '\n' .. helpmsg)
end

if type(arg) == 'table' and (lpeg.P"main.lua" * -1):match(arg[0]) then
    if not arg[1] then
        help('expected <command>')
    end
    if arg[1] == 'parse' then
        local config = {}
        for i = 2, #arg do
            local a = rawget(arg, i)
            local key, value = KeywordArgument:match(a)
            if not key then error('invalid argument: ' .. a) end
            rawset(config, key, value)
        end
        if not config.format then
            help('expected --format=<fmt> argument')
        elseif config.format == 'forge' then
            local t = grp.forge.parse(io.read('a'))
            io.write('return ' .. grp.util:serialize(t) .. '\n')
        else
            help('invalid <fmt>: ' .. config.format)
        end
    else
        help('invalid <command>: ' .. arg[1])
    end
end
