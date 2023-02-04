local lpeg = require "lpeg"

local Bar = lpeg.P"|"
local Space = lpeg.P" "^0
local NewLine = lpeg.P"\n"

local Table, Line, Cell = lpeg.V"Table", lpeg.V"Line", lpeg.V"Cell"

local Grammar = lpeg.P{
    "Report",
    Report = lpeg.Ct(Table * (NewLine^2 * Table)^0),
    Table = lpeg.Ct(Line * (NewLine * Line)^0),
    Line = lpeg.Ct(Bar * (Space * Cell * Space * Bar)^1),
    Cell = lpeg.C((1 - (Bar + NewLine + Space * Bar))^0),
}

local function getcontractname (title)
    local alpha = lpeg.R("az", "AZ")
    local num = lpeg.R"09"
    local uscore = lpeg.P"_"
    local name = (alpha + uscore) * (alpha + num + uscore)^0
    local colon = lpeg.P":"
    local suffix = lpeg.P" contract" * -1
    local patt = (1 - (colon * name * suffix))^0 * colon * lpeg.C(name) * suffix
    return assert(patt:match(title), 'bad title')
end

local function compile (ast)
    local report = {}
    for i, t in ipairs(ast) do
        local contract = {}
        local contractname = getcontractname(t[1][1])
        contract.deploymentCost = tonumber(t[4][1])
        contract.deploymentSize = tonumber(t[4][2])
        local functions = {}
        for j = 6, #t do
            local funcname = t[j][1]
            functions[funcname] = {
                min = tonumber(t[j][2]),
                avg = tonumber(t[j][3]),
                median = tonumber(t[j][4]),
                max = tonumber(t[j][5]),
                ncalls = tonumber(t[j][6]),
            }
        end
        contract.functions = functions
        report[contractname] = contract
    end
    return report
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

local ast = parse(io.read('a'))
local t = compile(ast)
print(serialize(t))
