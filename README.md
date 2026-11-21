# FreeCAD FCStd thumbnailer for KDE Plasma 6

KDE external thumbnailer for Dolphin/KDE.

It extracts the existing `thumbnails/Thumbnail.png` file from a FreeCAD `.FCStd` project archive.

The file's MIME type should be:

```text
application/x-extension-fcstd
```

Check it with:

```bash
xdg-mime query filetype example.FCStd
```

## Install

Unpack this project, then run:

```bash
./install.sh
```

The installer places the bash executable in `~/.local/bin` and the thumbnailer registration in `${XDG_DATA_HOME:-~/.local/share}/thumbnailers/`.

No root privileges are required.

## Test the extractor independently

```bash
~/.local/bin/fcstd-thumbnailer example.FCStd /tmp/example.png
file /tmp/example.png
```

A successful extraction returns exit status 0 and produces a PNG. If the archive has no `thumbnails/Thumbnail.png`, the script returns non-zero.

## Activate in Dolphin

Restart Dolphin:

```bash
kquitapp6 dolphin 2>/dev/null || true
dolphin
```

Make sure previews are enabled in Dolphin (View -> Show Previews) and that the relevant file type is not excluded in Configure Dolphin -> Interface / Previews (wording can vary by Dolphin version).

KDE caches thumbnails. If an old failed result persists, remove the cached thumbnail for the test file or temporarily clear the thumbnail cache:

```bash
rm -rf ~/.cache/thumbnails/*
```

Then revisit the folder.

## Registration details

The `.thumbnailer` file uses the freedesktop external-thumbnailer convention:

```ini
[Thumbnailer Entry]
TryExec=fcstd-thumbnailer
Exec=fcstd-thumbnailer %i %o
MimeType=application/x-extension-fcstd;
```

## Behaviour and limits

- Rejects missing, empty, non-PNG, and larger-than-64-MiB thumbnails.
- Writes to a temporary file and renames it into place only after successful extraction.
- Does not generate a replacement preview if the embedded thumbnail is absent.

## Acknowledgements

Inspired by https://github.com/StefanHamminga/kde-fcstd-thumbnailer and https://github.com/yorikvanhavre/kde-fcstd-thumbnailer.
