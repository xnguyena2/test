package mainfunction;

import java.io.IOException;
import java.nio.charset.Charset;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Paths;

import fuzzycommitment.FzzCmmt;
import randomprojection.Matrix;
import randomprojection.RandomProjection;

public class Authentication {

	double[]M;
	double[][] mt;
	static int quatization = 200;
	static int delta = 30;
	static int core = 60;
	static double sqrt2 = Math.sqrt(2);
	
	public Authentication(){
		readKM();
	}
	
	public double[] getM(){
		return M;
	}
	
	public double[] generBioTranfor(double[] bio){
		String respose="";
		double [][] x = new double[1][];
		x[0] = bio;
		double[][] result = Matrix.multiplyByMatrix(x, mt);
		return result[0];
	}
	
	public int[] fuzzyEncode(double[] bio, int[] quatizaBio,int[] key, int[] realKey){
		FzzCmmt fzzCmmt = new FzzCmmt(delta,core,quatization);
		int[] temQauatizaBio = fzzCmmt.QuatizationTransfo(bio, quatization/sqrt2);
		int[] tempKey = fzzCmmt.KeyGenR(bio.length, realKey);
		nativeCopy(tempKey,key);
		nativeCopy(temQauatizaBio,quatizaBio);
		int[] fzzCmmtTransfo = fzzCmmt.FuzzyTransFoFunction(quatizaBio, key);
		return fzzCmmtTransfo;
	}
	
	static void nativeCopy(int[] src, int[] dst){
		for(int i = 0;i<src.length;i++){
			dst[i] = src[i];
		}
	}
	
	static String readFile(String path, Charset encoding) 
			  throws IOException 
			{
			  byte[] encoded = Files.readAllBytes(Paths.get(path));
			  return new String(encoded, encoding);
			}
	public void readKM(){
		try {
			String content = readFile("KM.txt", StandardCharsets.UTF_8);
			M = convertToDoubleAr(content);
			RandomProjection RP = new RandomProjection(M);
			mt = RP.getRP();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	static double[] convertToDoubleAr(String input){
		if(input == null)
			return null;
		String[] tempArray = input.split(" ");
		double[] result = new double[tempArray.length];
		for(int i = 0;i<tempArray.length;i++){
			result[i] = Double.parseDouble(tempArray[i]);
		}
		return result;
	}
}
