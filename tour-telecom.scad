$fn=256;
tube = 5.5;
blue = [0,0,1];

module pie(radius, angle, height, spin=0) {
    // Negative angles shift direction of rotation
    clockwise = (angle < 0) ? true : false;
    // Support angles < 0 and > 360
    normalized_angle = abs((angle % 360 != 0) ? angle % 360 : angle % 360 + 360);
    // Select rotation direction
    rotation = clockwise ? [0, 180 - normalized_angle] : [180, normalized_angle];
    // Render
    if (angle != 0) {
        rotate([0,0,spin]) linear_extrude(height=height)
            difference() {
                circle(radius);
                if (normalized_angle < 180) {
                    union() for(a = rotation)
                        rotate(a) translate([-radius, 0, 0]) square(radius * 2);
                }
                else if (normalized_angle != 360) {
                    intersection_for(a = rotation)
                        rotate(a) translate([-radius, 0, 0]) square(radius * 2);
                }
            }
    }
}

module bigDisc() {
    color([0,0,1]) {
        difference() {
            cylinder(h = 10, r=24);
            translate([0,0,-1])
                cylinder(h = 12, r=tube);
        }
    }
}

module smallDisc() {
    color([0.5,0.5,0.5]) {
        difference() {
            cylinder(h = 4, r=19);
            translate([0,0,-1])
                cylinder(h = 6, r=tube);
        }
    }
}

module fullSmallDisc() {
    color([0.5,0.5,0.5]) {
        cylinder(h = 4, r=19);
    }
}

module miniDisc() {
    color([0.5,0.5,0.5]) cylinder(h = 4, r=10);
}

module electroDisc() {
    a = 12;
    r1 = 24;
    r2 = 19;
    r3 = 11;
    r4 = tube;
    difference() {
        union() {
            difference() {
                cylinder(h = 2, r=r1);
                translate([0,0,-1]) {
                    cylinder(h = 4, r=r2);
                }
            };
            cylinder(h = 2, r=r3);
            rotate([0,0,-a]){
                pie(r1, 2*a, 2);
            }
            rotate([0,0,180-a]){
                pie(r1, 2*a, 2);
            }
            rotate([0,0,90-a]){
                pie(r1, 2*a, 2);
            }
            rotate([0,0,270-a]){
                pie(r1, 2*a, 2);
            }
            
        }
        translate([0,0,-1]) {
            cylinder(h = 4, r=r4);
        }
    }
}

module hat() {
    color([0,0,1]) {
        difference() {
            cylinder(h = 5, r=38);
            translate([0,0,-1])
                cylinder(h = 7, r=tube);
        }
    }
}

module ceiling() {
    difference() {
        union() {
            fullSmallDisc();
            translate([0,0,4]) {
                miniDisc();
            }
        }
        translate([0,-5.2,-1]) {
            cylinder(h = 10, r=1);
        }
    }
}

module tower() {
    // The tower is made of 5 big discs
    for (i = [0:5]) {
        translate([0,0,i*14]) {
            bigDisc();
            translate([0,0,10]) {
                smallDisc();
            }
        }
    }
    translate([0,0,14*6 + 5])
    ceiling();

  // cylinder(h = 14*6 + 5 + 4 + 4 + 49, r=1);
  translate([0,0,6*14]) {
      hat();
  }
  translate([0,0,6*14+13]) {
      color([1,1,1])
      cylinder(h = 50, r=2);
  }
}

module disc1() {
translate ([0,60,0]) {
    union() {
        color(blue)
        difference() {
            cylinder(h = 2, r=24);
            translate([0,0,-1]) {
                cylinder(h = 4, r=tube);
            } 
        }
        
        translate([0,0,12]) {
            color("red")
            difference() {
                 cylinder(h = 6, r=24);
                translate([0,0,-1]){
                    cylinder(h = 8, r=19);
                }
            }
            color("red")
            difference() {
                color("red") cylinder(h = 6, r=11);
                translate([0,0,-1]){
                    cylinder(h = 8, r=tube+0.5);
                }
            }
        }
        
        color(blue)
        translate ([0,0,28])
            electroDisc();
   }
}
}

module disc2() {
translate ([60,0,0]) {
    color(blue)
    union() {
        difference() {
            cylinder(h = 2, r=24);
            translate([0,0,-1]) {
                cylinder(h = 4, r=tube);
            } 
        }
        
        translate([0,0,2]) {
            difference() {
                 cylinder(h = 6, r=24);
                translate([0,0,-1]){
                    cylinder(h = 8, r=19);
                }
            }
            difference() {
                color("red") cylinder(h = 6, r=11);
                translate([0,0,-1]){
                    cylinder(h = 8, r=tube+0.5);
                }
            }
        }
        
        translate ([0,0,8])
            electroDisc();
   }
}
}
     

// projection(cut=true) rotate([90,0,0]) tower();
// projection(cut=true) translate([0,0,-12]) tower();
// projection(cut = true) tower();
tower();