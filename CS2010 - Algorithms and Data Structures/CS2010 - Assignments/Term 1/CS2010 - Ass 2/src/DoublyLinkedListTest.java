import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertTrue;
import static org.junit.Assert.assertNull;

import org.junit.Test;
import org.junit.Ignore;
import org.junit.runner.RunWith;
import org.junit.runners.JUnit4;

//-------------------------------------------------------------------------
/**
 *  Test class for Doubly Linked List
 *
 *  @author  
 *  @version 13/10/16 18:15
 */
@RunWith(JUnit4.class)
public class DoublyLinkedListTest
{
    //~ Constructor ........................................................
    @Test
    public void testConstructor()
    {
      new DoublyLinkedList<Integer>();
    }

    //~ Public Methods ........................................................

    // ----------------------------------------------------------
    /**
     * Check if the insertBefore works
     */
    @Test
    public void testInsertBefore()
    {
        // test non-empty list
        DoublyLinkedList<Integer> testDLL = new DoublyLinkedList<Integer>();
        testDLL.insertBefore(0,1);
        
        testDLL.insertBefore(1,2);
        testDLL.insertBefore(2,3);

        testDLL.insertBefore(0,4);
        assertEquals( "Checking insertBefore to a list containing 3 elements at position 0", "4,1,2,3", testDLL.toString() );
        testDLL.insertBefore(1,5);
        assertEquals( "Checking insertBefore to a list containing 4 elements at position 1", "4,5,1,2,3", testDLL.toString() );
        testDLL.insertBefore(2,6);       
        assertEquals( "Checking insertBefore to a list containing 5 elements at position 2", "4,5,6,1,2,3", testDLL.toString() );
        testDLL.insertBefore(-1,7);        
        assertEquals( "Checking insertBefore to a list containing 6 elements at position -1 - expected the element at the head of the list", "7,4,5,6,1,2,3", testDLL.toString() );
        testDLL.insertBefore(7,8);        
        assertEquals( "Checking insertBefore to a list containing 7 elemenets at position 8 - expected the element at the tail of the list", "7,4,5,6,1,2,3,8", testDLL.toString() );
        testDLL.insertBefore(700,9);        
        assertEquals( "Checking insertBefore to a list containing 8 elements at position 700 - expected the element at the tail of the list", "7,4,5,6,1,2,3,8,9", testDLL.toString() );

        // test empty list
        testDLL = new DoublyLinkedList<Integer>();
        testDLL.insertBefore(0,1);        
        assertEquals( "Checking insertBefore to an empty list at position 0 - expected the element at the head of the list", "1", testDLL.toString() );
        testDLL = new DoublyLinkedList<Integer>();
        testDLL.insertBefore(10,1);        
        assertEquals( "Checking insertBefore to an empty list at position 10 - expected the element at the head of the list", "1", testDLL.toString() );
        testDLL = new DoublyLinkedList<Integer>();
        testDLL.insertBefore(-10,1);        
        assertEquals( "Checking insertBefore to an empty list at position -10 - expected the element at the head of the list", "1", testDLL.toString() );
     }

    // TODO: add more tests here. Each line of code in DoublyLinkedList.java should
    // be executed at least once from at least one test.
    
   //@Test
   //public void testIsEmpty(){
	 //  DoublyLinkedList<Integer> testDLL = new DoublyLinkedList<Integer>();
	   //boolean expectedResult = true;
	   //assertEquals(expectedResult, DoublyLinkedList.isEmpty());
	   
	   
   //}
   
   @Test
   public void testGet(){
	   
       DoublyLinkedList<Integer> testDLL = new DoublyLinkedList<Integer>();
       testDLL.insertBefore(0,1);
       testDLL.insertBefore(1,2);
       testDLL.insertBefore(2,3);
       
       String expectedResult = "2";
       assertEquals(expectedResult, testDLL.get(1).toString());
       
       String expectedResult2 = null;
       assertEquals(expectedResult2, testDLL.get(5));
       
       String expectedResult3 = null;
       assertEquals(expectedResult3, testDLL.get(-25));
       
	   
   }
   
   @Test
   
   public void testDeleteAt(){
	   DoublyLinkedList<Integer> testDLL = new DoublyLinkedList<Integer>();
	   
	   boolean expectedResult = false;
	   assertEquals(expectedResult, testDLL.deleteAt(0));
	   
       testDLL.insertBefore(0,1);
       testDLL.insertBefore(1,2);
       testDLL.insertBefore(2,3);
       
       boolean expectedResult2 = false;
       assertEquals(expectedResult2, testDLL.deleteAt(4));
       
       boolean expectedResult3 = true;
       assertEquals(expectedResult3, testDLL.deleteAt(0));
       
       boolean expectedResult4 = true;
       assertEquals(expectedResult4, testDLL.deleteAt(1));
       
       testDLL = new DoublyLinkedList<Integer>();
       testDLL.insertBefore(0,1);
       testDLL.insertBefore(1,2);
       testDLL.insertBefore(2,3);
       
       boolean expectedResult5 = true;
       assertEquals(expectedResult5, testDLL.deleteAt(1)); 
       
       boolean expectedResult6 = false;
       assertEquals(expectedResult6, testDLL.deleteAt(-8));
       
       DoublyLinkedList<Integer> testDLL3 = new DoublyLinkedList<Integer>();
       testDLL3.insertBefore(0,1);
       boolean expectedResult7 = true;
       assertEquals(expectedResult7, testDLL3.deleteAt(0));
       
       
       

   }
   
   @Test
   public void testReverse(){
	   
	   
	   DoublyLinkedList<Integer> testDLL = new DoublyLinkedList<Integer>();
	   String expectedResult = "";
	   testDLL.reverse();
	   assertEquals(expectedResult, testDLL.toString());
	   
       testDLL.insertBefore(0,1);
       String expectedResult2 = "1";
       testDLL.reverse();
       assertEquals(expectedResult2, testDLL.toString());
       
       testDLL.insertBefore(1,2);
       testDLL.insertBefore(2,3);
       
       String expectedResult3 = "3,2,1";
       testDLL.reverse();
       assertEquals(expectedResult3, testDLL.toString());
   
   }
   
   @Test
   public void testPush(){
	   DoublyLinkedList<Integer> testDLL = new DoublyLinkedList<Integer>();
       testDLL.insertBefore(0,1);
       testDLL.insertBefore(1,2);
       testDLL.insertBefore(2,3);
       
       String expectedResult = "4,1,2,3";
       testDLL.push(4);
       assertEquals(expectedResult, testDLL.toString());
       
   }
   
   @Test
   public void testPop(){
	   DoublyLinkedList<Integer> testDLL = new DoublyLinkedList<Integer>();
       testDLL.insertBefore(0,1);
       testDLL.insertBefore(1,2);
       testDLL.insertBefore(2,3);
       
       String expectedResult = "2,3";
       testDLL.pop();
       assertEquals(expectedResult, testDLL.toString());
       
       DoublyLinkedList<Integer> testDLL2 = new DoublyLinkedList<Integer>();
       testDLL.insertBefore(0,1);

       testDLL2.pop();
       assertTrue(testDLL2.isEmpty());
       String expectedResult2= "";
       assertEquals(expectedResult2, testDLL2.toString());
       
       
       
       
   }
   
   @Test
   public void testEnqueue(){
	   DoublyLinkedList<Integer> testDLL = new DoublyLinkedList<Integer>();
       testDLL.insertBefore(0,1);
       testDLL.insertBefore(1,2);
       testDLL.insertBefore(2,3);
       
       String expectedResult = "1,2,3,10";
       testDLL.enqueue(10);
       assertEquals(expectedResult, testDLL.toString());
   }
   
   @Test
   public void testDequeue(){
	   DoublyLinkedList<Integer> testDLL = new DoublyLinkedList<Integer>();
       testDLL.insertBefore(0,1);
       testDLL.insertBefore(1,2);
       testDLL.insertBefore(2,3);
       
       String expectedResult = "2,3";
       testDLL.dequeue();
       assertEquals(expectedResult, testDLL.toString());
    
       DoublyLinkedList<Integer> testDLL2 = new DoublyLinkedList<Integer>();
       testDLL.dequeue();
       String expectedResult2 = "";
       assertEquals(expectedResult2, testDLL2.toString());
   }
   
   @Test
   public void testEnqueueAndDequeue(){
	   DoublyLinkedList<Integer> testDLL = new DoublyLinkedList<Integer>();
	   testDLL.enqueue(4);
	   testDLL.dequeue();
	   assertNull(testDLL.dequeue());
//	   String expectedResult = null;
//	  
//	   assertEquals(expectedResult, testDLL.toString());
   }
}


