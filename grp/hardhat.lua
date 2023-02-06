local lpeg = require "lpeg"

local hardhat = {}

local HardhatGasReport
do
    local Dot = lpeg.P"·"
    local Dash = lpeg.P"-"
    local Bar = lpeg.P"|"
    local LongBar = lpeg.P"│"
    local Space = lpeg.P" "^0
    local NL = lpeg.P"\n"
    local Line = lpeg.V"Line"
    local Table = lpeg.V"Table"
    local TableLine = lpeg.V"TableLine"
    local TableOuterSep = lpeg.V"TableOuterSep"
    local TableInnerSep = lpeg.V"TableInnerSep"
    local Cell = lpeg.V"Cell"

    HardhatGasReport = lpeg.P{
        "Report",
        Report = lpeg.Ct(Line * (NL * Line)^0),
        Line = Table + (1 - NL)^0,
        Table = lpeg.Ct(TableOuterSep * NL * TableLine * NL * (TableInnerSep * NL * TableLine * NL)^0 * TableOuterSep),
        TableLine = lpeg.Ct(Bar * Space * Cell * Space * (Dot * Space * Cell * Space)^0 * LongBar),
        TableOuterSep = Dot * Dash^1 * (Bar * Dash^1)^0 * Dot,
        TableInnerSep = Dot^1 * (Bar * Dot^1)^0,
        Cell = lpeg.C((1 - (NL + Space * (Dot + LongBar)))^0),
    }
end

local function smartget(t, k)
    local v = rawget(t, k)
    if v == nil then
        v = {}
        rawset(t, k, v)
    end
    return v
end

local function compile (ast)
    local report = {}
    for i, t in ipairs(ast) do
        for j = 4, #t do
            local l = rawget(t, j)
            if #l == 7 then
                local contractname = l[1]
                local contract = smartget(report, contractname)
                local functions = smartget(contract, 'functions')
                local funcname = l[2]
                functions[funcname] = {
                    min = tonumber(l[3]),
                    max = tonumber(l[4]),
                    avg = tonumber(l[5]),
                    ncalls = tonumber(l[6]),
                }
            elseif #l == 6 then
                local contractname = l[1]
                local contract = smartget(report, contractname)
                contract.min = tonumber(l[2])
                contract.max = tonumber(l[3])
                contract.avg = tonumber(l[4])
            end
        end
    end
    return report
end

function hardhat.parse (s)
    local ast = HardhatGasReport:match(s)
    return ast and compile(ast)
end

return hardhat
