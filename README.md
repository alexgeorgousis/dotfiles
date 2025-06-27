# Requirements

# Installation

# Arch Installation Tips

## Connecting to WiFi

Official guide [here](https://wiki.archlinux.org/title/Iwd#Connect_to_a_network).

1. Run `iwctl`
2. In the `iwctl` prompt run `station list` to get the name of your wifi device - you should see something like `wlan0` or `wlan1`
3. Run `station <name> connect <SSID>`
    - If you don't know your WiFi's SSID by heart, run `station <name> scan` to find it
4. Type in your password when requested
5. You should see the `connect` command from above (which is still running) go to `connecting` and then `connected`

## Partitioning for dual boot

# Knowledge

I don't have a better place to put this so it's going here for now. This is a copy-paste of a [comment]() on a YouTube video that briefly (and very clearly) explains the confusing mess of compositors vs window managers vs desktop environments: 

_First off, "compositor" is not the Wayland equivalent to X11's "window manager". Window managers are an X11-only thing, whereas compositors also exist in X11. Historically, in X11, compositors were used to render effects, such as blur, drop shadows, etc. whereas window managers were responsible for, well, managing your windows. In KDE, you could even disable the compositor for extra performance on lower end devices, at the cost of having your image look like trash. So in X11, "compositor" and "window manager" refer to two different concepts._

_In Wayland, "window manager" is not a thing anymore, and compositors also perform the role of managing your windows. "Wayland" itself is just a set of protocols that specify how clients (windows) interact with servers (compositors), much like HTTP is just a set of protocols that also defines how clients (web browsers) interact with servers (web servers). The Wayland protocols allow clients & servers to talk to each other about what contents the clients are rendering, the size of the windows, what sizes they support, whether they are fullscreen, etc._

_A Wayland "server" (compositor) is responsible for collecting all the data from its clients (windows) and presenting it to the end user in whatever way it sees fit. It could layer windows on top of each other, choose to not display some at all (e.g. if they are minimized), display them in a tiling fashion, attach window decorations to them, you name it._

_The compositor is also responsible for handling user input and forwarding it to the clients that it concerns. This is one of the points where Wayland is significantly more secure than X11, because in X11, user input is broadcast globally over the X11 socket, whereas in Wayland, compositors only send input events to a subset of clients (usually the window that's currently in focus)._

_Furthermore, Wayland clients are completely unaware of each other, unlike in X11, where one window can see other windows and even the entire screen. This means that for things such as screenshots or screensharing under Wayland, you will need some sort of way to provide clients with the information they need. For this, we have another set of protocols in the form of "portals" (see the freedesktop portal spec if you're interested)._

_The ScreenCast portal for example describes a D-Bus API that Wayland clients can use to request a video stream of either the entire screen, a subregion, or a single window (selection here is performed by the user through the portal, not through the client) from the compositor in a secure and well-defined way._

_This is why, when working under Wayland, you will also need an application that provides these APIs to its clients (usually called something like xdg-desktop-portal-[compositorname]), as well as a library like Pipewire, which handles video encoding in the case of screen sharing._

_Finally, as for the difference between a compositor and a fully-fledged desktop environment, the compositor is literally just the thing that talks to clients, manages input, and renders your screen contents (it does a few more things than that, but those are the most important ones), whereas a desktop environment is a compositor plus a set of commonly used helper applications and utilities, e.g. some sort of user shell with a task bar, a file explorer, management utilities for things like networking, bluetooth, a notification daemon, a settings application, and so on. All of these you'd have to source yourself (or omit, if not needed) when working with a standalone compositor such as Sway or Hyprland. The X11 world here is much the same, last I checked i3 didn't come with a file browser out of the box :)_
