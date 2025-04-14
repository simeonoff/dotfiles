local utils = require('utils')

local mason_path = vim.fn.stdpath('data') .. '/mason'
local mason_lsp = mason_path .. '/packages/angular-language-server/node_modules'

local function get_probe_dir(dir)
  local project_root = utils.root_pattern({ 'node_modules' }, dir)
  return project_root and (project_root .. '/node_modules') or ''
end

local function get_angular_core_version(dir)
  local project_root = utils.root_pattern({ 'node_modules' }, dir)

  if not project_root then return '' end

  local package_json = project_root .. '/package.json'
  if not vim.uv.fs_stat(package_json) then return '' end

  local contents = io.open(package_json):read('*a')
  local json = vim.json.decode(contents)
  if not json.dependencies then return '' end

  local angular_core_version = json.dependencies['@angular/core']

  angular_core_version = angular_core_version and angular_core_version:match('%d+%.%d+%.%d+')

  return angular_core_version
end

local default_probe_dir = get_probe_dir(vim.fn.getcwd())
local default_angular_core_version = get_angular_core_version(vim.fn.getcwd())

local cmd = {
  'ngserver',
  '--stdio',
  '--tsProbeLocations',
  default_probe_dir,
  '--ngProbeLocations',
  default_probe_dir,
  mason_lsp .. '/@angular/language-server',
  '--angularCoreVersion',
  default_angular_core_version,
}

if default_angular_core_version then
  return {
    cmd = cmd,
    filetypes = { 'typescript', 'html', 'htmlangular' },
    root_markers = { 'angular.json' },
    on_new_config = function(new_config) new_config.cmd = cmd end,
  }
else
  return {}
end
