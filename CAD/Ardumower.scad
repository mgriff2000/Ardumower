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
HandleDiameter = 30;
HandleClearance = 50;
TotalLength = 450+HandleClearance+HandleDiameter;
CasterHole = 450;

/*
difference(){
    cube([x,y,z]); // outer walls of tub
        translate([Wall,Wall,Wall]){
            roundCube([x-2*Wall,y-2*Wall,2*z],CornerRad);
        }
}
*/
difference(){
    prism(Handle,TotalLength-x,Handle+HandleDiameter);
        translate([Wall,Wall-CornerRad,HandleDiameter]){
            roundCube([Handle-2*Wall,TotalLength-x-2*Wall+CornerRad,2*Handle],CornerRad);
        }
}


//316mm in between wheels
//wheel diameter 250
//120 tall
//Long dimension should be front to back
// total length 450
// caster bolt size 12
// grass height 3"
