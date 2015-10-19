class Visualizer
{
  int hertz;
  String averageAge;
  boolean canHear;
  float line1;
  boolean firstRun;
  boolean displayAge = false;
  boolean displayControls = false;
  int quaterSize;
  WaveformRenderer waveform;
  
  int xspacing = 1;   // How far apart should each horizontal location be spaced
  int w=width+16;;              // Width of entire wave
  
  float theta = 0.0;  // Start angle at 0
  float amplitude = 75.0;  // Height of wave
  float period = 400.0;  // How many pixels before the wave repeats
  float dx=(TWO_PI / period) * xspacing;  // Value for incrementing X, a function of period and xspacing
  float[] yvalues=new float[w/xspacing];  // Using an array to store height values for the wave
  
  Visualizer()
  {
    line1 = height / 2;
    quaterSize = (width / 4);
    waveform = new WaveformRenderer();
  }
  
  //Visualizer
  void animation()
  {
    fractalDraw();
    
    waveform.draw();
    
    stroke(0, 255, 0);
    
    w = width+16;
    dx = (TWO_PI / period) * xspacing;
    yvalues = new float[w/xspacing];
    
    println(period);
    
    switch(times)
    {
      case 1:
        question(8000,"Every human can hear this!");
        break;
      case 2:
        question(12000,"Over 50");
        break;
      case 3:
        question(15000,"Over 40");
        break;
      case 4:
        question(16000,"Over 30");
        break;
      case 5:
        question(17000,"Over 24");
        break;
      case 6:
        question(18000,"Over 22");
        break;
      case 7:
        question(19000,"Over 20");
        break;
    }
    
    controls();
  }
  
  void controls()
  {
    pushStyle();
    
    textAlign(LEFT);
    noStroke();
    
    if(displayControls)
    {
      fill(255, 255, 255, 100);
      rect(0,height - height/10,width*.60,height);
      fill(255);
      
      textSize(height/40);
      text("Help: H",width/200, height - height/40);
      textSize(height/20);
      text("Yes: Y",width/10, height - height/40);
      text("No: N",width/10 * 2, height - height/40);
      text("Reset: R",width/10 * 4, height - height/40);
    }
    else
    {
      textSize(height/40);
      fill(255);
      text("Help: H",width/200, height - height/40);
    }
    
    popStyle();
    
  }
  
  void overlay()
  {
    pushStyle();
    
    popStyle();
  }
  
  // wave = new Oscil... etc.
  void playFrequency(int times)
  {
    //wave.reset();
    
      switch(times) 
      {
      
        case 1:
        
        frequencies[6].removeListener( waveform );
        frequencies[5].removeListener( waveform );
        frequencies[4].removeListener( waveform );
        frequencies[3].removeListener( waveform );
        frequencies[2].removeListener( waveform );
        frequencies[1].removeListener( waveform );
        frequencies[0].removeListener( waveform );
          frequencies[6].pause();
          frequencies[5].pause();
          frequencies[4].pause();
          frequencies[3].pause();
          frequencies[2].pause();
          frequencies[1].pause();
          frequencies[0].loop();
          frequencies[0].addListener( waveform );

        break;
        case 2:
       
         frequencies[0].removeListener( waveform );
         frequencies[0].pause();
          frequencies[1].loop();
          frequencies[1].addListener( waveform );
        break;
        
        case 3:
       
        frequencies[1].removeListener( waveform ); 
         frequencies[1].pause();
          frequencies[2].loop();
          frequencies[2].addListener( waveform );
        break;
        
        case 4:
        
         frequencies[2].removeListener( waveform );
         frequencies[2].pause();
          frequencies[3].loop();
          frequencies[3].addListener( waveform );
        break;
        
        case 5:
       
        frequencies[3].removeListener( waveform ); 
         frequencies[3].pause();
          frequencies[4].loop();
          frequencies[4].addListener( waveform );
        break;
        
        case 6:
      
          visualizer.period -= 60;
        
      frequencies[4].removeListener( waveform );  
        frequencies[4].pause();
          frequencies[5].loop();
          frequencies[5].addListener( waveform );
        break;
        
        case 7:
        
      frequencies[5].removeListener( waveform );  
        frequencies[5].pause();
          frequencies[6].loop();
          frequencies[6].addListener( waveform );
        break;
  }    
  
}
  
  //Ask person if they can hear frequency, display average age, continue to next visualizer if true
  void question(int hertz, String age)
  {
    this.averageAge = age;
    textAlign(CENTER);
    textSize(width/16);
    stroke(255);
    text("Can you hear "+hertz+"Hz?", width/2, height/4);
    if(displayAge)
    {
      text(averageAge, width/2, (height/4)*3);
      textSize(width/32);
      text("Press R to reset.", width/2, (height*0.85));
      text("Press F for hearing facts.", width/2, (height*0.95));
    }
  }
  
  void facts()
  {
    pushStyle();
    textAlign(LEFT);
    fill(0);
    textSize(width/40);
    
    background(255);
    switch(displayFacts)
    {
      case 1:
      {
        facts1.resize(width, height);
        image(facts1, 0, 0);
        text("Press ENTER to continue", 10, height/15);
        break;
      }
      
      case 2:
      {
        facts2.resize(width, height);
        image(facts2, 0, 0);
        text("Press R to reset", 10, height/15);
        break;
      }
    }
    
    popStyle();
  }
  
  int nBranches = 6;
  float startingLength = 290;
  float phasor = 0.0;
  float rate = 0.0005;
  color bg = color(0, 8);
   
  PVector getVCoordinates(PVector v, float d, float a) {
    return new PVector(v.x + d * cos(a), v.y + d * sin(a));
  }
  
  void fractalDraw() 
  {
    pushStyle();
    smooth();
    strokeWeight(5);
    fill(bg);
    noStroke();
    rect(0, 0, width, height);
   
    float sine = sin(phasor * TWO_PI);
    float angle = map(sine, -1.0, 1.0, -HALF_PI, HALF_PI);
    float divPoint = map(sine, -1.0, 1.0, 1.0, 0.5);
     
    for (int i = 0; i < nBranches; i++) {
      float L = startingLength;
      float a = TWO_PI / (float) nBranches * (float) i;
      PVector v1 = new PVector(width / 2, height / 2);
      PVector v2 = getVCoordinates(v1, L, a);
       
      while (L > 2) {
        stroke(0, 0, 255, 32);
        L *= 0.95;
         
        line(v1.x, v1.y, v2.x, v2.y);
        a += angle;
       
        v1.x = lerp(v1.x, v2.x, divPoint);
        v1.y = lerp(v1.y, v2.y, divPoint);
         
        v2 = getVCoordinates(v1, L, a);
      }
    }
   
    phasor += rate;
    if (phasor >= 1.0) {
      phasor -= 1.0;
    }
    popStyle();
  }


void removeListeners()
{
        frequencies[6].removeListener( waveform );
        frequencies[5].removeListener( waveform );
        frequencies[4].removeListener( waveform );
        frequencies[3].removeListener( waveform );
        frequencies[2].removeListener( waveform );
        frequencies[1].removeListener( waveform );
        frequencies[0].removeListener( waveform );
        frequencies[6].pause();
        frequencies[5].pause();
        frequencies[4].pause();
        frequencies[3].pause();
        frequencies[2].pause();
        frequencies[1].pause();
        frequencies[0].pause();
}
}