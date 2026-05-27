hl.config({
    env = {
        "XDG_CURRENT_DESKTOP,Hyprland",
        "XDG_SESSION_TYPE,wayland",
        "XDG_SESSION_DESKTOP,Hyprland",
        "QT_QPA_PLATFORM,wayland;xcb",
        "QT_WAYLAND_DISABLE_WINDOWDECORATION,1",
        "QT_QPA_PLATFORMTHEME,qt5ct",
        "GDK_BACKEND,wayland,x11",
        "SDL_VIDEODRIVER,wayland",
        "CLUTTER_BACKEND,wayland",
        "ELECTRON_OZONE_PLATFORM_HINT,auto",
        "_JAVA_AWT_WM_NONREPARENTING,1",
    },
})
