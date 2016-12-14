package mainfunction;

import java.io.BufferedWriter;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.UnsupportedEncodingException;
import java.io.Writer;
import java.nio.charset.Charset;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Paths;

import randomprojection.Matrix;
import randomprojection.RandomProjection;

public class Enrollment {
	double[]M;
	double[][] mt;
	public Enrollment(){
		RandomProjection RP = new RandomProjection(100);
		M = RP.generateCorM();
		mt = RP.getRP();
	}
	
	public String generBioTranfor(double[] bio){
		String respose="";
		double [][] x = new double[1][];
		x[0] = bio;
		double[][] result = Matrix.multiplyByMatrix(x, mt);
		for(int i = 0;i< result[0].length;i++){
			respose+=result[0][i];
			if(i!=result[0].length-1)
				respose+=" ";
		}
		return respose;
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
	
	public double[] getM(){
		return M;
	}
	
	public void saveM(){
		String KM = "";
		for(int i = 0;i<M.length;i++){
			KM+=M[i];
			if(i!=M.length-1)
				KM+=" ";
		}
		try (Writer writer = new BufferedWriter(new OutputStreamWriter(
				new FileOutputStream("KM.txt"), "utf-8"))) {
			writer.write(KM);	   
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
