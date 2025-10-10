return {
  "saghen/blink.cmp",
  opts = {
    appearance = {
      -- Use nerd font icons
      use_nvim_cmp_as_default = false,
      nerd_font_variant = "mono",

      -- Menu appearance
      kind_icons = {
        Text = "󰉿",
        Method = "󰊕",
        Function = "󰊕",
        Constructor = "󰒓",
        Field = "󰜢",
        Variable = "󰆦",
        Class = "󰠱",
        Interface = "󰜰",
        Module = "󰆧",
        Property = "󰖷",
        Unit = "󰪚",
        Value = "󰦨",
        Enum = "󰦨",
        Keyword = "󰻾",
        Snippet = "󰩫",
        Color = "󰏘",
        File = "󰈔",
        Reference = "󰬲",
        Folder = "󰉋",
        EnumMember = "󰦨",
        Constant = "󰏿",
        Struct = "󰆼",
        Event = "󱐋",
        Operator = "󰪚",
        TypeParameter = "󰬛",
      },
    },

    completion = {
      menu = {
        border = "rounded", -- Options: "none", "single", "double", "rounded", "solid", "shadow"
        winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
        windblend = 80,

        -- Scrollbar
        scrollbar = true,

        -- Width/height
        max_height = 15,

        -- Draw options
        draw = {
          columns = { { "kind_icon" }, { "label", "label_description", gap = 1 } },
          components = {
            kind_icon = {
              text = function(ctx)
                return ctx.kind_icon .. ctx.icon_gap
              end,
              highlight = "CmpItemKind",
            },
            label = {
              width = { fill = true, max = 60 },
              text = function(ctx)
                return ctx.label .. ctx.label_detail
              end,
              highlight = "CmpItemAbbr",
            },
            label_description = {
              width = { max = 30 },
              text = function(ctx)
                return ctx.label_description
              end,
              highlight = "CmpItemAbbrMatch",
            },
          },
        },
      },

      documentation = {
        auto_show = true,
        auto_show_delay_ms = 200,
        window = {
          border = "rounded",
          winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:BlinkCmpDocCursorLine,Search:None",
          max_width = 80,
          max_height = 20,
          winblend = 0,
        },
      },
    },
  },
}
