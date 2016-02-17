var vl = point_distance_3d(pos_x,pos_y,pos_z,lookAt_x,lookAt_y,lookAt_z);

viewVec_x = (lookAt_x - pos_x) / vl;
viewVec_y = (lookAt_y - pos_y) / vl;
viewVec_z = (lookAt_z - pos_z) / vl;
