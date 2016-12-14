package MathUtils;

import java.util.Arrays;

public class Convert {
	public static String E2H(int e,int length){
		if(e<=0)
			return "0";
		char[] charArray = new char[length];
		for(int i = 0;i < length;i++){
			if(length - i - 1 < e)
				charArray[i] = '1';
			else charArray[i] = '0';
		}
		String str = new String(charArray);
		return str;
	}
	
	static int H2E(String h){
		return h.length();
	}
}
