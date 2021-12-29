-- This is a pretty dumb script.
-- It just replaces text files like this:
--
--   #if value == 'something' then
--     hello, `username`
--   #end
--
-- more or less with this:
--
--   if value == 'something' then
--      print("hello", username, "")
--   end
--
-- And then executes the result with the Lua interpreter.
--
-- It gets variables, e.g. "value" above, from the input
-- lua file and the OS enviroment, the latter is only if
-- prefixed with "DUI_", the prefix is stripped.
--

if not _ENV then
	print('This mod requires Lua 5.2+, found ' .. _VERSION)
	os.exit(42)
end

function main(argv)
	if #argv < 2 then
		print("Usage: lua build.lua <input> <output>")
		os.exit(1)
	end

	-- setup the environment for script execution
	local env = {}
	local ignore = Set({
		'arg', 'collectgarbage', '_G', '_ENV', 'pcall', 'xpcall',
		'main', 'process_text_chunk', 'generate_lua_script',
	})

	for k, v in pairs(_ENV) do
			if not ignore[k] then
			env[k] = v
		end
	end

	env.include = function(filename)
		local f = assert(loadfile(filename, 't', env))
		return f()
	end

	local load_config = assert(loadfile(argv[1], 't', env))
	local config = load_config()
	assert(type(config and config.files) == 'table')

	-- global variables from OS environment
	for k, v in pairs(getenv()) do
		if k:sub(1, 4) == 'DUI_' then
			env[k:sub(5)] = v
		end
	end

	local output = assert(io.open(argv[2], "w"))
	local buffer = {}

	env.output = output
	env.buffer = buffer
	env['_'] = function(...)
		table.insert(buffer, table.concat({ ... }))
	end

	local is_lua = function(f)
		return f:match('.lua$') and true or false
	end

	for is_lua, group in groupby(config.files, is_lua) do
		for i, filename in ipairs(group) do
			env['__file__'] = filename

			local file = assert(io.open(filename, 'r'))
			local script = generate_lua_script(file)
			file:close()

			-- useful for debugging
			local script_file = assert(io.open(argv[2] .. ".lua", "w"))
			script_file:write(script)
			script_file:close()

			local run_script = assert(load(script, filename, "t", env))

			run_script()
		end

		if #buffer > 0 then
			local text = table.concat(buffer)

			if is_lua then
				output:write('`\n')
				output:write(text)
				output:write('`\n')
			else
				output:write(text)
			end

			table.clear(buffer)
		end
	end

	output:close()
end

function table.clear(t)
	local count = #t
	for i = 0, count do
		t[i] = nil
	end
end

function process_text_chunk(buf, sink)
	if #buf == 0 then
		return
	end

	local input = table.concat(buf)
	local is_lua = false
	local code = '%q'

	table.insert(sink, '_(');
	for slice in input:gmatch('([^`]+)`?') do
		if is_lua then
			table.insert(sink, slice)
		else
			table.insert(sink, code:format(slice))
		end
		table.insert(sink, ',');
		is_lua = not is_lua
	end
	table.insert(sink, '"");\n');
end

function generate_lua_script(file, script)
	local buf = {}
	local script = { 'if type(init) == "function" then init() end\n' }

	for line in file:lines() do
		local is_preprocessor, text = line:match('^%s*(#?)(.*)$')
		if #is_preprocessor > 0 then
			process_text_chunk(buf, script)
			buf = {}

			if #text > 0 then
				table.insert(script, text)
				table.insert(script, '\n')
			end
		else
			table.insert(buf, line)
			table.insert(buf, '\n')
		end
	end

	process_text_chunk(buf, script)

	return table.concat(script)
end

function Set(list)
	local s = {}
	for _, v in ipairs(list) do
		s[v] = true
	end
	return s
end

function getenv()
	local env = {}

	for line in io.popen("set"):lines() do
		local key = line:match("^[^=]+")
		if key then
			env[key] = os.getenv(key)
		end
	end

	return env
end

function iter(value)
	local t = type(value)
	if t == 'function' then
		return value
	elseif t ~= 'table' then
		error('Type error, expected table, got: ' .. t)
	end

	local i = 0
	local n = #value

	return (function()
		i = i + 1
		if i <= n then
			return value[i]
		end
	end)
end

function groupby(iterable, key)
	local cgroup, ckey = {}, nil

	iterable = iter(iterable)

	return (function()
		while true do
			local item = iterable()
			if not item then
				if cgroup and #cgroup > 0 then
					local rkey, rgroup = ckey, cgroup
					cgroup, ckey = nil, nil
					return rkey, rgroup
				end
				return
			end

			local k = key(item)
			if k ~= ckey then
				local rkey, rgroup = ckey, cgroup
				cgroup, ckey = { item }, k
				if #rgroup > 0 then
					return rkey, rgroup
				end
			else
				table.insert(cgroup, item)
			end
		end
	end)
end

main(arg)
