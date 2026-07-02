# OpenSCAD Parts — Roversa

Parametric 3D-printable parts modelled in OpenSCAD.

---

## Parts

### `motor-tension-block.scad`

A motor tension/idler block with an H-shaped profile (viewed from above).
Two thin longitudinal fins extend 10 mm beyond each end of the central block
body, allowing the part to slide down over a motor. 45° chamfers on the entry
edges guide the part into place.

**Overall envelope (with fins):** 61.7 mm × 26.0 mm × 10 mm

#### Parameters

| Parameter | Default | Description |
|---|---|---|
| `length` | 41.7 mm | Length of the central block body |
| `width` | 23.0 mm | Width of the central block body |
| `height` | 10.0 mm | Height of the part |
| `fin_thickness` | 1.5 mm | Wall thickness of each fin (Y direction) |
| `fin_extension` | 10.0 mm | How far each fin extends beyond each block end (X direction) |
| `notch_inset` | 2.0 mm | Distance from fin tip to the near edge of each wire notch |
| `notch_length` | 5.0 mm | Wire notch length along the fin (X direction) |
| `notch_depth` | 6.0 mm | Wire notch depth from the top of the fin (Z direction) |
| `bevel_size` | 1.25 mm | Leg length of the 45° entry chamfers |

#### Features

**Fins** — Two fins run the full 61.7 mm length (block + both extensions),
one on each long side of the block (Y = 0 and Y = `width`), each 1.5 mm thick.

**Wire notches** — The fin on the Y = 0 side has an open-top rectangular notch
at each end, for routing a motor wire. Each notch is `notch_inset` mm from the
fin tip, `notch_length` mm long, and `notch_depth` mm deep.

**Entry bevels** — 45° chamfers are cut at three locations to guide the block
onto the motor as it slides down:
- Inner top edge of each fin, over the extension sections only (not alongside the block body)
- Top edge of each exposed block end face (X = 0 and X = `length`)

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

**Override parameters** on the command line with `-D`:
```
openscad -D "length=45" -D "bevel_size=0.6" -o motor-tension-block.stl motor-tension-block.scad
```

`motor-tension-block.stl` and `motor-tension-block.png` are tracked in version
control and must be kept in sync with the source. **After any change to
`motor-tension-block.scad`, regenerate both files with the two commands above
and include the updated files in the same commit/PR.** Other generated
formats (3MF, AMF, DXF, SVG) are excluded from version control (see
`.gitignore`).
