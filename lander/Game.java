import java.io.*;
import java.nio.file.Files;
import java.nio.file.OpenOption;
import java.nio.file.StandardOpenOption;
import java.util.ArrayList;

class Game {

    private static final boolean debug = false;

    private static final String debugFile = "output.txt";

    private static final double noBurn = 0.0;

    private static final double fullBurn = 1.0;

    private static final double deltaTime = 0.5;

    private static void play(Rocket rocket) throws RocketException /* needs throws clause */{
    	BufferedReader inputReader = new BufferedReader(new InputStreamReader(System.in));
        while (true) {
            /* read input and decide whether to burn or not */
        	double burn = noBurn;
        	try
        	{
        		boolean inputGood = false;

        		while (inputGood == false)
        		{
	        		String inputString = inputReader.readLine();
	        		if (inputString.length() > 0)
	        		{
	            		char[] input = inputString.toCharArray();

	            		if (input[0] == 'b')
	            		{
	            			print("b ");
	            			burn = fullBurn;
	            			inputGood = true;
	            		}
	        		}

	        		else
	        			inputGood = true;
        		}
        	}
        	catch (IOException e) {
				e.printStackTrace();
        	}

            rocket.move(deltaTime, burn); 
            
            print(rocket.getHeightString());
        }

    }

    public static void main(String[] args) throws RocketException 
    {
        /* create a planet with gravity 0.3 and surface at 0.0 */
        Planet pluto = new Planet(0.3, 0.0, "Pluto");
        /* create a rocket with engine strength 2.0, 20.0 units of fuel */
        Rocket rocket = new Rocket(2.0, 20.0, pluto);
        rocket.setHeight(50.0);
        play(rocket); 
    }
    
    
    public static void print(String temp)
    {
    	System.out.println(temp);

    	if (debug)
    	{
    		try {
				PrintWriter output = new PrintWriter(new BufferedWriter(new FileWriter(debugFile,true)));
				output.println(temp);
				output.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
    	}
    }

} // end of Game class
