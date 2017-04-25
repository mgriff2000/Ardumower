



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