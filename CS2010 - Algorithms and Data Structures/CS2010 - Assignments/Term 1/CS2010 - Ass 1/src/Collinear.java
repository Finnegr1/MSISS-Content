// -------------------------------------------------------------------------
/**
 *  This class contains only two static methods that search for points on the
 *  same line in three arrays of integers. 
 *
 *  @author  
 *  @version 03/10/16 17:10:35
 */
class Collinear
{

   // ----------------------------------------------------------
    /**
     * Counts for the number of non-hoizontal lines that go through 3 points in arrays a1, a2, a3.
     * This method is static, thus it can be called as Collinear.countCollinear(a1,a2,a3)
     * @param a1: An UNSORTED array of integers. Each integer a1[i] represents the point (a1[i], 1) on the plain.
     * @param a2: An UNSORTED array of integers. Each integer a2[i] represents the point (a2[i], 2) on the plain.
     * @param a3: An UNSORTED array of integers. Each integer a3[i] represents the point (a3[i], 3) on the plain.
     * @return the number of points which are collinear and do not lie on a horizontal line.
     *
     * Array a1, a2 and a3 contain points on the horizontal line y=1, y=2 and y=3, respectively.
     * A non-horizontal line will have to cross all three of these lines. Thus
     * we are looking for 3 points, each in a1, a2, a3 which lie on the same
     * line.
     *
     * Three points (x1, y1), (x2, y2), (x3, y3) are collinear (i.e., they are on the same line) if
     * 
     * x1(y2−y3)+x2(y3−y1)+x3(y1−y2)=0 
     *
     * In our case y1=1, y2=2, y3=3.
     *
     * You should implement this using a BRUTE FORCE approach (check all possible combinations of numbers from a1, a2, a3)
     *
     * ----------------------------------------------------------
     *
     * Experimental Performance:
     * -------------------------
     *  Write the running time of the algorithm when run with the following input sizes
     *  
     *  Input Size N      Running Time (sec)
     *  ------------------------------------
     *  1000              1.814
     *  2000              13.959
     *  4000              84.325
     *
     *  Assuming that the running time of your algorithm is of the form aN^b,
     *  estimate 'b' and 'a' by fitting a line to the experimental points:
     *
     *  b = -8.032
     *  a = 2.769
     *
     *  What running time do you predict using your results for input size 5000?
     *  What is the actual running time you get with such an input?
     *  What is the error in percentage?
     *
     *  Error = ( (Actual time) - (Predicted time) ) * 100 / (Predicted time)
     *
     *  Input Size N      Predicted Running Time (sec)        Actual Running Time (sec)       Error (%)
     *  ------------------------------------------------------------------------------------------------
     *  5000              162.3483735                         166.998                         2.86%
     * 
     *  Approximate Mathematical Performance:
     *  -------------------------
     *
     *  Using an appropriate cost model, give the performance of your algorithm.
     *  Explain your answer.
     *
     *  Performance:	(1/2)*N^3  
     *
     *  Explanation: Using tilde notation we have:
     *  			 3 array accesses, each with a cost of approximately (1/6)*N^3. Added together they equal (1/2)*N^3.
     */
    static int countCollinear(int[] a1, int[] a2, int[] a3)
    {
    	int count = 0;
		int y1 = 1;
		int y2 = 2;
		int y3 = 3;

		for (int i = 0; i <= a1.length - 1; i++) {
			for (int j = 0; j <= a2.length - 1; j++) {
				for (int k = 0; k <= a3.length - 1; k++) {
					if (a1[i] * (y2 - y3) + a2[j] * (y3 - y1) + a3[k] * (y1 - y2) == 0) {
						count++;
					}

				}
			}
		}
		return count;
    }

    // ----------------------------------------------------------
    /**
     * Counts for the number of non-hoizontal lines that go through 3 points in arrays a1, a2, a3.
     * This method is static, thus it can be called as Collinear.countCollinearFast(a1,a2,a3)
     * @param a1: An UNSORTED array of integers. Each integer a1[i] represents the point (a1[i], 1) on the plain.
     * @param a2: An UNSORTED array of integers. Each integer a2[i] represents the point (a2[i], 2) on the plain.
     * @param a3: An UNSORTED array of integers. Each integer a3[i] represents the point (a3[i], 3) on the plain.
     * @return the number of points which are collinear and do not lie on a horizontal line.
     *
     * In this implementation you should make non-trivial use of InsertionSort and Binary Search.
     * The performance of this method should be much better than that of the above method.
     *
     * Experimental Performance:
     * -------------------------
     *  Measure the running time of the algorithm when run with the following input sizes
     *  
     *  Input Size N      Running Time (sec)
     *  ------------------------------------
     *  1000              0.234
     *  2000              0.942
     *  4000              3.355
     *  5000              6.305/
     *  
     *
     *
     *  Compare Implementations:
     *  ------------------------
     *  Show the sppedup achieved by this method, using the times you got from your experiments.
     *
     *  Input Size N      Speedup = (time of countCollinear)/(time of countCollinearFast)
     *  --------------------------------------------------------------------------------
     *  1000              8.17
     *  2000              15.82
     *  4000              24.94
     *  5000              26.02
     *
     *
     *  Approximate Mathematical Performance:
     *  -------------------------------------
     *
     *  Using an appropriate cost model, give the performance of your algorithm.
     *  Explain your answer.
     *
     *  Performance: (N^2)*(logN)
     *
     *  Explanation: The insertion sort method will contribute the N^2 and the binary search costs N*logN.
     *
     *
     */
    static int countCollinearFast(int[] a1, int[] a2, int[] a3)
    {
		int count = 0;
		int y1 = 1;
		int y2 = 2;
		int y3 = 3;
		sort(a3);
		for (int x1 = 0; x1 < a1.length; x1++) {
			for (int x2 = 0; x2 < a2.length; x2++) {
				int test = a1[x1] * (y2 - y3) + a2[x2] * (y3 - y1);
				int search = -1*(test / (y1 - y2)); /* Separating the x3 value [(a3[k] * (y1 - y2)], multiplying by -1
														as y1-y2 will return negative*/
				
				if (Collinear.binarySearch(a3, search))
				{
					count++;
				}

			}
		}
		return count;
    	
    }
    // ----------------------------------------------------------
    /**
     * Sorts an array of integers according to InsertionSort.
     * This method is static, thus it can be called as Collinear.sort(a)
     * @param a: An UNSORTED array of integers. 
     * @return after the method returns, the array must be in ascending sorted order.
     *
     * ----------------------------------------------------------
     *
     * Approximate Mathematical Performance:
     * -------------------------------------
     *  Using an appropriate cost model, give the performance of your algorithm.
     *  Explain your answer.
     *
     *  Performance: N^2
     *
     *  Explanation: The inner loop contains two array accesses each contributing (1/2)*N^2.
     *
     */
    static void sort(int[] a)
    {
    	for (int j = 1; j < a.length; j++) {
			int i = j - 1;
			while (i >= 0 && a[i] > a[i + 1]) {
				int temp = a[i];
				a[i] = a[i+1];
				a[i+1] = temp;
				i--;

			}
    	}
    }

    // ----------------------------------------------------------
    /**
     * Searches for an integer inside an array of integers.
     * This method is static, thus it can be called as Collinear.binarySearch(a,x)
     * @param a: A array of integers SORTED in ascending order.
     * @param x: An integer.
     * @return true if 'x' is contained in 'a'; false otherwise.
     *
     * ----------------------------------------------------------
     *
     * Approximate Mathematical Performance:
     * -------------------------------------
     *  Using an appropriate cost model, give the performance of your algorithm.
     *  Explain your answer.
     *
     *  Performance: logN + 1 
     *
     *  Explanation: On each iteration of the while loop, the array is split in half. This will end up
     *  			 resulting in (at most) the loop repeating T(N/N)+(N)*(1) times. This is the same as logN+1.
     *
     */
    static boolean binarySearch(int[] a, int x)
    {
    	int lo = 0;
		int hi = a.length - 1;
		while (lo <= hi)
		{
			int mid = lo + (hi - lo) / 2;
			if (x < a[mid]) {
				hi = mid - 1;
			} else if (x > a[mid]) {
				lo = mid + 1;
			} else {
				return true;
			}
		}

		return false;
	
    }

}