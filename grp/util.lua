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
    return type(s) == 'string' and string.match(s, '^[_%a][_%w]*$') ~= nil and self.reserved[s] == nil
end

-- checks if object is serializable
function util:isserializable (o)
    return self.stypes[type(t)] ~= nil
end

function util.keycmp (a, b)
    local ta = type(a)
    local tb = type(b)
    if ta == tb then
        if ta == 'number' then
            return a < b
        else
            return tostring(a) < tostring(b)
        end
    else
        return ta < tb
    end
end

function util:spairs (t)
    local keys = {}
    for k in pairs(t) do
        table.insert(keys, k)
    end
    table.sort(keys, self.keycmp)
    local i = 0
    return function()
        i = i + 1
        local k = rawget(keys, i)
        return k, t[k]
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
        assert(not visited[t], 'reference cycle')
        visited[t] = true

        -- set of serialized keys
        local serialized = {}

        -- print integer keys in order
        for i, v in ipairs(t) do
            serialized[i] = true
            local vstr = self:serialize(v, np, visited)
            s = s .. '\n' .. np .. vstr .. ','
        end

        -- print name-like string keys in order
        for k, v in self:spairs(t) do
            if not serialized[k] and self:isname(k) then
                serialized[k] = true
                local vstr = self:serialize(v, np, visited)
                s = s .. '\n' .. np .. k .. ' = ' .. vstr .. ','
            end
        end

        -- print remaining keys in order
        for k, v in self:spairs(t) do
            if not serialized[k] then
                serialized[k] = true
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

return util
