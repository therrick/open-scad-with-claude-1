# OpenSCAD Parts — Roversa

Parametric 3D-printable parts modelled in OpenSCAD.

---

## Parts

### `motor-tension-block.scad`

A motor tension/idler block with an H-shaped cross-section (viewed from above).
The central body sits between two thin longitudinal fins that extend 10 mm
beyond each end of the block, allowing the part to slide or be clamped along a
channel.

**Overall envelope (with fins):** 61.7 mm × 23.6 mm × 10 mm

| Parameter | Default | Description |
|---|---|---|
| `length` | 41.7 mm | Length of the central block body |
| `width` | 23.0 mm | Width of the central block body |
| `height` | 10.0 mm | Height of the part |
| `fin_thickness` | 0.3 mm | Wall thickness of each fin (Y direction) |
| `fin_extension` | 10.0 mm | How far each fin extends beyond the block ends (X direction) |

The fins run along the two long sides of the block. Each fin is
`fin_thickness` wide and extends `fin_extension` past each short end,
giving a total length of `length + 2 × fin_extension`.

---

## Building

Requires [OpenSCAD](https://openscad.org/) (2021.01 or later).

**Export to STL:**
```
openscad -o motor-tension-block.stl motor-tension-block.scad
```

**Render a PNG preview:**
```
openscad --render -o motor-tension-block.png motor-tension-block.scad
```

**Customise parameters** by editing the variables at the top of each `.scad`
file, or pass overrides on the command line with `-D`:
```
openscad -D "length=45" -o motor-tension-block.stl motor-tension-block.scad
```

Generated STL, PNG, and 3MF files are excluded from version control (see
`.gitignore`). Only the `.scad` source files are tracked.
