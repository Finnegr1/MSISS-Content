import java.util.Arrays;

/**
 * CS2010 (Hilary Term) - Assignment 1
 *
 * Nine Digit Perfect Square
 *
 * A natural number, p, is a perfect square if for some natural number k, k^2=p.
 * For example, 16 is a perfect square, as 4^2=16. The number 20 is not a
 * perfect square as there is no natural number k such that k^2=20.
 *
 * Problem: Develop an algorithm that will find all nine-digit perfect squares
 * that use all nine digits exactly once. For example, 139,854,276 is a solution
 * (the first) as 11,826^2=139,854,276.
 *
 * 1) Fill in the implementation of the methods described in this file.
 *
 * 2) Test your implementation by developing suitable test suite in the
 * NineDigitPerfectSquareTest JUnit test case.
 *
 * @author: 
 *
 */

public class NineDigitPerfectSquare {

    /**
     * A method to return an array containing all squeres between low and high
     *
     * @param low: lowest perfect square
     * @param high: largest perfect square
     *
     * @return an array containing all the perfect squares between low and high
     */
    public int[] perfectSquaresBetween(int low, int high){
    	
    	int min = (int) Math.ceil(Math.sqrt(low));
    	int max =  (int)Math.floor(Math.sqrt(high));
    	
    	int arrayLength =((max-min)+1);
    	int[] perfectSquares = new int[arrayLength];
    	
    	for(int i=min,j=0; i <= max; i++, j++){
    		perfectSquares[j] = i*i;
    	}
    	
    

       return perfectSquares;
    }

    public int countNineDigitPerfectSquares(){
        return getNineDigitPerfectSquares().length;
    }

    /**
     * A method to determine if the number specified in parameter "number"
     * contains all 9 digits exactly once.
     *
     * @param number
     *            : A number to be tested
     * @return whether the number contains all 9 digits exactly once
     */
    public boolean containsAllDigitsOnce(int number) {
    	boolean[] allDigits = new boolean[9];
    	Arrays.fill(allDigits, Boolean.FALSE);
    	boolean check = true;
    	for(int digit = 1; (digit<=9)&&check==true; digit++){
    		int remainder = number%10;
    		number = (int) Math.floor(number/10);
    		if(remainder==0){
    			check = false;
    		}else if(allDigits[remainder-1]==true){
    			check = false;
    		}else{
    			allDigits[remainder-1]=true;
    		}
    	}
    	return check;
    	
    }


    /**
     * A method to return an array containing all the squares discovered
     *
     * @return an array containing all of the perfect squares which
     * contain all digits 1..9 exactly once.
     */
    public int[] getNineDigitPerfectSquares() {
    	int[] uniqueNineDigitPS = new int[0];
    	int[] nineDigitPS = perfectSquaresBetween(123456789,987654321);
    	for(int i=0; i<nineDigitPS.length; i++){
    		if(containsAllDigitsOnce(nineDigitPS[i])== true){
    			int temp[] = new int[uniqueNineDigitPS.length+1];
    			for(int j=0; j<uniqueNineDigitPS.length; j++){
    				temp[j] = uniqueNineDigitPS[j];
    			}
    			uniqueNineDigitPS = temp;
    			uniqueNineDigitPS[uniqueNineDigitPS.length-1] = nineDigitPS[i];
    		}
    	}
    	
        return uniqueNineDigitPS;

    }
}