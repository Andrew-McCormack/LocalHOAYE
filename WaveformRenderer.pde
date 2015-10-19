class WaveformRenderer implements AudioListener
{
  private float[] left;
  private float[] right;
  private int quaterSize;
  
  WaveformRenderer()
  {
    left = null; 
    right = null;
    quaterSize = width / 4;
  }
  
  synchronized void samples(float[] samp)
  {
    left = samp;
  }
  
  synchronized void samples(float[] sampL, float[] sampR)
  {
    left = sampL;
    right = sampR;
  }
  
  synchronized void draw()
  {
      noFill();
      stroke(0, 255, 0);
      
    
      beginShape();
      for ( int i = quaterSize; i < right.length - quaterSize; i+= 5 )
      {
        vertex(i, height/2 + right[i]*50);
      }
      endShape();
    
  }
}