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
c.fonts.default_size = '12pt'
c.fonts.default_family = 'IBMPlexMono'

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
config.bind('t', 'set-cmd-text -s :open -t')
config.bind('P', 'open -p')
config.bind('pp', 'tab-pin')
config.bind('_', 'zoom-out')
config.bind('O', 'set-cmd-text :open -t -r {url:pretty}')
config.bind('f', 'hint links run open {hint-url}')
config.bind('F', 'hint all tab-bg')
config.bind('zi', 'zoom-in')
config.bind('zo', 'zoom-out')
config.bind('<<', 'navigate prev -t')
config.bind('>>', 'navigate next -t')
config.bind('<Ctrl-p>', 'open -p')
config.bind('<Ctrl-w>', 'fake-key <Ctrl-backspace>', 'insert')

# Tabs
c.auto_save.session = True
c.tabs.title.format = '{audio}{private}{index}: {current_title}'
c.colors.tabs.selected.odd.bg = '#88c0d0'
c.colors.tabs.selected.even.bg = '#88c0d0'
c.colors.tabs.pinned.selected.odd.bg = '#88c0d0'
c.colors.tabs.pinned.selected.even.bg = '#88c0d0'
c.colors.tabs.selected.odd.fg = '#434c5e'
c.colors.tabs.selected.even.fg = '#434c5e'
c.colors.tabs.pinned.selected.odd.fg = '#434c5e'
c.colors.tabs.pinned.selected.even.fg = '#434c5e'
c.fonts.tabs.selected = 'bold 10pt'
c.fonts.tabs.unselected = '10pt'

# Status bar
c.statusbar.show = 'in-mode'

# Spellcheck
c.spellcheck.languages = ['en-US']

# Media
c.content.media.audio_video_capture = False
c.content.media.video_capture = False
c.content.autoplay = False

# Other custom settings
config.source('custom-config.py')
