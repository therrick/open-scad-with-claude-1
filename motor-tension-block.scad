// Motor Tension Block
// Key dimensions
length        = 41.7;  // mm, main block long axis
width         = 23.0;  // mm, main block width
height        = 12.0;  // mm
fin_thickness = 1.5;   // mm, fin wall thickness (Y direction)
fin_extension = 10.0;  // mm, how far fins extend beyond each end of the block (X direction)

// Wire notch — two notches on one fin, one at each end, open at the top
notch_inset  = 2.0;   // mm, distance from fin tip to near edge of notch
notch_length = 5.0;   // mm, notch extent along the fin (X direction)
notch_depth  = 8.0;   // mm, notch depth from top of fin (Z direction)

// Bevel — 45° chamfers to guide the part down over the motor:
//   • inner top edges of the fin extensions (not alongside the block)
//   • top edges of the two exposed block ends
bevel_size = 1.25;    // mm, leg length of chamfer triangle

// Derived
fin_total_length = length + 2 * fin_extension;  // 61.7mm
notch_x_near     = -fin_extension + notch_inset;
notch_x_far      = length + fin_extension - notch_inset - notch_length;
bevel            = bevel_size * sqrt(2);

module wire_notches(y_start) {
    translate([notch_x_near, y_start - 1, height - notch_depth])
        cube([notch_length, fin_thickness + 2, notch_depth + 1]);
    translate([notch_x_far,  y_start - 1, height - notch_depth])
        cube([notch_length, fin_thickness + 2, notch_depth + 1]);
}

// 45° chamfer on the inner top edge of a fin at Y=y_inner, restricted to the
// two extension sections only (not the run alongside the block body).
module fin_inner_bevel(y_inner) {
    // Near extension: X = -fin_extension to 0
    translate([-fin_extension, y_inner, height])
        rotate([45, 0, 0])
        translate([0, -bevel/2, -bevel/2])
        cube([fin_extension, bevel, bevel]);
    // Far extension: X = length to length+fin_extension
    translate([length, y_inner, height])
        rotate([45, 0, 0])
        translate([0, -bevel/2, -bevel/2])
        cube([fin_extension, bevel, bevel]);
}

// 45° chamfer on the top edge of a block end face (edge runs along Y at X=x_pos, Z=height).
module block_end_bevel(x_pos) {
    translate([x_pos, 0, height])
        rotate([0, -45, 0])
        translate([-bevel/2, 0, -bevel/2])
        cube([bevel, width, bevel]);
}

// Main block — bevel the two exposed end top edges
difference() {
    cube([length, width, height]);
    block_end_bevel(0);       // near end (X=0)
    block_end_bevel(length);  // far end (X=length)
}

// Notched fin — bevel on inner top edge of extension sections only
difference() {
    translate([-fin_extension, -fin_thickness, 0])
        cube([fin_total_length, fin_thickness, height]);
    wire_notches(-fin_thickness);
    fin_inner_bevel(0);
}

// Plain fin — bevel on inner top edge of extension sections only
difference() {
    translate([-fin_extension, width, 0])
        cube([fin_total_length, fin_thickness, height]);
    fin_inner_bevel(width);
}
