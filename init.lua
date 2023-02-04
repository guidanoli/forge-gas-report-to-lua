local lpeg = require "lpeg"

local Bar = lpeg.P"|"
local Space = lpeg.P" "^0
local NewLine = lpeg.P"\n"

local Table, Line, Cell = lpeg.V"Table", lpeg.V"Line", lpeg.V"Cell"

local Grammar = lpeg.P{
    "Report",
    Report = lpeg.Ct(Table * (NewLine^2 * Table)^0),
    Table = lpeg.Ct(Line * (NewLine * Line)^0),
    Line = lpeg.Ct(lpeg.P"|" * (Space * Cell * Space * Bar)^1),
    Cell = lpeg.C(((1 - (Bar + NewLine)) - #(Space * Bar))^0),
}

local function compile (ast)
    local ast1 = {}
    for i, t in ipairs(ast) do
        local t1 = {}
        t1.name = assert(t[1][1])
        t1.deploymentCost = tonumber(t[4][1])
        t1.deploymentSize = tonumber(t[4][2])
        local funcs = {}
        for j = 6, #t do
            funcs[t[j][1]] = {
                min = tonumber(t[j][2]),
                avg = tonumber(t[j][3]),
                median = tonumber(t[j][4]),
                max = tonumber(t[j][5]),
                ncalls = tonumber(t[j][6]),
            }
        end
        t1.functions = funcs
        ast1[i] = t1
    end
    return ast1
end

local function parse (s)
    local ast = Grammar:match(s)
    if not ast then error('syntax error', 2) end
    return ast
end

-- reserved words
local reserved = {}
do
    local reservedlst = {
        'and', 'break', 'do', 'else', 'elseif', 'end', 'false', 'for',
        'function', 'goto', 'if', 'in', 'local', 'nil', 'not', 'or',
        'repeat', 'return', 'then', 'true', 'until', 'while',
    }
    for k, v in pairs(reservedlst) do
        reserved[v] = k
    end
end

-- serializable value types
local stypes = {}
do
    local stypeslst = {
        'nil', 'boolean', 'number', 'string', 'table'
    }
    for k, v in pairs(stypeslst) do
        stypes[v] = k
    end
end

-- checks if string is valid name
local function isname (s)
    return string.match(s, '^[_%a][_%w]*$') ~= nil and reserved[s] == nil
end

-- checks if object is serializable
local function isserializable (o)
    return stypes[type(t)] ~= nil
end

local function serialize (t, sp, visited)
    sp = sp or ''
    visited = visited or {}

    if not isserializable(t) then
        error(type(t) .. ' is not serializable', 2)
    end

    if type(t) == 'table' then
        local np = sp .. '  '
        local s = '{'

        -- check ref cycles
        if visited[t] then
            error('reference cycle', 2)
        end
        visited[t] = true

        -- print integer keys in order
        local ikeys = {}
        for i, v in ipairs(t) do
            ikeys[i] = true
            s = s .. '\n' .. np .. serialize(v, np, visited) .. ','
        end

        -- print name-like string keys in order
        local nkeys = {}
        local onkeys = {}
        for k, v in pairs(t) do
            if not ikeys[k] then
                if type(k) == 'string' and isname(k) then
                    table.insert(onkeys, k)
                    nkeys[k] = true
                end
            end
        end
        table.sort(onkeys)
        for _, k in ipairs(onkeys) do
            local v = rawget(t, k)
            local vstr = serialize(v, np, visited)
            s = s .. '\n' .. np .. k .. ' = ' .. vstr .. ','
        end

        -- print other keys randomly
        for k, v in pairs(t) do
            if not ikeys[k] and not nkeys[k] then
                local kstr = '[' .. serialize(k, np, visited) .. ']'
                local vstr = serialize(v, np, visited)
                s = s .. '\n' .. np .. kstr .. ' = ' .. vstr .. ','
            end
        end

        -- end string
        if next(t) then
            s = s .. '\n' .. sp
        end
        s = s .. '}'
        return s
    else
        return string.format('%q', t)
    end
end

local ast = parse(io.stdin:read('a'))
local t = compile(ast)
print(serialize(t))
