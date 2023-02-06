local lpeg = require "lpeg"
local util = require "util"

local ForgeGasReport
do
    local Bar = lpeg.P"|"
    local Space = lpeg.P" "^0
    local NewLine = lpeg.P"\n"
    local Table = lpeg.V"Table"
    local Line = lpeg.V"Line"
    local Cell = lpeg.V"Cell"

    ForgeGasReport = lpeg.P{
        "Report",
        Report = lpeg.Ct(Table * (NewLine^2 * Table)^0),
        Table = lpeg.Ct(Line * (NewLine * Line)^0),
        Line = lpeg.Ct(Bar * (Space * Cell * Space * Bar)^1),
        Cell = lpeg.C((1 - (Bar + NewLine + Space * Bar))^0),
    }
end

local ContractTitle
do
    local Alpha = lpeg.R("az", "AZ")
    local Number = lpeg.R"09"
    local Underscore = lpeg.P"_"
    local Name = (Alpha + Underscore) * (Alpha + Number + Underscore)^0
    local Colon = lpeg.P":"
    local TitleSuffix = lpeg.P" contract" * -1

    ContractTitle = (1 - (Colon * Name * TitleSuffix))^0 * Colon * lpeg.C(Name) * TitleSuffix
end

local function getcontractname (title)
    return assert(ContractTitle:match(title), 'bad contract title')
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
    return assert(ForgeGasReport:match(s), 'bad gas report')
end

local ast = parse(io.read('a'))
local t = compile(ast)
print(util:serialize(t))
