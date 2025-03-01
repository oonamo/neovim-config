local fs = {}

---Read file contents
---@param path string
---@return string
function fs.read(path)
  local file = io.open(path, 'r')
  if not file then
    return nil
  end
  local content = file:read('*a')
  file:close()
  return content or ''
end


---Write string into file
---@param path string
---@return boolean success
function fs.write_file(path, str)
  local file = io.open(path, 'w')
  if not file then
    return false
  end
  file:write(str)
  file:close()
  return true
end

return fs
