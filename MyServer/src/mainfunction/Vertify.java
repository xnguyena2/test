package mainfunction;

import fuzzycommitment.FzzCmmt;

public class Vertify {
	FzzCmmt fzzCmmt;
	static int quatization = 200;
	static int delta = 30;
	static int core = 60;
	static double sqrt2 = Math.sqrt(2);
	public Vertify(){
		fzzCmmt = new FzzCmmt(delta,core,quatization);		
	}
	
	public int[] vertify(double[] mainBio, int[] fzzCmmtTransfo, int[] decodeCommitValue, int[] quatizaBio){

		int[] tempquatizaBio = fzzCmmt.QuatizationTransfo(mainBio, quatization/sqrt2);
		int[] tempdecodeCommitValue = fzzCmmt.FuzzyTransFoFunction(tempquatizaBio, fzzCmmtTransfo);
		int[] keyDecode = fzzCmmt.Decode(tempdecodeCommitValue);
		nativeCopy(tempdecodeCommitValue, decodeCommitValue);
		nativeCopy(tempquatizaBio,quatizaBio);
		return keyDecode;
	}
	
	void nativeCopy(double[] src, double[] dst){
		for(int i = 0;i<src.length;i++){
			dst[i] = src[i];
		}
	}
	
	void nativeCopy(int[] src, int[] dst){
		for(int i = 0;i<src.length;i++){
			dst[i] = src[i];
		}		
	}
}
