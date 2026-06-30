// Motor Tension Block
// Key dimensions
length        = 41.7;  // mm, main block long axis
width         = 23.0;  // mm, main block width
height        = 10.0;  // mm
fin_thickness = 0.3;   // mm, fin wall thickness (Y direction)
fin_extension = 10.0;  // mm, how far fins extend beyond each end of the block (X direction)

// Wire notch — cut into both fins at the -X end, open at the top
notch_inset  = 2.0;   // mm, distance from fin tip to near edge of notch
notch_length = 5.0;   // mm, notch extent along the fin (X direction)
notch_depth  = 6.0;   // mm, notch depth from top of fin (Z direction)

// Derived
fin_total_length = length + 2 * fin_extension;  // 61.7mm
notch_x          = -fin_extension + notch_inset; // X start of notch

// Fin with wire notch cut into the -X end, open at the top.
// y_start: Y coordinate of the fin's near face.
module fin(y_start) {
    difference() {
        translate([-fin_extension, y_start, 0])
            cube([fin_total_length, fin_thickness, height]);
        translate([notch_x, y_start - 1, height - notch_depth])
            cube([notch_length, fin_thickness + 2, notch_depth + 1]);
    }
}

// Main block
cube([length, width, height]);

// Both fins on the Y=0 long side (outside Y=0 face and outside Y=width face),
// each with a wire notch at the same (-X) end.
fin(-fin_thickness);
fin(width);
