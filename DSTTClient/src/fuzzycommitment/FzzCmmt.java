package fuzzycommitment;

import java.util.Random;

/*
 * 
 * --------------------create by Nguyen Nam Tiep (51103624)------------------
 * -------------------helped by Professor Nguyen Thi Ai Thao-----------------
 * ---------------------------------HCMUt------------------------------------
 * 
 * 
 * */
public class FzzCmmt {
	private int fDelta = 30;//default value for PCA with Quatization is 200
	private int fCoreKey = 100;
	private int fQuantization = 200;
	private double sqrt2 = Math.sqrt(2);
	
	public FzzCmmt(){};// default init
	
	public FzzCmmt(int Delta, int Core, int Quatization)//
	{
		this.fCoreKey = Core;
		this.fDelta = Delta;
		this.fQuantization = Quatization;
	}
	
	public void changeCoreFzz(int delta, int coreKey){
		this.fDelta = delta;
		this.fCoreKey = coreKey;
	}

	public int[] QuatizationTransfo(double[] vectorBiometric){
		int vectorLength = vectorBiometric.length;
		int[] quatizVector = new int[vectorLength];
		for(int i=0; i<vectorLength; i++){
			quatizVector[i] = (int)Math.round(vectorBiometric[i]*fQuantization/sqrt2);
		}
		return quatizVector;
	}

	public int[] QuatizationTransfo(double[] vectorBiometric,double quatizationDouble){
		int vectorLength = vectorBiometric.length;
		int[] quatizVector = new int[vectorLength];
		for(int i=0; i<vectorLength; i++){
			quatizVector[i] = (int)Math.round(vectorBiometric[i]*quatizationDouble);
		}
		return quatizVector;
	}
	
	public int[] FuzzyTransFoFunction(int[] vectorBiometric, int[] key)// create commit value before transfo
	{
		int length = vectorBiometric.length;
		int[] commitValue = new int[length];
		if(length != key.length || length < 1)
			return null;
		else {
			for(int i = 0;i < length;i++){
				commitValue[i] = vectorBiometric[i] - key[i];
			}
		}
		return commitValue;
	}
	
	/*General key from Core*/
	public int[] KeyGen(int keyLength)// key format [Core*a, Core*b, Core*c,....] (a,b,c,...) is set of random Integer number
	{
		Random rand = new Random();
		int min = -1000, max = 1000;
		int[] key = new int[keyLength];
		for(int i = 0;i < keyLength;i++){
			key[i] = (rand.nextInt((max - min) + 1) + min)*this.fCoreKey;
		}
		return key;
	}
	
	/*General key from Core*/
	public int[] KeyGenR(int keyLength, int[] realKey)// key format [Core*a, Core*b, Core*c,....] (a,b,c,...) is set of random Integer number
	{
		Random rand = new Random();
		int min = -1000, max = 1000;
		int[] key = new int[keyLength];
		//realKey = new int[keyLength];
		for(int i = 0;i < keyLength;i++){
			realKey[i] = (rand.nextInt((max - min) + 1) + min); 
			key[i] = realKey[i]*this.fCoreKey;
		}
		return key;
	}
	
	/*Decode*/
	public int[] Decode(int[] CommitValue)
	{
		boolean isErrorWhenDecode = false;
		int commitLength = CommitValue.length;
		int[] nearestKey = new int[commitLength];
		for(int i = 0;i < commitLength;i++){
			int dau = 1;
			if(CommitValue[i]<0)
				dau = -1;
			CommitValue[i]*=dau;
			int secretIndex = CommitValue[i]/this.fCoreKey;
			int offset = CommitValue[i] - this.fCoreKey*secretIndex;
			if(offset <= this.fDelta){
				nearestKey[i] = dau*secretIndex*this.fCoreKey;
			}else if(((secretIndex+1)*this.fCoreKey - CommitValue[i]) <= this.fDelta){
				nearestKey[i] = dau*(secretIndex+1)*this.fCoreKey;
			}
			else{
				isErrorWhenDecode = true;
			}
			CommitValue[i]*=dau;
		}
		if(!isErrorWhenDecode){
			return nearestKey;
		}else 
			return null;
	}
	
}
