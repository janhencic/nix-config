local ls = require('luasnip')

local s = ls.snippet
local i = ls.insert_node
local fmt = require('luasnip.extras.fmt').fmt

local M = {}

local lua_snippets = {
  s(
    'lfn',
    fmt(
      [[
        local function {name}({parameters})
          {body}
        end
      ]],
      {
        name = i(1),
        parameters = i(2),
        body = i(0),
      }
    )
  ),
  s(
    'mfn',
    fmt(
      [[
        function {module_name}.{function_name}({parameters})
          {body}
        end
      ]],
      {
        module_name = i(1),
        function_name = i(2),
        parameters = i(3),
        body = i(0),
      }
    )
  ),
  s(
    'afn',
    fmt(
      [[
        function()
          {content}
        end
      ]],
      {
        content = i(0),
      }
    )
  ),
  s(
    'printt',
    fmt(
      [[
        print("{value}")
      ]],
      {
        value = i(0),
      }
    )
  ),
  s(
    'print',
    fmt(
      [[
        print({value})
      ]],
      {
        value = i(0),
      }
    )
  ),
  s(
    'require',
    fmt(
      [[
        local {imported_module_name} = require('{module_name}')
      ]],
      {
        imported_module_name = i(1),
        module_name = i(0),
      }
    )
  ),
}
local bash_snippets = {
  s(
    'fn',
    fmt(
      [[
        {name}() {{
          {body}
        }}
      ]],
      {
        name = i(1),
        body = i(0),
      }
    )
  ),
  s(
    'for',
    fmt(
      [[
        for {index} in {sequence}; do
          {body}
        done
      ]],
      {
        index = i(1),
        sequence = i(2),
        body = i(0),
      }
    )
  ),
  s(
    'v',
    fmt(
      [[
        "${{{variabe}}}"
      ]],
      {
        variabe = i(0),
      }
    )
  ),
}

local js_snippets = {
  s(
    'cfn',
    fmt(
      [[
        const {name} = ({args}) => {{
          {body}
        }}
      ]],
      {
        name = i(1),
        args = i(2),
        body = i(0),
      }
    )
  ),
}

function M.js()
  ls.add_snippets('javascript', js_snippets)
end

function M.lua()
  ls.add_snippets('lua', lua_snippets)
end

function M.bash()
  ls.add_snippets('sh', bash_snippets)
end

return M
