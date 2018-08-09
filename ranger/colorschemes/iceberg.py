from ranger.gui.colorscheme import ColorScheme
from ranger.gui.color import *

class iceberg(ColorScheme):
    progress_bar_color = 242

    def use(self, context):
        fg, bg, attr = default_colors

        if context.reset:
            return default_colors

        elif context.in_browser:
            fg = 255
            if context.selected:
                attr = reverse
            else:
                attr = normal
            if context.empty or context.error:
                fg = 232
                bg = 203
            if context.border:
                fg = default
            if context.text:
                fg = 252
            if context.document:
                fg = 149
            if context.image:
                fg = 221
            if context.audio:
                fg = 215
            if context.container:
                fg = 141
            if context.directory:
                fg = 111
            elif context.executable and not \
                    any((context.media, context.container,
                        context.fifo, context.socket)):
                fg = 203
            if context.socket:
                fg = 232
                bg = 149
                attr |= bold
            if context.video:
                fg = 215
            if context.fifo:
                fg = 232
                bg = 215
                attr |= bold
            if context.device:
                fg = 232
                bg = 149
                attr |= bold
            if context.link:
                fg = 232
                if context.bad:
                    bg = 203
                else:
                    bg = 149
            if context.tag_marker and not context.selected:
                attr |= bold
                if fg in (red, magenta):
                    fg = white
                else:
                    fg = red
            if not context.selected and (context.cut or context.copied):
                fg = 234
                bg = 244
                attr |= bold
            if context.main_column:
                if context.selected:
                    attr |= bold
                if context.marked:
                    attr |= bold
                    bg = 232
            if context.badinfo:
                if attr & reverse:
                    bg = magenta
                else:
                    fg = magenta

            if context.inactive_pane:
                fg = 241

        elif context.in_titlebar:
            attr |= bold
            if context.hostname:
                fg = context.bad and 16 or 255
                if context.bad:
                    bg = 215
            elif context.directory:
                fg = 111
            elif context.tab:
                fg = context.good and 148 or 111
                bg = 239
            elif context.link:
                fg = cyan

        elif context.in_statusbar:
            if context.permissions:
                if context.good:
                    fg = 141
                elif context.bad:
                    fg = 203
                    bg = 235
            if context.marked:
                attr |= bold | reverse
                fg = 232
                bg = 149
            if context.message:
                if context.bad:
                    attr |= bold
                    fg = 203
                    bg = 232
            if context.loaded:
                bg = self.progress_bar_color

        if context.text:
            if context.highlight:
                attr |= reverse

        if context.in_taskview:
            if context.title:
                fg = 141

            if context.selected:
                attr |= reverse

            if context.loaded:
                if context.selected:
                    fg = self.progress_bar_color
                else:
                    bg = self.progress_bar_color

        return fg, bg, attr
