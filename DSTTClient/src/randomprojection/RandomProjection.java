package randomprojection;

import java.util.Random;

public class RandomProjection {
	private int n = 100;
	private double[][] matrixProjection;
	
	
	public RandomProjection(int n){
		this.n = n;
		matrixProjection = new double[2*n][2*n];
		for(int i = 0;i<2*n;i++){
			for(int j = 0;j<2*n;j++){
				matrixProjection[i][j] = 0;
			}
		}
	}
	
	public RandomProjection(double[] M){
		this.n = M.length;
		matrixProjection = new double[2*n][2*n];
		for(int i = 0;i < n;i ++){
			double sinG = Math.sin(M[i]), cosG = Math.cos(M[i]); 
			matrixProjection[2*i][2*i] = cosG;
			matrixProjection[2*i+1][2*i] = -sinG;
			matrixProjection[2*i][2*i+1] = sinG;
			matrixProjection[2*i+1][2*i+1] = cosG;
		}
	}
	
	public double[] generateCorM(){
		Random rand = new Random();
		double[] M = new double[this.n];
		double min = 0, max = 2*Math.PI;
		for(int i = 0;i < n;i ++){
			double gama = (max-min)*rand.nextDouble() + min;
			M[i] = gama;
			double sinG = Math.sin(gama), cosG = Math.cos(gama); 
			matrixProjection[2*i][2*i] = cosG;
			matrixProjection[2*i+1][2*i] = -sinG;
			matrixProjection[2*i][2*i+1] = sinG;
			matrixProjection[2*i+1][2*i+1] = cosG;
		}
		return M;
	}
	
	public double[][] getRP(){
		return this.matrixProjection;
	}

}
