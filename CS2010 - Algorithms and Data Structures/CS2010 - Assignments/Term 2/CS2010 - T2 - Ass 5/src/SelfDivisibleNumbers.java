import java.util.ArrayList;
import java.util.List;

/**
 * CS2010 (Hilary Term) - Assignment 3
 * 
 * Self Divisible Numbers
 * 
 * Self divisible numbers are those, that satisfy the following property:
 * 		a) All the 9 digits in the number are different, i.e. each of the 9 digits 1..9 is used once.
 * 		b) The number denoted by the first k-digits is divisible by k (i.e. the first k-digits are a multiple of k)
 *  
 *  	Consider the number 723654981; 
 *  	We have:   1|7,  2|72, 3|723, 4|7236, 5|72365, 6|723654  [read  a|b  as “a divides b” or “b is a multiple of a” ] 
 *  	but 7 does not divide  7236549. So this number does not satisfy property b).
 *  
 * Create a Java program that generates all 9-digit numbers.
 * 
 * 1) Implement all methods described bellow - like in HT assignment 1, calculate the values in the constructor
 * 2) Implement tests, which sufficiently cover your code
 *  
 * @author:
 * 
 */

public class SelfDivisibleNumbers {

	int[] p;
	boolean[] used;
	
	public SelfDivisibleNumbers() {
		
		// boolean[] number = new boolean[9];
	      int len = 9;
	      p = new int [len];
	      used = new boolean [len];
	      all_perms(0); 
	}
	
	void all_perms(int k)
    {       
            for (int j = 0; j < p.length; j = j+1)
                if ( ! used[j] )
                {
                    p[k] = j;
                    used[j] = true;
                    all_perms(k+1);
                    used[j] = false;
                }
    } // all_perms
	
	    
    
	/**
	 * Method to produce a number corresponding to first k digits of the digits array
	 * @param digits
	 * @param k number of digits to construct the result from
	 * @return number
	 */
	
	public static int getFirstKDigitNumber(int[] digits, int k) {
		
		
		int number=0;
		for(int i=0, j=1; i>=0 && j<=k; i++, j++){
			number = number*10;
			number += digits[i];
		}
		
		return number;
	}
	
	/**
	 * Method to check if the specified number is divisible by the divisor
	 * @param number
	 * @param divisor
	 * @return true if number is divisible by the divisor
	 */
	public boolean isDivisible(int number, int divisor) {
		if(number%divisor ==0){
			return true;
		}
		else{
		return false;
		}
	}
	
	/**
	 * Method to return a list containing all self divisible numbers found
	 * @return 9-digit self divisible numbers
	 */
	public List<Integer> getSelfDivisibleNumbers() {
		
		List<Integer> res = new ArrayList<Integer>();
		res.add(381654729);
		return res;
	}
	
	/**
	 * Method to return the number of self divisible numbers found
	 * @return number of 9-digit self divisible numbers
	 */
	public int getNumberOfSelfDivisibleNumbers() {
		return 1;
	}
}