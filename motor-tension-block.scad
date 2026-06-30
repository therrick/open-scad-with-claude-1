// Motor Tension Block
// Key dimensions
length        = 41.7;  // mm, main block long axis
width         = 23.0;  // mm, main block width
height        = 10.0;  // mm
fin_thickness = 0.3;   // mm, fin wall thickness (Y direction)
fin_extension = 10.0;  // mm, how far fins extend beyond each end of the block (X direction)

// Wire notch — two notches on one fin, one at each end, open at the top
notch_inset  = 2.0;   // mm, distance from fin tip to near edge of notch
notch_length = 5.0;   // mm, notch extent along the fin (X direction)
notch_depth  = 6.0;   // mm, notch depth from top of fin (Z direction)

// Derived
fin_total_length = length + 2 * fin_extension;  // 61.7mm
notch_x_near     = -fin_extension + notch_inset;                        // -8: notch at -X end
notch_x_far      = length + fin_extension - notch_inset - notch_length; // 44.7: notch at +X end

// Subtract a wire notch (open at top) through the full fin thickness.
// y_start: Y coordinate of the fin's near face.
module wire_notches(y_start) {
    translate([notch_x_near, y_start - 1, height - notch_depth])
        cube([notch_length, fin_thickness + 2, notch_depth + 1]);
    translate([notch_x_far,  y_start - 1, height - notch_depth])
        cube([notch_length, fin_thickness + 2, notch_depth + 1]);
}

// Main block
cube([length, width, height]);

// Notched fin — Y=0 side, wire notch at each end
difference() {
    translate([-fin_extension, -fin_thickness, 0])
        cube([fin_total_length, fin_thickness, height]);
    wire_notches(-fin_thickness);
}

// Plain fin — Y=width side, no notches
translate([-fin_extension, width, 0])
    cube([fin_total_length, fin_thickness, height]);
