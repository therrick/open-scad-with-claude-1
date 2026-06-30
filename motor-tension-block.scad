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

// Bevel — 45° chamfer on all four top interior edges of the main block
bevel_size = 1.0;     // mm, leg length of chamfer triangle

// Derived
fin_total_length = length + 2 * fin_extension;  // 61.7mm
notch_x_near     = -fin_extension + notch_inset;
notch_x_far      = length + fin_extension - notch_inset - notch_length;
bevel            = bevel_size * sqrt(2);  // diagonal of rotated cutter cube

// 45° chamfer cutter for a top edge running along X at Y=y_pos, Z=height.
// Subtract this from a solid to bevel the edge.
module chamfer_top_xedge(x_len, y_pos) {
    translate([0, y_pos, height])
        rotate([45, 0, 0])
        translate([0, -bevel/2, -bevel/2])
        cube([x_len, bevel, bevel]);
}

// 45° chamfer cutter for a top edge running along Y at X=x_pos, Z=height.
module chamfer_top_yedge(y_len, x_pos) {
    translate([x_pos, 0, height])
        rotate([0, -45, 0])
        translate([-bevel/2, 0, -bevel/2])
        cube([bevel, y_len, bevel]);
}

module wire_notches(y_start) {
    translate([notch_x_near, y_start - 1, height - notch_depth])
        cube([notch_length, fin_thickness + 2, notch_depth + 1]);
    translate([notch_x_far,  y_start - 1, height - notch_depth])
        cube([notch_length, fin_thickness + 2, notch_depth + 1]);
}

// Main block — all four top edges chamfered
difference() {
    cube([length, width, height]);
    chamfer_top_xedge(length, 0);      // edge at Y=0
    chamfer_top_xedge(length, width);  // edge at Y=width
    chamfer_top_yedge(width, 0);       // edge at X=0
    chamfer_top_yedge(width, length);  // edge at X=length
}

// Notched fin — Y=0 side, wire notch at each end
difference() {
    translate([-fin_extension, -fin_thickness, 0])
        cube([fin_total_length, fin_thickness, height]);
    wire_notches(-fin_thickness);
}

// Plain fin — Y=width side, no notches
translate([-fin_extension, width, 0])
    cube([fin_total_length, fin_thickness, height]);
