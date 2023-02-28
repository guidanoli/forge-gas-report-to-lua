local util = require "grp.util"

local diff = {}

-- calculates the difference of each entry in two tables recursively
-- entries of different types are completely ignored
-- assumes there are no reference cycles in either table
function diff:difftables (ta, tb)
    local td = {}
    for k, va in pairs(ta) do
        local vb = rawget(tb, k)
        if vb ~= nil then
            if type(va) == type(vb) then
                if type(va) == 'number' then
                    local absdiff = vb - va
                    if absdiff ~= 0 then
                        td[k] = {
                            absdiff = absdiff,
                            reldiff = absdiff / va,
                        }
                    end
                elseif type(va) == 'table' then
                    local t = self:difftables(va, vb)
                    if next(t) ~= nil then
                        td[k] = t
                    end
                end
            end
        end
    end
    return td
end

local function printmdlineaux (a, ...)
    if a ~= nil then
        if a == '' then
            io.write('| ')
        else
            io.write('| ' .. a .. ' ')
        end
        printmdlineaux(...)
    end
end

-- print line of markdown table
local function printmdline (...)
    printmdlineaux(...)
    io.write('|\n')
end

local function fmtdiff (d)
    if d and d.absdiff then
        return string.format('%d (%.2f%%)', d.absdiff, 100 * d.reldiff)
    else
        return ''
    end
end

local function fmtfuncdiff (f)
    return fmtdiff(f.min), fmtdiff(f.max), fmtdiff(f.avg)
end

local function fmtdeploydiff (c)
    return '', '', fmtdiff(c.avg)
end

local function isdiffprintable (d)
    return d and (d.min or d.max or d.avg)
end

-- prints diff as markdown table
function diff:printdiff (t)
    printmdline('Contract', 'Function', 'Min', 'Max', 'Avg')
    printmdline(':-', ':-', ':-:', ':-:', ':-:')
    for cname, c in util:spairs(t) do
        if isdiffprintable(c.deployment) then
            printmdline(cname, '', fmtdeploydiff(c.deployment))
        end
        if c.functions then
            for fname, f in util:spairs(c.functions) do
                if isdiffprintable(f) then
                    printmdline(cname, fname, fmtfuncdiff(f))
                end
            end
        end
    end
end

return diff
