local util = {}

-- reserved words
util.reserved = {}
do
    local reservedlst = {
        'and', 'break', 'do', 'else', 'elseif', 'end', 'false', 'for',
        'function', 'goto', 'if', 'in', 'local', 'nil', 'not', 'or',
        'repeat', 'return', 'then', 'true', 'until', 'while',
    }
    for i, v in ipairs(reservedlst) do
        util.reserved[v] = true
    end
end

-- serializable value types
util.stypes = {}
do
    local stypeslst = {
        'nil', 'boolean', 'number', 'string', 'table'
    }
    for i, v in ipairs(stypeslst) do
        util.stypes[v] = true
    end
end

-- checks if string is valid name
function util:isname (s)
    return string.match(s, '^[_%a][_%w]*$') ~= nil and self.reserved[s] == nil
end

-- checks if object is serializable
function util:isserializable (o)
    return self.stypes[type(t)] ~= nil
end

function util.keycmp (a, b)
    local ta = type(a)
    local tb = type(b)
    if ta == tb then
        return tostring(a) < tostring(b)
    else
        return ta < tb
    end
end

function util:serialize (t, sp, visited)
    sp = sp or ''
    visited = visited or {}

    if not self:isserializable(t) then
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
            s = s .. '\n' .. np .. self:serialize(v, np, visited) .. ','
        end

        -- print name-like string keys in order
        local nkeys = {}
        do
            local onkeys = {}
            for k in pairs(t) do
                if not ikeys[k] then
                    if type(k) == 'string' and self:isname(k) then
                        table.insert(onkeys, k)
                        nkeys[k] = true
                    end
                end
            end
            table.sort(onkeys)
            for _, k in ipairs(onkeys) do
                local v = rawget(t, k)
                local vstr = self:serialize(v, np, visited)
                s = s .. '\n' .. np .. k .. ' = ' .. vstr .. ','
            end
        end

        -- print remaining keys in order
        do
            local orkeys = {}
            for k in pairs(t) do
                if not ikeys[k] and not nkeys[k] then
                    table.insert(orkeys, k)
                end
            end
            table.sort(orkeys, self.keycmp)
            for _, k in ipairs(orkeys) do
                local v = rawget(t, k)
                local kstr = '[' .. self:serialize(k, np, visited) .. ']'
                local vstr = self:serialize(v, np, visited)
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

-- calculates the difference of each entry in two tables recursively
-- entries of different types are completely ignored
-- assumes there are no reference cycles in either table
function util:difftables (ta, tb)
    local td = {}
    for k, va in pairs(ta) do
        local vb = rawget(tb, k)
        if vb ~= nil then
            if type(va) == type(vb) then
                if type(va) == 'number' then
                    td[k] = va - vb
                elseif type(va) == 'table' then
                    td[k] = self:difftables(va, vb)
                end
            end
        end
    end
    return td
end

return util
