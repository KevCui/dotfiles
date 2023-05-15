# Load setting via GUI
config.load_autoconfig(True)

# Theme
config.source('nord-qutebrowser.py')
c.colors.webpage.preferred_color_scheme = 'dark'
c.colors.webpage.darkmode.enabled = True
c.colors.webpage.darkmode.policy.images = 'never'
c.colors.webpage.darkmode.threshold.text = 150
c.colors.webpage.darkmode.threshold.background = 205
c.colors.hints.bg = '#5e81ac'
c.colors.hints.fg = '#e5e9f0'
c.colors.hints.match.fg = '#2e3440'
c.colors.statusbar.command.private.bg = '#d08770'
c.colors.statusbar.url.hover.fg = '#d8dee9'
c.fonts.default_size = '12pt'
c.fonts.default_family = 'IBMPlexMono'
c.scrolling.bar = 'when-searching'
c.scrolling.smooth = True
c.downloads.remove_finished = 60000

# Hints
c.hints.chars = 'arstdhneio'
c.hints.border = '0px'
c.fonts.hints = 'bold 15pt IBMPlexMono'

# Key binging
config.bind('j', 'scroll-page 0 -0.5')
config.bind('J', 'scroll up')
config.bind('k', 'scroll-page 0 0.5')
config.bind('K', 'scroll down')
config.bind('L', 'tab-next')
config.bind('H', 'tab-prev')
config.bind(',', 'back')
config.bind('.', 'forward')
config.bind('t', 'set statusbar.show always;; set-cmd-text -s :open -t')
config.bind('P', 'open -p {url:pretty}')
config.bind('pp', 'tab-pin;; tab-move')
config.bind('_', 'zoom-out')
config.bind('O', 'set statusbar.show always;; set-cmd-text -s :open -t -r {url:pretty}')
config.bind('f', 'hint links run open {hint-url}')
config.bind('F', 'hint all tab-bg')
config.bind('s', 'hint all tab-bg')
config.bind('/', 'set statusbar.show always;; set-cmd-text /')
config.bind(';t', 'spawn --userscript translate')
config.bind(';D', 'spawn --userscript translate --deepl')
config.bind(';T', 'open -t https://translate.google.com/translate?sl=auto&tl=en&u={url}')
config.bind('<Escape>', 'mode-enter normal;; set statusbar.show in-mode', mode='command')
config.bind('<Return>', 'command-accept;; set statusbar.show in-mode', mode='command')
config.bind('zi', 'zoom-in')
config.bind('zo', 'zoom-out')
config.bind('gl', 'tab-move +')
config.bind('gh', 'tab-move -')
config.bind('gM', 'tab-move end')
config.bind('<<', 'navigate prev -t')
config.bind('>>', 'navigate next -t')
config.bind('<Ctrl-p>', 'open -p')
config.bind('<Ctrl-w>', 'fake-key <Ctrl-backspace>', 'insert')
config.bind('<Ctrl-q>', 'mode-enter passthrough')
config.unbind('<Ctrl-V>')

# Tabs
c.auto_save.session = True
c.tabs.title.format = '{audio}{private}{index}: {current_title}'
c.colors.tabs.selected.odd.bg = '#5e81ac'
c.colors.tabs.selected.even.bg = '#5e81ac'
c.colors.tabs.pinned.selected.odd.bg = '#5e81ac'
c.colors.tabs.pinned.selected.even.bg = '#5e81ac'
c.colors.tabs.bar.bg = '#2e3440'
c.colors.tabs.odd.bg = '#2e3440'
c.colors.tabs.even.bg = '#2e3440'
c.colors.tabs.pinned.odd.bg = '#2e3440'
c.colors.tabs.pinned.even.bg = '#2e3440'
c.fonts.tabs.selected = 'bold 9pt'
c.fonts.tabs.unselected = '9pt'
c.tabs.last_close = 'close'
c.tabs.select_on_remove = 'prev'
c.tabs.pinned.frozen = False

# Status bar
c.statusbar.show = 'in-mode'

# Spellcheck
c.spellcheck.languages = ['en-US']

# Media
c.content.media.audio_video_capture = False
c.content.media.video_capture = False
c.content.autoplay = False
c.content.pdfjs = True

# Other custom settings
config.source('custom-config.py')
