package javafaces;

import java.awt.image.BufferedImage;
import java.awt.image.ColorConvertOp;
import java.awt.image.Raster;
import java.awt.image.RenderedImage;
import java.awt.image.WritableRaster;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FilenameFilter;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.io.PrintStream;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Enumeration;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.List;

import javax.imageio.ImageIO;
import javax.media.jai.JAI;
import javax.media.jai.RenderedImageAdapter;

public class FaceRecognition {
	private FaceBundle bundle;
	private double[][] weights;		//projection of sample images
	public int eigenfacesNumber = 1;
	private int imgW = 180;
	private int imgH = 200;
	
	public MatchResult findMatchResult(String imageFileName,int selectedeigenfaces){
		Matrix2D inputFace = getNormalisedInputFace(imageFileName);
		inputFace.subtract(new Matrix2D(bundle.getAvgFace(), 1));
		Matrix2D inputWts = getInputWeights(selectedeigenfaces, inputFace);		//weights of test img in eigenfaces space
		double[] distances = getDistances(inputWts);		
		ImageDistanceInfo distanceInfo = getMinimumDistanceInfo(distances);
		double minimumDistance = Math.sqrt(distanceInfo.getValue());
		String matchingFileName = getMatchingFileName(distanceInfo);
		return new MatchResult(matchingFileName,minimumDistance);		
	}
	private String getMatchingFileName(ImageDistanceInfo distanceInfo) {
		List<String> imageFileNames = bundle.getImageFileNamesList();
		String matchingFileName = imageFileNames.get(distanceInfo.getIndex());
		return matchingFileName;
	}
	private Matrix2D getInputWeights(int selectedeigenfaces, Matrix2D inputFace) {
		double[][] eigenFacesArray = bundle.getEigenFaces();
		Matrix2D eigenFacesMatrix=new Matrix2D(eigenFacesArray);
		Matrix2D eigenFacesMatrixPart=eigenFacesMatrix.getSubMatrix(selectedeigenfaces);
		Matrix2D eigenFacesMatrixPartTranspose=eigenFacesMatrixPart.transpose();
		Matrix2D inputWts=inputFace.multiply(eigenFacesMatrixPartTranspose);
		return inputWts;
	}
	private Matrix2D getNormalisedInputFace(String imageFileName) {
		double[] inputFaceData = getImageData(imageFileName);
		//Matrix2D inputFace=new Matrix2D(inputFaceData,1);
    Matrix2D inputFace=new Matrix2D(inputFaceData, imgH);
		inputFace.normalise();
		return inputFace;
	}	
	private ImageDistanceInfo getMinimumDistanceInfo(double[] distances) {
		double minimumDistance = Double.MAX_VALUE;
		int index=0;
		for (int i = 0; i < distances.length; i++) {
			if (distances[i] < minimumDistance) { 
				minimumDistance=distances[i];
				index=i;				
			}
		}
		return new ImageDistanceInfo(distances[index], index);		
	}	
	private double[] getDistances(Matrix2D inputWt) {			
		Matrix2D tempWt=new Matrix2D(weights);	
		double[] inputWtData=inputWt.flatten();		
		tempWt.subtractFromEachRow(inputWtData);
		tempWt.multiplyElementWise(tempWt);
		double[][] temp=tempWt.toArray();
		double[] distances = new double[temp.length];
		for (int i = 0; i < temp.length; i++) {
			double sum = 0.0;
			for (int j = 0; j < temp[0].length; j++) {
				sum += temp[i][j];
			}
			distances[i] = sum;
		}
		return distances;
	}
	private double[] getImageData(String imageFileName) {
		RenderedImage rendimg = JAI.create("fileload", imageFileName);
		BufferedImage bufferedImage = convertToGray(new RenderedImageAdapter(
				rendimg).getAsBufferedImage());
		int imageWidth = bufferedImage.getWidth();
		int imageHeight = bufferedImage.getHeight();
		double[] inputFace = new double[imageWidth * imageHeight];
		bufferedImage.getData().getPixels(0, 0, imageWidth, imageHeight,
				inputFace);
		return inputFace;
	}
	private void doCalculations(String dir,List<String> imglist,int selectedNumOfEigenFaces){
		FaceBundle b=createFaceBundle(imglist);
		double[][] wts=calculateWeights(b,selectedNumOfEigenFaces);
		bundle=b;
		weights=wts;
		//writeCache(dir,b);
	}	
	private double[][] calculateWeights(FaceBundle b,int selectedNumOfEigenFaces){
		Matrix2D eigenFaces=new Matrix2D(b.getEigenFaces());
		Matrix2D eigenFacesPart=eigenFaces.getSubMatrix(selectedNumOfEigenFaces);
		Matrix2D adjustedFaces=new Matrix2D(b.getAdjustedFaces());
		Matrix2D eigenFacesPartTr=eigenFacesPart.transpose();
		Matrix2D wts=adjustedFaces.multiply(eigenFacesPartTr);
		return wts.toArray();
	}
	public FaceBundle createFaceBundle(List<String> filenames){
		BufferedImage[] bufimgs=getGrayScaleImages(filenames);
		checkImageDimensions(filenames, bufimgs);
		Matrix2D imagesData = getNormalisedImagesData(bufimgs);
		double[] averageFace=imagesData.getAverageOfEachColumn();
		imagesData.adjustToZeroMean();
		EigenvalueDecomposition egdecomp = getEigenvalueDecomposition(imagesData);
		double[] eigenvalues=egdecomp.getEigenValues();
		double[][]eigvectors=egdecomp.getEigenVectors();
		sortEigenVectors(eigenvalues,eigvectors);
		Matrix2D eigenFaces=getNormalisedEigenFaces(imagesData,new Matrix2D(eigvectors));
		int imageWidth=bufimgs[0].getWidth();
		createEigenFaceImages(eigenFaces,imageWidth);
		int imageHeight=bufimgs[0].getHeight();
		FaceBundle b=new FaceBundle(filenames,imagesData.toArray(),averageFace,eigenFaces.toArray(),eigenvalues,imageWidth,imageHeight);
		
		return b;		
	}
	private EigenvalueDecomposition getEigenvalueDecomposition(
			Matrix2D imagesData) {
		Matrix2D imagesDataTr=imagesData.transpose();
		Matrix2D covarianceMatrix=imagesData.multiply(imagesDataTr);
		EigenvalueDecomposition egdecomp =covarianceMatrix.getEigenvalueDecomposition();
		return egdecomp;
	}
	public void createEigenFaceImages(Matrix2D egfaces,int imgwidth){
		double[][] eigenfacesArray=egfaces.toArray();						
		String fldrname=".."+File.separator+"eigenfaces";
		makeNewFolder(fldrname);
		String prefix="eigen";
		String ext=".png";		
		for(int i=0;i<eigenfacesArray.length;i++){
			double[] egface=eigenfacesArray[i];
			String filename=fldrname+File.separator+prefix+i+ext;			
			createImageFromArray(filename,egface,imgwidth);
		}
	}
	private Matrix2D getNormalisedEigenFaces(Matrix2D imagesData,Matrix2D eigenVectors) {
		Matrix2D eigenVectorsTr=eigenVectors.transpose();
		Matrix2D eigenFaces=eigenVectorsTr.multiply(imagesData);
		double[][] eigenFacesData=eigenFaces.toArray();
		for(int i=0;i<eigenFacesData.length;i++){
			double norm=Matrix2D.norm(eigenFacesData[i]);
			for(int j=0;j<eigenFacesData[i].length;j++){
				double v=eigenFacesData[i][j];
				eigenFacesData[i][j]=v/norm;
			}
		}
		return new Matrix2D(eigenFacesData);		
	}
	public void sortEigenVectors(double[] eigenValues,double[][]eigenVectors){
		Hashtable<Double,double[]> table =  new Hashtable<Double,double[]> ();	
		Double[] evals=new Double[eigenValues.length];
		getEigenValuesAsDouble(eigenValues, evals);		
		fillHashtable(eigenValues, eigenVectors, table, evals);
		ArrayList<Double> keylist = sortKeysInReverse(table);				
		updateEigenVectors(eigenVectors, table, evals, keylist);		
		Double[] sortedkeys=new Double[keylist.size()];
		keylist.toArray(sortedkeys);//store the sorted list elements in an array
		//use the array to update the original double[]eigValues
		updateEigenValues(eigenValues, sortedkeys);		
	}
	private void getEigenValuesAsDouble(double[] eigenValue, Double[] evals) {
		for(int i=0;i<eigenValue.length;i++){
			evals[i]=new Double(eigenValue[i]);
		}
	}
	private ArrayList<Double> sortKeysInReverse(
			Hashtable<Double, double[]> table) {
		Enumeration<Double> keys=table.keys();
		ArrayList<Double> keylist=Collections.list(keys);		
		Collections.sort(keylist,Collections.reverseOrder());//largest first
		return keylist;
	}
	private void updateEigenValues(double[] eigenValue, Double[] sortedkeys) {
		for(int i=0;i<sortedkeys.length;i++){
			Double dbl=sortedkeys[i];
			double dblval=dbl.doubleValue();
			eigenValue[i]=dblval;
		}
	}
	private void updateEigenVectors(double[][] eigenVector,
			Hashtable<Double, double[]> table, Double[] evals,
			ArrayList<Double> keylist) {
		for(int i=0;i<evals.length;i++){
			double[] ret=table.get(keylist.get(i));//coumn i
			setColumn(eigenVector,ret,i);//update the double[][]
		}
	}
	private void fillHashtable(double[] eigenValues, double[][] eigenVectors,
			Hashtable<Double, double[]> table, Double[] evals) {
		for(int i=0;i<eigenValues.length;i++){
			Double key=evals[i];
			double[] value=getColumn(eigenVectors ,i);			
			table.put(key,value);
		}
	}	
	private double[] getColumn( double[][] mat, int j ){
		int m = mat.length;
		double[] res = new double[m];
		for ( int i = 0; i < m; ++i ){
			res[i] = mat[i][j];
		}
		return(res);
	}
	private void setColumn(double[][] mat,double[] col,int c){
		int len=col.length;
		for(int row=0;row<len;row++){
			mat[row][c]=col[row];
		}
	}
	private Matrix2D getNormalisedImagesData(BufferedImage[] bufImgs){
		int imageWidth=bufImgs[0].getWidth();
		int imageHeight=bufImgs[0].getHeight();
		int rows=bufImgs.length;
		int cols=imageWidth * imageHeight;
		double[][] data=new double[rows][cols];
		for(int i=0;i<rows;i++){						
			bufImgs[i].getData().getPixels(0,0, imageWidth,imageHeight,data[i]);
		}
		Matrix2D imagesData=new Matrix2D(data);
		imagesData.normalise();
		return imagesData;		
	}		
	private void checkImageDimensions(List<String> filenames,
			BufferedImage[] bufimgs) {
		int imgheight=0;
		int imgwidth=0;
		for(int i=0;i<bufimgs.length;i++){			
			if(i==0){
				imgheight=bufimgs[i].getHeight();
				imgwidth=bufimgs[i].getWidth();				
			}
			if((imgheight!=bufimgs[i].getHeight()) || (imgwidth!=bufimgs[i].getWidth())){				
				throw new RuntimeException("all images should have same dimensions!\n"+filenames.get(i)+" is of diff size");								
			}
		}
	}	
	public BufferedImage[] getGrayScaleImages(List<String> filenames){
		BufferedImage[] bufimgs=new BufferedImage[filenames.size()];
		Iterator<String> it=filenames.iterator();		
		int i=0;
		while(it.hasNext()){
			String fn=it.next();		
			File f=new File(fn);
			if (f.isFile()){
				RenderedImage rendimg=JAI.create("fileload",fn);
				BufferedImage b = convertToGray(new RenderedImageAdapter(rendimg).getAsBufferedImage());
				bufimgs[i++]=b;
			}
		}
		return bufimgs;			
	}
	private BufferedImage convertToGray(BufferedImage img){
		try{
		BufferedImage gray = new BufferedImage(img.getWidth(),img.getHeight(),
	              BufferedImage.TYPE_BYTE_GRAY);
		ColorConvertOp op = new ColorConvertOp(
	              img.getColorModel().getColorSpace(),
	              gray.getColorModel().getColorSpace(),null);
	    op.filter(img,gray); 
		return gray;
		}catch(Exception e){
			throw new RuntimeException("grayscale conversion failed");
		}		
	}
	private void writeCache(String dir,FaceBundle cachedata){		
		try{
			FileOutputStream fout = new FileOutputStream(dir+File.separator+"mycache.cache");
		    ObjectOutputStream fos = new ObjectOutputStream(fout);
		    fos.writeObject(cachedata);
		    System.out.println("wrote cache");
		    fos.close();
		    fout.close();		    
		}
		catch(Exception e){
			e.printStackTrace();
		}
	}
	private FaceBundle getOldFacesBundle(String dir)throws FileNotFoundException, IOException, ClassNotFoundException {
		FileInputStream fin=new FileInputStream(dir+File.separator+"mycache.cache");
		ObjectInputStream fo = new ObjectInputStream(fin);
		FaceBundle oldBundle=(FaceBundle)fo.readObject();
		fo.close();
		fin.close();
		return oldBundle;
	}	
	private void validateSelectedEigenFacesNumber(int selectedNumOfEigenFaces,
			List<String> newFileNames) {
		int numImgs=newFileNames.size();
		if(selectedNumOfEigenFaces <=0 || selectedNumOfEigenFaces >=numImgs){
			throw new RuntimeException("incorrect number of selectedeigenfaces used");			
		}
	}	
	private List<String> getFileNames(String dir, String[] children) {
		java.util.List<String> imageFileNames=new java.util.ArrayList<String>();
		for (String i : children){			
			String fileName=dir+File.separator+i;
			imageFileNames.add(fileName);
		}
		Collections.sort(imageFileNames);
		return imageFileNames;
	}
	public List<String> parseDirectory(String directoryName,String extension){		
		final String ext="."+extension;
		String[] children=null;
		File directory=new File(directoryName);
		
		if(directory.isDirectory()){
			children=directory.list(new FilenameFilter(){
				public boolean accept(File f,String name){
					return name.endsWith(ext);						
				}					
			});			
		}else{
			throw new RuntimeException(directoryName+" is not a directory");
		}		
		return getFileNames(directoryName, children);
	}
	public void checkCache(String dir,String extension,int selectedNumOfEigenFaces){
		List<String> newFileNames=parseDirectory(dir,extension);
    doCalculations(dir,newFileNames,selectedNumOfEigenFaces);
    /*
		validateSelectedEigenFacesNumber(selectedNumOfEigenFaces, newFileNames);
		FaceBundle oldBundle=null;
		try{
			oldBundle = getOldFacesBundle(dir);
			List<String> oldFileNames=oldBundle.getImageFileNamesList();			
			processCache(dir,newFileNames,oldFileNames,oldBundle,selectedNumOfEigenFaces);
		}
		catch(FileNotFoundException e){
			debug("cache file not found");
			doCalculations(dir,newFileNames,selectedNumOfEigenFaces);
		}
		catch(IOException e){
			throw new RuntimeException("io error with mycache.cache");
		}
		catch(ClassNotFoundException e){
			e.printStackTrace();
		}*/
	}	
	private void processCache(String dir,List<String>newFileNames,List<String>oldFileNames,FaceBundle oldBundle,int selectedNumOfEigenFaces){
		if(newFileNames.equals(oldFileNames)){
			bundle=oldBundle;			
			weights=calculateWeights(oldBundle,selectedNumOfEigenFaces);
		}
		else{
			debug("folder contents changed");
			doCalculations(dir,newFileNames,selectedNumOfEigenFaces);
		}
	}
	private void createImageFromArray(String filename,double[] imgdata,int wd){
		try{
		BufferedImage bufimg=new BufferedImage(wd,imgdata.length/wd, BufferedImage.TYPE_BYTE_GRAY);
		Raster rast=bufimg.getData();			
		WritableRaster wr= rast.createCompatibleWritableRaster();		
		double maxValue=Double.MIN_VALUE;
		double minValue=Double.MAX_VALUE;		
		for(int i=0;i<imgdata.length;i++){
			maxValue=Math.max(maxValue, imgdata[i]);
			minValue=Math.min(minValue, imgdata[i]);			
		}
		for(int j=0;j<imgdata.length;j++){
			imgdata[j]=((imgdata[j]-minValue)*255)/(maxValue-minValue);
		}		
		wr.setPixels(0, 0, wd,imgdata.length/wd, imgdata);
		bufimg.setData(wr);
		File newfile=new File(filename);
		ImageIO.write(bufimg, "png", newfile);		
	}catch(Exception e){
		e.printStackTrace();
	}
	}
	private void makeNewFolder(String fldr){
		File folder=new File(fldr);
		if (folder.isDirectory()){
			debug("folder:"+fldr+" exists");
			deleteContents(folder);
		}
		else{
			debug("no such folder as:"+fldr);
			folder.mkdir();
			debug("made dir:"+fldr);
		}
	}
	private void deleteContents(File f) {
		File[] files=f.listFiles();
		for(File i:files){
			delete(i);
		}
	}
	private void delete(File i) {
		if(i.isFile()){
			boolean del=i.delete();
			/*if(del==true){
				debug("deleted:"+i.getName());
			}*/
		}
	}	
	public void reconstructFaces(int selectedeigenfaces){		
		double[][]eigenfacesArray=bundle.getEigenFaces();		
		Matrix2D egnfacesMatrix=new Matrix2D(eigenfacesArray);
		Matrix2D egnfacesSubMatrix=egnfacesMatrix.getSubMatrix(selectedeigenfaces);
		double[] eigenvalues=bundle.getEigenValues();
		Matrix2D eigenvalsMatrix=new Matrix2D(eigenvalues,1);
		Matrix2D eigenvalsSubMatrix=eigenvalsMatrix.transpose().getSubMatrix(selectedeigenfaces);
		
		/*
		 * i am using the term 'phi' to denote mean subtracted reconstructed imagedata  
		 * since that term appears in T&P doc.The term 'xnew' denotes phi+average_image
		 *
		 **/		
		double[][] phi = getPhiData(egnfacesSubMatrix, eigenvalsSubMatrix);		
		double[][] xnew = addAverageFaceData(phi);		
		String reconFolderName=".."+File.separator+"reconfaces";
		String ext=".png";		
		reconstructPhiImages(phi, reconFolderName, ext);		
		reconstructOriginalImages(xnew, reconFolderName, ext);
		debug("reconstruction over");		
	}
	private double[][] getPhiData(Matrix2D egnfacesSubMatrix,
			Matrix2D eigenvalsSubMatrix) {
		double[]evalsub=eigenvalsSubMatrix.flatten();		
		Matrix2D tempEvalsMat=new Matrix2D(weights.length,evalsub.length);
		tempEvalsMat.replaceRowsWithArray(evalsub);
		Matrix2D tempmat=new Matrix2D(weights);
		tempmat.multiplyElementWise(tempEvalsMat);				
		Matrix2D phinewmat=tempmat.multiply(egnfacesSubMatrix);		
		double[][]phi=phinewmat.toArray();
		return phi;
	}
	private double[][] addAverageFaceData(double[][] phi) {
		double[][] xnew=new double[phi.length][phi[0].length];
		double[] avgface=bundle.getAvgFace();
		for(int i=0;i<phi.length;i++){
			for(int j=0;j<phi[i].length;j++){
				xnew[i][j]=phi[i][j]+avgface[j];
			}
		}
		return xnew;
	}
	private void reconstructOriginalImages(double[][] xnew,
			String reconFolderName, String ext) {
		String prefix;
		prefix="xnew";
		int imgwidth=bundle.getImageWidth();
		for(int i=0;i<xnew.length;i++){
			double[] xnewdata=xnew[i];
			String filename=reconFolderName+File.separator+prefix+i+ext;			
			createImageFromArray(filename,xnewdata,imgwidth);
		}
	}
	private void reconstructPhiImages(double[][] phi, String reconFolderName,
			String ext) {
		int imgwidth=bundle.getImageWidth();		
		makeNewFolder(reconFolderName);
		String prefix="phi";		
		for(int i=0;i<phi.length;i++){
			double[] phidata=phi[i];
			String filename=reconFolderName+File.separator+prefix+i+ext;			
			createImageFromArray(filename,phidata,imgwidth);
		}		
	}
	
	// This is function used for generating biometric vector
	public Matrix2D[] generateBioVec(String dir, String extension)
	{
		List<String> newFileNames = parseDirectory(dir,extension);
	    
		BufferedImage[] bufimgs = getGrayScaleImages(newFileNames);
		int imgNumber = newFileNames.size();
		double imgData[][][] = new double[imgNumber][imgH][imgW];
		Matrix2D[] imagesData = new Matrix2D[imgNumber];
		
		for(int i=0;i<bufimgs.length;i++){
			for(int j=0;j<imgH;j++){
				bufimgs[i].getData().getPixels(0,j,imgW,1,imgData[i][j]);
			}
			imagesData[i] = new Matrix2D(imgData[i]);
		}

		//calculate average image
		double[][] avg = new double[imgH][imgW];
		for(int i=0;i<imgH;i++){
			for(int j=0;j<imgW;j++){
				double sum = 0;
				for(int k=0;k<imgNumber;k++){
					sum += imagesData[k].getQuick(i,j);
				}
				avg[i][j] = sum/imgNumber;
			}
		}
		Matrix2D avgFace = new Matrix2D(avg);

		//calculate Gt
		Matrix2D cov = new Matrix2D(imgW, imgW);
		for(int i=0;i<imgNumber;i++){
			double[] data = imagesData[i].flatten();
			Matrix2D temp = new Matrix2D(data, imgH);
			temp.subtract(avgFace);
			Matrix2D tempTR =temp.transpose();
			Matrix2D mul = tempTR.multiply(temp);
			cov.add(mul);
		}
		for(int i=0;i<imgW;i++){
			for(int j=0;j<imgW;j++){
				cov.set(i,j, cov.getQuick(i,j)/imgNumber);
			}
		}

		//calculate eigenvectors
		EigenvalueDecomposition egdecomp = getEigenvalueDecomposition(cov);
		double[] eigenvalues = egdecomp.getEigenValues();
		double[][] eigvectors = egdecomp.getEigenVectors();
		sortEigenVectors(eigenvalues, eigvectors);
		Matrix2D[] eigenvectors = new Matrix2D[eigenfacesNumber];
		for(int i=0;i<eigenfacesNumber;i++){
			eigenvectors[i] = new Matrix2D(eigvectors[i], imgW);
			normalize(eigenvectors[i]);
		}
		return eigenvectors;
	}
	
	public void normalize(Matrix2D mat){
		//This matrix may contains negative numbers!
		int cols = mat.columns();
		int rows = mat.rows();
		double min, max;
		max = Double.MIN_VALUE;
		min = Double.MAX_VALUE;
		for(int i=0; i<rows; i++)
		for(int j=0; j<cols; j++){
			double t = mat.getQuick(i, j);
			max = Math.max(max, t);
			min = Math.min(min, t);
		}
		double abs = Math.max(Math.abs(min),max);
		for(int i=0; i<rows; i++)
		for(int j=0; j<cols; j++){
			double t = mat.getQuick(i, j);
			mat.setQuick(i,j,(t+abs)/2/abs);
		}
	}

	public double matrixDistance(Matrix2D m1, Matrix2D m2, int rows, int cols){
		double sum = 0;
		for(int i=0;i<rows;i++){
			for(int j=0;j<cols;j++){
				double diff = Math.abs(m1.getQuick(i,j) - m2.getQuick(i,j));
				sum += diff*diff;
			}
		}
		return Math.sqrt(sum);
	}
	
	public static String getFileExtension(String filename) {
	    String ext = "";
	    int i = filename.lastIndexOf('.');
	    if (i > 0 &&  i < filename.length() - 1) {
	        ext = filename.substring(i+1).toLowerCase();
	    }
	    return ext;
	} 
	public static void debug(String msg) {
		System.out.println(msg);		
	}
	
	public double[][] generateBiometric(String dir, String extension){
		List<String> newFileNames = parseDirectory("template","jpg");
		BufferedImage[] bufimgs = getGrayScaleImages(newFileNames);
		int imgNumber = newFileNames.size();
		double imgData[][][] = new double[imgNumber][imgH][imgW];
		Matrix2D[] imagesData = new Matrix2D[imgNumber];
		
		for(int i=0;i<bufimgs.length;i++){
			for(int j=0;j<imgH;j++){
				bufimgs[i].getData().getPixels(0,j,imgW,1,imgData[i][j]);
			}
			imagesData[i] = new Matrix2D(imgData[i]);
		}

		//calculate average image
		double[][] avg = new double[imgH][imgW];
		for(int i=0;i<imgH;i++){
			for(int j=0;j<imgW;j++){
				double sum = 0;
				for(int k=0;k<imgNumber;k++){
					sum += imagesData[k].getQuick(i,j);
				}
				avg[i][j] = sum/imgNumber;
			}
		}
		
		Matrix2D avgFace = new Matrix2D(avg);

		//calculate Gt
		Matrix2D cov = new Matrix2D(imgW, imgW);
		for(int i=0;i<imgNumber;i++){
			double[] data = imagesData[i].flatten();
			Matrix2D temp = new Matrix2D(data, imgH);
			temp.subtract(avgFace);
			Matrix2D tempTR =temp.transpose();
			Matrix2D mul = tempTR.multiply(temp);
			cov.add(mul);
		}
		for(int i=0;i<imgW;i++){
			for(int j=0;j<imgW;j++){
				cov.set(i,j, cov.getQuick(i,j)/imgNumber);
			}
		}
		//calculate eigenvectors
		EigenvalueDecomposition egdecomp = getEigenvalueDecomposition(cov);
		double[] eigenvalues = egdecomp.getEigenValues();
		double[][] eigvectors = egdecomp.getEigenVectors();
		sortEigenVectors(eigenvalues, eigvectors);
		Matrix2D[] eigenvectors = new Matrix2D[eigenfacesNumber];
		for(int i=0;i<eigenfacesNumber;i++){
			eigenvectors[i] = new Matrix2D(eigvectors[i], imgW);
			normalize(eigenvectors[i]);
		}

		List<String> testImgs;
		if(extension!=null){
			testImgs = parseDirectory(dir,extension);
		}else {
			testImgs = new ArrayList<String>();
			testImgs.add(dir);
			File temp = new File(dir);
			dir = temp.getParent();
		}
		BufferedImage[] bufimgsTest = getGrayScaleImages(testImgs);
		//assign name to people
		String[] object = new String[bufimgsTest.length];
		Iterator<String> it = testImgs.iterator();
		int ii=0;
		while(it.hasNext()){
			String name = it.next();
			name = name.substring(0, name.length()-6);
			object[ii++] = name;									
		}
		int imgNumberTest = testImgs.size();
		double imgDataTest[][][] = new double[imgNumberTest][imgH][imgW];
		Matrix2D[] imagesDataTest = new Matrix2D[imgNumberTest];

		
		for(int i=0;i<imgNumberTest;i++){
			for(int j=0;j<imgH;j++){
				bufimgsTest[i].getData().getPixels(0,j,imgW,1,imgDataTest[i][j]);
			}
			imagesDataTest[i] = new Matrix2D(imgDataTest[i]);
		}
		
		Matrix2D[] projected = new Matrix2D[imgNumberTest];
		for(int i=0;i<imgNumberTest;i++){
			double[][] res = new double[eigenfacesNumber][imgH];
			for(int j=0;j<eigenfacesNumber;j++){
				res[j] = imagesDataTest[i].multiply(eigenvectors[j]).flatten();
			}
			projected[i] = new Matrix2D(res);
			normalize(projected[i]);
		}

		double [][]vectorBio = new double [imgNumberTest][imgH];
		//output each matrix with name
		try{
			if(dir.endsWith("\\") || dir.endsWith("/"))
			{
				dir.subSequence(0, dir.length()-2);
			}
			PrintStream out = new PrintStream(dir+"\\biometric.txt");
			for(int i=0;i<imgNumberTest;i++){
				StringBuffer buf = new StringBuffer(testImgs.get(i) + " ");//////////////////////////////////----------->change(object[i] + " ");
				for(int j=0; j<eigenfacesNumber; j++){
					for(int k=0; k<imgH; k++) { 
						double d = projected[i].getQuick(j, k);
						buf.append(d + " ");
						vectorBio[i][k] = d;
					}
				}
				out.println(buf.toString());
			}
		}catch(IOException ex){
			ex.printStackTrace();
		}
		return vectorBio;
	}
}

class ImageDistanceInfo {	
	int index;
	double value;
	public ImageDistanceInfo(double value, int index) {
		this.value = value;
		this.index = index;
	}
	public int getIndex() {
		return index;
	}
	public double getValue() {
		return value;
	}
}

class MatchResult {
	private String matchFileName;
	private double matchDistance;
	public MatchResult(String matchFileName,double matchDistance){
		this.matchFileName=matchFileName;
		this.matchDistance=matchDistance;
	}
	public String getMatchFileName() {
		return matchFileName;
	}
	public void setMatchFileName(String matchFileName) {
		this.matchFileName = matchFileName;
	}
	public double getMatchDistance() {
		return matchDistance;
	}
	public void setMatchDistance(double matchDistance) {
		this.matchDistance = matchDistance;
	}
	
}
