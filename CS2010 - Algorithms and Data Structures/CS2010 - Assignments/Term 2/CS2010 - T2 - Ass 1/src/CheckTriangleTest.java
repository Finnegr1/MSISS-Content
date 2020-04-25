import org.junit.Test;
import static org.junit.Assert.*;

public class CheckTriangleTest {



    @Test
    public void checkTriangleSameTest(){
        double[] arr = {15,15,15};
        assertTrue(arr.toString()+" is a triangle",CheckTriangle.form_triangle(arr));
    }

    @Test
    public void checkTriangleTest(){
        double[] arr = {3, 4, 6};
        assertTrue(arr.toString()+" is a triangle",CheckTriangle.form_triangle(arr));
    }

    @Test
    public void checkTriangleFalseTest(){
        double[] arr = {25,5,5};
        assertFalse(arr.toString()+" should not be a triangle",CheckTriangle.form_triangle(arr));
    }

    @Test
    public void kindTriangleFalseTest(){
        double[] arr = {25,5,5};
        assertEquals(arr.toString() + " should not be a triangle", 0, CheckTriangle.kind_triangle(arr));
    }

    @Test
    public void kindTrianglObtuseTest(){
        double[] arr = {3,4,6};
        assertEquals(arr.toString()+" should be obtuse",3, CheckTriangle.kind_triangle(arr));
    }

    @Test
     public void kindTriangleRightAngledTest(){
        double[] arr = {3,4,5};
        assertEquals(arr.toString()+" should be right-angled",1, CheckTriangle.kind_triangle(arr));
    }

    @Test
     public void kindTriangleAcuteTest(){
        double[] arr = {6,6,6};
        assertEquals(arr.toString()+" should be acute",2,CheckTriangle.kind_triangle(arr));
    }


    @Test
    public void maxTest(){
        double[] arr = {6,6,6};
        assertEquals("6 is the max in "+ arr.toString(),6,CheckTriangle.max(arr),0);
    }

    @Test
     public void maxTest2(){
        double[] arr = {6,7,5};
        assertEquals("7 is the max in "+ arr.toString(),7,CheckTriangle.max(arr),0);
    }

    @Test
    public void minTest(){
        double[] arr = {6,5,4};
        assertEquals("4 is the min in "+ arr.toString(),4,CheckTriangle.min(arr),0);
    }

    @Test
     public void minTest2(){
        double[] arr = {6,5,4.1,4.3,7};
        assertEquals("4.3 is the min in "+ arr.toString(),4.3,CheckTriangle.min(arr),1);
    }

    @Test
     public void sumTest(){
        double[] arr = {6,5,4.1,4.3,7};
        assertEquals("26.4 is the sum in "+ arr.toString(),26.4,CheckTriangle.sum(arr),1);
    }
}