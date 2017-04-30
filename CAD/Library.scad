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

