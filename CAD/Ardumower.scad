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
difference(){
    cube([x,y,z]); // outer walls of tub
        translate([Wall,Wall,Wall]){
            roundCube([x-2*Wall,y-2*Wall,2*z],CornerRad);
        }
}
*/


/*
union(){
    Tail();
    mirror([0,0,1]){
        Tail();
    }
    rotate([0,90,0]){
        cylinder(r=HandleD/2,h=Handle,center=false);
    }
}
*/

/*
translate([Handle/2,HandleD/2+HandleClearance+CasterD/2,0]){
    %cylinder(r=CasterD/2,h=200,center=true);
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


//76.2mm from blade to ground
// blade motor shaft extends 35.6108 from mounting face. 
BladeH = 76.2;
BladeMotorShaftL = 35.6108;
BladeMotorD = 64.4144;
WheelD = 250;
WheelMotorD = 25;
WheelMotorMountingHoleL = 8.5; //distance from center of shaft to center of mounting hole.

TubBottomH = BladeH+BladeMotorShaftL-Wall;

WheelMotorShaftH = WheelD/2-TubBottomH; // height from bottom of tub to center of motor shaft. This comes out to be very close to just setting the motor on the bottom of the tub. So that is what I'm going to do. 
WheelMotorShaftH = Wall+WheelMotorD/2;
WheelMotorL = 65.5; // not including shaft and 

// motor set screw should be M2 10mm long?


NumSpokes = 24;
WheelHubR = 19/2+8;
SpokeT = 2*WheelHubR*PI/NumSpokes;
WheelLargeRim = (WheelD*PI-SpokeT*NumSpokes)/NumSpokes/2;
echo(SpokeT);
SmallRad = 1.0*NumSpokes*(WheelD/2-WheelLargeRim-SpokeT/2)/(NumSpokes+PI);
echo(SmallRad);
WheelSmallRim = (2*SmallRad*PI-NumSpokes*SpokeT)/NumSpokes/2;

intersection(){
difference(){
hull(){
translate([0,0,8]){
cylinder(r=WheelHubR,h=40,center=false);
}
cylinder(r=WheelD/2,h=Wall,center=false);
}

for(index=[0:NumSpokes]){
    translate([WheelD/2*cos(index*360/NumSpokes+360/NumSpokes/2),WheelD/2*sin(index*360/NumSpokes+360/NumSpokes/2),Wall/2]){
        cylinder(r=WheelLargeRim,h=100,center=true);
    }
    translate([SmallRad*cos(index*360/NumSpokes+360/NumSpokes/2),SmallRad*sin(index*360/NumSpokes+360/NumSpokes/2),Wall/2]){
        cylinder(r=WheelSmallRim,h=100,center=true);
    }
}
}

union(){
translate([0,0,Wall/2]){
    for(index=[0:NumSpokes/2]){
        rotate(index*360/NumSpokes){
cube([SpokeT,WheelD,100],center=true);
        }
            }
}

difference(){
    cylinder(r=WheelD/2,h=100,center=true);
    cylinder(r=SmallRad,h=100,center=true);
}
}
}




