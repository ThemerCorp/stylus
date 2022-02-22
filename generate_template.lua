-- Scan a dir
local function scandir(directory)
  local i, t, popen = 0, {}, io.popen
  local pfile = popen('ls "' .. directory .. '"')
  for filename in pfile:lines() do
    i = i + 1
    t[i] = filename
  end
  pfile:close()
  return t
end

local t = scandir("themes")

for i = 1, #t do
  t[i] = t[i]:gsub(".lua", "")
  local cp = require(string.format("themes/%s", t[i]))
  cp["scheme-name"] = t[i]
  local json_cp = require("json").encode(cp)
  local file = io.open(string.format("generated_templates/%s.json", t[i]), "w")
  file:write(json_cp)
  file:close()
end
