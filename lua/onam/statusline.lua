---@class Component
---@field init? fun(self, bufnr?: number)
---@field str string | fun(self, bufnr?: number): string
---@field cache_cmp_str? string
---@field last_update_buf? number
---@field buf_update? boolean | fun(self, bufnr?: number): boolean
---@field clear_hl_cycle? boolean
---@field hl_created? boolean
---@field hl_name? string
---@field hls? table
---@field color? Highlight | string | fun(self): Highlight

local M = {}
M.hls = {}

---Gets hl
---@param name string
---@return vim.api.keyset.hl_info|nil
local function get_hl(name)
    local hl = vim.api.nvim_get_hl(0, { name = name, link = false })
    return vim.tbl_isempty(hl) == false and hl or (function()
        local hl = get_hl("StatusLine")
        if not hl then
            error("recursive normal")
        end
        return hl
    end)()
end

---Returns digit to hex color
---@param color number
---@return string?
local function to_hex(color)
    if not color then
        return
    end
	return string.format("#%06x", color)
end

---@alias Highlight { fg?: string, bg?: string, bold?: boolean, italic?: boolean, special?: string, add?: boolean }

---Creates hl
---@param hl Highlight
---@return string
local function create_hl(hl)
    if type(hl) == "table" then
        local hl_name = (hl.fg or "") .. (hl.bg or "")
        if M.hls[hl_name] then
            return M.hls[hl_name]
        end
        local new_hl = {
            italic = hl.italic,
            bold = hl.bold,
            special = hl.special,
        }
        local fg_ishex = hl.fg and hl.fg:sub(1,1) == "#"
        if not fg_ishex then
            new_hl.fg = to_hex(get_hl(hl.fg).fg)
        else
            new_hl.fg = hl.fg
        end

        local bg_ishex = hl.bg and hl.bg:sub(1,1) == "#"
        if not bg_ishex then
            new_hl.bg = to_hex(get_hl(hl.bg).bg)
        else
            new_hl.bg = hl.bg
        end

        if not new_hl.bg then
            new_hl.bg = to_hex(get_hl("StatusLine").bg)
        end

        vim.api.nvim_set_hl(0, "statusline_" .. hl_name, new_hl)
        M.hls[hl_name] = "%#statusline_" .. hl_name ..  "#"

        M.theme_has_changed = false
        return M.hls[hl_name]
    elseif type(hl) == "string"  then
        local is_hex = hl:sub(1, 1) == "#"
        if not is_hex then
            return "%#" .. hl .. "#"
        end
        return ""
    end
    return ""
end

---Groups string and hl
---@param str string
---@param hl string
---@return string
local function group_hl(str, hl)
	return "%#" .. hl .. "#" .. (str or "")
end

---@type Component
local Git = {
	buf_update = function(self)
        M.has_git = self.branch ~= nil
        return not M.has_git
    end,
	init = function(self)
        self.branch = vim.b.minigit_summary_string or ""
	end,
	str = function(self)
		if self.branch ~= nil then
            return self.branch .. " "
        end
        return ""
	end,
    color = {
        bg = "StatusLine",
        fg = "MiniDiffSignChange",
    }
}

---@type Component
local diff = {
	init = function(self)
        self.data = vim.b.minidiff_summary
	end,
	str = function(self)
        if self.data == nil or self.data.add == nil then
            return ""
        end
        local str = ""
        if self.data.add > 0 then
            str = group_hl(self.static.add .. self.data.add , "MiniDiffSignAdd_stl") .. " "
        end
        if self.data.change > 0 then
            str = str.. group_hl(self.static.change .. self.data.change , "MiniDiffSignChange_stl") .. " "
        end
        if self.data.delete > 0 then
            str = str .. group_hl(self.static.delete .. self.data.delete , "MiniDiffSignDelete_stl") .. " "
        end
        return str
	end,
    static = {
        add = "+",
        change = "~",
        delete = "-"
    }
}

local Diagnostics = {
    init = function(self, bufnr)
        if M.diag_str_cache then
            self.cache_str = M.diag_str_cache
            return
        end
        self.cache_str = nil
        local cnt = M.diag_cnt_cache or { 0, 0, 0, 0}
        self.errors = cnt[1]
        self.warns = cnt[2]
        self.infos = cnt[3]
        self.hints = cnt[4]
    end,
    static = {
        error_icon = function(self)
            if self.error_sign and self.error_sign ~= "" then
                return self.error_sign
            end
            local error = vim.fn.sign_getdefined("DiagnosticSignError")
            if error and error[1].text then
                self.error_sign = error[1].text
            else
                self.error_sign = ""
            end
            return self.error_sign
        end,
        warn_icon = function(self)
            if self.warn_sign and self.warn_sign ~= "" then
                return self.warn_sign
            end
            local warn = vim.fn.sign_getdefined("DiagnosticSignWarn")
            if warn and warn[1].text then
                self.warn_sign = warn[1].text
            else
                self.warn_sign = ""
            end
            return self.warn_sign
        end,
        info_icon = function(self)
            if self.info_sign and self.info_sign ~= "" then
                return self.info_sign
            end
            local info = vim.fn.sign_getdefined("DiagnosticSignInfo")
            if info and info[1].text then
                self.info_sign = info[1].text
            else
                self.info_sign = ""
            end
            return self.info_sign
        end,
        hint_icon = function(self)
            if self.hint_sign and self.hint_sign ~= "" then
                return self.hint_sign
            end
            local hint = vim.fn.sign_getdefined("DiagnosticSignHint")
            if hint and hint[1].text then
                self.hint_sign = hint[1].text
            else
                self.hint_sign = ""
            end
            return self.hint_sign
        end,
    },
    str = function(self, bufnr)
        if self.cache_str and self.cache_str ~= "" then
            return self.cache_str
        end
        local cache_str = ""
        if self.errors > 0 then
            cache_str = cache_str .. create_hl({ fg = "DiagnosticSignError" }) .. self.static.error_icon(self) .. self.errors ..  " "
        end
        if self.warns > 0 then
            cache_str = cache_str .. create_hl(({ fg = "DiagnosticSignWarn" })) .. self.static.warn_icon(self) .. self.warns .. " "
        end
        if self.infos > 0 then
            cache_str = cache_str .. create_hl(({ fg = "DiagnosticSignInfo" })) .. self.static.info_icon(self) .. self.infos .. " "
        end
        if self.hints > 0 then
            cache_str = cache_str .. create_hl(({ fg = "DiagnosticSignHint" })) .. self.static.hint_icon(self) .. self.hints .. " "
        end
        M.diag_str_cache = cache_str
        return cache_str
    end,
}

local error = {
    init = function (self)
        self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
    end,
    static = {
        error_icon = function(self)
            if self.error_sign then
                return self.error_sign
            end
            local error = vim.fn.sign_getdefined("DiagnosticSignError")
            if error then
                self.error_sign = error[1].text
            end
            return self.error_sign
        end,
    },
    str = function (self)
        return self.errors > 0 and (self.static.error_icon(self) .. self.errors .. " ") or ""
    end,
    color = {
        fg = "Error",
    },
}

local warn = {
    init = function (self)
        self.warns = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.Warn })
    end,
    static = {
        warn_icon = function(self)
            if self.warn_sign then
                return self.warn_sign
            end
            local warn = vim.fn.sign_getdefined("DiagnosticSignWarn")
            if warn then
                self.warn_sign = warn[1].text
            end
            return self.warn_sign
        end,
    },
    str = function (self)
        return self.warns > 0 and (self.static.warn_icon(self) .. self.warns .. " ") or ""
    end,
    color = {
        fg = "DiagnosticSignWarn",
    },
}

local info = {
    init = function (self)
        self.infos = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.Info })
    end,
    static = {
        info_icon = function(self)
            if self.info_sign then
                return self.info_sign
            end
            local info = vim.fn.sign_getdefined("DiagnosticSignInfo")
            if info then
                self.info_sign = info[1].text
            end
            return self.info_sign
        end,
    },
    str = function (self)
        return self.infos > 0 and (self.static.info_icon(self) .. self.infos .. " ") or ""
    end,
    color = {
        fg = "DiagnosticSignInfo",
    },
}

local hints = {
    init = function (self)
        self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.Hint })
    end,
    static = {
        hint_icon = function(self)
            if self.hint_sign then
                return self.hint_sign
            end
            local hint = vim.fn.sign_getdefined("DiagnosticSignHint")
            if hint then
                self.hint_sign = hint[1].text
            end
            return self.hint_sign
        end,
    },
    str = function (self)
        return self.hints > 0 and (self.static.hint_icon(self) .. self.hints .. " ") or ""
    end,
    color = {
        fg = "DiagnosticSignHint",
    },
}

---@type Component
local filename = {
    buf_update = true,
	str = function()
		return "%t%m%r"
	end,
    color = { fg = "StatusLine", bg = "StatusLine" }
}

---@type Component
local filetype = {
	str = function()
		return "%y"
	end,
}

---@type Component
local ruler = {
	str = function()
		return "%l/%L"
	end,
}

---@type Component
local align = {
	str = function()
		return "%="
	end,
}

local ClientIcon = {
    buf_update = function()
        return M.has_clients
    end,
    str = function ()
        return "≡ "
    end,
    color = {
        fg = "Boolean",
        bg = "StatusLine",
    },
}

local Clients = {
    buf_update = true,
    init = function(self)
        local clients = vim.lsp.get_clients({
            bufnr = 0
        })
        self.names = {}
        for _, client in pairs(clients) do
            table.insert(self.names, client.name)
        end
        M.has_clients = clients and #clients > 0
    end,
    str = function(self)
        if not self.names or #self.names <= 0 then
            return ""
        end
        local str = ""
        for _, name in ipairs(self.names or {}) do
            str = str  .. name
        end
        return str
    end,
}

---@type Component
local harpoon = {
    buf_update = true,
	init = function(self)
		self.list = require("harpoon"):list().items
        self.buf_name = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":~:.")
	end,
	str = function(self)
		local inactive = "-"
		local active = ""
		for i, v in ipairs(self.list) do
			if v.value == self.buf_name then
				active = tostring(i)
				break
			end
		end
		return (active ~= "" and active or inactive) .. "/" .. tostring(#self.list)
	end,
}

local space = {
	str = " ",
}

---@type Component[]
local components = {
    -- GitIcon,
    Git,
    space,
    diff,
    align,
    filename,
    align,
    Diagnostics,
    ClientIcon,
    Clients,
}

M.cur_buf = vim.api.nvim_get_current_buf()

vim.api.nvim_create_autocmd("BufEnter", {
	callback = function()
		M.cur_buf = vim.api.nvim_get_current_buf()
	end,
})

function M.statusline()
	local str = " "
	for _, comp in ipairs(components) do
		local comp_str = ""
        if type(comp.buf_update) == "boolean" then
            if comp.buf_update == true then
                if comp.last_update_buf == M.cur_buf then
                    goto set_str
                end
            end
        elseif type(comp.buf_update) == "function" then
            if comp:buf_update(M.cur_buf) == true then
                if comp.last_update_buf == M.cur_buf then
                    goto set_str
                end
            end
        end
		if comp.init ~= nil then
			comp:init(M.cur_buf)
		end
		if type(comp.str) == "function" then
			-- comp_str = (comp:str(M.cur_buf) and comp:str(M.cur_buf) or "")
			comp_str = comp:str(M.cur_buf) or ""
		elseif type(comp.str) == "string" then
			comp_str = comp.str or "" --[[@as string]]
		end
        if comp.color then
            if type(comp.color) == "function" then
                comp_str = create_hl(comp:color()) .. comp_str
            else
                comp_str = create_hl(comp.color --[[@as Highlight]]) .. comp_str
            end
        end
		comp.cache_cmp_str = comp_str .. "%#Statusline#"
		comp.last_update_buf = M.cur_buf

        ::set_str::
		str = str .. comp.cache_cmp_str
	end
	return str
end

vim.api.nvim_create_autocmd("Colorscheme", {
    callback = function ()
        M.hls = {}
        M.has_git = false
    end
})

vim.api.nvim_create_autocmd("DiagnosticChanged", {
    callback = function (event)
        local diag_count = { 0, 0, 0, 0 }
        for _, diagnostic in ipairs(event.data.diagnostics) do
            diag_count[diagnostic.severity] = diag_count[diagnostic.severity] + 1
        end
        M.diag_str_cache = nil
        M.diag_cnt_cache = diag_count
    end
})

vim.o.statusline = "%!v:lua.require('onam.statusline').statusline()"

return M
