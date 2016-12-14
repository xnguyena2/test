package client;

import java.util.Random;

public class Calculator {
	//--------------------------------------------
	// MATH FUNCTIONS
	//--------------------------------------------
	// Rounding a double number with n number after "."
	public static double rounding(double number, int n)
	{
		int exp = (int)(Math.pow(10, n));
		int number_exp = (int) (number * exp);
		double result = (double)number_exp/exp;
		//double result = (double)Math.round(number*exp)/exp;
		return result;
	}

	// Xor 2 bit
	private static int xorInt(int bit1, int bit2)
	{
		if (bit1 == bit2)
			return 0;
		return 1;
	}
	
	// Xor 2 binary array with different length 
	public static char[] xor2binaryArray(char[] arr1, char[] arr2)
	{
		int size = Math.max(arr1.length, arr2.length);
		char []temp1 = binaryToBinaryNbit(arr1, size);
		char []temp2 = binaryToBinaryNbit(arr2, size);
	
		char []result = new char[size];
		for (int i = 0; i < size; i++)
		{
			result[i] =Integer.toBinaryString(( xorInt((int)temp1[i], (int)temp2[i]))).toCharArray()[0];
		}
		return result;
	}
	
	// Convert string to binary array
	public static char[] stringToBinaryArray(String str)
	{
		char[] cArray = str.toCharArray();
		char[] result = new char[cArray.length * 8]; // each element will export to 8 bit binary
		char [] temp; // temporary array to save binary array of each element string
		for (int i = 0; i < cArray.length; i++)
		{
			temp = charToBinary8bit(cArray[i]);
			for (int j = 0; j < 8; j++) {
				result[(i * 8)+j] = temp[j];
			}
		}
		return result;
	}
	
	// Xor 2 string -> binary String
	public static String xor2String(String str1, String str2)
	{
		char[] cArr = xor2binaryArray(stringToBinaryArray(str1), stringToBinaryArray(str2));
		String result = new String(cArr);
		cArr = null;
		return result;
	}
	
	// Convert binary array to array n bit
	public static char[] binaryToBinaryNbit(char[] arr, int n)
	{
		int len = arr.length;
		if (len >= n)
		{
			return arr;
		}
		else
		{
			char [] result = new char[n];
			for (int i = 0; i < n; i++)
			{
				result[i] = '0';
			}
			
			for(int i = 0; i < len; i++)
			{
				result[(n - len) + i] = arr[i];
			}
			return result;
		}
	}

	// Convert 1 int to binary array 8 bit
	private static char[] intToBinary8bit(int iData)
	{
		String str = Integer.toBinaryString(iData);
		char[] result = binaryToBinary8bit( str.toCharArray());
		return result;
	}
	
	// Convert binary array < 8 bit to array 8 bit
	private static char[] binaryToBinary8bit(char data[])
	{
		int len = data.length;
		if(len == 8)
		{
			return data;
		}
		return binaryToBinaryNbit(data, 8);
	}

	// Convert binary 1 char to 1 8bit binary array
	private static char[] charToBinary8bit(char cData)
	{
		int iChar = (int)cData;
		return intToBinary8bit(iChar);
	}
	
	// Compare 2 string
	public static boolean compareString(String str1, String str2)
	{
		if (str1.equals(str2))
			return true;
		return false;
	}
	
	// Hash message
	public static String hash(String message)
	{
		int m = message.hashCode();
		return Integer.toString(m);
	}
	
	// Random an integer number < 10e6 and >=1
	public static int randomIntNumber()
	{
		Random r = new Random();
		return r.nextInt(999999) + 1;
	}
	
	// Random an double number around [-1,1]
	public double randomDouble()
	{
		Random r = new Random();
		boolean bl =r.nextBoolean();
		if(bl == true)
			return r.nextDouble();
		return -r.nextDouble();
	}
	
	// Random ID 32 characters
	public String randomID()
	{
		Random r = new Random();
		String result = "";
		for (int i =0; i < 32; i++)
		{
			result += Integer.toString(r.nextInt(10));
		}
		return result;
	}
	
	// Calculate Chebyshev algorithm Tn(x)
	public static double chebyshev(int n, double x )
	{
		return  Math.cos(n*Math.acos(x));
	}
	
	// Change String to arraydouble
	public static int[] getArrayfromString(String string) {
	    String[] strings = string.replace("[", "").replace("]", "").split(", ");
	    int result[] = new int[strings.length];
	    for (int i = 0; i < result.length; i++) {
	    	result[i] = Integer.parseInt(strings[i]);
	    }
	    return result;
	}	
	
	public static String ArrayToStringOneWay(int [] data)
	{
		String result = "";
		for(int i = 0; i< data.length; i++)
		{
			result += Integer.toString(data[i]);
		}
		return result;
	}
}
