# Desktop Apps

ChromeOS supports [Gnome Desktop Files](https://developer.gnome.org/integration-guide/stable/desktop-files.html.en).

Desktop shortcuts live in one of two places:

1. /usr/share/applications - Applications shared by all users
2. ~/.local/share/applications - Applications specific to your user account

A desktop shortcut is defined as a .desktop file. It looks like:

```config
[Desktop Entry]
Version=1.0
Type=Application
Name=Android Studio
Icon=/home/natehunzaker/android-studio/bin/studio.png
Exec="/home/natehunzaker/android-studio/bin/studio.sh" %f
Comment=The Drive to Develop
Categories=Development;IDE;
Terminal=false
StartupWMClass=jetbrains-studio
```

You can create your own shortcuts this way too! Learn more about them here:

https://developer.gnome.org/desktop-entry-spec
