include <Library.scad>;

//cube([290,275,250]);// print area
//cylinder(8,95,center=false); //cutting disk

// Tub
x = 280;
y = 260;
z = 128;
Wall = 8;
CornerRad = 10;
Handle = 125+2*Wall;
HandleD = 30;
HandleClearance = 50;
CasterHole = 450-280;
CasterD = 57;
CasterBoltD = 12;
CasterH = 75;

TailH = z-CasterH-Wall/2;
TailL = CasterHole+CasterD/2+HandleClearance+HandleD/2;

Tailm = (TailH-(HandleD/2))/(0-TailL);
Tailb = TailH-Tailm*0;
TailPrism = -Tailb/Tailm;

/*
translate([TotalLength-x,0,0]){
difference(){
    cube([x,y,z]); // outer walls of tub
        translate([Wall,Wall,Wall]){
            roundCube([x-2*Wall,y-2*Wall,2*z],CornerRad);
        }
}
}
*/

union(){
    Tail();
    mirror([0,0,1]){
        Tail();
    }
    rotate([0,90,0]){
        cylinder(r=HandleD/2,h=Handle,center=false);
    }
}

translate([Handle/2,HandleD/2+HandleClearance+CasterD/2,0]){
    %cylinder(r=CasterD/2,h=200,center=true);
}
/*
translate([HandleClearance+HandleD,y/2,0]){ //Caster
    cylinder(r=57/2,h=75,center=false);
}
*/


//316mm in between wheels
//wheel diameter 250
//120 tall
//Long dimension should be front to back
// total length 450
// caster bolt size 12
// grass height 3"
//75 between bottom of tub and top of caster
//diameter of caster surface 57