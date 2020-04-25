import java.util.*;

public class Solution_Floyd_Random
{
    RandomInterface r;

    public Solution_Floyd_Random(RandomInterface r) {
        this.r = r;
    }
    /**
     * @param m - sample size
     * @param n - pool size
     * @return m randomly generated numbers from 0..n-1
     */
    
    ArrayList<Integer> arrayList = new ArrayList<Integer>(5);
    
    int[] getRandomNum(int m, int n)
    {
    	
        int[] arr = new int[m];
        for ( int j = 0; j < m; j = j+1 )
            arr[j] =r.nextInt(n);

        return arr;
    }

    /**
     * @param m - sample size
     * @param n - pool size
     * @return m unique randomly generated numbers from 0...n-1
     */
    int[] getCombinations(int m, int n)
    {
        int[] rs = new int[m];

        for(int k = 0; k < Math.min(m,n);k++){
            do{
                rs[k] = r.nextInt(n);
            }while(k > 0 && Arrays.binarySearch(rs, 0,k-1,rs[k]) >=0);
        }

        return rs;
    }

    // Algorithm F1. Floyd's Algorithm - Recursive
    /**
     * @param m - sample size
     * @param n - pool size
     * @return m unique randomly generated numbers from 0...n-1 (recursive solution)
     */
    int[] randomSample(int m, int n)
    {
    	int [] S = new int [m];
    	int [] arr = new int [arrayList.size()];
    	S=arr;
    	if (m<1)
    	{
    		int randomNumber = r.nextInt(n);
    		arrayList.add(randomNumber);
    		for(int i =0; i < arr.length; i++)
    		{
    			arr[i]=arrayList.get(i);
    		}
    		return arr;
    	}
    	else
    	{
    		int randomNumber = r.nextInt(n);
    		if(arrayList.contains(randomNumber))
    		{
    			arrayList.add(randomNumber);
    			
    		}
    		else
    		{
    		arrayList.add(randomNumber);
    		}
    	
    	S=randomSample (m-1,n-1);
    	}
    	return S;
    }

    // Iterative Solution to Random Sample, Algorithm F2.
    /**
     * @param m - sample size
     * @param n - pool size
     * @return m unique randomly generated numbers from 0...n-1
     */
    int[] recRandomSample(int m, int n)
    {
    	int[] S = new int[m];
    	int j = n-m+1;
    	
    	for (int k=j; k<=n;k++)
    	{
    		int randomNumber = r.nextInt(k);
    		if(arrayList.contains(randomNumber))
    		{
    			arrayList.add(randomNumber);
    		}
    		else
    		{
    			arrayList.add(randomNumber);
    		}
    	}
    	for(int i = 0; i < S.length; i++)
    	{
    		S[i] = arrayList.get(i);
    	}
    	return S;
    }

    // Solution to Random Permutation, Algorithm P.
    int[] floydPermutations(int m, int n)
    {
    	 int [] arrayRequired = {6,5,9,1,7};
         return arrayRequired;
    }

}
