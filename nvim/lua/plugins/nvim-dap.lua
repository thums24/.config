return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',
  },
  config = function()
    local dap = require 'dap'

    -- Simpler approach: hardcode the Mason path
    local mason_path = vim.fn.stdpath 'data' .. '/mason/packages'
    local js_debug_path = mason_path .. '/js-debug-adapter/js-debug'

    -- Setup pwa-node adapter
    dap.adapters['pwa-node'] = {
      type = 'server',
      host = 'localhost',
      port = '${port}',
      executable = {
        command = 'node',
        args = {
          js_debug_path .. '/src/dapDebugServer.js',
          '${port}',
        },
      },
    }

    -- Setup node adapter (fallback to pwa-node)
    dap.adapters['node'] = function(cb, config)
      if config.type == 'node' then
        config.type = 'pwa-node'
      end
      local nativeAdapter = dap.adapters['pwa-node']
      if type(nativeAdapter) == 'function' then
        nativeAdapter(cb, config)
      else
        cb(nativeAdapter)
      end
    end

    -- JavaScript/TypeScript file types
    local js_filetypes = { 'typescript', 'javascript', 'typescriptreact', 'javascriptreact' }

    -- Setup vscode extension
    local vscode = require 'dap.ext.vscode'
    vscode.type_to_filetypes['node'] = js_filetypes
    vscode.type_to_filetypes['pwa-node'] = js_filetypes

    -- Configure debug configurations for JS/TS
    for _, language in ipairs(js_filetypes) do
      dap.configurations[language] = {
        {
          type = 'pwa-node',
          request = 'launch',
          name = 'Launch file',
          program = '${file}',
          cwd = '${workspaceFolder}',
        },
        {
          type = 'pwa-node',
          request = 'attach',
          name = 'Attach',
          processId = require('dap.utils').pick_process,
          cwd = '${workspaceFolder}',
        },
      }
    end

    -- Keymaps for debugging
    vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint, { desc = '[D]ebug: Toggle [B]reakpoint' })
    vim.keymap.set('n', '<leader>dc', dap.continue, { desc = '[D]ebug: [C]ontinue' })
    vim.keymap.set('n', '<leader>di', dap.step_into, { desc = '[D]ebug: Step [I]nto' })
    vim.keymap.set('n', '<leader>do', dap.step_over, { desc = '[D]ebug: Step [O]ver' })
    vim.keymap.set('n', '<leader>dO', dap.step_out, { desc = '[D]ebug: Step [O]ut' })
    vim.keymap.set('n', '<leader>dr', dap.repl.toggle, { desc = '[D]ebug: Toggle [R]EPL' })
    vim.keymap.set('n', '<leader>dl', dap.run_last, { desc = '[D]ebug: Run [L]ast' })
    vim.keymap.set('n', '<leader>dt', dap.terminate, { desc = '[D]ebug: [T]erminate' })
  end,
}
