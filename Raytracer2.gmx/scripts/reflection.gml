///reflection(pX,pY,pZ,pewX,pewY,pewZ,sphere_index)
    var fR = 0;
    var fG = 0;
    var fB = 0;
    var fdR = 0;
    var fdG = 0;
    var fdB = 0;
    var sR = 0;
    var sG = 0;
    var sB = 0;
    var rR = 0;
    var rG = 0;
    var rB = 0;
    var r_a;
    
    r_a[0] = 0;
    r_a[1] = 0;
    r_a[2] = 0;
    
    //compute ray
    var pewRayX = argument3;
    var pewRayY = argument4;
    var pewRayZ = argument5;
    
    //normalize ray
    var vl = point_distance_3d(0,0,0,pewRayX,pewRayY,pewRayZ);
    
    pewRayX /= vl;
    pewRayY /= vl;
    pewRayZ /= vl;
    
    //cast ray and find intersection
    var t = 1000000;
    var target = -1;
    var ttemp = 0;
    
    for (var k=0; k<numObj; k++)
    {       
        if (k == argument6)
            continue;
    
        ttemp = raySphereIntersect(ball[k],(argument0-ball[k].posX),
                                        (argument1-ball[k].posY),
                                        (argument2-ball[k].posZ),
                                        pewRayX,pewRayY,pewRayZ);
                                        
        if (ttemp < t)
        {
            t = ttemp;
            target = k;
            fdR = ball[k].mat_diffuse_r;
            fdG = ball[k].mat_diffuse_g;
            fdB = ball[k].mat_diffuse_b;
        }
    }    
    
    // if hit
    if (t < 1000000)
    {
        //ambient
        if (ambientOn)
        {
            fR = light.mat_ambient_r;
            fG = light.mat_ambient_g;
            fB = light.mat_ambient_b;
        }
        
        // find point of intersection
        var pX = argument0 + pewRayX * t;
        var pY = argument1 + pewRayY * t;
        var pZ = argument2 + pewRayZ * t;
        
        //find light
        var lRayDirX = light.lookAtX;
        var lRayDirY = light.lookAtY;
        var lRayDirZ = light.lookAtZ;
        
        vl = point_distance_3d(0,0,0,lRayDirX,lRayDirY,lRayDirZ);
        lRayDirX /= vl;
        lRayDirY /= vl;
        lRayDirZ /= vl;
            
        // find normal
        var nX = pX - ball[target].posX;
        var nY = pY - ball[target].posY;
        var nZ = pZ - ball[target].posZ;
        
        vl = point_distance_3d(0,0,0,nX,nY,nZ);
        nX /= vl;
        nY /= vl;
        nZ /= vl;
        
        // find reflected ray
        var ldn = dot_product_3d(lRayDirX,lRayDirY,lRayDirZ,nX,nY,nZ);
        
        var rX = lRayDirX - 2 * ldn * nX;
        var rY = lRayDirY - 2 * ldn * nY;
        var rZ = lRayDirZ - 2 * ldn * nZ;
        
        vl = point_distance_3d(0,0,0,rX,rY,rZ);
        rX /= vl;
        rY /= vl;
        rZ /= vl;
        
        var in_shadow = false;
        
        //find shadow
        if (shadowsOn)
        {
            for (var k=0; k<numObj; k++)
            {
                if (k == target)
                    continue;
                    
                ttemp = raySphereIntersect(ball[k],pX-ball[k].posX,pY-ball[k].posY,pZ-ball[k].posZ,
                                                lRayDirX,lRayDirY,lRayDirZ);
                if (ttemp < 1000000)
                {
                    in_shadow = true;
                    break;
                }
            }
        }
        
        if (!in_shadow)
        {
            if (diffuseOn)
            {    
                // find diffuse
                var ndl = dot_product_3d(nX,nY,nZ,lRayDirX,lRayDirY,lRayDirZ);
                
                if (ndl > 0)
                {
                    fR += light.mat_diffuse_r * power(ndl,5);
                    fG += light.mat_diffuse_g * power(ndl,5);
                    fB += light.mat_diffuse_b * power(ndl,5);
                }
            }
            
           if (specularOn)
           {       
                //find specular
                
                var vdr = dot_product_3d(pewRayX,pewRayY,pewRayZ,rX,rY,rZ);
                
                if (vdr > 0 && t < 1000000)
                {
                    sR = light.mat_specular_r * power(vdr,25);
                    sG = light.mat_specular_g * power(vdr,25);
                    sB = light.mat_specular_b * power(vdr,25);
                }
            }
        }

        fR = min(1,fR*fdR+sR);
        fG = min(1,fG*fdG+sG);
        fB = min(1,fB*fdB+sB);
        
        r_a[0] = fR;
        r_a[1] = fG;
        r_a[2] = fB;
    }
return r_a;
