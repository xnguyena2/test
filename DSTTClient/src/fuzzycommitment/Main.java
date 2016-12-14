package fuzzycommitment;

import javafaces.FaceRecognition;
import mainfunction.Authentication;
import mainfunction.Enrollment;
import randomprojection.Matrix;
import randomprojection.RandomProjection;

import java.io.BufferedReader;
import java.io.File;
import java.io.FilenameFilter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.Socket;
import java.net.UnknownHostException;
import java.util.Arrays;
import java.util.List;

import org.jfree.chart.ChartFactory;
import org.jfree.chart.ChartUtilities;
import org.jfree.chart.JFreeChart;
import org.jfree.chart.plot.PlotOrientation;
import org.jfree.data.xy.XYSeries;
import org.jfree.data.xy.XYSeriesCollection;

import EncriptUtils.Hash;
import MathUtils.Binary;
import MathUtils.Convert;

public class Main {
	
	static void distance(double b1[], double b2[], double[] result){
		double maxDistance = 0;
		double cityBlock = 0;
		int length = b1.length;
		for(int i = 0;i < length;i++){
			double currentDistance = Math.abs(b1[i] - b2[i]);
			cityBlock += currentDistance;
			if(currentDistance > maxDistance){
				maxDistance = currentDistance;
			}
		}
		result[0] = maxDistance;
		result[1] = cityBlock/length;
	}
	
	static void getValue(String pathFolder, double[] result){		
		FaceRecognition face1 = new FaceRecognition();
		double [][] listBi1 = face1.generateBiometric(pathFolder, "jpg");
		double [][] listBi1Clone = listBi1.clone();
		
		int length = listBi1.length;
		double maxDistance = 0;
		double minDistance = 1;
		double avgDistance = 0;
		int counter = 0;
		for(int i = 0;i < length; i++){
			for(int j = 0;j < length; j++){
				if(i != j){					
					double currentDistance[] = new double[2];
					distance(listBi1[i],listBi1Clone[j],currentDistance);
					if(currentDistance[0] > maxDistance)
						maxDistance = currentDistance[0];
					if(currentDistance[0] < minDistance)
						minDistance = currentDistance[0];
					avgDistance += currentDistance[1];
					counter++;
				}
			}
		}
		result[0] = maxDistance;
		result[1] = minDistance;
		result[2] = avgDistance/(length*(length-1));
		System.out.println("min distance:"+minDistance);
		System.out.println("max distance:"+maxDistance);
		System.out.println("avg distance:"+avgDistance/(length*(length-1)));		
	}
	

	public static String[] parseDirectory(String directoryName){		
		String[] children=null;
		File directory=new File(directoryName);
		
		if(directory.isDirectory()){
			children=directory.list(new FilenameFilter(){
				public boolean accept(File f,String name){
					System.out.println(name);
					return true;						
				}					
			});			
		}else{
			throw new RuntimeException(directoryName+" is not a directory");
		}		
		return children;
	}
	
	public static boolean vertification(double[] bio1, double[] bio2, double threshold){
		int length = bio1.length;
		for(int i = 0; i<length;i++){
			double delta = Math.abs(bio1[i] - bio2[i]);
			if(Math.abs(bio1[i] - bio2[i])> threshold)
				return false;
		}
		return true;
	}
	
	static int getFRROf1Men(double[][] bioArray, int indexMain, double threshold){
		double[] mainBio = bioArray[indexMain];
		int frr = 0;
		for(int i = 0;i<bioArray.length;i++){
			if(i != indexMain){
				if(!vertification(mainBio,bioArray[i],threshold)){
					frr++;
				}
			}
		}
		return frr;
	}
	static int NumberThreshold = 50;
	static double startThreshold = 0.1;
	static int[] listIndex = new int[]{1,3,6,8,15,17};
	static double sqrt2 = Math.sqrt(2);
	static double[][] getFRR(String parentFolder){
		String[] folderHumanFace = parseDirectory(parentFolder);
		double[][][] listBio = new double[folderHumanFace.length][][];
		double[] frr = new double[NumberThreshold];
		double[] far = new double[NumberThreshold];
		
		RandomProjection RP = new RandomProjection(100);
		double[] M = RP.generateCorM();
		double [][] mt = RP.getRP();
		
		for(int i = 0;i < folderHumanFace.length;i++){
			
			System.out.println("got "+i+" :"+parentFolder+"\\"+folderHumanFace[i]);
			
			FaceRecognition face1 = new FaceRecognition();
			listBio[i] = face1.generateBiometric(parentFolder+"\\"+folderHumanFace[i], "jpg");
			
			
			//System.out.println(Matrix.toString(RP.getRP()));
			for(int j = 0;j<listBio[i].length;j++){
				double [][] x = new double[1][];
				x[0] = listBio[i][j];
				
				double[][] result = Matrix.multiplyByMatrix(x, mt);
				listBio[i][j] = result[0];
			}
			
		}		
		
		for(int j = 0 ;j < NumberThreshold;j++){
			int falsenumber = 0;
			double threshold = startThreshold+0.01*j;
			for(int i = 0;i<folderHumanFace.length;i++){
				falsenumber+=getFRROf1Men(listBio[i],0,threshold);
			}
			System.out.println("FFR of "+threshold+" :"+falsenumber);
			frr[j] = (double)falsenumber/(folderHumanFace.length*19);
			
			far[j] = getFAR(listBio,listIndex,0,threshold);
		}
		double[][] result = new double[2][];
		result[0] = frr;
		result[1] = far;
		return result;
	}
	
	static double getFAR(double[][][] ListBio, int[] listIndex,int mainIndex, double threshold){
		int FAR = 0;
		int counter = 0;
		for(int j = 0;j<ListBio.length;j++){
			for(int i = j+1;i<ListBio.length;i++){
				for(int k = 0;k< listIndex.length;k++){
					counter++;
					if(vertification(ListBio[j][mainIndex],ListBio[i][listIndex[k]],threshold))
						FAR++;					
				}
			}			
		}
		return (double)FAR/counter;
	}
	
	static void getHistg(int[] Hisg,double[][] bio1){
		for(int i = 0; i < bio1.length;i++){
			for(int j = i+1; j < bio1.length;j++){
				for(int k = 0;k<bio1[i].length;k++){
					double delta = Math.abs(bio1[i][k] - bio1[j][k])*100;
					Hisg[(int)delta]++;
				}
			}
		}
	}
	
	static void getHistogram(String parentFolder){
		String[] folderHumanFace = parseDirectory(parentFolder);	
		double[][][] listBio = new double[folderHumanFace.length][][];	
		for(int i = 0;i < folderHumanFace.length;i++){
			
			System.out.println("got "+i+" :"+parentFolder+"\\"+folderHumanFace[i]);
			
			FaceRecognition face1 = new FaceRecognition();
			listBio[i] = face1.generateBiometric(parentFolder+"\\"+folderHumanFace[i], "jpg");
			
		}
		int[] Hist = new int[100];
		double[] HistNor = new double[100];
		Arrays.fill(Hist, 0);
		for(int j = 0;j<listBio.length;j++){
			getHistg(Hist,listBio[j]);
		}
		int total = 0;
		for(int i = 0;i<100;i++){
			total+=Hist[i];
		}
		for(int i = 0;i<100;i++){
			HistNor[i] = ((double)Hist[i]/total);
		}
		
		final XYSeries lineFARs = new XYSeries( "Histg" );
		for(int i = 0; i<100;i++){
			lineFARs.add( 0.01*i , HistNor[i]*100 );
			System.out.println("delta: " + 0.01*i + ", HistNor:"+HistNor[i]*100);
		}
		final XYSeriesCollection dataset = new XYSeriesCollection( );
		dataset.addSeries( lineFARs );
		JFreeChart xylineChart = ChartFactory.createXYLineChart(
				"Browser threshold delta!",
				"Category",
				"Score",
				dataset,
				PlotOrientation.VERTICAL,
				true, true, false);
		int width = 1024; // Width of the image 
		int height = 480; // Height of the image 
		File XYChart = new File( "Histg.jpeg" );
		try {
			ChartUtilities.saveChartAsJPEG( XYChart, xylineChart, width, height);
		} catch (IOException e) {
			
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println(e);
		}
		
		System.out.println(Arrays.toString(Hist));
		System.out.println("finished!!");
	}
	
	static boolean checkFuzzyCmmt(FzzCmmt fzzCmmt, int[] mainBio, int[] clientBio){
		int[] key = fzzCmmt.KeyGen(mainBio.length);
		int[] fzzCmmtTransfo = fzzCmmt.FuzzyTransFoFunction(clientBio, key);
		
		//server side
		int[] decodeCommitValue = fzzCmmt.FuzzyTransFoFunction(mainBio, fzzCmmtTransfo);
		int[] keyDecode = fzzCmmt.Decode(decodeCommitValue);
		//-------------------------------end server side-----------------------------
		
		int lengthKey = key.length;
		boolean isMatch = true;
		for(int i = 0;i < lengthKey;i++){
			if(key[i] != keyDecode[i]){
				isMatch = false;
				break;
			}
		}
		return isMatch;
	}
	
	static int quatization = 200;
	static double[][] getERROfSystem(String parentFolder){
		String[] folderHumanFace = parseDirectory(parentFolder);	
		double[][][] listBio = new double[folderHumanFace.length][][];
		int[][][] listBioQ = new int[folderHumanFace.length][][];	
		double[] frr = new double[NumberThreshold];
		double[] far = new double[NumberThreshold];
		
		RandomProjection RP = new RandomProjection(100);
		double[] M = RP.generateCorM();
		double [][] mt = RP.getRP();
		
		FzzCmmt fzzCmmt = new FzzCmmt(30,60,200);
		
		for(int i = 0;i < folderHumanFace.length;i++){
			
			System.out.println("got "+i+" :"+parentFolder+"\\"+folderHumanFace[i]);
			
			FaceRecognition face1 = new FaceRecognition();
			listBio[i] = face1.generateBiometric(parentFolder+"\\"+folderHumanFace[i], "jpg");
			
			//System.out.println(Matrix.toString(RP.getRP()));
			listBioQ[i] = new int[listBio[i].length][];
			for(int j = 0;j<listBio[i].length;j++){
				double [][] x = new double[1][];
				x[0] = listBio[i][j];
				
				double[][] result = Matrix.multiplyByMatrix(x, mt);
				listBioQ[i][j] = fzzCmmt.QuatizationTransfo(result[0], quatization/sqrt2);
			}
			
		}
		
		for(int j = 0 ;j < NumberThreshold;j++){
			int falsenumber = 0;
			double threshold = quatization*(startThreshold+0.01*j);
			int delta = (int)threshold;
			fzzCmmt.changeCoreFzz(delta, delta*2);
			for(int i = 0;i<folderHumanFace.length;i++){
				falsenumber+=getFRROfSystem(fzzCmmt,listBioQ[i],0);
			}
			System.out.println("FFR of "+threshold+" :"+falsenumber);
			frr[j] = (double)falsenumber/(folderHumanFace.length*19);
			
			far[j] = getFAROfSystem(fzzCmmt,listBioQ,listIndex,0);
		}
		double[][] result = new double[2][];
		result[0] = frr;
		result[1] = far;
		return result;
	}
	
	static int getFRROfSystem(FzzCmmt fzzCmmt, int[][] listBio, int mainIndex){
		int[] mainBio = listBio[mainIndex];
		int fResults = 0;
		for(int i = 0;i<listBio.length;i++){
			if(i!=mainIndex){
				if(!checkFuzzyCmmt(fzzCmmt,mainBio,listBio[i])){
					fResults++;
				}				
			}
		}		
		return fResults;
	}
	
	static double getFAROfSystem(FzzCmmt fzzCmmt, int[][][] listBio, int[] listIndex, int mainIndex){
		int FAR = 0;
		int counter = 0;
		for(int i = 0;i<listBio.length;i++){
			for(int j = i+1; j < listBio.length;j++){
				for(int k = 0;k < listIndex.length; k++){
					counter++;
					if(checkFuzzyCmmt(fzzCmmt,listBio[i][mainIndex],listBio[j][listIndex[k]])){
						FAR++;
					}					
				}
			}
		}
		return (double)FAR/counter;
	}
	
	static void eroll(double[] bio) {

        // Make connection and initialize streams
        Socket socket;
		try {
			socket = new Socket("169.254.126.210", 1512);
	        new Capitalizer(socket,bio).start();
		} catch (UnknownHostException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    }
	
	private static class Capitalizer extends Thread{
		Socket socket;
		double[] bio;
		String S = "hello";
		public Capitalizer(Socket socket, double[] bio){
			this.socket = socket;
			this.bio = bio;
		}
		
        public void run() {
            try {
	            BufferedReader in = new BufferedReader(
	                    new InputStreamReader(socket.getInputStream()));
	            PrintWriter out = new PrintWriter(socket.getOutputStream(), true);
	            //regist(in, out, bio);
	            login(in, out, bio);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
        }
        
        public void regist(BufferedReader in, PrintWriter out, double[] bio){
            try {
	            Enrollment enrll = new Enrollment();
	            String bioTranfor = enrll.generBioTranfor(bio);
	            System.out.println(bioTranfor);
	            
	        	out.println("enrollment");	            
	        	out.println(bioTranfor);
	        	//out.println(S);
				String input = in.readLine();
				System.out.print("response:"+input);//Arrays.toString(convertToDoubleAr(input)));
				enrll.saveM();
            } catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
        }
        
        public void login(BufferedReader in, PrintWriter out, double[] bio){
            try {
            	Authentication authen = new Authentication();
            	int[] quatizaBio  = new int[bio.length], key = new int[bio.length], realKey = new int[bio.length];
            	
	            double[] bioNonInvert = authen.generBioTranfor(bio);
	            int[] fuzzyEncoded = authen.fuzzyEncode(bioNonInvert, quatizaBio, key, realKey);
	            System.out.println(Main.toString(bioNonInvert));
	            
	        	out.println("authentication");	            
	        	out.println(Main.toString(fuzzyEncoded));
	        	//out.println(S);
				String input = in.readLine();
				String sKey = Main.toString(key);
				System.out.println("Keyresponse:"+input);//Arrays.toString(convertToDoubleAr(input)));
				System.out.println("OriginalKey:"+Arrays.toString(key));//Arrays.toString(convertToDoubleAr(input)));
				System.out.println(input.equals(Arrays.toString(key)));
            } catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
        }
	}
	
	static String toString(int[] intAr){
		String result="";
		for(int i = 0;i< intAr.length;i++){
			result+=intAr[i];
			if(i!=intAr.length - 1){
				result+=" ";
			}
		}
		return result;
	}
	
	static String toString(double[] doubleAr){
		String result="";
		for(int i = 0;i< doubleAr.length;i++){
			result+=doubleAr[i];
			if(i!=doubleAr.length - 1){
				result+=" ";
			}
		}
		return result;
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

	public static void main(String[] args) {
		

		FaceRecognition face1 = new FaceRecognition();
		double[][] listBio = face1.generateBiometric("test\\faces94\\faces94\\face\\9326871", "jpg");
		eroll(listBio[16]);
		
		//System.out.println(Hash.hash("123456"));
		
		
		// TODO Auto-generated method stub
		//LineChartExample chasst = new LineChartExample();
		//chasst.example1();
		

		//FaceRecognition face1 = new FaceRecognition();
		//double [][] listBi1 = face1.generateBiometric("test\\faces94\\faces94\\malestaff\\anonym", "jpg");
		
/*
	    String lseq ="0011111111101111111111111100101101111100110000001011111000010100";
	    String tseq ="0011111111100000110011001100110011001100110011001100110011001100";
	    String result = "0000000000001111001100110000011110110000000011000111001011011000";
	    System.out.println(result.equals(Binary.XOR(tseq, lseq)));
		System.out.println(Convert.E2H(200,200));
		*/
		
		
		/*
		double[][] err = getERROfSystem("test\\faces94\\faces94\\face");//getFRR
		double[] frr = err[0];
		double[] far = err[1];
		final XYSeries lineFRRs = new XYSeries( "FRR" );
		final XYSeries lineFARs = new XYSeries( "FAR" );
		int length = frr.length;
		for(int i = 0; i<length;i++){
			lineFRRs.add( quatization*(startThreshold+0.01*i) , frr[i]*100 );
			lineFARs.add( quatization*(startThreshold+0.01*i) , far[i]*100 );
			System.out.println("threshold: " + i + ", FRR:"+frr[i]*100+", FAR:"+far[i]*100);
		}
		final XYSeriesCollection dataset = new XYSeriesCollection( );
		dataset.addSeries( lineFRRs );
		dataset.addSeries( lineFARs );
		JFreeChart xylineChart = ChartFactory.createXYLineChart(
				"Browser threshold delta!",
				"Category",
				"Score",
				dataset,
				PlotOrientation.VERTICAL,
				true, true, false);
		int width = 1024; // Width of the image 
		int height = 480; // Height of the image 
		File XYChart = new File( "ERRSystem.jpeg" );
		try {
			ChartUtilities.saveChartAsJPEG( XYChart, xylineChart, width, height);
		} catch (IOException e) {
			
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println(e);
		}
		*/
		
		//getHistogram("test\\faces94\\faces94\\face");
		
		/*
		double [][] A = new double[][]{
				{1,2,3},
				{4,5,6},
				{3,3,3}
		};
		double [][] x = new double[][]{
			{2,4,7}
			};
		
		double[][] result = Matrix.multiplyByMatrix(x, A);
		
		for(int i = 0;i<result[0].length;i++){
			System.out.println(result[0][i]);
		}*/
		
		/*RandomProjection RP = new RandomProjection(100);
		double[] M = RP.generateCorM();
		//System.out.println(Matrix.toString(RP.getRP()));
		double [][] mt = RP.getRP();
		for(int i = 0;i< 200;i++){
			String rows = "";
			for(int j = 0;j< 200;j++){
				rows += mt[i][j]+" | ";
			}
			System.out.println(rows);
			if(i == 90)
			break;
		}*/
		
		//statisticalTest();
		/*
		FzzCmmt fzzCmmt = new FzzCmmt(30,60,200);
		//"test\\faces94\\faces94\\female\\ekavaz"
		String parentFolder = "test\\faces94\\faces94\\face";
		String folderHumanFace[] = parseDirectory(parentFolder);
		double[] maxs = new double[folderHumanFace.length];
		double[] mins = new double[folderHumanFace.length];
		double[] avgs = new double[folderHumanFace.length];
		for(int i = 0;i < folderHumanFace.length;i++){
			double[] results = new double[3];
			getValue(parentFolder+"\\"+folderHumanFace[i],results);
			maxs[i] = results[0];
			mins[i] = results[1];
			avgs[i] = results[2];
			System.out.println();
		}
		
		drawChart(maxs,mins,avgs);
		
		System.out.println("finished!!");
		*/
		
		/*
		if(false)
		{
			double [] Bi1 = listBi1[0];
			//System.out.println("bi1 length"+Bi1.length);
			//System.out.println("biometric1 array:"+Arrays.toString(Bi1));
			
			int[] QuaVector1 = fzzCmmt.QuatizationTransfo(Bi1);
			System.out.println("enroll vector:"+Arrays.toString(QuaVector1));
	
			FaceRecognition face2 = new FaceRecognition();
			double [][] listBi2 = face2.generateBiometric("fztes", "jpg");
			double [] Bi2 = listBi2[0];
			//System.out.println("bi2 length"+Bi2.length);
			//System.out.println("biometric2 array:"+Arrays.toString(Bi2));
			int[] QuaVector2 = fzzCmmt.QuatizationTransfo(Bi2);
			System.out.println("vertify vector:"+Arrays.toString(QuaVector2));
			
			
			//----------------------this part at client side ----------------------------
			int[] key = fzzCmmt.KeyGen(QuaVector1.length);
			System.out.println("key vector:--------"+Arrays.toString(key));
			
			int[] fzzCmmtTransfo = fzzCmmt.FuzzyTransFoFunction(QuaVector1, key);
			System.out.println("fuzzycommit value vector:"+Arrays.toString(fzzCmmtTransfo));
			//-------------------------------end server side-----------------------------
			
	
			//----------------------this part at server side ----------------------------
			int[] decodeCommitValue = fzzCmmt.FuzzyTransFoFunction(QuaVector2, fzzCmmtTransfo);
			System.out.println("Nearest key vector:"+Arrays.toString(decodeCommitValue));
			
			int[] keyDecode = fzzCmmt.Decode(decodeCommitValue);
			System.out.println("vertify key vector:"+Arrays.toString(keyDecode));
			//-------------------------------end server side-----------------------------
			
			int lengthKey = key.length;
			boolean isMatch = true;
			for(int i = 0;i < lengthKey;i++){
				if(key[i] != keyDecode[i]){
					isMatch = false;
					break;
				}
			}
			if(isMatch)
				System.out.println("Match!!");
			else System.out.println("not Match!!");
		}*/
		
	}
	
	static void statisticalTest(){
		String parentFolder = "test\\faces94\\faces94\\face";
		String folderHumanFace[] = parseDirectory(parentFolder);
		double[] maxs = new double[folderHumanFace.length];
		double[] mins = new double[folderHumanFace.length];
		double[] avgs = new double[folderHumanFace.length];
		for(int i = 0;i < folderHumanFace.length;i++){
			double[] results = new double[3];
			getValue(parentFolder+"\\"+folderHumanFace[i],results);
			maxs[i] = results[0];
			mins[i] = results[1];
			avgs[i] = results[2];
			System.out.println("work at "+i);
		}
		
		drawChart(maxs,mins,avgs);
		
		System.out.println("finished!!");
	}
	
	public static void drawChart(double[] Maxs, double[] Mins, double[] Avgs){
		final XYSeries lineMins = new XYSeries( "Min" );
		final XYSeries lineMaxs = new XYSeries( "Max" );
		final XYSeries lineAvgs = new XYSeries( "Avg" );
		int length = Maxs.length;
	      for(int i = 0; i<length;i++){
		      lineMins.add( i+1 , Mins[i] );
		      lineMaxs.add(i+1, Maxs[i]);		      
	    	  lineAvgs.add(i+1,Avgs[i]);
	      }
	      final XYSeriesCollection dataset = new XYSeriesCollection( );
	      dataset.addSeries( lineMins );
	      dataset.addSeries( lineMaxs );
	      dataset.addSeries( lineAvgs );

	      JFreeChart xylineChart = ChartFactory.createXYLineChart(
	         "Browser threshold delta!", 
	         "Category",
	         "Score", 
	         dataset,
	         PlotOrientation.VERTICAL, 
	         true, true, false);
	      
	      int width = 1024; /* Width of the image */
	      int height = 480; /* Height of the image */ 
	      File XYChart = new File( "statisticalTest.jpeg" ); 
	      try {
			ChartUtilities.saveChartAsJPEG( XYChart, xylineChart, width, height);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println(e);
		}
	}

}
