
float l1 = 12;  //length of l1
float l2 = 9.7; //length of l2

float l1_scaled = 0;
float l2_scaled = 0;

float l_total;



int width = 650;
int height = 650;

int centerX = width/2;
int centerY = height/2;

int circle_diameter = (width - 75);



float angle;

void setup() {
  size(650,650);
  background(0);
  
  l_total = l1+l2;
  l1_scaled = (circle_diameter/2)*(l1/l_total);
  l2_scaled = (circle_diameter/2)*(l2/l_total);
  
  
}

void draw() {
  background(255,106,0);
  stroke(255);
  
 
  noFill();
  ellipse(centerX, centerY,circle_diameter,circle_diameter);
  line((width/2), 0, (width/2), height); 
  line(0, (height/2), width, (height/2));
  
  float s_ang, a_ang;
  
  float ret_vals[] = new float[2];
  float x1y1_vals[] = new float[2];
  ret_vals = mouseXY_2_unitXY();
  s_ang = calc_shoulder_ang(ret_vals[0], ret_vals[1]);
 
  x1y1_vals = draw_shoulder(s_ang, l1_scaled);
  
  
  
  a_ang = calc_arm_ang(ret_vals[0], ret_vals[1]);
  draw_arm(x1y1_vals[0], x1y1_vals[1], a_ang, l2_scaled, s_ang); 
  
  text("END EFFECTOR XY", 35,85);
  text("X = " + ret_vals[0], 50,100);
  text("Y = " + ret_vals[1], 50,120);
  
  text("S = " + s_ang + "degrees",50,(height-50) );
  text("E = " + a_ang + "degrees",50,(height-30) );
  
  
}

float calc_shoulder_ang (float x, float y){
  float shoulder_angle, yx_div, q_ang;
  yx_div = (float)y/x;
  q_ang = acos( (x*x + y*y + (l1_scaled*l1_scaled) - (l2_scaled*l2_scaled)) / ((2*l1_scaled)*sqrt(x*x + y*y)) );
  
  shoulder_angle = degrees(atan(yx_div) -q_ang);
  
  return shoulder_angle;
  
}

float[] draw_shoulder(float ang, float l1_scaled){
  float angle = radians(ang);
  float[] xy_vals= new float[2];
  float x,y;
  
  x = cos(angle) * l2_scaled;
  y = sin(angle) * l2_scaled;
 
  line(centerX, centerY, (centerX + x), (centerY -y) ); //-y due to x-y co-ord system
  
  
  xy_vals[0] = centerX + x  ;
  xy_vals[1] = centerY -y;
  return xy_vals;
  
}

float calc_arm_ang (float x, float y) {
  float arm_angle;
  arm_angle = degrees( acos( (x*x + y*y -(l1_scaled*l1_scaled) -(l2_scaled*l2_scaled)) / (2*l1_scaled*l2_scaled) ) );
  
  return arm_angle;
  
  
  
}

float draw_arm(float xpos, float ypos, float a_ang, float l, float shoulder_ang){
  float arm_angle = radians(shoulder_ang + a_ang);
  float x,y;
  x = cos(arm_angle) * l2_scaled;
  y = sin(arm_angle) * l2_scaled;
  line(xpos, ypos, (xpos +x), (ypos - y)); //-y due to x-y co-ord system
  
  
  return angle;
  
}


void draw_line(float xpos, float ypos, float ang, float l){
  float angle = radians(ang);
  float x,y;
  x = cos(angle) * 100;
  y = sin(angle) * 100;
  line(xpos, ypos, (xpos +x), (ypos - y)); //-y due to x-y co-ord system
 
  
}







void draw_all(int effector_x, int effector_y) {
  
    
}

float[] mouseXY_2_unitXY(){
  float[] coords= new float[2];
  coords[0] = mouseX - (width/2);
  coords[1] = (height/2) - mouseY;
  return coords;
  
}
  