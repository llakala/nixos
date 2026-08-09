local fzf_lua = require("fzf-lua")
local M = {}

---@param fn fun(thread)
local function wrap_create_resume(fn)
  return function()
    coroutine.wrap(function()
      local co = coroutine.running()
      fn(co)
    end)()
  end
end

local function call_satod(kind, handler)
  return wrap_create_resume(function(co)
    local tmpdir, err = vim.uv.fs_mkdtemp("/tmp/tmp.XXXXXX")
    if not tmpdir then
      vim.print(err)
      return
    end
    local contents = string.format("sadin %s %s", tmpdir, kind)
    local options = {
      fzf_args = {
        "--border",
        "--highlight-line",
        "--no-separator",
        "--ansi",
        "--preview-window='75%'",
        "--preview-window='top'",
        "--cycle",
        "--multi",
        "--reverse",
        "--scheme=path",
        "--tiebreak='pathname,index'",
        "--bind='ctrl-l:accept'",
      },
      preview = {
        type = "cmd",
        fn = function(items)
          for index, item in ipairs(items) do
            items[index] = string.gsub(item, "/", "\\\\")
          end
          return string.format("cat %s/%s | diff-so-fancy", tmpdir, items[1])
        end,
      },
      fn_selected = function(choices)
        coroutine.resume(co, choices)
      end,
      winopts = {
        on_close = function()
          coroutine.resume(co)
        end,
      },
    }
    local fzf_co = fzf_lua.fzf_exec(contents, options)
    assert(fzf_co)

    local items = coroutine.yield()
    if coroutine.status(fzf_co) == "normal" then
      -- if we selected some items and didn't just press <Esc>, we need to
      -- await AGAIN for the items to actually arrive
      items = coroutine.yield()
    end

    if items then
      handler(tmpdir, items)
    end
    vim.fs.rm(tmpdir, { recursive = true })
  end)
end

M.hire = call_satod("hire", function(tmpdir, items)
  for i = 2, #items, 1 do
    local item = string.gsub(items[i], "/", "\\")
    local command = string.format("cat '%s/%s' | git apply --cached -", tmpdir, item)
    os.execute(command)
  end
end)

M.fire = call_satod("fire", function(tmpdir, items)
  for i = 2, #items, 1 do
    local item = string.gsub(items[i], "/", "\\")
    local command = string.format("cat '%s/%s' | git apply --cached -R -", tmpdir, item)
    os.execute(command)
  end
end)

M.kill = call_satod("kill", function(tmpdir, items)
  for i = 2, #items, 1 do
    local item = string.gsub(items[i], "/", "\\")
    local command = string.format("cat '%s/%s' | git apply -R -", tmpdir, item)
    os.execute(command)
  end
end)

return M
