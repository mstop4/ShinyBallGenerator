{
//argument0 = sphere
//argument1 = origin x
//argument2 = origin y
//argument3 = origin z
//argument4 = direction x
//argument5 = direction y
//argument6 = direction z

var a, b, c, q, disc, t0, t1, temp;

    // Compute A, B, C
    a = dot_product_3d(argument4,argument5,argument6,argument4,argument5,argument6);
    b = 2 * dot_product_3d(argument4,argument5,argument6,argument1,argument2,argument3);
    c = dot_product_3d(argument1,argument2,argument3,argument1,argument2,argument3) - sqr(argument0.radius);

    // Find discriminant
    
    disc = b*b - 4*a*c;
    
    // if discriminant < 0, ray misses sphere
    
    if (disc < 0)
        return 1000000;
        
    // Compute q
    
    if (b < 0)
        q = (-b - sqrt(disc)) / 2;
    else
        q = (-b + sqrt(disc)) / 2;
        
    // compute t0 and t1
    
    t0 = q / a;
    t1 = c / q;
    
    // make sure t0 is smaller than t1
    
    if (t0 > t1)
    {
        temp = t0;
        t0 = t1;
        t1 = temp;
    }
    
    // if t1 < 0, object is behind ray, miss
    
    if (t1 < 0)
        return 1000000;
    
    // if t0 < 0, the intersection point is at t1
    if (t0 < 0)
        return t1;

    // else the intersection point is at t0
    else
        return t0;
}
