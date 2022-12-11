local helper = {}
local home = string.gsub(os.getenv('LOCALAPPDATA'), '\\', '/')

function helper.get_config_path()
  local config = home .. '/nvim'
  return config
end

function helper.get_data_path()
  local data = home .. '/nvim-data'
  return data
end

function helper.get_cache_path()
  local cache = home .. '/nvim-data/cache'
  return cache
end

return helper
