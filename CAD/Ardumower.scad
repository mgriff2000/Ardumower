include <Library.scad>;

//cube([290,275,250]);// print area
//cylinder(8,95,center=false); //cutting disk

//Tub();



translate([0,0,TubBottomFromGround]){
  color("LawnGreen"){  
Tub();
  }
  
    
    translate([WheelD/4,(y-273)/2,Wall ]){               
        cube([0.06*25.4,273,4.5*25.4]);   
    }
    
    translate([x-Wall-CornerRad/2-Brickx,(y-Bricky)/2,Wall]){
        cube([Brickx,Bricky,Brickz]);

    }
    
    translate([Wall+BladeL+BladeDiskD/2,y/2,Wall]){
cylinder(r=BladeMotorD/2,h = BladeMotorL);
}
}
color("LawnGreen"){
translate([Wall+BladeL+BladeDiskD/2,y/2,TubBottomFromGround-Wall-BladeMotorShaftL]){
BladeDisk();
}

translate([x+(TailL),y/2-(Handle)/2,CasterH+Wall/2]){
rotate([0,0,90]){
    difference(){
union(){
    Tail();
    mirror([0,0,1]){
        Tail();
    }

}
translate([10,10,0]){
    rotate([0,90,0]){
        cylinder(r=M8Clearance/2,h=3*Handle,center=true);
    }
}
}
}
}




translate([WheelD/2+Wall,0,WheelD/2]){
    rotate([90,0,0]){
Wheel();
    }
}

translate([WheelD/2+Wall,y+Wall,WheelD/2]){
    rotate([90,0,0]){
Wheel();
    }
}
}

translate([x+CasterHole,y/2,0]){
    cylinder(r=CasterD/2,h=CasterH);
    translate([-CasterOffset,0,CasterWheelD/2]){
    sphere(r=CasterWheelD/2);
    }
}

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


