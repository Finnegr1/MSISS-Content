import org.junit.Assert;
import org.junit.Test;

public class FloydRandomTest {


    @Test
    public void testSamplingWithRep(){
        Solution_Floyd_Random fr = new Solution_Floyd_Random(new RandomStub(new int[]{1,5,1,6,5,8,4,3,7,3,4,6}));

        Assert.assertArrayEquals("Array Content should be ", new int[]{1, 5, 1, 6, 5}, fr.getRandomNum(5, 10));

    }

    @Test
    public void testSamplingUnique(){
        Solution_Floyd_Random fr = new Solution_Floyd_Random(new RandomStub(new int[]{1,5,1,6,5,8,4,3,7,3,4,6}));

        Assert.assertArrayEquals("Array Content should be ", new int[]{1, 5, 6, 8, 4}, fr.getCombinations(5, 10));

    }

    @Test
    public void testSamplingWithRepRec(){
        Solution_Floyd_Random fr = new Solution_Floyd_Random(new RandomStub(new int[]{1,5,1,6,5,8,4,3,7,3,4,6}));

        Assert.assertArrayEquals("Array Content should be ", new int[]{1, 5, 1, 6, 5}, fr.randomSample(5, 10));

    }

    @Test
    public void testPermutation(){
        Solution_Floyd_Random fr = new Solution_Floyd_Random(new RandomStub(new int[]{1,5,1,6,5,8,4,3,7,3,4,6}));

        Assert.assertArrayEquals("Array Content should be ", new int[]{6, 5, 9, 1, 7}, fr.floydPermutations(5, 10));
    }

    @Test
    public void testRecursiveSampling(){
        Solution_Floyd_Random fr = new Solution_Floyd_Random(new RandomStub(new int[]{1,5,1,6,5,8,4,3,7,3,4,6}));

        Assert.assertArrayEquals("Array Content should be ", new int[]{1, 5, 1, 6, 5}, fr.recRandomSample(5, 10));
    }
}