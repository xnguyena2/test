/*
 * This file is used as a reference from this link: 
 * https://www.dropbox.com/sh/7832vvyynmvb90h/AABCVnm39cSgPYr3iFfxZMk6a/keymanager/SecureSketch.java?dl=0
 */

package fuzzyext;

import java.math.BigInteger;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class GenerateKey {
	private int quantization;
	//threshold for error correction
	private int delta;
	private int[]  helperData;
	
	public GenerateKey() {
		//Default value
		quantization = 200;
		delta = 30;
		helperData = new int[quantization];
	}
	
	//Create key
	public int[] transformer(double[] features){
		int n = features.length;
		int[] res = new int[n];
		for(int i=0; i<n; i++){
			res[i] = (int)Math.round(features[i]*quantization);
		}
		return res;
	}
	
	public String GenKey(int[] feature)
	{
		int len = feature.length;
		int [] featureHash = new int [len];
		for(int i = 0; i < len; i++)
		{
			featureHash[i] = Integer.toString(feature[i]).hashCode();
		}

		int result = 0;
		for (int i =0; i < len; i ++)
		{
			result += featureHash[i];
		}
		String strResult = Integer.toString(result); 
		MessageDigest md5 = null;
		try {
			md5 = MessageDigest.getInstance("MD5");
		} catch (NoSuchAlgorithmException e) {
			// Show error
		}
		md5.update(StandardCharsets.UTF_8.encode(strResult));
		return String.format("%032x", new BigInteger(1, md5.digest()));
	}
	
	//Create sketch for quantized feature vectors
	public int[] sketchGeneration(int[] qFeatures){
		int n = qFeatures.length;
		int[] res = new int[n];
		for(int i=0; i<n; i++){
			res[i] = qFeatures[i] - getNearest(qFeatures[i]);
		}
		return res;
	}
	
	//Recover original feature from similar feature and sketch
	public int[] sketchRecover(int[] qFeatures, int[] sketch){
		int n = qFeatures.length;
		int[] res = new int[n];
		for(int i=0; i<n; i++){
			res[i] = getNearest(qFeatures[i] - sketch[i]) + sketch[i];
		}
		return res;
	}
	
	//get the nearest codeword from the provided value
	public int getNearest(int v){
		int min = v - delta;
		min = Math.max(min, 0);
		int max = v + delta;
		max = Math.min(max, quantization);
		for(int i=min; i<=max; i++){
			if(i % (2*delta+1) == 0)	//the distance between 2 nearest codewords is (delta + delta + 1)
				return i;
		}
		return -1;	//this will never happen
	}
	
	public int[] getHeperData()
	{
		return this.helperData;
	}
}
