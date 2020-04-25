import java.util.Random;
import java.util.Scanner;

public class ChapmanPuzzle {
	
	public static void main(String args[]){
		int[] puzzleBoard =  new int[16];
		int currentPos = 0;
		puzzleBoard = board();
		for(int i=0; i<=15; i++){
			if(puzzleBoard[i]==0){
				currentPos = i;
			}
		}
		boolean completed = false;
		
		do{
			System.out.println("--------------------------------------------");
			print(puzzleBoard);
			System.out.println("--------------------------------------------");
			System.out.println("You may move the blank BB: up, down, left or right.");
			System.out.println("What move do you wish to make?");
			System.out.println("(up 'i', down 'm', left 'j', right 'k').");
			System.out.println("To quit press 'q'.");
		

			
			Scanner scan = new Scanner(System.in);
			String input = scan.next();
			switch(input){
			case "q": System.out.println("You have selected to quit the game. Thanks for playing.");
					  completed = true;
				      break;
			case "i": int newPosU = moveUp(puzzleBoard, currentPos);	
					  currentPos = newPosU;
					  break;
			case "m": int newPosD = moveDown(puzzleBoard, currentPos);	
					  currentPos = newPosD;
					  break;	
			case "j": int newPosL = moveLeft(puzzleBoard, currentPos);	
					  currentPos = newPosL;
					  break;		
			case "k": int newPosR = moveRight(puzzleBoard, currentPos);	
			  		  currentPos = newPosR;
			  		  break;	
	  		 default: System.out.println("Invalid input. Try again.");
	  		 		  break;
			}
			
		}while(completed==false);
	}
	
	public static int[] board()
	{
		// initialise a board with 16 (4*4) elements
		int[] board = new int[16];
		
		//fill each element
		board[0] = 1; board[1] = 2; board[2] = 5; board[3] = 0;
		board[4] = 6; board[5] = 4; board[6] = 10;board[7] = 7;
		board[8] = 14;board[9] = 9; board[10] = 13;board[11] = 12;
		board[12] = 15;board[13] = 3;board[14] = 11;board[15] = 8;

		//randomise the elements of the array
		Random r = new Random();
		for (int i = 0; i < 100; i++)
		{
			int p = r.nextInt(15);
			int q = r.nextInt(15);
			swap(board, p, q);
		}
		//returns a randomised array
		return board;
	}

	public static int moveDown(int[] board, int currentPosition)
	{
		//Check if moving Down is actually possible
		if (currentPosition == 12 || currentPosition == 13 || currentPosition == 14 || currentPosition == 15)
		{
			System.err.print("You are not able to move down from this position");
		}
		
		//updates the selected position
		else
		{
			swap(board, currentPosition, currentPosition + 4);
			currentPosition = currentPosition + 4;
		}
		//keep track of the BB
		return currentPosition;
	}

	public static int moveUp(int[] board, int currentPosition)
	{
		//Check if moving Up is actually possible
		if (currentPosition == 0 || currentPosition == 1 || currentPosition == 2 || currentPosition == 3)
		{
			System.err.print("You are not able to move up from this position");
		}
		//updates the selected position
		else
		{
			swap(board, currentPosition, currentPosition - 4);
			currentPosition = currentPosition - 4;
		}
		//keep track of the BB
		return currentPosition;
	}

	public static int moveLeft(int[] board, int currentPosition)
	{
		//Check if moving Left is actually possible
		if (currentPosition == 0 || currentPosition == 4 || currentPosition == 8 || currentPosition == 12)
		{
			System.err.print("You are not able to move left from this position");
		}
		//updates the selected position
		else
		{
			swap(board, currentPosition, currentPosition - 1);
			currentPosition = currentPosition - 1;
		}
		//keep track of the BB
		return currentPosition;
	}

	public static int moveRight(int[] board, int currentPosition)
	{
		//Check if moving Right is actually possible
		if (currentPosition == 3 || currentPosition == 7 || currentPosition == 11 || currentPosition == 15)
		{
			System.err.print("You are not able to move right from this position");
		}
		
		//updates the selected position
		else
		{
			swap(board, currentPosition, currentPosition + 1);
			currentPosition = currentPosition + 1;
		}
		//keep track of the BB
		return currentPosition;
	}
	
	public static int[] swap(int[] array, int i, int j)
	{
		// determines the value at the two positions to be swapped
		int ivalue = array[i];
		int jvalue = array[j];
		// swaps the values
		array[i] = jvalue;
		array[j] = ivalue;
		return array;
		
	}

	public static void print(int[] board)
	{
		String board2[] = new String[16];
		for(int i=0; i<=15; i++){
			int value = board[i];
			switch(value){
			case 0: board2[i]= "BB";
					break;
			default:String val = String.format("%02d", board[i]);
					board2[i]= val;
					break;
			}
		}
		System.out.println(board2[0]+ "|" + board2[1]+ "|"+ board2[2]+"|" + board2[3]);
		System.out.println(board2[4] +"|"+ board2[5] +"|"+ board2[6]+"|" + board2[7]);
		System.out.println(board2[8] + "|"+board2[9] +"|"+ board2[10]+"|" + board2[11]);
		System.out.println(board2[12] +"|"+ board2[13]+"|" + board2[14] +"|"+ board2[15]);
	}

	public static boolean isSolvable(int[] is)
	{
		boolean test = even_perm(is);
		
		return test;
	}

	public static boolean isSolved(Object object)
	{
		return false;
	}

	public static boolean even_perm(int[] is)
	{
		boolean even = false;
		int inversionCount = 0;
		for(int i=0; i<=15; i++){
			for(int j=1; j<=16; j++){
				if(is[i]>is[j]){
					inversionCount++;
				}
			}
		}
		if(inversionCount%2==0){
			even =true;
		}
		else{
			even =false;
		}
		return even;
	}

}