M2Tap = 1.6;
UNF1_72Tap = 1.5113;
M3Clearance = 3.4;
M8Tap = 6.8;
M8Clearance = 9;
UNF10_32Clearance = 5.61;
CircTol = 0.1;
Tol = 0.2;
x = 260;
y = 280;
//z = 128;
Wall = 7;
CornerRad = 10;
Handle = 125+2*Wall;
HandleD = 30;
HandleClearance = 50;

CasterD = 57;
CasterBoltD = 12;

CasterFrameTopToAxle = 95.5;
CasterWheelD = 123;
CasterOffset = 40; 
CasterH = CasterWheelD/2+CasterFrameTopToAxle;
CasterHole = Wall+CasterOffset+CasterWheelD/2;


BladeH = 76.2;
BladeMotorShaftL = 35.6108;
BladeMotorD = 64.4144+Tol;
BladeMotorShaftHoleD = 19.05+2*Tol;
BladeMotorMountingHoleL = 25.4;//distance from center
BladeMotorL = 4.5*25.4;
BladeL = 25;
WheelD = 250;
WheelMotorD = 25+Tol;
WheelMotorMountingHoleL = 8.5; //distance from center of shaft to center of mounting hole.

TubBottomH = BladeH+BladeMotorShaftL-Wall;

WheelMotorShaftH = WheelD/2-TubBottomH; // height from bottom of tub to center of motor shaft. This comes out to be very close to just setting the motor on the bottom of the tub. So that is what I'm going to do. 
WheelMotorShaftH = Wall+WheelMotorD/2;
WheelMotorL = 65.5; // not including shaft and 
WheelMototShaftHoleD = 7+CircTol+Tol;
BladeDiskD = 190;
BladeMountingHoleR = 85;

CenterWheelMotorShaft = Wall+WheelD/2;

TubBottomFromGround = WheelD/2-Wall-WheelMotorD/2;
TailH = CasterH-TubBottomFromGround+Wall/2;
TailH=CornerRad+3*8;
TailL = CasterHole+CasterD/2+HandleClearance+HandleD/2;
Tailm = (TailH-(HandleD/2))/(0-TailL);
Tailb = TailH-Tailm*0;
TailPrism = -Tailb/Tailm;

z = CasterH-TubBottomFromGround+TailH+Wall/2;

Brickx = 75;
Bricky = 126+108-3;
Brickz = 150;

theta = -atan2(z-WheelMotorD,x-Wall);
circuitBoardHoley = 17.75;
module roundCube(dim=[10,10,10],rad=1){
    translate([rad,rad,rad]){
        minkowski() {
        cube([dim[0]-2*rad,dim[1]-2*rad,dim[2]-2*rad]);
            sphere(r=rad,$fn=100);

        }
    }
}

module flatTopRoundCube(dim=[10,10,10],rad=1){
    translate([rad,rad,0]){
        minkowski() {
        cube([dim[0]-2*rad,dim[1]-2*rad,dim[2]/2]);
            cylinder(r=rad,h=dim[2]/2,$fn=100);

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

module CylinderFillet(Cr,Fr){
    difference(){
    cylinder(r=Cr+Fr,h=Fr,$fn=100);
    translate([0,0,Fr]){
    rotate_extrude(convexity = 10){
    translate([Cr+Fr, 0, 0]){
        circle(r = Fr, $fn = 100);

    }
}
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
//echo(SpokeT);
SmallRad = 1.0*NumSpokes*(WheelD/2-WheelLargeRim-SpokeT/2)/(NumSpokes+PI);
//echo(SmallRad);
WheelSmallRim = (2*SmallRad*PI-NumSpokes*SpokeT)/NumSpokes/2;
WheelMountHoleL = 6.35;

module Wheel(){
intersection(){
difference(){
hull(){
translate([0,0,8]){
cylinder(r=WheelHubR,h=0,center=false);
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
for(index=[0:3]){
    rotate([0,0,index*90]){
translate([WheelMountHoleL,0,0]){
   cylinder(r= M3Clearance/2+CircTol,h=3*Wall,center=true,$fn=100);
}
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


module Tub(){
    
difference(){
union(){
difference(){
    flatTopRoundCube([x,y,z],CornerRad); // outer walls of tub
        translate([Wall,Wall,Wall]){
            roundCube([WheelD/2-WheelMotorD/2-Wall,y-2*Wall,2*z],CornerRad);
        }
        translate([WheelD/2+WheelMotorD/2+2*Wall,Wall,Wall]){
            roundCube([x-WheelD/2-WheelMotorD/2-3*Wall,y-2*Wall,2*z],CornerRad);
        }
        translate([Wall+WheelD/2-WheelMotorD/2,Wall,Wall]){
            cube([WheelMotorD,y-2*Wall,2*z]);
        }
translate([Wall+WheelD/2,0,Wall+WheelMotorD/2]){
            rotate([90,0,0]){
            cylinder(r=WheelMototShaftHoleD/2,h=x*3,center=true,$fn=100);
            }
        }
        translate([Wall+WheelD/2,0,Wall+WheelMotorD/2+WheelMotorMountingHoleL]){
            rotate([90,0,0]){
            cylinder(r=(M3Clearance+Tol)/2+CircTol,h=x*3,center=true,$fn=100);
            }
        } 
        translate([Wall+WheelD/2,0,Wall+WheelMotorD/2-WheelMotorMountingHoleL]){
            rotate([90,0,0]){
            cylinder(r=(M3Clearance+Tol)/2+CircTol,h=x*3,center=true,$fn=100);
            }
        }

            translate([0,-Wall,WheelMotorD]){
                rotate([0,theta,0]){
                    cube([2*x,2*y,2*z]);
                }
            }
    translate([WheelD/4,(y-273-1)/2,Wall ]){               
        cube([0.06*25.4+1,273+1,4.5*25.4]);   
    }            
    }
            translate([Wall+BladeL+BladeDiskD/2,y/2,Wall]){
            cylinder(r=BladeMotorD/2+Wall,h=2*z,$fn=100);
        }
    }
    
        translate([Wall+CornerRad,Wall,WheelMotorD/2+2*Wall]){
            roundCube([x-2*Wall-2*CornerRad,y-2*Wall,2*z],CornerRad);
        }
        translate([Wall+BladeL+BladeDiskD/2,y/2,Wall]){
            cylinder(r=BladeMotorD/2+CircTol,h=2*z,,$fn=100);
        }
        translate([Wall+BladeL+BladeDiskD/2,y/2,Wall]){
            cylinder(r=BladeMotorShaftHoleD/2,h=2*z,center=true,$fn=100);
        }
        translate([Wall+BladeL+BladeDiskD/2+BladeMotorMountingHoleL,y/2,Wall]){
            cylinder(r=(UNF10_32Clearance+Tol)/2+CircTol,h=2*z,center=true,$fn=100);
        }
        translate([Wall+BladeL+BladeDiskD/2-BladeMotorMountingHoleL,y/2,Wall]){
            cylinder(r=(UNF10_32Clearance+Tol)/2+CircTol,h=2*z,center=true,$fn=100);
        } 
        
         translate([x-10,y/2-(Handle/3)/2,CasterH-TubBottomFromGround+CornerRad+2.25*Wall]){
            rotate([0,90,0]){
            cylinder(r=M8Clearance/2+CircTol,h=x,center=false,$fn=100);
            }
        }
         translate([x-10,y/2+(Handle/3)/2,CasterH-TubBottomFromGround+CornerRad+2.25*Wall]){
            rotate([0,90,0]){
            cylinder(r=M8Clearance/2+CircTol,h=x,center=false,$fn=100);
            }
        }
         translate([x-10,y/2-(Handle/3)/2,CasterH-TubBottomFromGround-CornerRad-1.25*Wall]){
            rotate([0,90,0]){
            cylinder(r=M8Clearance/2+CircTol,h=x,center=false,$fn=100);
            }
        }
         translate([x-10,y/2+(Handle/3)/2,CasterH-TubBottomFromGround-CornerRad-1.25*Wall]){
            rotate([0,90,0]){
            cylinder(r=M8Clearance/2+CircTol,h=x,center=false,$fn=100);
            }
        }
        
}
  
}

module BladeDisk(){
    difference(){
union(){
cylinder(r=BladeDiskD/2,h=Wall,$fn=100);
    translate([0,0,Wall]){
        
    cylinder(r=8/2+Wall,h=2*8+10,$fn=100);
    CylinderFillet(8/2+Wall,CornerRad);
        
    }
}
translate([0,0,Wall]){
    cylinder(r=8/2+CircTol,h=2*(2*8+10),$fn=100);
}

translate([0,0,Wall+8]){
    rotate([90,0,0]){
        cylinder(r=UNF1_72Tap/2+CircTol,h=2*(Wall+CornerRad),$fn=100);
    }
}
translate([0,0,Wall+8+10]){
    rotate([90,0,0]){
        cylinder(r=UNF1_72Tap/2+CircTol,h=2*(Wall+CornerRad),$fn=100);
    }
}

translate([BladeMountingHoleR,0,0]){
    cylinder(r=M8Tap/2+CircTol,h=4*Wall,$fn=100,center=true);
}
rotate([0,0,120]){
translate([BladeMountingHoleR,0,0]){
    cylinder(r=M8Tap/2+CircTol,h=4*Wall,$fn=100,center=true);
}
}

rotate([0,0,-120]){
translate([BladeMountingHoleR,0,0]){
    cylinder(r=M8Tap/2+CircTol,h=4*Wall,$fn=100,center=true);
}
}
}
}