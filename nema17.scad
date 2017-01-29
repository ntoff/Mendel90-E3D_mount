nema_height=10;
shaft_dia=6;
module nema(nema_height,shaft_dia){
    echo("Note: Nema is designed to be differenced out of something, dimensions of screws and shaft are larger than actual");
linear_extrude(nema_height){
    hull(){
        translate([0,0-2,0])circle(d=3.5,$fn=16);
        translate([0,02,0])circle(d=3.5,$fn=16);
    }
    hull(){
        translate([31,0-2,0])circle(d=3.5,$fn=16);
        translate([31,02,0])circle(d=3.5,$fn=16);
    }
    hull(){
        translate([31,31-2,0])circle(d=3.5,$fn=16);
        translate([31,31+2,0])circle(d=3.5,$fn=16);
    }
    hull(){
        translate([0,31-2,0])circle(d=3.5,$fn=16);
        translate([0,31+2,0])circle(d=3.5,$fn=16);
    }
}
linear_extrude(nema_height)hull(){
    translate([31/2,31/2-2,0])circle(d=25);
    translate([31/2,31/2+2,0])circle(d=25);
}
color("Silver")translate([31/2,31/2,0])cylinder(d=shaft_dia,h=25,$fn=64); //motor shaft


color("DarkSlateGray")translate([(31-42)/2,(31-42)/2,-42])cube(42); //motor body
}

//rotate([0,90,0])
//nema(nema_height=3,shaft_dia=15);