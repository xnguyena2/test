package MathUtils;

public class Binary {
	private static boolean bitOf(char in) {
	    return (in == '1');
	}

	private static char charOf(boolean in) {
	    return (in) ? '1' : '0';
	}
	
	public static String XOR(String lseq, String tseq){
		StringBuilder sb = new StringBuilder();

	    for (int i = 0; i < lseq.length(); i++) {
	        sb.append(charOf(bitOf(lseq.charAt(i)) ^ bitOf(tseq.charAt(i))));
	    }

	    String result = sb.toString();
	    
	    return result;
	}
}
