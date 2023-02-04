local util = {}

-- reserved words
util.reserved = {}
do
    local reservedlst = {
        'and', 'break', 'do', 'else', 'elseif', 'end', 'false', 'for',
        'function', 'goto', 'if', 'in', 'local', 'nil', 'not', 'or',
        'repeat', 'return', 'then', 'true', 'until', 'while',
    }
    for k, v in pairs(reservedlst) do
        util.reserved[v] = k
    end
end

-- serializable value types
util.stypes = {}
do
    local stypeslst = {
        'nil', 'boolean', 'number', 'string', 'table'
    }
    for k, v in pairs(stypeslst) do
        stypes[v] = k
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
            s = s .. '\n' .. np .. serialize(v, np, visited) .. ','
        end

        -- print name-like string keys in order
        local nkeys = {}
        local onkeys = {}
        for k, v in pairs(t) do
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

return util
