vim.g.mapleader = " "
vim.g.maplocalleader = " "
local map = vim.api.nvim_set_keymap
local opt = { noremap = true, silent = true }
local pluginKeys = {}

---------------- Core ------------------
-- 分屏
map('n', '<leader>sh', ':vsp<CR>', opt)
map('n', '<leader>sv', ':sp<CR>', opt)

map('i', 'jj', '<Esc>', opt)
map('i', '<C-h>', '<ESC>I', opt)
map('i', '<C-l>', '<ESC>A', opt)
-- 保存
map('i', '<C-s>', '<ESC>:w<CR>a', opt)
map('n', '<C-s>', '<ESC>:w<CR>', opt)
-- 退出
map('n', 'q', ':wq<CR>', opt)
map('n', 'qq', ':q<CR>', opt)
map('n', '<C-q>', ':q!<CR>', opt)

---------------- Plugins -----------------
-- bufferline
-- 左右Tab切换
map("n", "<C-j>", ":BufferLineCycleNext<CR>", opt)
map("n", "<C-k>", ":BufferLineCyclePrev<CR>", opt)
-- 关闭
--"moll/vim-bbye"
map("n", "<leader>bb", ":Bdelete!<CR>", opt)
map("n", "<leader>bj", ":BufferLineCloseRight<CR>", opt)
map("n", "<leader>bk", ":BufferLineCloseLeft<CR>", opt)
map("n", "<leader>bc", ":BufferLinePickClose<CR>", opt)

-- nvim-tree
map("n", "<C-h>", ":NvimTreeFocus<CR>", opt)
map("n", "<leader>jj", ":NvimTreeFocus<CR>", opt)
map("n", "<leader>jk", ":NvimTreeToggle<CR>", opt)

-- 列表快捷键
pluginKeys.nvimTreeList = {
  -- 打开文件或文件夹
  { key = {"l", "o", "<2-LeftMouse>"}, action = "edit" },
  -- 分屏打开文件
  { key = "v", action = "vsplit" },
  { key = "h", action = "split" },
  -- 显示隐藏文件
  { key = "i", action = "toggle_custom" }, -- 对应 filters 中的 custom (node_modules)
  { key = ".", action = "toggle_dotfiles" }, -- Hide (dotfiles)
  -- 文件操作
  { key = "y", action = "copy" },
  { key = "s", action = "system_open" },
}

-- Telescope
map("n", "<leader>f", ":Telescope find_files<CR>", opt) -- 查找文件
map("n", "<leader>g", ":Telescope live_grep<CR>", opt) -- 全局搜索

pluginKeys.telescopeList = {
  i = {
    -- 上下移动
    ["<C-j>"] = "move_selection_next",
    ["<C-k>"] = "move_selection_previous",
    ["<Down>"] = "move_selection_next",
    ["<Up>"] = "move_selection_previous",
    -- 历史记录
    ["<C-n>"] = "cycle_history_next",
    ["<C-p>"] = "cycle_history_prev",
    -- 关闭窗口
    ["<C-;>"] = "close",
    -- 预览窗口上下滚动
    ["<C-u>"] = "preview_scrolling_up",
    ["<C-d>"] = "preview_scrolling_down",
  },
}

-- lsp 
pluginKeys.mapLSP = function(mapbuf)
  -- rename
  mapbuf("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opt)
  -- code action
  mapbuf("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opt)
  -- go xx
  mapbuf("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opt)
  mapbuf("n", "gh", "<cmd>lua vim.lsp.buf.hover()<CR>", opt)
  mapbuf("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opt)
  mapbuf("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opt)
  mapbuf("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opt)
  -- diagnostic
  mapbuf("n", "gp", "<cmd>lua vim.diagnostic.open_float()<CR>", opt)
  mapbuf("n", "gk", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opt)
  mapbuf("n", "gj", "<cmd>lua vim.diagnostic.goto_next()<CR>", opt)
  mapbuf("n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opt)
  -- 没用到
  -- mapbuf('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opt)
  -- mapbuf("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opt)
  -- mapbuf('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opt)
  -- mapbuf('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opt)
  -- mapbuf('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opt)
  -- mapbuf('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opt)
end
-- nvim-cmp 自动补全
pluginKeys.cmp = function(cmp)
    return {
        -- 出现补全
        ["<A-.>"] = cmp.mapping(cmp.mapping.complete(), {"i", "c"}),
        -- 取消
        ["<A-,>"] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close()
        }),
        -- 上一个
        ["<C-k>"] = cmp.mapping.select_prev_item(),
        -- 下一个
        ["<C-j>"] = cmp.mapping.select_next_item(),
        -- 确认
        ["<CR>"] = cmp.mapping.confirm({
            select = true,
            behavior = cmp.ConfirmBehavior.Replace
        }),
        -- 如果窗口内容太多，可以滚动
        ["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), {"i", "c"}),
        ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(4), {"i", "c"}),
    }
end

return pluginKeys

