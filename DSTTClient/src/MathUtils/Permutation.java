package MathUtils;

import java.util.Random;

public class Permutation {
	public static double[] permutate(double[] v,int[] index){
		double[] result = new double[v.length];
		for(int i = 0;i<result.length;i++){
			result[i] = v[index[i]];
		}
		return result;
	}
	
	public static int[] genePermutatIndex(int maxIndex){
		int[] result = new int[maxIndex];
		Random rand = new Random();
	    for(int i = 0;i<maxIndex;i++){
	    	result[i] = rand.nextInt(maxIndex);
	    }
	    return result;
	}
}
