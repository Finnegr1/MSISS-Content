import org.junit.Test;

import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertTrue;

public class ChapmanPuzzleTest {

    @Test
    public void testSolvableEmpty(){
        assertFalse(ChapmanPuzzle.isSolvable(null));
        assertTrue(ChapmanPuzzle.isSolvable(new int[]{}));
    }

    @Test
    public void testSolvableSingle(){
        assertTrue(ChapmanPuzzle.isSolvable(new int[]{3,5}));
        assertFalse(ChapmanPuzzle.isSolvable(new int[]{5,3}));
    }

    @Test
    public void testSolvable(){
        assertTrue(ChapmanPuzzle.isSolvable(new int[]{1,2,3,5,6,7,8,4}));
        assertFalse(ChapmanPuzzle.isSolvable(new int[]{1,2,3,5,7,8,4,6}));
        assertTrue(ChapmanPuzzle.isSolvable(new int[]{1,2,3,5,7,8,6,9}));
    }

    @Test
    public void testIsSolvedFalse(){
        assertFalse(ChapmanPuzzle.isSolved(null));
        assertFalse(ChapmanPuzzle.isSolved(new int[]{8,7,6}));
        assertFalse(ChapmanPuzzle.isSolved(new int[]{3,8,9,34,15}));
    }

    @Test
    public void testIsSolvedTrue(){
        assertTrue(ChapmanPuzzle.isSolved(new int[]{}));
        assertTrue(ChapmanPuzzle.isSolved(new int[]{3}));
        assertTrue(ChapmanPuzzle.isSolved(new int[]{3,8}));
        assertTrue(ChapmanPuzzle.isSolved(new int[]{3,8,9,34,1000}));
    }

    @Test
    public void testEvenPerm(){
       assertTrue(ChapmanPuzzle.even_perm(new int[]{3,8}));
       assertTrue(ChapmanPuzzle.even_perm(new int[]{3,8,4,6}));
       assertFalse(ChapmanPuzzle.even_perm(new int[]{3,8,6,4}));
       assertFalse(ChapmanPuzzle.even_perm(null));
       assertTrue(ChapmanPuzzle.even_perm(new int[]{}));
   }



}