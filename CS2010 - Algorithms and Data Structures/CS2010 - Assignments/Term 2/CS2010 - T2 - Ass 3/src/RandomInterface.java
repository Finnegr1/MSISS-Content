import java.util.Collection;
import java.util.Iterator;
import java.util.Random;

public interface RandomInterface{
     int nextInt(int bound);

}

class RandomStub implements RandomInterface{

    private int pos = 0;
    private int[] arr;

    public RandomStub(int[] arr){
        this.arr = arr;
    }

    @Override
    public int nextInt(int bound){

        while(arr[pos] >bound)
            pos++;

        return arr[pos++];
    }
}
