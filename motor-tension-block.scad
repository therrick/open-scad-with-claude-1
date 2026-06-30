// Motor Tension Block
// Key dimensions
length        = 41.7;  // mm, main block long axis
width         = 23.0;  // mm, main block width
height        = 10.0;  // mm
fin_thickness = 0.3;   // mm, fin wall thickness (Y direction)
fin_extension = 10.0;  // mm, how far fins extend beyond each end of the block (X direction)

// Derived
fin_total_length = length + 2 * fin_extension;  // 61.7mm

// Main block
cube([length, width, height]);

// Left fin — sits outside Y=0 face, runs full fin_total_length in X
translate([-fin_extension, -fin_thickness, 0])
    cube([fin_total_length, fin_thickness, height]);

// Right fin — sits outside Y=width face, runs full fin_total_length in X
translate([-fin_extension, width, 0])
    cube([fin_total_length, fin_thickness, height]);
