/**
 * Class FacebookCircles: calculates the statistics about the friendship circles in facebook data.
 *
 * @author
 *
 * @version 01/12/15 02:03:28
 */
public class FacebookCircles {

  /**
   * Constructor
   * @param numberOfFacebookUsers : the number of users in the sample data.
   * Each user will be represented with an integer id from 0 to numberOfFacebookUsers-1.
   */
	
	 int[] facebookUsers;
	 int[] sizes;
	 int numberOfCircles;
	  
  public FacebookCircles(int numberOfFacebookUsers) {
	  int i = 0;
	  facebookUsers = new int[numberOfFacebookUsers];
	  sizes = new int[numberOfFacebookUsers];
	  while (i != numberOfFacebookUsers)
	  {
		  sizes[i] = 1;
		  facebookUsers[i] = i;
		  i++;
	  }
  }
  
  public int find(int root)
  {
	  	while(facebookUsers[root] != root)
	  	{
	  		facebookUsers[root] = facebookUsers[facebookUsers[root]];
	  		root = facebookUsers[root];
	  	}
	  	return root;
  }

  /**
   * creates a friendship connection between two users, represented by their corresponding integer ids.
   * @param user1 : int id of first user
   * @param user2 : int id of second  user
   */
  public void friends( int user1, int user2 ) {


	    if(facebookUsers == null)
	    {
	    	System.out.println("You have no facebook users.");
	    	return;
	    }
	    int firstRoot = find(user1);
	    int secondRoot = find(user2);
	    if(firstRoot == secondRoot)
	    {
	    	return;
	    }
	    
	    if(sizes[firstRoot] < sizes[secondRoot])
	    {
	    	facebookUsers[firstRoot] = secondRoot;
	    	sizes[secondRoot] += sizes[firstRoot];
	    }
	    else
	    {
	    	facebookUsers[secondRoot] = firstRoot;
	    	sizes[firstRoot] += sizes[secondRoot];
	    }
	    
  }
  
  /**
   * @return the number of friend circles in the data already loaded.
   */
  public int numberOfCircles() {
			int circles = 0;
		    for(int i = 0; i < facebookUsers.length; i ++)
		    {
		    	if(facebookUsers[i] == i)
		    	{
		    		circles++;
		    	}
		    }
		    return circles;
		  }
  
  /**
   * @return the size of the largest circle in the data already loaded.
   */
  public int sizeOfLargestCircle() {
	  int largest = sizes[0];
	    for ( int count = 0; count < sizes.length; count++)
	    {
	    	if (sizes[count] > largest)
	    	{
	    		largest = sizes[count];
	    	}
	    }
	    return largest;
  }

  /**
   * @return the size of the median circle in the data already loaded.
   */
  public int sizeOfAverageCircle() {
	  int total = 0;
	    for ( int i = 0; i < sizes.length; i++)
	    {
	    	if(facebookUsers[i] == i)
	    	{
	    		total += sizes[i];
	    	}
	    }
	    total = total/numberOfCircles();
	    return total;
  }

  /**
   * @return the size of the smallest circle in the data already loaded.
   */
  public int sizeOfSmallestCircle() {
		int smallest = find(0);   
		smallest = sizes[smallest];
		for ( int i = 0; i < sizes.length; i++)
	    {
	    	if(facebookUsers[i] == i)
	    	{
	    		if(sizes[i] < smallest)
	    		{
	    			smallest = sizes[i];
	    		}
	    	}
	    }
		return smallest;
  }


}