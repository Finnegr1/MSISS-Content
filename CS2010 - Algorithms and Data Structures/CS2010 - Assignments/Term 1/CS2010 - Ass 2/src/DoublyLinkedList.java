import java.util.Iterator;
import java.util.ListIterator;
import java.util.NoSuchElementException;

// -------------------------------------------------------------------------
/**
 *  This class contains the methods of Doubly Linked List.
 *
 *  @RossFinnegan  
 *  @version 13/10/16 18:15
 */


/**
 * Class DoublyLinkedList: implements a *generic* Doubly Linked List.
 * @param <T> This is a type parameter. T is used as a class name in the
 * definition of this class.
 *
 * When creating a new DoublyLinkedList, T should be instantiated with an
 * actual class name that extends the class Comparable.
 * Such classes include String and Integer.
 *
 * For example to create a new DoublyLinkedList class containing String data: 
 *    DoublyLinkedList<String> myStringList = new DoublyLinkedList<String>();
 *
 * The class offers a toString() method which returns a comma-separated sting of
 * all elements in the data structure.
 * 
 * This is a bare minimum class you would need to completely implement.
 * You can add additional methods to support your code. Each method will need
 * to be tested by your jUnit tests -- for simplicity in jUnit testing
 * introduce only public methods.
 */
class DoublyLinkedList<T extends Comparable<T>>
{

    /**
     * private class DLLNode: implements a *generic* Doubly Linked List node.
     */
    private class DLLNode
    {
        public final T data; // this field should never be updated. It gets its
                             // value once from the constructor DLLNode.
        public DLLNode next;
        public DLLNode prev;
        public int size;
      
    
        /**
         * Constructor
         * @param theData : data of type T, to be stored in the node
         * @param prevNode : the previous Node in the Doubly Linked List
         * @param nextNode : the next Node in the Doubly Linked List
         * @return DLLNode
         */
        public DLLNode(T theData, DLLNode prevNode, DLLNode nextNode) 
        {
          data = theData;
          prev = prevNode;
          next = nextNode;
          
        }
    }

    // Fields head and tail point to the first and last nodes of the list.
    private DLLNode head, tail;
    private int size;
    /**
     * Constructor
     * @return DoublyLinkedList
     */
    public DoublyLinkedList() 
    {
      head = null;
      tail = null;
      size=0;
      
      
    }

    /**
     * Tests if the doubly linked list is empty
     * @return true if list is empty, and false otherwise
     *
     * Worst-case asymptotic runtime cost: Theta(1)
     *
     * Justification:
     *  This method will run two checks in theta(1), and return a value in theta(1).
     *  Theta(1)*Theta(1)=Theta(1)
     */
    public boolean isEmpty()
    {
    if(head==null || tail==null)
    { return true; }
    else{return false;}
    }

    /**
     * Inserts an element in the doubly linked list
     * @param pos : The integer location at which the new data should be
     *      inserted in the list. We assume that the first position in the list
     *      is 0 (zero). If pos is less than 0 then add to the head of the list.
     *      If pos is greater or equal to the size of the list then add the
     *      element at the end of the list.
     * @param data : The new data of class T that needs to be added to the list
     * @return none
     *
     * Worst-case asymptotic runtime cost: Theta(n)
     *
     * Justification:
     *  In the worst-cast the code will reach the final else statement.
     *  And in this case the while loop will loop all the way until the second last position filled.
     *  This can be approximated to the last position
     *  Which means  that the result time to perform the assignments will be theta(n)
     */
    public void insertBefore( int pos, T data ) 
    {
      DLLNode element = new DLLNode(data, null, null);
    	
      
      if(isEmpty()){
    		head = element;
    		tail = element;
    		size++;
    	}
      else{
      if(pos<=0){
    	  element.next = head;	
    	  head.prev = element;
    	  head = element;
    	  size++;
      }
      else if(pos>=size){
    	  element.prev = tail;
    	  tail.next=element;
    	  tail = element;
    	  size++;
      }
      else{
    	int i=0;
    	DLLNode ptr = head;
		while(i < pos){
			ptr=ptr.next;
			i++;
    	  }
		DLLNode tmp = element;
		ptr.prev.next = tmp;
		tmp.prev=ptr.prev;
		ptr.prev = tmp;
		tmp.next = ptr;
		
      }
    }}

    /**
     * Returns the data stored at a particular position
     * @param pos : the position
     * @return the data at pos, if pos is within the bounds of the list, and null otherwise.
     *
     * Worst-case asymptotic runtime cost: Theta(N)
     *
     * Justification:
     *  In the worst-cast the code will reach the final else statement.
     *  And in this case the while loop will loop all the way until the last position filled.
     *  Which means  that the result time to perform the assignments will be theta(n) where n is the number of elements in the list
     *
     */
    public T get(int pos) 
    {
      int currentPos = 0;
      T data = null;
      if(pos>size-1){
    	  return data;
      }
      if(pos<0){
    	  return data;
      }
      else{
    	  DLLNode ptr = head;
    	  while(pos>currentPos){
    		  ptr=ptr.next;
    		  currentPos++;
    	  }
    	  data = ptr.data;
    	  return data;
      }
     
    }

    /**
     * Deletes the element of the list at position pos.
     * First element in the list has position 0. If pos points outside the
     * elements of the list then no modification happens to the list.
     * @param pos : the position to delete in the list.
     * @return true : on successful deletion, false : list has not been modified. 
     *
     * Worst-case asymptotic runtime cost: Theta(n)
     *
     * Justification:
     *  In the worst-cast the code will reach the final else statement.
     *  And in this case the while loop will loop all the way until the second last position filled.
     *  Which means  that the result time to perform the assignments will be theta(n)
     */
    public boolean deleteAt(int pos) 
    {
      if(pos>size-1){
      return false;
      }else if(pos<0){
    	  return false;	
      }
      else if(isEmpty()){
    	  return false;
      }
      else if(pos==0){
    	  deleteFirst();
    	  return true;
      }
      else if(pos==size-1){
    	  deleteLast();
    	  return true;
      }
      else{
    	  int currentPos = 0;
    	  DLLNode ptr=head;
    	  while(currentPos<pos){
    		  ptr=ptr.next;
    		  currentPos++;
    		  }
    	  
    	ptr.prev.next = ptr.next;
    	ptr.next.prev = ptr.prev;
    	ptr.prev = null;
    	ptr.next = null;
    	size--;
    	return true;  
      }
    }
    
    public void deleteFirst(){
    	if(size==1){
    		head = null;
    		tail = null;
    		size--;
    	}else{
    	head = head.next;
    	head.prev = null;
    	size--;
    	}
    }
    
    public void deleteLast(){
    		tail = tail.prev;
    		tail.next = null;
    		size--;
    	
    }

    /**
     * Reverses the list.
     * If the list contains "A", "B", "C", "D" before the method is called
     * Then it should contain "D", "C", "B", "A" after it returns.
     *
     * Worst-case asymptotic runtime cost: Theta(n)
     *
     * Justification:
     *  In the worst-cast the code will reach the final else statement.
     *  And in this case the while loop will loop all the way until the last position filled.
     *  This can be approximated to the last position
     *  Which means  that the result time to perform the assignments will be theta(n)
     */
    public void reverse()
    {
    	if(isEmpty()){
    		System.out.println("The List is empty and cannot be reversed");
    	}
    	else if(size==1){
    		System.out.println("The size is the 1, cannot be reversed.");
    		
    	}
    	else{
    	DLLNode temp = head;
    	head = tail;
    	tail = temp;
    	
  		DLLNode current = head;
  		
  		while(current!=null){
  			temp = current.next;   //swap the next and prev pointer
  			current.next = current.prev;
  			current.prev = temp;
  			current = current.next;
  		}}
  		
    }


    /*----------------------- STACK */
    /**
     * This method should behave like the usual push method of a Stack ADT.
     * If only the push and pop methods are called the data structure should behave like a stack.
     * How exactly this will be represented in the Doubly Linked List is up to the programmer.
     * @param item : the item to push on the stack
     *
     * Worst-case asymptotic runtime cost: Theta(n)
     *
     * Justification:
     *  The incrementation of size and the call of the method insertBefore both have worst case running
     *  times of theta(1), however you must consider the worst case running time of the method called.
     *  In this case the insertBefore method has a worst case running time of theta(n)
     *  Therefore the worstcase asymptotic runtime cost is theta(n)
     */
    public void push(T item) 
    {
    insertBefore(0,item);
    size++;
    }

    /**
     * This method should behave like the usual pop method of a Stack ADT.
     * If only the push and pop methods are called the data structure should behave like a stack.
     * How exactly this will be represented in the Doubly Linked List is up to the programmer.
     * @return the last item inserted with a push; or null when the list is empty.
     *
     * Worst-case asymptotic runtime cost: Theta(1)
     *
     * Justification:
     *  None of the costs of any of these operations is greater than Theta(1)
     *  Therefore calculating the worst case asymptotic running time simply gives Theta(1)
     */
    public T pop() 
    {
    if(isEmpty()){
    	return null;
    }
    else{
      T data = head.data;
      head = head.next;
     
      return data;
    }}

    /*----------------------- QUEUE */
 
    /**
     * This method should behave like the usual enqueue method of a Queue ADT.
     * If only the enqueue and dequeue methods are called the data structure should behave like a FIFO queue.
     * How exactly this will be represented in the Doubly Linked List is up to the programmer.
     * @param item : the item to be enqueued to the stack
     *
     * Worst-case asymptotic runtime cost: Theta(1)
     *
     * Justification:
     *  None of the costs of any of these operations is greater than Theta(1)
     *  Therefore calculating the worst case asymptotic running time simply gives Theta(1)
     */
    public void enqueue(T item) 
    {	
    if(isEmpty()){
    	DLLNode first = new DLLNode(item,null,null);
    	head = first;
		tail = first;
		size++;	
    }
      DLLNode oldTail = tail;
      tail = new DLLNode(item,null,null);
      oldTail.next = tail;
      size++;
    }

     /**
     * This method should behave like the usual dequeue method of a Queue ADT.
     * If only the enqueue and dequeue methods are called the data structure should behave like a FIFO queue.
     * How exactly this will be represented in the Doubly Linked List is up to the programmer.
     * @return the earliest item inserted with a push; or null when the list is empty.
     *
     * Worst-case asymptotic runtime cost: Theta(1)
     * 
     * Justification:
     *  *  None of the costs of any of these operations is greater than Theta(1)
     *  Therefore calculating the worst case asymptotic running time simply gives Theta(1)
     */
    public T dequeue() 
    {
    	
    	if(isEmpty()){
    		return null;
    	}
    	else if(size==1){
    		head= null;
    		tail = null;
    		size--;
    		return null;
    	}
    	else if(size==2){
    		T data = head.data;
    		head = tail;
    		size--;
    		return data;
    	}
    	else{
      T data = head.data;
      head = head.next;
      size--;
      return data;
    }}
 

    /**
     * @return a string with the elements of the list as a comma-separated
     * list, from beginning to end
     *
     * Worst-case asymptotic runtime cost:   Theta(n)
     *
     * Justification:
     *  We know from the Java documentation that StringBuilder's append() method runs in Theta(1) asymptotic time.
     *  We assume all other method calls here (e.g., the iterator methods above, and the toString method) will execute in Theta(1) time.
     *  Thus, every one iteration of the for-loop will have cost Theta(1).
     *  Suppose the doubly-linked list has 'n' elements.
     *  The for-loop will always iterate over all n elements of the list, and therefore the total cost of this method will be n*Theta(1) = Theta(n).
     */
    public String toString() 
    {
      StringBuilder s = new StringBuilder();
      boolean isFirst = true; 

      // iterate over the list, starting from the head
      for (DLLNode iter = head; iter != null; iter = iter.next)
      {
        if (!isFirst)
        {
          s.append(",");
        } else {
          isFirst = false;
        }
        s.append(iter.data.toString());
      }

      return s.toString();
    }


}


