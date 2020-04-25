public class CheckTriangle
{


    public static final int ACUTE_TRI = 2;
    public static final int RIGHT_ANGLED_TRI = 1;
    public static final int OBTUSE_TRI = 3;
    public static final double TINY_DIFF = 0.0001;
    public static final int NOT_TRI = 0;

    public static boolean form_triangle(double[] ls)
    {
    double a = ls[0];
    double b = ls[1];
    double c = ls[2];
     
    double[] tri = {a,b,c};
    double max = max(tri);
    double sum = sum(tri);
    
    if(2*max<sum){
    	return true;
    }
    else {
			return false;
		 }
	}
    
    public static int kind_triangle(double[] ls)
    {
    	if(form_triangle(ls)==false){
        return NOT_TRI;
    	}
    	else{
    		double a = ls[0];
    	    double b = ls[1];
    	    double c = ls[2];
    	    
    	    double lhs = c*c-((a*a)+(b*b));
    	    double rhs = -2*a*b;
    	    double cosAngle = lhs/rhs;
    	    
    	    if(cosAngle == 0){
    	    	return RIGHT_ANGLED_TRI;
    	    }
    	    else if(cosAngle>0){
    	    	return ACUTE_TRI;
    	    }
    	    else{
    	    	return OBTUSE_TRI;
    	    }
    	    
    	}
    }	
    //calculate the sum of arr
    public static double sum(double[] arr)
    {	
    	double sum = 0;
    	for(int i=0; i<=arr.length-1; i++){
        sum+=arr[i];
    	}
        return sum;
    }

	//returns the maximum element of arr
    public static double max(double[] arr)
    {
        double tempMax = 0;
        tempMax = arr[0];
        if(arr[1]>tempMax){
        	tempMax = arr[1];
        }
        if(arr[2]>tempMax){
        	tempMax = arr[2];
        }
        double realMax = tempMax;
        return realMax;
 
    }

    //returns the minimum element of arr
    public static double min(double[] arr)
    {
    	double min;
    	min = arr[0];
    	for(int i=1; i<=arr.length-1; i++){
        if(arr[i]<min){
        	min = arr[i];
        }
    }
    	return min;
    }
}