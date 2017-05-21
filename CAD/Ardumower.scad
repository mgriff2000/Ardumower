include <Library.scad>;

//cube([290,275,250]);// print area
//cylinder(8,95,center=false); //cutting disk

// Tub
CircTol = 0.2;
Tol = 0.2;
x = 280;
y = 260;
z = 128;
Wall = 8;
CornerRad = 12.5;
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

BladeH = 76.2;
BladeMotorShaftL = 35.6108;
BladeMotorD = 64.4144;
BladeMotorShaftHoleD = 19.05;
BladeMotorMountingHoleL = 25.4;//distance from center
WheelD = 250;
WheelMotorD = 25;
WheelMotorMountingHoleL = 8.5; //distance from center of shaft to center of mounting hole.

TubBottomH = BladeH+BladeMotorShaftL-Wall;

WheelMotorShaftH = WheelD/2-TubBottomH; // height from bottom of tub to center of motor shaft. This comes out to be very close to just setting the motor on the bottom of the tub. So that is what I'm going to do. 
WheelMotorShaftH = Wall+WheelMotorD/2;
WheelMotorL = 65.5; // not including shaft and 
WheelMototShaftHoleD = 7+CircTol+Tol;
BladeL = 13.1;
BladeDiskD = 190;
CenterWheelMotorShaft = Wall+WheelD/2;
    
//Tub();

//BladeDisk();


union(){
    Tail();
    mirror([0,0,1]){
        Tail();
    }
    rotate([0,90,0]){
        cylinder(r=HandleD/2,h=Handle,center=false);
    }
}


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

// motor set screw should be M2 10mm long?


//Wheel();




