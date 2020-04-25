import static org.junit.Assert.*;

import java.util.ArrayList;
import java.util.List;

import org.junit.BeforeClass;
import org.junit.Test;


public class SelfDivisibleNumbersTest {

	static SelfDivisibleNumbers sdn;
	
	@BeforeClass
	public static void oneTimeSetUp() throws Exception {
		sdn = new SelfDivisibleNumbers();
}
	
	@Test
	public void constructorTest() {
		assertNotNull("Checking the constructor",sdn);
	}
	
	public void testGetFirstKNumbers(){
		int[]test = {6,5,7,2,1,3};
		int k =3;
		assertEquals("", 657,SelfDivisibleNumbers.getFirstKDigitNumber(test, k));
	}
	
	public void testIsDivisable(){
		int number1 =4;
		int number2 = 3;
		int divisor =2;
		
		assertEquals("",true,sdn.isDivisible(number1, divisor));
		assertEquals("",false,sdn.isDivisible(number2, divisor));
	}
	
	public void testGetSelfDivisableNumbers(){
		List<Integer> res = new ArrayList<Integer>();
		res.add(381654729);
		assertEquals("", res, sdn.getSelfDivisibleNumbers());
	}
	
	public void testGetNumberOfSelfDivisableNumbers(){
		assertEquals("",1,sdn.getNumberOfSelfDivisibleNumbers());
	}

}