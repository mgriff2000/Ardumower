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



module roundCube(dim=[10,10,10],rad=1){
    translate([rad,rad,rad]){
        minkowski() {
        cube([dim[0]-2*rad,dim[1]-2*rad,dim[2]-2*rad]);
            sphere(r=rad,$fn=100);

        }
    }
}

module prism(l, w, h){
   polyhedron(
           points=[[0,0,0], [l,0,0], [l,w,0], [0,w,0], [0,w,h], [l,w,h]],
           faces=[[0,1,2,3],[5,4,3,2],[0,4,5,1],[0,3,4],[5,2,1]]
           );
}
   
module roundPrism(l,w,h,rad){
    translate([rad,rad,rad]){
        minkowski() {
        prism(l-2*rad,w-2*rad,h-2*rad);
            sphere(r=rad,$fn=100);

        }
    }
}

module Tail(){
    
    translate([0,-(TailPrism-TailL),0]){
        difference(){
            prism(Handle,TailPrism,TailH);
            
            translate([Wall,0,Wall/2]){// scoop out the middle
                roundCube([Handle-2*Wall,TailPrism-Wall,TailH+Wall],CornerRad);
            }
            translate([Handle/3,0,TailH-(TailH-Wall/2-CornerRad)/2]){//poke mounting hole
                rotate([90,0,0]){
                    cylinder(r=9/2,h=1000,center=true,$fn=100);
                }
            }

            translate([2*Handle/3,0,TailH-(TailH-Wall/2-CornerRad)/2]){//poke another mounting hole
                rotate([90,0,0]){
                    cylinder(r=9/2,h=1000,center=true,$fn=100);
                }
            }  
            
            translate([-1,-1,-1]){// snip the end off
                cube([Handle*2,TailPrism-TailL,TailH]);
            }
            translate([Wall,0,-1]){// blow out the Handle Clearance
                cube([Handle-2*Wall,TailPrism-TailL+HandleD/2+HandleClearance,TailH]);
            }
            translate([Handle/2,TailPrism-TailL+HandleD/2+HandleClearance+CasterD/2,0]){//drill caster bolt hole
                cylinder(r=CasterBoltD/2,h=2*TailH,center=true,$fn=100);
            }
        }
    }
    
}

//Wheel

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

NumSpokes = 24;
WheelHubR = 19/2+8;
SpokeT = 2*WheelHubR*PI/NumSpokes;
WheelLargeRim = (WheelD*PI-SpokeT*NumSpokes)/NumSpokes/2;
echo(SpokeT);
SmallRad = 1.0*NumSpokes*(WheelD/2-WheelLargeRim-SpokeT/2)/(NumSpokes+PI);
echo(SmallRad);
WheelSmallRim = (2*SmallRad*PI-NumSpokes*SpokeT)/NumSpokes/2;

module Wheel(){
intersection(){
difference(){
hull(){
translate([0,0,8]){
cylinder(r=WheelHubR,h=8,center=false);
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
}
