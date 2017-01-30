include<nema17.scad>
/*E3D mount for a mendel90
F5 to compile it for viewing the assembled assembly
F6 to compile it with just the mount plate, base plate, and filament guide to see orientation of parts

change print variable to 1 and F6 to compile for printing

note: Only openscad parts are compiled for printing, imported STLs won't show up but can be manually
added to your slicer. DO NOT PRINT THE X CARRIAGE, included x carriage is only for design reference,
the x carriage generated for your machine should be used as long as the holes all line up, check by
replacing the included x carriage with your own.
*/

//CHANGE THIS TO 1 TO COMPILE FOR PRINTING
print=0;
$fn=32;
plate_thickness=6;
upright_thickness=5;
offset=5; //moves the motor left and right for different sized drive wheels
x=18.5-4;
y=35;
y2=31;
plate_height=43;
filament_hole_size = 17; //size of the hole in the base plate, NOT the size of your filament
bowden_tube_dia=4.5; //diameter of the PTFE liner in the e3d
bodge_for_upright = 4 - upright_thickness;

module extras(){
    %color("red")translate([0,5,-100])cylinder(d=1.75,h=200); //filament for reference
    /**/
    %color("white")translate([0,5,-42.7-3]){
        cylinder(d=22.3,h=26);
        cylinder(d=16,h=42.7);
        translate([0,0,-7.1])cylinder(d=3,h=7.1);
        translate([0,0,-7.1])cylinder(d=3,h=11.5);
        } //e3d heatsink for reference
    %color("silver")translate([0,4+5,-42.7-3-8])
        difference(){
            cube([20,20,10],center=true);
            translate([0,4,0])rotate([0,90,0])cylinder(d=5,h=21,center=true);
            translate([0,-4,0])cylinder(d=5,h=11,center=true);
        }
    /**/
    %translate([-18.52+bodge_for_upright,-0+5-31/2-offset,41.6-(5-plate_thickness)])rotate([0,90,0])nema(nema_height=3,shaft_dia=8);
    %color("red")translate([-18.5+bodge_for_upright,-31.45,plate_thickness])import("extruder_corner_shaved.stl");
    %color("red")translate([-18.5+bodge_for_upright,21.5,plate_thickness])import("extruder_corner.stl");
    %color("orange")translate([18.5,-28+5.5+2.9,plate_thickness])rotate([0,0,0])import("idler.stl"); //idler bearing holder
    %color("silver")translate([18.5,-28+5.5+2.9,plate_thickness])rotate([0,0,0])import("idler_shaft.stl"); //idler bearing holder
    %color("pink")translate([18.5,-28+5.5+2.9,plate_thickness])rotate([0,0,0])import("idler_bearing_real.stl"); //idler bearing holder
    /*
        Comment out ONE of these to make more sense of it all
        either the one with or without the extra tab is needed but not both.
        There's not much difference other than one extra bolt.
    */
    //filament guide with extra mount tab
    //%color("orange")translate([18.5,-28+5.5,plate_thickness])rotate([0,0,0])import("driverholder.stl"); 
    //filament guide without extra mount tab
    %color("purple")translate([18.5,-28+5.5,plate_thickness])rotate([0,0,0])import("extruder guide2.stl"); 
    //%color("yellow")translate([0,0,0])rotate([0,180,0])import("x_carriage.stl");
    /*
        E3d fan duct for reference, comment out TWO of them to leave the one you want
    */
    //front facing
    //%color("red")translate([0,5,-19.7])rotate([-90,0,90])import("V6.6_Duct.stl");  
    //right facing
    %color("orange")mirror([1,0,0])translate([0,5,-46])rotate([90,0,0])import("V6.6_Duct.stl"); 
    //left facing
    //%color("green")translate([0,5,-46])rotate([90,0,10])import("V6.6_Duct.stl");
}

module e3d(){
    extra=8;
    hull(){
        translate([0,5,0])rotate([180,0,0])cylinder(d=16.5,h=4);
        translate([0,-5,0])rotate([180,0,0])cylinder(d=16.5,h=4);
    }
    translate([0,5,-3.95+extra])rotate([180,0,0])cylinder(d=12.2,h=6+extra);
    hull(){
        translate([0,5,-3.95+extra])rotate([180,0,0])cylinder(d=11,h=6+extra);
        translate([0,-5,-3.95+extra])rotate([180,0,0])cylinder(d=13,h=6+extra);
    }
    hull(){
        translate([0,5,-10])rotate([180,0,0])cylinder(d=16.5,h=2);
        translate([0,-5,-10])rotate([180,0,0])cylinder(d=16.5,h=2);
    }
}

module baseplate(){
    color("RoyalBlue")difference(){
        union(){
            linear_extrude(plate_thickness)
               polygon( points=[[-45+bodge_for_upright,-y],[-60+bodge_for_upright,-15],[-60+bodge_for_upright,10],[-43+bodge_for_upright,y2],[17,y2],[30,y2-15],[30,-y+10],[20,-y]]);
            minkowski(){
            translate([-25/2,10,0])rotate([180,0,0])cube([25,10,5]);
                rotate([180,0,0])cylinder(d=9,h=5);
            }
            //translate([0,5,0])rotate([180,0,0])cylinder(d=20,h=10,$fn=$fn*2);
        }

        //mounting holes
        translate([-25,0,plate_thickness-2.9])cylinder(d1=5,d2=9,h=3); //countersink
        translate([25,0,plate_thickness-2.9])cylinder(d1=5,d2=9,h=3); //countersink
        translate([-25,0,-1])cylinder(d=5,h=plate_thickness); 
        translate([25,0,-1])cylinder(d=5,h=plate_thickness);
        //end mounting holes
            
        translate([18.5,-28+5.5,-0.5])cylinder(d=5,h=6); //guide mount hole
        translate([18.5,-28+5.5,-0.5])cylinder(d1=9,d2=5,h=3); //guide mount hole
        #translate([-35.7+bodge_for_upright,-26.25,1])cylinder(d=5,h=plate_thickness); //motor 90 degree bracket mount hole
        #translate([-35.7+bodge_for_upright,26.25,1])cylinder(d=5,h=plate_thickness); //motor 90 degree bracket mount hole
        #translate([-35.7+bodge_for_upright,-26.25,-0.1])cylinder(d1=9,d2=5,h=3); //motor 90 degree bracket mount hole
        #translate([-35.7+bodge_for_upright,26.25,-0.1])cylinder(d1=9,d2=5,h=3); //motor 90 degree bracket mount hole
        
        translate([0,5,+plate_thickness/2])cylinder(d=filament_hole_size,h=plate_thickness+0.5,center=true,$fn=32); //filament hole
        translate([0,0,-3])e3d();

    }
}

module filament_inlet(){
    clearance = 0.4;
    color("RoyalBlue")
    difference(){
        union(){
            translate([0,5,+plate_thickness/2])cylinder(d=filament_hole_size-clearance,h=plate_thickness+0.5,center=true,$fn=32); //filament hole
            translate([0,5,0])cylinder(d=8,h=24,center=false,$fn=32); //filament hole
        }
        translate([18.5,-28+5.5+2.9,plate_thickness])rotate([0,0,0])import("idler_bearing.stl"); //idler bearing holder
        translate([-18.52,-0+5-31/2-offset,40.6])rotate([0,90,0])nema(nema_height=3,shaft_dia=15);
        translate([0,5,0])cylinder(d=bowden_tube_dia,h=25,center=false,$fn=32); //filament hole
        translate([0,5,+plate_thickness/2-0.76])cylinder(d1=filament_hole_size-clearance-2,d2=bowden_tube_dia,h=plate_thickness+0.5-1.5,center=true,$fn=32); //filament hole
    }
}

module nema_mount(){
difference(){
    union(){
        
        color("brown")translate([0,0,plate_thickness])
            linear_extrude(plate_height)
                polygon( points=[[-x,-y],[-x,y2],[-x+-upright_thickness,y2],[-x+-upright_thickness,-y]]);
        }
     
    translate([-18.52+bodge_for_upright,-0+5-31/2-offset,41.6-(5-plate_thickness)])rotate([0,90,0])nema(nema_height=upright_thickness+10);
    //bolt holes
    color("green") translate([0,-26.44,22.17-(5-plate_thickness)])rotate([0,90,0])cylinder(d=5,h=100,center=true);
    color("green") translate([0,26.44,22.17-(5-plate_thickness)])rotate([0,90,0])cylinder(d=5,h=100,center=true);
    color("green") translate([0,-26.44,22.17+19.25-(5-plate_thickness)])rotate([0,90,0])cylinder(d=5,h=100,center=true);
    //zip tie hole for holding the cables, comment out if you don't want it
    color("green") translate([0,26.44,22.17+19.25-(5-plate_thickness)])rotate([0,90,0])cylinder(d=5,h=100,center=true);
}
}

if (print == 1){
    translate([0,0,plate_thickness])rotate([180,0,0]) 
        baseplate();
    translate([-10,35,-x])rotate([0,90,90]) 
        nema_mount();
    translate([-8,56,0.25]) 
        filament_inlet();
}else {
    baseplate();
    nema_mount();
    filament_inlet();
    extras();
    }
