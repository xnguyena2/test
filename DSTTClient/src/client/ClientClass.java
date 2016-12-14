package client;
import hep.aida.ref.Test;

import java.net.Socket;
import java.security.NoSuchAlgorithmException;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Arrays;
import java.util.Calendar;
import java.io.*;

import javafaces.FaceRecognition;
import fuzzyext.*;

import com.mysql.jdbc.Connection;
import com.mysql.jdbc.Statement;

public class ClientClass {
	private int port;
	private String IP;
	private Socket socket;
	BufferedReader inFromServer;
	DataOutputStream outToServer;
	private Connection connectData;
	private Statement stmData;
	
	public ClientClass(int port, String IP)
	{
		this.port = port;
		this.IP = IP;
		this.connectData = null;
		this.stmData = null;
	}
	
	// Send message to server
	private void sendMessage(DataOutputStream dataOut, String  message)
	{
		try {
			dataOut.writeBytes(message + "\n");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			System.out.println("Error send message");
		}
	}
	
	// Get message from server
	private String getMessage(BufferedReader dataInt)
	{
		try {
			String result = dataInt.readLine();
			return result;
		} catch (IOException e) {
			// TODO Auto-generated catch block
			return "";
		}
	}
	
	private void connect()
	{
		try {
			
			this.socket = new Socket(this.IP, this.port);
			this.inFromServer = new BufferedReader(
					new InputStreamReader(this.socket.getInputStream()));
			this.outToServer = new DataOutputStream(this.socket.getOutputStream());
		} catch (IOException e) {
			System.out.println("Can't connect to server, try again late...\n");
		}
	}

	private void close()
	{
		try {
			this.socket.close();
			System.out.println("Disconnected to server.");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			System.out.println("Socket are closed before.");
		}
	}
	
	// Connect to database
	private boolean connecToDatabase(String URL, String user, String pass)
	{
		try {
			Class.forName("com.mysql.jdbc.Driver");
		      this.connectData =  (Connection) DriverManager.getConnection(URL, user, pass);
		      this.stmData = (Statement) this.connectData.createStatement();
			return true;
		} catch (ClassNotFoundException | SQLException e) {
			System.out.println("Error, cant connect to database");
			return false;
		}
	}

	// Execute query that do not get value return
	private void execute(String queryString)
	{
		System.out.println("Executing: "+ queryString);
		try {
			this.stmData.execute(queryString);
		} catch (SQLException e) {
			System.out.println("Can't execute");
		}
	}
	
	// Execute query getting return value
	private ResultSet executeQuery(String query)
	{
		System.out.println("Executing "+ query);
		try {
			ResultSet rs = this.stmData.executeQuery(query);
			return rs;
		} catch (SQLException e) {
			return null;
		}
	}
	
	// Close connection database
	private void closeDatabase()
	{
		try {
			this.stmData.close();
			this.connectData.close();
			System.out.println("Connection to database has been closed.");
		} catch (SQLException e) {
			System.out.println("Error: Close");
		}
	}
	
	// Register request function to server
	private int registerPhase(double [] Bi_raw, String password)
	{
		sendMessage(outToServer, "REG");
		// Get biometric from user
		GenerateKey genkey = new GenerateKey();
		int [] Bi = genkey.transformer(Bi_raw);
		int [] helper = genkey.sketchGeneration(Bi);
		String HD = Arrays.toString(helper);
		// Use fuzzy ext to general helper data and K		
		String Ki = genkey.GenKey(Bi);
		// Calculate BBi
		
		String BBi = Calculator.xor2String(Calculator.ArrayToStringOneWay(Bi), Ki);
		String hashKi_cc_PW = Calculator.hash(Ki+password);
	    sendMessage(outToServer, BBi);
	    sendMessage(outToServer, hashKi_cc_PW);
	    
	    // Wait for server
	    // Get from server
	    String flag = getMessage(inFromServer);
	    if(flag.equals("false") == true)
	    {
	    	System.out.println("Can not register this account");
	    	return 0;
	    }
	    
	    String O1 = getMessage(inFromServer);
	   // System.out.println("Get O1 " + O1);
	    String O2 = getMessage(inFromServer);
	   // System.out.println("Get O2 " + O2);
	    String s = getMessage(inFromServer);
	    //System.out.println("Get s " + s);
	    String SPUB = getMessage(inFromServer);
	    //System.out.println("Get SPUB = " + SPUB);
	    String id = getMessage(inFromServer);
	    
		//Calendar calendar = Calendar.getInstance();
		//System.out.println(System.currentTimeMillis());
	    /*
	     * Save HD, O1, O2, s, SPUB to database. Finished register phase.
	     */
		connecToDatabase("jdbc:mysql://localhost/client_database", "root", "dissertation");
		String query = "INSERT INTO user_client values("
				+ id +", '" 
				+ HD + "', '"
				+ O1 + "', '"
				+ O2 + "', "
				+ s + ", "
				+ SPUB + ")";
		execute(query);
		closeDatabase();
		return Integer.parseInt(id);
	}
	
	private boolean loginPhase(double[] Bi_raw, int id, String password)
	{
		sendMessage(outToServer, "LOG");
		Calendar calendar = Calendar.getInstance();
		String HD, O1, O2;
		double s, SPUB;
		// Get data from database
		connecToDatabase("jdbc:mysql://localhost/client_database", "root", "dissertation");
		String query = "SELECT hd, o1, o2, s, spub FROM user_client WHERE id = " + id + ";";
		ResultSet rs = executeQuery(query);
		try {
			if(rs.next() == false)
			{
				System.out.println("No data with id = "+ id);
				closeDatabase();
				return false;
			}
			HD = rs.getString("hd");
			O1 = rs.getString("o1");
			O2 = rs.getString("o2");
			s = Double.parseDouble(rs.getString("s"));
			SPUB = Double.parseDouble(rs.getString("spub"));
		} catch (SQLException e) {
			closeDatabase();
			return false;
		}
		closeDatabase();
		// Get Ki from HD,  Bi and Fuzzy
		GenerateKey genkey = new GenerateKey();
		int [] BiTransform = genkey.transformer(Bi_raw);
		int [] helper = Calculator.getArrayfromString(HD);
		
		int [] Bi = genkey.sketchRecover(BiTransform, helper);
		
		String Ki = genkey.GenKey(Bi);
		//System.out.println("BiTrans       =" + Arrays.toString(BiTransform));
		//System.out.println("BiTransCrrc=" + Arrays.toString(Bi));
		//System.out.println("Ki=" + Ki);
		String h_Ki_PW = Calculator.hash((Ki+ password));
		int Rc = Calculator.randomIntNumber();
		double M1 = Calculator.chebyshev(Rc, s);
		double M2 = Calculator.chebyshev(Rc, SPUB);
		double M2_mod = Calculator.rounding(M2, 2);
		//Math.floor(M2 * 10000) / 10000; // need another function
		
		//Get time now
		long t1 = System.currentTimeMillis();
		String alpha = Calculator.xor2String(h_Ki_PW, Calculator.hash((
				Double.toString(M1) + Double.toString(M2_mod) + Long.toString(t1))));
		
		sendMessage(outToServer, alpha);
		sendMessage(outToServer, ""+alpha.length());
		sendMessage(outToServer, O1);
		sendMessage(outToServer, O2);
		sendMessage(outToServer, Double.toString(M1));
		sendMessage(outToServer, Long.toString(t1));
		sendMessage(outToServer, Integer.toString(id));
		
		// Waiting server
		// Get flag before continue
		String flag = getMessage(inFromServer);
		if (flag.equals("false"))
		{
			System.out.println("Server deny");
			//System.out.println("M2_mod = " + M2_mod);
			//System.out.println("M2 = " + M2);
			//System.out.println("t1 = " + t1);
			return false;
		}
		String M3 = getMessage(inFromServer);
		long t = System.currentTimeMillis();
		String beta = getMessage(inFromServer);
		String t2 = getMessage(inFromServer);		
		// Checking time
		if((t - Long.parseLong(t2)) > 500)
		{
			System.out.println("Fail at t2");
			sendMessage(outToServer, "false");
			return false;
		}
		
		String betacp = Calculator.hash((Double.toString(M2_mod) + M3 + t2));
		if(Calculator.compareString(beta, betacp) == false)
		{
			//send to server.
			System.out.println("Client deny at beta");
			sendMessage(outToServer, "false");
			return false;
		}	
		
		double M4 = Calculator.chebyshev(Rc, Double.parseDouble(M3));
		double M4_mod = Calculator.rounding(M4, 2);//Math.floor(M4 * 10000) / 10000;

		long t3 = System.currentTimeMillis();
		String gama = Calculator.hash(Double.toString(M2_mod) + Double.toString(M4_mod) + t3);
		sendMessage(outToServer, "true");
		sendMessage(outToServer, gama);
		sendMessage(outToServer, Long.toString(t3));
		
		// Wait server.
		flag = getMessage(inFromServer);
		if(flag.equals("false"))
		{
			System.out.println("Server deny");
			//System.out.println("Fail M2mod = "+ M2_mod);
			//System.out.println("Fail M4mod = "+ M4_mod);
			return false;
		}
		System.out.println("Login successfully");
		return true;
	}
	
	public static void test()
	{
		 FaceRecognition faceRec = new FaceRecognition();
		 long start_time = 0;
		 long end_time = 0;
		 System.out.println("Generating data biometric for REGISTATION from test folder");
		 double [][] listTestBiometricR = faceRec.generateBiometric("test\\RegIMG", "jpg");
		 int len = listTestBiometricR.length;
		 
		 
		 int[] listID = new int[len];
		 // Registering.... 
		 System.out.println("Registering...");
		 
		 int regSuccess = 0;
		 int logSuccess = 0;
		 for(int i =0; i < len; i++)
		 {
			 ClientClass cliTest = new ClientClass(7777, "127.0.0.1");
			 cliTest.connect();
			 listID[i] = cliTest.registerPhase(listTestBiometricR[i], "password");
			 if(listID[i] >0) 
			 {
				 regSuccess++;
			 }
			 cliTest.close();
		 }
		PrintStream out = null;
		StringBuffer buf = new StringBuffer();
		StringBuffer buf2 = new StringBuffer();
		
		long t1,t2;
		try {
			out = new PrintStream("test\\result.txt");
		} catch (FileNotFoundException e) {
			//todo
		}
		 
		//---------------------------START TEST 1---------------------
		 start_time = System.currentTimeMillis();
		 double [][] listTestBiometricL = faceRec.generateBiometric("test\\LogIMG", "jpg");
		 //double [][] listTestBiometricL = listTestBiometricR;
		 // Logging....
		 System.out.println("Logging...");
		 for(int i = 0; i < len; i++)
		 {
			 if(listID[i] == 0) 
			 {
				 continue;
			 }
			 
			 t1 = System.currentTimeMillis();
			 ClientClass cliTest = new ClientClass(7777, "127.0.0.1");
			 cliTest.connect();
			 boolean isLog = cliTest.loginPhase(listTestBiometricL[i], listID[i], "password");
			 if(isLog == true)
			 {
				 System.out.println("Login successfully with id " + listID[i]);
				 logSuccess ++;
				 t2 = System.currentTimeMillis();
				 buf.append("ID: " + listID[i] + " -  Time for login: " + (t2-t1)+" (ms)"+"\n");
			 }
			 else 
			 {
				 System.out.println("FAILED login with id " + listID[i]);
				 buf2.append("FAILED login with id " + listID[i]+"\n");
			 }
			 cliTest.close(); 
		 }
		 end_time = System.currentTimeMillis();
		 
		 System.out.println("Finished test");
		 System.out.println("-------------------------------------------");
		 System.out.println("Number register: " + len);
		 System.out.println("Number register successfully: "+ regSuccess);
		 System.out.println("Number login successfully: "+ logSuccess);
		 buf.append("-------------------------------------------\n");
		 buf.append("Number register: " + len+"\n");
		 buf.append("Number register successfully: "+ regSuccess+"\n");
		 buf.append("Number login successfully: "+ logSuccess+"\n");
		 buf.append("Total time : " + (end_time - start_time));
		 out.println(buf.toString());
		 out.println(buf2.toString());
		 out.close();
		 
		//---------------------------START TEST FAIL---------------------
		 
		 for (int numtest = 1; numtest <=3; numtest++)
		 {
			 // Test login with fail img
			 PrintStream outFail = null;
			StringBuffer bufFail = new StringBuffer();
			StringBuffer bufFail2 = new StringBuffer();
			logSuccess = 0;
			try {
				outFail = new PrintStream("test\\result_fail"+numtest+".txt");
			} catch (FileNotFoundException e) {
				//todo
			}
			 start_time = System.currentTimeMillis();
			 double [][] listTestBiometricFail = faceRec.generateBiometric("test\\LogIMG_Fail"+numtest, "jpg");
			 for(int i = 0; i < len; i++)
			 {
				 if(listID[i] == 0) 
				 {
					 continue;
				 }
				 
				 t1 = System.currentTimeMillis();
				 ClientClass cliTest = new ClientClass(7777, "127.0.0.1");
				 cliTest.connect();
				 boolean isLog = cliTest.loginPhase(listTestBiometricFail[i], listID[i], "password");
				 if(isLog == true)
				 {
					 logSuccess ++;
					 t2 = System.currentTimeMillis();
					 bufFail.append("ID: " + listID[i] + " -  Time for login: " + (t2-t1)+" (ms)"+"\n");
				 }
				 else 
				 {
					 bufFail2.append("FAILED login with id " + listID[i]+"\n");
				 }
				 cliTest.close(); 
			 }
			 
			 end_time = System.currentTimeMillis();
			 
			 bufFail.append("-------------------------------------------\n");
			 bufFail.append("Number register: " + len+"\n");
			 bufFail.append("Number register successfully: "+ regSuccess+"\n");
			 bufFail.append("Number login successfully: "+ logSuccess+"\n");
			 bufFail.append("Total time: "+ (end_time - start_time)+" (ms)\n");
			 outFail.println(bufFail2.toString());
			 outFail.println(bufFail.toString());
			 
			 out.close();
		 }
	}
	
	public static void testPerson()
	{
		 FaceRecognition faceRec = new FaceRecognition();
		 System.out.println("Generating data biometric for REGISTATION from test folder");
		 double [][] listTestBiometricR = faceRec.generateBiometric("per\\RegIMG", "jpg");
		 int len = listTestBiometricR.length;
		 int id;
		 // Registering.... 
		 System.out.println("Registering...");
		 int regSuccess = 0;
		 int logSuccess = 0;
		 
		 if(len > 0)
		 {
			 ClientClass cliTest = new ClientClass(7777, "127.0.0.1");
			 cliTest.connect();
			 id = cliTest.registerPhase(listTestBiometricR[0], "password");
			 if(id == 0) 
			 {
				 System.out.println("Can't register");
				 return;
			 }
			 cliTest.close();
		 }
		 else
		 {
			 return;
		 }
			 
		 double [][] listTestBiometricL = faceRec.generateBiometric("per\\LogIMG\\duong2", "jpg");
		 //double [][] listTestBiometricL = listTestBiometricR;
		 // Logging....
		 System.out.println("Logging...");
		 for(int i = 0; i < listTestBiometricL.length; i++)
		 {
			 ClientClass cliTest = new ClientClass(7777, "127.0.0.1");
			 cliTest.connect();
			 boolean isLog = cliTest.loginPhase(listTestBiometricL[i], id, "password");
			 if(isLog == true)
			 {
				 System.out.println("Login successfully with id " + id);
				 logSuccess ++;
			 }
			 cliTest.close(); 
		 }
		 
		 System.out.println("Login sucessfully: " + logSuccess +"/" + listTestBiometricL.length);
	}
		
public int enroll(String pass) {
		// TODO Auto-generated method stub
	connecToDatabase("jdbc:mysql://localhost/client_database", "root", "dissertation");
	System.out.println("CONNECTED DB");
	String query = "DELETE FROM user_client WHERE 1;";
	execute(query);
	closeDatabase();
    ClientClass client = new ClientClass(7777, "127.0.0.1");
	client.connect();	
	FaceRecognition face = new FaceRecognition();
	double [][] listBi = face.generateBiometric("tmp", "jpg");
	double [] Bi = listBi[0];
	System.out.println("register with pass: " + pass);
    return client.registerPhase(Bi, pass);
    
}
public boolean login(String password)
{
	String id= "";
	connecToDatabase("jdbc:mysql://localhost/client_database", "root", "dissertation");
	System.out.println("CONNECTED DB");
	String query = "SELECT * FROM user_client;";
	ResultSet rs = executeQuery(query);
	try {
		if(rs.next() == false)
		{
			System.out.println("No data");
			closeDatabase();
		}
		id  = rs.getString("id");
		
		ClientClass client = new ClientClass(7777, "127.0.0.1");
		client.connect();	
		FaceRecognition face = new FaceRecognition();
		double [][] listBi = face.generateBiometric("tmp", "jpg");
		double [] Bi = listBi[0];
		System.out.println("ID = " + id);
	    return client.loginPhase(Bi, Integer.parseInt(id), password);

	} catch (SQLException e) {
		closeDatabase();
	}
	return false;
}
}
