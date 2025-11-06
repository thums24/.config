return {
  'saghen/blink.cmp',
  event = 'VimEnter',
  build = 'cargo build --release',
  version = '*',
  opts = {
    appearance = {
      -- Use nerd font icons
      use_nvim_cmp_as_default = false,
      nerd_font_variant = 'mono',

      -- Menu appearance
      kind_icons = {
        Text = '󰉿',
        Method = '󰊕',
        Function = '󰊕',
        Constructor = '󰒓',
        Field = '󰜢',
        Variable = '󰆦',
        Class = '󰠱',
        Interface = '󰜰',
        Module = '󰆧',
        Property = '󰖷',
        Unit = '󰪚',
        Value = '󰦨',
        Enum = '󰦨',
        Keyword = '󰻾',
        Snippet = '󰩫',
        Color = '󰏘',
        File = '󰈔',
        Reference = '󰬲',
        Folder = '󰉋',
        EnumMember = '󰦨',
        Constant = '󰏿',
        Struct = '󰆼',
        Event = '󱐋',
        Operator = '󰪚',
        TypeParameter = '󰬛',
      },
    },

    completion = {
      menu = {
        border = 'rounded',
        winhighlight = 'Normal:BlinkCmpMenu,FloatBorder:BlinkCmpMenuBorder,CursorLine:BlinkCmpMenuSelection,Search:None',
        winblend = 0,
        scrollbar = true,
        max_height = 15,

        draw = {
          columns = { { 'kind_icon' }, { 'label', 'label_description', gap = 1 } },
          components = {
            kind_icon = {
              text = function(ctx)
                return ctx.kind_icon .. ctx.icon_gap
              end,
              highlight = 'BlinkCmpKind',
            },
            label = {
              width = { fill = true, max = 60 },
              text = function(ctx)
                return ctx.label .. ctx.label_detail
              end,
              highlight = 'BlinkCmpLabel',
            },
            label_description = {
              width = { max = 30 },
              text = function(ctx)
                return ctx.label_description
              end,
              highlight = 'BlinkCmpLabelMatch',
            },
          },
        },
      },

      documentation = {
        auto_show = true,
        auto_show_delay_ms = 200,
        window = {
          border = 'rounded',
          winhighlight = 'Normal:Normal,FloatBorder:FloatBorder',
          max_width = 80,
          max_height = 20,
          winblend = 0,
        },
      },
    },
  },
}
