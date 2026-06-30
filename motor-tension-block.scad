// Motor Tension Block
// Key dimensions
length        = 41.7;  // mm, main block long axis
width         = 23.0;  // mm, main block width
height        = 10.0;  // mm
fin_thickness = 0.6;   // mm, fin wall thickness (Y direction)
fin_extension = 10.0;  // mm, how far fins extend beyond each end of the block (X direction)

// Wire notch — two notches on one fin, one at each end, open at the top
notch_inset  = 2.0;   // mm, distance from fin tip to near edge of notch
notch_length = 5.0;   // mm, notch extent along the fin (X direction)
notch_depth  = 6.0;   // mm, notch depth from top of fin (Z direction)

// Bevel — 45° chamfer on the inner top edge of each fin, running the full
// fin length, to guide the part down over the motor
bevel_size = 0.5;     // mm, leg length of chamfer triangle

// Derived
fin_total_length = length + 2 * fin_extension;  // 61.7mm
notch_x_near     = -fin_extension + notch_inset;
notch_x_far      = length + fin_extension - notch_inset - notch_length;
bevel            = bevel_size * sqrt(2);  // diagonal of rotated cutter cube

module wire_notches(y_start) {
    translate([notch_x_near, y_start - 1, height - notch_depth])
        cube([notch_length, fin_thickness + 2, notch_depth + 1]);
    translate([notch_x_far,  y_start - 1, height - notch_depth])
        cube([notch_length, fin_thickness + 2, notch_depth + 1]);
}

// 45° chamfer cutter for the inner top edge of a fin at Y=y_inner, Z=height.
// Cuts into the fin (away from the block) and downward, along the full fin length.
module fin_inner_bevel(y_inner) {
    translate([-fin_extension, y_inner, height])
        rotate([45, 0, 0])
        translate([0, -bevel/2, -bevel/2])
        cube([fin_total_length, bevel, bevel]);
}

// Main block — no chamfers
cube([length, width, height]);

// Notched fin (Y=-fin_thickness to 0) — bevel on inner top edge at Y=0
difference() {
    translate([-fin_extension, -fin_thickness, 0])
        cube([fin_total_length, fin_thickness, height]);
    wire_notches(-fin_thickness);
    fin_inner_bevel(0);
}

// Plain fin (Y=width to width+fin_thickness) — bevel on inner top edge at Y=width
difference() {
    translate([-fin_extension, width, 0])
        cube([fin_total_length, fin_thickness, height]);
    fin_inner_bevel(width);
}
