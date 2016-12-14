package Server;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.InetAddress;
import java.net.ServerSocket;
import java.net.Socket;
import java.nio.charset.Charset;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.Arrays;
import java.util.Random;

import mainfunction.Vertify;

public class Server {

	public static void main(String[] args) throws Exception {
        System.out.println("The capitalization server is running.");
        int clientNumber = 0;
        ServerSocket listener = new ServerSocket(1512);
        InetAddress iAddress = InetAddress.getLocalHost();
        String currentIp = iAddress.getHostAddress();
        System.out.println("Current IP address : " +currentIp); //gives only host address
        try {
            while (true) {
                new Capitalizer(listener.accept(), clientNumber++).start();
            }
        } finally {
            listener.close();
        }
    }

	private static class Capitalizer extends Thread{
		private Socket socket;
        private int clientNumber;
        double[] BTC;

        public Capitalizer(Socket socket, int clientNumber) {
            this.socket = socket;
            this.clientNumber = clientNumber;
            readBTC();
            log("New connection with client# " + clientNumber + " at " + socket);
        }
        

    	static String readFile(String path, Charset encoding) 
    			  throws IOException 
    			{
    			  byte[] encoded = Files.readAllBytes(Paths.get(path));
    			  return new String(encoded, encoding);
    			}
    	public void readBTC(){
    		try {
    			String content = readFile("BTC.txt", StandardCharsets.UTF_8);
    			BTC = convertToDoubleAr(content);
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

        /**
         * Services this thread's client by first sending the
         * client a welcome message then repeatedly reading strings
         * and sending back the capitalized version of the string.
         */
        public void run() {
            try {

                // Decorate the streams so we can send characters
                // and not just bytes.  Ensure output is flushed
                // after every newline.
                BufferedReader in = new BufferedReader(
                        new InputStreamReader(socket.getInputStream()));
                PrintWriter out = new PrintWriter(socket.getOutputStream(), true);

                // Get messages from the client, line by line; return them
                // capitalized
                while (true) {
                    String input = in.readLine();
                    log("input:"+input);
                    String respone = "";
                    if (input.equals("getna")) {
                    	respone = generaNA();
                    }
                    if(input.equals("enrollment")){
                    	fileUtils.writetofile("BTC.txt", in.readLine());
                    	//fileUtils.writetofile("S.txt", in.readLine());
                    	respone = "enrollment_success";
                    }else if(input.equals("authentication")){
                    	Vertify vrt = new Vertify();
                    	int[] decodeCommitValue = new int[BTC.length], quatizaBio = new int[BTC.length];
                    	int[] keyDecode = vrt.vertify(BTC, getString2IntA(in.readLine()), decodeCommitValue, quatizaBio);
                    	respone = Arrays.toString(keyDecode);
                    }
                    out.println(respone);
                }
            } catch (IOException e) {
                log("Error handling client# " + clientNumber + ": " + e);
            } finally {
                try {
                    socket.close();
                } catch (IOException e) {
                    log("Couldn't close a socket, what's going on?");
                }
                log("Connection with client# " + clientNumber + " closed");
            }
        }
        
        int[] getString2IntA(String content){
        	String[] cnt = content.split(" ");
        	int[] result = new int[cnt.length];
        	for(int i = 0; i<result.length;i++){
        		result[i] = Integer.parseInt(cnt[i]);
        	}
        	return result;
        }
        
        String generaNA(){
        	String result = "";
    		Random rand = new Random();
    		for(int i = 0;i < 200;i++){
    			result+= rand.nextDouble();
    			if(i!=199)
    				result+=" ";
    		}
        	return result;
        }

        /**
         * Logs a simple message.  In this case we just write the
         * message to the server applications standard output.
         */
        private void log(String message) {
            System.out.println(message);
        }
	}

	
}
