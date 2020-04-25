import static org.junit.Assert.assertEquals;

import org.junit.Test;
import org.junit.Ignore;
import org.junit.runner.RunWith;
import org.junit.runners.JUnit4;

import java.io.File;
import java.util.Arrays;

//-------------------------------------------------------------------------
/**
 *  Test class for Collinear.java
 *
 *  @author  
 *  @version 03/10/16 17:10:35
 */
@RunWith(JUnit4.class)
public class CollinearTest
{
    //~ Constructor ........................................................
    @Test
    public void testConstructor()
    {
      new Collinear();
    }

    //~ Public Methods ........................................................

    // ----------------------------------------------------------
    /**
     * Check that the two methods work for empty arrays
     */
    @Test
    public void testEmpty()
    {
        int expectedResult = 0;

        assertEquals("countCollinear failed with 3 empty arrays",       expectedResult, Collinear.countCollinear(new int[0], new int[0], new int[0]));
        assertEquals("countCollinearFast failed with 3 empty arrays", expectedResult, Collinear.countCollinearFast(new int[0], new int[0], new int[0]));
        
    }

    // ----------------------------------------------------------
    /**
     * Check for no false positives in a single-element array
     */
    @Test
    public void testSingleFalse()
    {
        int[] a3 = { 15 };
        int[] a2 = { 5 };
        int[] a1 = { 10 };

        int expectedResult = 0;

        assertEquals("countCollinear({10}, {5}, {15})",       expectedResult, Collinear.countCollinear(a1, a2, a3) );
        assertEquals("countCollinearFast({10}, {5}, {15})", expectedResult, Collinear.countCollinearFast(a1, a2, a3) );
    }

    // ----------------------------------------------------------
    /**
     * Check for no false positives in a single-element array
     */
    @Test
    public void testSingleTrue()
    {
        int[] a3 = { 15, 5 };       int[] a2 = { 5 };       int[] a1 = { 10, 15, 5 };

        int expectedResult = 1;

        assertEquals("countCollinear(" + Arrays.toString(a1) + "," + Arrays.toString(a2) + "," + Arrays.toString(a3) + ")",     expectedResult, Collinear.countCollinear(a1, a2, a3));
        assertEquals("countCollinearFast(" + Arrays.toString(a1) + "," + Arrays.toString(a2) + "," + Arrays.toString(a3) + ")", expectedResult, Collinear.countCollinearFast(a1, a2, a3));
    }
    

    // TODO: add more tests here. Each line of code and each decision in Collinear.java should
    // be executed at least once from at least one test.

    // ----------------------------------------------------------
    
    //Check that a value can be found in a sorted array with the binary search method
     @Test
     public void binaryFind(){
     	int[] a1 = {6,22,56,82,104};
     	int search = 6;
     	boolean expectedResult = true;
     	
     	assertEquals(expectedResult, Collinear.binarySearch(a1, search));
     }
     
     //Checking for a element in an unsorted array in the lower half of the array 
     @Test
     public void binaryFindLowerWithSort(){
     	int[] a1 = {22,56,82,83,6};
     	Collinear.sort(a1);
     	int search = 6;
     	boolean expectedResult = true;
     	
     	assertEquals(expectedResult, Collinear.binarySearch(a1, search));
     }
     
     //Checking for an element in an unsorted array in the upper half of the array
     @Test
     public void binaryFindHigherWithSort(){
     	int[] a1 = {22,56,82,83,6};
     	Collinear.sort(a1);
     	int search = 82;
     	boolean expectedResult = true;
     	
     	assertEquals(expectedResult, Collinear.binarySearch(a1, search));
     }
     
    /**
     *  Main Method.
     *  Use this main method to create the experiments needed to answer the experimental performance questions of this assignment.
     *
     *  You should read the lecture notes and/or book to understand how to correctly implement the main methods.
     *  You can use any of the provided classes to read from files, and time your code.
     *
     */
     public static void main(String[] args)
     {	
    	int[] a1 = new int[1000]; int[] a2=new int [1000]; int[] a3 = new int[1000]; 
    	int[] a4 = new int[2000]; int[] a5=new int [2000]; int[] a6 = new int[2000]; 
    	int[] a7 = new int[4000]; int[] a8=new int [4000]; int[] a9 = new int[4000];
    	int[] a10 = new int[5000]; int[] a11=new int [5000]; int[] a12 = new int[5000];
    	 
    	File file = new File("src/r01000-1.txt");
    	In filereader = new In(file);
    	a1 = filereader.readAllInts();
    	filereader.close();
    	
    	File file2 = new File("src/r01000-2.txt");
    	In filereader2 = new In(file2);
    	a2 = filereader2.readAllInts();
    	filereader2.close();
    	
    	File file3 = new File("src/r01000-3.txt");
    	In filereader3 = new In(file3);
    	a3 = filereader3.readAllInts();
    	filereader3.close();
    	
    	File file4 = new File("src/r02000-1.txt");
    	In filereader4 = new In(file4);
    	a4 = filereader4.readAllInts();
    	filereader4.close();
    	
    	File file5 = new File("src/r02000-2.txt");
    	In filereader5 = new In(file5);
    	a5 = filereader5.readAllInts();
    	filereader5.close();
    	
    	File file6 = new File("src/r02000-3.txt");
    	In filereader6 = new In(file6);
    	a6 = filereader6.readAllInts();
    	filereader6.close();
    	
    	File file7 = new File("src/r04000-1.txt");
    	In filereader7 = new In(file7);
    	a7 = filereader7.readAllInts();
    	filereader7.close();
    	
    	File file8 = new File("src/r04000-2.txt");
    	In filereader8 = new In(file8);
    	a8 = filereader8.readAllInts();
    	filereader8.close();
    	
    	File file9 = new File("src/r04000-3.txt");
    	In filereader9 = new In(file9);
    	a9 = filereader9.readAllInts();
    	filereader9.close();
    	
    	File file10 = new File("src/r05000-1.txt");
    	In filereader10 = new In(file10);
    	a10 = filereader10.readAllInts();
    	filereader10.close();
    	
    	File file11 = new File("src/r05000-2.txt");
    	In filereader11 = new In(file11);
    	a11 = filereader11.readAllInts();
    	filereader11.close();
    	
    	File file12 = new File("src/r05000-3.txt");
    	In filereader12 = new In(file12);
    	a12 = filereader12.readAllInts();
    	filereader12.close();
    
    
    
    	StdOut.println("ARRAY SIZE - 1000");
    	Stopwatch stopwatch = new Stopwatch();
    	StdOut.println("STANDARD COUNT\n" + Collinear.countCollinear(a1,a2,a3));
    	double time = stopwatch.elapsedTime();
    	StdOut.println("elapsed time " + time);
    	
    	Stopwatch stopwatch2 = new Stopwatch();
    	StdOut.println("FAST COUNT\n" + Collinear.countCollinearFast(a1, a2, a3));
    	double time2 = stopwatch2.elapsedTime();
    	StdOut.println("elapsed time "+time2);
    	
    	
    	StdOut.println("\nARRAY SIZE - 2000");
    	Stopwatch stopwatch3 = new Stopwatch();
    	StdOut.println("STANDARD COUNT\n" + Collinear.countCollinear(a4,a5,a6));
    	double time3 = stopwatch3.elapsedTime();
    	StdOut.println("elapsed time " + time3);
    	
    	Stopwatch stopwatch4 = new Stopwatch();
    	StdOut.println("FAST COUNT\n" + Collinear.countCollinearFast(a4, a5, a6));
    	double time4 = stopwatch4.elapsedTime();
    	StdOut.println("elapsed time "+time4);
    	
    	
    	StdOut.println("\nARRAY SIZE - 4000");
    	Stopwatch stopwatch5 = new Stopwatch();
    	StdOut.println("STANDARD COUNT\n" + Collinear.countCollinear(a7,a8,a9));
    	double time5 = stopwatch5.elapsedTime();
    	StdOut.println("elapsed time " + time5);
    	
    	Stopwatch stopwatch6 = new Stopwatch();
    	StdOut.println("FAST COUNT\n" + Collinear.countCollinearFast(a7, a8, a9));
    	double time6 = stopwatch6.elapsedTime();
    	StdOut.println("elapsed time "+time6);
    	
    	StdOut.println("\nARRAY SIZE - 5000");
    	Stopwatch stopwatch7 = new Stopwatch();
    	StdOut.println("STANDARD COUNT\n" + Collinear.countCollinear(a10,a11,a12));
    	double time7 = stopwatch7.elapsedTime();
    	StdOut.println("elapsed time " + time7);
    	
    	Stopwatch stopwatch8 = new Stopwatch();
    	StdOut.println("FAST COUNT\n" + Collinear.countCollinearFast(a10, a11, a12));
    	double time8 = stopwatch8.elapsedTime();
    	StdOut.println("elapsed time "+time8);
    	
    	
    	
    	
    	
     }

}
