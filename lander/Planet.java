class Planet {

    private double gravity; /* units: (m/s/s) */
    private double ground;  /* units: m */
    private String name;

    /* constructors and accessors go here--you are to complete them */
       
    public Planet() {

	gravity = 9.8/6;
	ground = 0.0;
	name = "Moon";
	
	} // boring planet

    
    public Planet(double _gravity, double _ground, String _name)
    {
    	gravity = _gravity;
    	ground = _ground;
    	name = _name;
    }


    public double getGravity()
    {
    	return gravity;
    }


    public double getGround()
    {
    	return ground;
    }


    public String getName()
    {
    	return name;
    }
}
