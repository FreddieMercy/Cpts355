/*
 * Copyright (c) 1995, 1996 Sun Microsystems, Inc. All Rights Reserved.
 *
 * Permission to use, copy, modify, and distribute this software
 * and its documentation for NON-COMMERCIAL purposes and without
 * fee is hereby granted provided that this copyright notice
 * appears in all copies. Please refer to the file "copyright.html"
 * for further important copyright and licensing information.
 *
 * SUN MAKES NO REPRESENTATIONS OR WARRANTIES ABOUT THE SUITABILITY OF
 * THE SOFTWARE, EITHER EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED
 * TO THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
 * PARTICULAR PURPOSE, OR NON-INFRINGEMENT. SUN SHALL NOT BE LIABLE FOR
 * ANY DAMAGES SUFFERED BY LICENSEE AS A RESULT OF USING, MODIFYING OR
 * DISTRIBUTING THIS SOFTWARE OR ITS DERIVATIVES.
 */
import java.awt.*;
import java.applet.Applet;

/*
 * This applet animates graphics that it generates. This example eliminates
 * flashing by overriding the update() method. For the graphics this example
 * generates, overriding update() isn't quite good enough -- on some systems,
 * you can still see a crawling effect.
 */

public class GameApplet extends Applet implements Runnable {
    int frameNumber = -1; 
    int delay; 
    Thread animatorThread; 
    boolean updirection = false; 
    boolean reachedSurface = false; 
    boolean landed = true;
    String landedMessage = "Safely on the ground"; 
    String crashedMessage = "Reduced to a rubble of bits"; 
    Image myImage;  
    Image myImageLander; 
    Image myImageLanderB; 
    Image myImageLanderCrashed; 
    Image myImageLanderLanded; 
    Rocket rk; 
    private double burn = 0.0; 
    private static final double noBurn = 0.0;
    private static final double fullBurn = 1.0; 

    int squareSize = 20; 
    boolean fillColumnTop = true; 

    public void init() {
        // Initialize the rocket and planet
        String str;
        int fps = 10;
        delay = 0;
        /* make a planet named Pluto with gravity 0.3 and surface 0.0 */
        Planet pluto = new Planet(0.3, 0.0, "Pluto"); // Change this to correct constructor

   
        myImage = getImage(getCodeBase(), "lunarSurface.gif");
        myImageLander = getImage(getCodeBase(), "apolloLander.gif");
        myImageLanderB = getImage(getCodeBase(), "apolloLanderBurn.gif");
        myImageLanderCrashed = getImage(getCodeBase(), "apolloLanderCrash.gif");
        myImageLanderLanded = getImage(getCodeBase(), "apolloLanderLanded.gif");
        // How many milliseconds between frames?
        str = getParameter("fps");
        try {
            if (str != null) {
                fps = Integer.parseInt(str);
            }
        } catch (Exception e) {
        }
        /* calculate the inter-frame time (in milliseconds) */
        delay = (fps > 0) ? (1000 / fps) : 100;

        // How many pixels wide is each square?
        str = getParameter("squareWidth");
        try {
            if (str != null) {
                squareSize = Integer.parseInt(str);
            }
        } catch (Exception e) {
        }
        
        setSize(640,500);
        /* create a rocket */
        rk = new Rocket(2.0,20.0,pluto);
    }

    public void start() {
        // Start animating!
        if (animatorThread == null) {
            animatorThread = new Thread(this);
        }
        animatorThread.start();
    }

    public void stop() {
        // Stop the animating thread.
        animatorThread = null;
    }

    public void run() {

        Thread.currentThread().setPriority(Thread.MIN_PRIORITY);

        long startTime = System.currentTimeMillis();
.
        while (Thread.currentThread() == animatorThread) {
   
            try {
  
            	rk.move(delay * 0.001, burn);
            } catch (RocketException e) {
                
            	if (rk.getHeight() <= 0)
            	{
            		reachedSurface = true;
            		if (rk.getVelocity() <= rk.getSafeVelocity())
            			landed = false;
            	}
                
            	repaint();
            }

            repaint();

            
            try {
                startTime += delay;
                Thread.sleep(Math.max(0, startTime - System.currentTimeMillis()));
            } catch (InterruptedException e) {
            
            	if (rk.getHeight() <= 0)
            	{
            		reachedSurface = true;
            		if (rk.getVelocity() <= rk.getSafeVelocity())
            			landed = true;
            	}
       
            	repaint();
                break;
            }
        }
    }

    public void paint(Graphics g) {
        update(g);
    }

    public void update(Graphics g) {
        g.setColor(Color.white);
        if (reachedSurface) {
            g.drawImage(myImage, 0, 0, this);
          
            if (landed)
            {
                g.drawImage(myImageLanderLanded, 300, 350 - (int) rk.getHeight(), this);
                g.drawString(landedMessage, 50, 50);
            }
  
            else
            {
                g.drawImage(myImageLanderCrashed, 300, 350 - (int) rk.getHeight(), this);
                g.drawString(crashedMessage, 50, 50);
            }
            stop();
        } else {
            g.drawImage(myImage, 0, 0, this);
            if (updirection)
                g.drawImage(myImageLanderB, 300, 355 - (int) rk.getHeight(),
                        this);
            else
                g.drawImage(myImageLander, 300, 355 - (int) rk.getHeight(),
                        this);
        }
        g.drawString(rk.getState(), 10, 20);
    }
    
    
    public boolean mouseDown(Event e, int x, int y)
    {
    	burn = fullBurn;
    	return true;
    }
    
    
    public boolean mouseUp(Event e, int x, int y)
    {
    	burn = noBurn;
    	return true;
    }
}
