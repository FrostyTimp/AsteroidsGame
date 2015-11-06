SpaceShip ship=new SpaceShip();
Star [] space=new Star[200];
public void setup() 
{
  size(500,500);
  for(int starI=0;starI<space.length;starI++)
  {
    space[starI]=new Star((int)(Math.random()*500),(int)(Math.random()*500));
  }
}
public void draw() 
{
  background(0);
  for(int starI=0;starI<space.length;starI++)
  {
    space[starI].show();
  }
  ship.move();
  if(key==' ')
  {
    ship.shoot((int)ship.myCenterX,(int)ship.myCenterY);
  }

  ship.show();
}
void keyPressed()
{
  if(keyCode==UP)
  {
    ship.accelerate(1);
  }
  if(keyCode==DOWN)
  {
    ship.accelerate(-1);
  }
  if(keyCode==RIGHT)
  {
    ship.myPointDirection+=45;
  }
  if(keyCode==LEFT)
  {
    ship.myPointDirection-=45;
  }
  if(keyCode==SHIFT)
  {
    ship.setX((int)(Math.random()*500));
    ship.setY((int)(Math.random()*500));
    ship.myDirectionX=0;
    ship.myDirectionY=0;
    ship.myPointDirection=90;
  }
}
class Star
{
  private int starX;
  private int starY;
  private int starR;
  private int starG;
  private int starB;
  Star(int x, int y)
  {
    starX=x;
    starY=y;
    starR=(int)(Math.random()*256);
    starG=(int)(Math.random()*256);
    starB=(int)(Math.random()*256);
  }
  public void show()
  {
    stroke(starR,starG,starB);
    point(starX,starY);
  }
}
class SpaceShip extends Floater 
{
  public void setX(int x){myCenterX=x;}  
  public int getX(){return (int)myCenterX;}
  public void setY(int y){myCenterY=y;}   
  public int getY(){return (int)myCenterY;}
  public void setDirectionX(double x){myDirectionX=x;}   
  public double getDirectionX(){return myDirectionX;}   
  public void setDirectionY(double y){myDirectionY=y;}   
  public double getDirectionY(){return myDirectionY;}
  public void setPointDirection(int degrees){myPointDirection=degrees;}   
  public double getPointDirection(){return myPointDirection;}
  SpaceShip()
  {
    corners=23;
    int[] xS={-9,-2,-5,-3,-5,-6,-6,-4,0,6,3,14,3,6,0,-4,-6,-6,-5,-3,-5,-2,-9};
    int[] yS={0,3,4,5,7,8,13,9,6,4,3,0,-3,-4,-6,-9,-13,-8,-7,-5,-4,-3,0};
    xCorners=xS;
    yCorners=yS;
    myColor=255;
    myCenterX=250;
    myCenterY=250;
    myDirectionX=0;
    myDirectionY=0;
    myPointDirection=90;
  }
  public void shoot(int bX, int bY)
  {
    int beamX;
    int beamY;
    beamX=bX;
    beamY=bY;
    strokeWeight(5);
    stroke(0,255,0);
    fill(0,255,0);
    if(beamX<500&&beamX>0)
    {
      if(beamY<500&&beamY>0)
      {
        line(beamX,beamY,(float)beamX+50*(float)(Math.cos(myPointDirection*(Math.PI/180))),(float)beamY+50*(float)(Math.sin(myPointDirection*(Math.PI/180))));
        beamX+=5*Math.cos(myPointDirection*(Math.PI/180));
        beamY+=5*Math.sin(myPointDirection*(Math.PI/180));
      }
    }
    println(bX);
  }
}

  abstract class Floater //Do NOT modify the Floater class! Make changes in the SpaceShip class 
{   
  protected int corners;  //the number of corners, a triangular floater has 3   
  protected int[] xCorners;   
  protected int[] yCorners;   
  protected int myColor;   
  protected double myCenterX, myCenterY; //holds center coordinates   
  protected double myDirectionX, myDirectionY; //holds x and y coordinates of the vector for direction of travel   
  protected double myPointDirection; //holds current direction the ship is pointing in degrees    
  abstract public void setX(int x); 
  abstract public int getX();   
  abstract public void setY(int y);   
  abstract public int getY();   
  abstract public void setDirectionX(double x);
  abstract public double getDirectionX();   
  abstract public void setDirectionY(double y);  
  abstract public double getDirectionY();   
  abstract public void setPointDirection(int degrees);
  abstract public double getPointDirection(); 

  //Accelerates the floater in the direction it is pointing (myPointDirection)   
  public void accelerate (double dAmount)   
  {          
    //convert the current direction the floater is pointing to radians    
    double dRadians =myPointDirection*(Math.PI/180);     
    //change coordinates of direction of travel    
    myDirectionX += ((dAmount) * Math.cos(dRadians));    
    myDirectionY += ((dAmount) * Math.sin(dRadians));       
  }   
  public void rotate (int nDegreesOfRotation)   
  {     
    //rotates the floater by a given number of degrees    
    myPointDirection+=nDegreesOfRotation;   
  }   
  public void move ()   //move the floater in the current direction of travel
  {      
    myCenterX += myDirectionX;    
    myCenterY += myDirectionY;     
    if(myCenterX >width)
    {     
      myCenterX=0;
    }    
    else if(myCenterX<0)
    {     
      myCenterX=width;    
    }    
    if(myCenterY >height)
    {    
      myCenterY=0;
    }   
    else if(myCenterY < 0)
    {     
      myCenterY=height;
    }   
  }   
  public void show ()  //Draws the floater at the current position  
  {
    fill(myColor);
    strokeWeight(1);
    stroke(myColor);
    //convert degrees to radians for sin and cos         
    double dRadians = myPointDirection*(Math.PI/180);                 
    int xRotatedTranslated, yRotatedTranslated;    
    beginShape();         
    for(int nI = 0; nI < corners; nI++)    
    {     
      //rotate and translate the coordinates of the floater using current direction 
      xRotatedTranslated = (int)((xCorners[nI]* Math.cos(dRadians)) - (yCorners[nI] * Math.sin(dRadians))+myCenterX);     
      yRotatedTranslated = (int)((xCorners[nI]* Math.sin(dRadians)) + (yCorners[nI] * Math.cos(dRadians))+myCenterY);      
      vertex(xRotatedTranslated,yRotatedTranslated);    
    }   
    endShape(CLOSE);  
  }   
} 

