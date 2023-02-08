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
                    local absdiff = va - vb
                    if absdiff ~= 0 then
                        td[k] = {
                            absdiff = va - vb,
                            reldiff = (va - vb) / va,
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

return diff
