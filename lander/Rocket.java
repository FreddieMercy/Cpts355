import java.text.DecimalFormat;

class Rocket {
    static final RocketException crashed = new RocketException(
            "Crashed and Burned");
    static final RocketException landed = new RocketException("Safely Landed");
    private double velocity = 0.0; // default to 0
    private double height = 50.0; // default to 50.0
    private Planet planet;
    private static final double safeVelocity = -1.0; // Land within this
                                                       // velocity
    private double fuel = 0.0;
    private double engineStrength = 0.0;

    public Rocket(double es, double fu, Planet moon)
    {
    	engineStrength = es;
    	fuel = fu;
    	planet = moon;
    }
    

    public double getHeight()
    {
    	return height;
    }

   public double getVelocity()
    {
    	return velocity;
    }

    public String getState()
    {
    	DecimalFormat format = new DecimalFormat("#0.0");
    	return "HEIGHT " + format.format(height) + " VELOCITY " + format.format(velocity) + " FUEL " + format.format(fuel);
    }

    private boolean reachedSurface() {
 
    	if (height > planet.getGround())
	{
    		return false;
	}
    	return true;
    }

    private boolean landed()
    {
	if (velocity <= safeVelocity)
	{
		return true;
	}    	
	return false;
    }

   private void nextFuel(double burnRate, double deltaTime)
   {
    	fuel -= burnRate * deltaTime;
   }

    public void move(double dt, double burnRate) throws RocketException 
    {

        if (!reachedSurface()) 
	{
        	double actualBurn = burnRate;
        	if (fuel < burnRate * dt)
		{
        		actualBurn = fuel / burnRate;
        	}

        	velocity += ((engineStrength * burnRate) - planet.getGravity()) * dt;

        	nextFuel(actualBurn, dt);
        	nextHeight(dt);
        }
    }

    private void nextHeight(double deltaTime) throws RocketException {
        height += velocity * deltaTime;
        if (reachedSurface()) {
            if (landed()) {
                throw crashed;
            } else {
                throw landed;
            }
        }
    }
	
    public double getSafeVelocity()
    {
    	return safeVelocity;
    }

    private void nextVelocity(double burnRate, double deltaTime) 
    {
        velocity += ((engineStrength * burnRate) - planet.getGravity()) * deltaTime;
    }

    public String getHeightString() {
        double maxHeight = (height > 60.0) ? height : 60.0;
        double belowGround = planet.getGround() - 10.0;
        int size = (int) (maxHeight - belowGround) + 1;
        char[] buffer = new char[size];
        DecimalFormat df = new DecimalFormat(" ###.##");

        int groundPosition = (int) (planet.getGround() - belowGround);

        for (int i = 0; i < size; i++)
            buffer[i] = ' ';
        int adjustedPosition = (int) (height - belowGround);
        adjustedPosition = (adjustedPosition <= 0) ? 0 : adjustedPosition;
        buffer[groundPosition] = '|';
        buffer[adjustedPosition] = '*';
        return (new String(buffer) + " " + df.format(velocity));
    }

    public void setHeight(double newH)
    {
    	height = newH;
    }
}
