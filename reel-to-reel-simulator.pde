import beads.*;
import controlP5.*;

AudioContext ac;
SamplePlayer music, button, stop;
ControlP5 p5;

Glide gainGlide, rateGlide;
Gain masterGain;

double sampleLength;
Bead endListener;

void setup() {
  size(200, 350);
  ac = new AudioContext();
  p5 = new ControlP5(this);
  
  try {
    music = new SamplePlayer(ac, SampleManager.sample(dataPath(("intermission.wav"))));
    sampleLength = music.getSample().getLength();
    
    endListener = new Bead() {
      protected void messageReceived(Bead message) {
        try {
          stop = new SamplePlayer(ac, SampleManager.sample(dataPath(("button.wav"))));
          ac.out.addInput(stop);
          stop.start();
          
          music.setEndListener(null);
        } catch (Exception e) {
          println("Problem loading stop sample.");
          e.printStackTrace();
        }
      }
    };
    
    music.setEndListener(endListener);

  } catch (Exception e) {
    println("Problem loading sample.");
    e.printStackTrace();
    exit();
  }
  
  gainGlide = new Glide(ac, 0.5, 500);
  rateGlide = new Glide(ac, 0, 500);
  masterGain = new Gain(ac, 1, gainGlide);
  
  music.setRate(rateGlide);
  
  masterGain.addInput(music);
  ac.out.addInput(masterGain);
 
  p5.addSlider("gainSlider")
    .setPosition(150, 60)
    .setSize(25, 240)
    .setRange(0, 100)
    .setValue(50)
    .setLabel("Gain");
    
  p5.addButton("play")
    .setPosition(30, 60)
    .setSize(100, 40)
    .setLabel("Play")
    .onClick(new CallbackListener() {
      public void controlEvent(CallbackEvent event) {
        play();
      }
    });
    
  p5.addButton("stop")
    .setPosition(30, 110)
    .setSize(100, 40)
    .setLabel("Stop")
    .onClick(new CallbackListener() {
      public void controlEvent(CallbackEvent event) {
        stop();
      }
    });
    
  p5.addButton("fastForward")
    .setPosition(30, 160)
    .setSize(100, 40)
    .setLabel("Fast Forward")
    .onClick(new CallbackListener() {
      public void controlEvent(CallbackEvent event) {
        fastForward();
      }
    });
    
  p5.addButton("rewind")
    .setPosition(30, 210)
    .setSize(100, 40)
    .setLabel("Rewind")
    .onClick(new CallbackListener() {
      public void controlEvent(CallbackEvent event) {
        rewind();
      }
    });
    
  p5.addButton("reset")
    .setPosition(30, 260)
    .setSize(100, 40)
    .setLabel("Reset")
    .onClick(new CallbackListener() {
      public void controlEvent(CallbackEvent event) {
        reset();
      }
    });
    
  ac.start();
}

void play() {
  correctOutOfBounds();
  println(music.getPosition());
  playButtonSound();
  
  music.setEndListener(endListener);
  
  rateGlide.setValue(1);
}

void stop() {
  playButtonSound();
  rateGlide.setValue(0);
}

void fastForward() {
  correctOutOfBounds();
  playButtonSound();
  rateGlide.setValue(4); 

  music.setEndListener(endListener);
}

void rewind() {
  correctOutOfBounds();
  playButtonSound();
  rateGlide.setValue(-4);
  
  music.setEndListener(endListener);
}

void reset() {
  playButtonSound();
  music.setPosition(0);
  rateGlide.setValue(0);
}

void gainSlider(int value) {
  gainGlide.setValue(value / 100.0);
}

void playButtonSound() {
  try {
    button = new SamplePlayer(ac, SampleManager.sample(dataPath(("button.wav"))));
    ac.out.addInput(button);
    button.start();
  } catch (Exception e) {
    println("Problem loading sample.");
    e.printStackTrace();
    exit();
  }
}

void correctOutOfBounds() {
  if (music.getPosition() < 0) {
    music.reset();
  } else if (music.getPosition() >= music.getSample().getLength()) {
    music.setPosition(music.getSample().getLength());
  }
}

void draw() {
  background(0);
}
