///draw_text_outlined_ext(x,y,string,xscale,yscale,angel,incolour,outcolour,outwidth,alpha,fidelity)

var _x = argument[0];
var _y = argument[1];
var _str = argument[2];
var _xscale = argument[3];
var _yscale = argument[4];
var _angle = argument[5];
var _incol = argument[6];
var _outcol = argument[7];
var _outwidth = argument[8];
var _alpha = argument[9];
var _fidelity = argument[10];

for (var i=0; i<360; i+=360/_fidelity)
    draw_text_transformed_colour(_x + lengthdir_x(_outwidth * _xscale, i),
                                 _y + lengthdir_y(_outwidth * _yscale, i),
                                 _str,_xscale,_yscale,_angle,_outcol,_outcol,_outcol,_outcol,_alpha);
                                 
draw_text_transformed_colour(_x,_y,_str,_xscale,_yscale,_angle,_incol,_incol,_incol,_incol,_alpha);
