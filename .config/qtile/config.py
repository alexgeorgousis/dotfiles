# Copyright (c) 2010 Aldo Cortesi
# Copyright (c) 2010, 2014 dequis
# Copyright (c) 2012 Randall Ma
# Copyright (c) 2012-2014 Tycho Andersen
# Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 horsik
# Copyright (c) 2013 Tao Sauvage
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

from libqtile import bar, layout, widget, hook
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal

import os
import subprocess

terminal = "alacritty"
browser = "google-chrome-stable"

#***************************************************************************
# Key bindings
#***************************************************************************

mod = "mod4"
alt = "mod1"

keys = [

    # Switch between windows
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    # Key([mod], "space", lazy.layout.next(), desc="Move window focus to other window"),

    # Switch between screens
    Key([alt], "h", lazy.prev_screen(), desc="Move focus to screen on the left"),
    Key([alt], "l", lazy.next_screen(), desc="Move focus to screen on the right"),

    # Move windows
    Key([alt, "control"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"),
    Key([alt, "control"], "l", lazy.layout.shuffle_right(), desc="Move window to the right"),
    Key([alt, "control"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([alt, "control"], "k", lazy.layout.shuffle_up(), desc="Move window up"),

    # Resize windows
    Key([alt, "shift"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key([alt, "shift"], "l", lazy.layout.grow_right(), desc="Grow window to the right"),
    Key([alt, "shift"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([alt, "shift"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([alt, "shift"], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    Key([mod         ], "f", lazy.window.toggle_fullscreen(), desc="Toggle fullscreen for current window"),

    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key([alt, "shift"], "Return", lazy.layout.toggle_split(), desc="Toggle between split and unsplit sides of stack"),
    
    Key([mod                    ], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    Key([mod                    ], "c",      lazy.window.kill(), desc="Kill focused window"),
    Key([mod                    ], "p",      lazy.spawn("dmenu_run"), desc="Run dmenu"),
    Key([alt, "shift"           ], "r",      lazy.reload_config(), desc="Reload the config"),
    Key([alt, "shift", "control"], "r",      lazy.reload_config(), desc="Reload the config"),
    Key([alt, "shift"           ], "q",      lazy.shutdown(), desc="Shutdown Qtile"),

]

#***************************************************************************
# Groups
#***************************************************************************

groups = [
    Group("dev",   spawn=[terminal]),
    Group("www",   spawn=[browser]),
    Group("notes", spawn=[]),
]

for i in range(len(groups)):
    name = groups[i].name
    idx = i + 1
    
    keys.append(Key([alt         ], str(idx), lazy.group[name].toscreen(), desc="Switch to group"))
    keys.append(Key([alt, "shift"], str(idx), lazy.window.togroup(name), desc="Move window to group"))

#***************************************************************************
# Screens
#***************************************************************************

def get_screen(include_systray=False):
    widgets = []

    widgets.append(widget.GroupBox(
        highlight_method="line",
        highlight_color="#282a36",
        block_highlight_text_color="#caa9fa",
    ))

    widgets.append(widget.Spacer())

    if include_systray:
        widgets.append(widget.Systray())
    widgets.append(widget.Clock(format="%d-%m-%Y %a %I:%M %p"))

    return Screen(top=bar.Bar(widgets, 24, opacity=0.95))

num_screens = 3
# Note: There can only be 1 instance of widget.Systray() across all screens
screens = [get_screen(include_systray=True) if i == 0 else get_screen() for i in range(num_screens)]

#***************************************************************************
# Layouts
#***************************************************************************

layouts = [
    layout.Columns(
        border_focus="#caa9fa",
        border_width=1,
        border_on_single=True,
        insert_position=1,  # create new window below currently focused one
        margin=8,
        margin_on_single=8,
    ),
]

#***************************************************************************
# Misc
#***************************************************************************

# Run autostart script - as described in the docs:
# https://docs.qtile.org/en/latest/manual/config/hooks.html#autostart
@hook.subscribe.startup
def autostart():
    path = os.path.expanduser('~/.config/qtile/autostart.sh')
    subprocess.run(['sh', path])

widget_defaults = dict(
    font="Ubuntu Bold",
    fontsize=14,
    padding=16,
    background="#282a36",
)
extension_defaults = widget_defaults.copy()

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
    ]
)

auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
