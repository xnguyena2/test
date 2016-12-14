package gui;

import java.awt.EventQueue;
import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.Image;
import java.awt.Rectangle;
import java.awt.Toolkit;

import client.*;

import javax.imageio.ImageIO;
import javax.swing.JFrame;

import com.jgoodies.forms.layout.FormLayout;
import com.jgoodies.forms.layout.ColumnSpec;
import com.jgoodies.forms.layout.RowSpec;

import javax.swing.GroupLayout;
import javax.swing.GroupLayout.Alignment;
import javax.swing.JButton;
import javax.swing.LayoutStyle.ComponentPlacement;

import java.awt.event.ActionListener;
import java.awt.event.ActionEvent;
import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.IOException;

import javax.swing.JDialog;
import javax.swing.JOptionPane;
import javax.swing.JPasswordField;
import javax.swing.JTextField;
import javax.swing.JPanel;
import javax.swing.JEditorPane;
import javax.swing.JLabel;
import javax.swing.ImageIcon;

import org.opencv.core.Core;
import org.opencv.core.Mat;
import org.opencv.core.MatOfByte;
import org.opencv.highgui.Highgui;
import org.opencv.highgui.VideoCapture;

public class GuiClient {
	private ClientClass client = new ClientClass(7777, "172..0.0.1");
	static String FILE_BIO = "biometric.jpg";
	private DaemonThread myThread = null;
	int count = 0;
	VideoCapture webSource = null;
	Mat frame = new Mat();
	MatOfByte mem = new MatOfByte();
	
	private JFrame jframe;
	private JTextField txtPass;
	private JButton btn_register;
	private JButton btn_takePhoto;
	JButton btn_clear;
	JButton btn_login;
	JPanel panel;

	/**
	 * Launch the application.
	 */
	public static void main(String[] args) {
		System.loadLibrary(Core.NATIVE_LIBRARY_NAME);
		EventQueue.invokeLater(new Runnable() {
			public void run() {
				try {
					GuiClient window = new GuiClient();
					window.jframe.setVisible(true);
					window.startCapture();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		});
	}

	/**
	 * Create the application.
	 */
	public GuiClient() {
		initialize();
	}
	
	public void resize(String inputImagePath,
            String outputImagePath, int scaledWidth, int scaledHeight)
            throws IOException {
        // reads input image
        File inputFile = new File(inputImagePath);
        BufferedImage inputImage = ImageIO.read(inputFile);
 
        // creates output image
        BufferedImage outputImage = new BufferedImage(scaledWidth,
                scaledHeight, inputImage.getType());
 
        // scales the input image to the output image
        Graphics2D g2d = outputImage.createGraphics();
        g2d.drawImage(inputImage, 0, 0, scaledWidth, scaledHeight, null);
        g2d.dispose();
 
        // extracts extension of output file
        String formatName = outputImagePath.substring(outputImagePath
                .lastIndexOf(".") + 1);
 
        // writes to output file
        ImageIO.write(outputImage, formatName, new File(outputImagePath));
    }
	
	private void resize(String inputImagePath,String outputImagePath, double percent) throws IOException {
        File inputFile = new File(inputImagePath);
        BufferedImage inputImage = ImageIO.read(inputFile);
        int scaledWidth = (int) (inputImage.getWidth() * percent);
        int scaledHeight = (int) (inputImage.getHeight() * percent);
        resize(inputImagePath, outputImagePath, scaledWidth, scaledHeight);
    }
	
	private BufferedImage cropImage(File fileIMG, Rectangle rect) {
		BufferedImage src;
		try {
			src = ImageIO.read(fileIMG);
			BufferedImage dest = src.getSubimage(104, 0, rect.width, rect.height);
			return dest; 
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	
	private void makeIMG(BufferedImage bufferedImage, String filepath)
	{
		File outputfile = new File(filepath);
		if(outputfile.exists())
		{
			outputfile.delete();
		}
		try {
			ImageIO.write(bufferedImage, "jpg", outputfile);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public void startCapture() {
		webSource =new VideoCapture(0);
		myThread = new DaemonThread();
		Thread t = new Thread(myThread);
		t.setDaemon(true);
		myThread.runnable = true;
		t.start();
	}
	
	public static void setWarningMsg(String text){
	    Toolkit.getDefaultToolkit().beep();
	    JOptionPane optionPane = new JOptionPane(text,JOptionPane.WARNING_MESSAGE);
	    JDialog dialog = optionPane.createDialog("Warning!");
	    dialog.setAlwaysOnTop(true);
	    dialog.setVisible(true);
	}
	/**
	 * Initialize the contents of the frame.
	 */
	private void initialize() {
		jframe = new JFrame();
		jframe.setBounds(100, 100, 419, 448);
		jframe.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		jframe.getContentPane().setLayout(null);
		txtPass = new JPasswordField();
		txtPass.setColumns(10);
		txtPass.setBounds(127, 326, 206, 20);
		jframe.getContentPane().add(txtPass);
		
		btn_register = new JButton("Register");
		btn_register.setBounds(10, 361, 87, 23);
		jframe.getContentPane().add(btn_register);
		
		btn_takePhoto = new JButton("Take");
		
		btn_takePhoto.setBounds(107, 361, 87, 23);
		jframe.getContentPane().add(btn_takePhoto);
		
		btn_login = new JButton("Login");
		btn_login.setBounds(306, 361, 87, 23);
		jframe.getContentPane().add(btn_login);
		
		JLabel lblPassword = new JLabel("Password:");
		lblPassword.setBounds(55, 326, 68, 20);
		jframe.getContentPane().add(lblPassword);
		
		panel = new JPanel();
		panel.setBounds(10, 11, 383, 287);
		jframe.getContentPane().add(panel);
		
		btn_clear = new JButton("Clear");
		btn_clear.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				File fileIMG = new File("tmp/" + FILE_BIO);
				if (fileIMG.exists())
				{
					fileIMG.delete();
				}
				btn_login.setEnabled(false);
				btn_register.setEnabled(false);
				btn_clear.setEnabled(false);
				btn_takePhoto.setEnabled(true);
				startCapture();
			}
		});
		btn_clear.setBounds(204, 361, 87, 23);
		jframe.getContentPane().add(btn_clear);
		
		btn_takePhoto.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				File file = new File("tmp/" + FILE_BIO);
				Highgui.imwrite(file.getPath(), frame);
				
				BufferedImage buffer_newIMG = cropImage(file, new Rectangle(432, 480));
				makeIMG(buffer_newIMG, file.getPath());
				try {
					resize("tmp/" + FILE_BIO, "tmp/" + FILE_BIO, 0.417);
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
				myThread.runnable = false;            
	            webSource.release();
	            
	            btn_login.setEnabled(true);
	            btn_clear.setEnabled(true);
	            btn_register.setEnabled(true);
	            btn_takePhoto.setEnabled(false);
			}
		});
		
		btn_register.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				String password = txtPass.getText();
				if(password.isEmpty())
				{
					setWarningMsg("Please insert your password.");
					return;
				}
				
				//ClientClass client = new ClientClass(7777, "172..0.0.1");
				int id = client.enroll(password);
				if(id != 0)
				{
					setWarningMsg("REGISTER SUCCESSFULLY.");
				}
				
				File fileIMG = new File("tmp/" + FILE_BIO);
				if (fileIMG.exists())
				{
					//fileIMG.delete();
				}
			}
		});
		btn_login.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				
				File fileIMG = new File("tmp/" + FILE_BIO);
				if (!fileIMG.exists())
				{
					setWarningMsg("Can not find the bio");
				}
				else
				{
					String password = txtPass.getText();
					if(password.isEmpty())
					{
						setWarningMsg("Please insert your password.");
						return;
					}
					
					System.out.println("login with pass: " + password);
					if(client.login(password) == true)
					{
						setWarningMsg("LOGIN SUCCESSFULLY");
					}
					else
					{
						setWarningMsg("LOGIN FAILED");
					}
					fileIMG.delete();
				}		
			}
		});
		btn_login.setEnabled(false);
		btn_register.setEnabled(false);
		btn_clear.setEnabled(false);
	}

	class DaemonThread implements Runnable
	{
	    protected volatile boolean runnable = false;

	    @Override
	    public  void run()
	    {
	        synchronized(this)
	        {
	            while(runnable)
	            {
	                if(webSource.grab())
	                {
						try
						{
							webSource.retrieve(frame);
							Highgui.imencode(".bmp", frame, mem);
							Image im = ImageIO.read(new ByteArrayInputStream(mem.toArray()));

							BufferedImage buff = (BufferedImage) im;
							Graphics g=panel.getGraphics();

							if (g.drawImage(buff, 0, 0, jframe.getWidth(), jframe.getHeight() -150 , 0, 0, buff.getWidth(), buff.getHeight(), null))
							
							if(runnable == false)
										{
								System.out.println("Going to wait()");
								this.wait();
							}
						}
						catch(Exception ex)
						{
						}
	                }
	            }
	        }
		}
	}
}