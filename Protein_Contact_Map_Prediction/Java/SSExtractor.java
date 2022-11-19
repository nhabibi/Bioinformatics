import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStreamReader;


public class SSExtractor {

	private final static String RUNPSIPREDPATH = "F:\\Bio\\Tools\\psipred261\\";
	//private final static String WORKSPACE = "C:\\Users\\Narges\\workspace\\Thesis\\";
	
	
    public void extractSS(String FastaPath,String SSPath){
		
		try{
			     String[] list = new File(FastaPath).list();
		         for(int i=0; i<list.length; ++i){
			 	     //Run runpsipred.bat for this fasta file
		        	 String fileName = list[i].substring(0, list[i].indexOf('.'));
				     String command = RUNPSIPREDPATH+"runpsipred.bat  "+FastaPath+fileName+".fasta";
				     Process p = Runtime.getRuntime().exec(command);
		             BufferedReader brProcess = new BufferedReader(new InputStreamReader(p.getInputStream()));
		             String lineProcess = "";
		             while ((lineProcess = brProcess.readLine()) != null) {
		                   System.out.println(lineProcess);
		             }
		             brProcess.close();
		             p.waitFor();
		             System.out.println("p.exitValue() = " + p.exitValue());
		             //Extract and save predicted SS
		             BufferedReader brHoriz = new BufferedReader(new InputStreamReader(new FileInputStream( FastaPath+fileName+".fasta"+".horiz" )));
		             String lineHoriz ="";
		             String SS = "";
		             while ((lineHoriz = brHoriz.readLine()) != null ){
		        	       if( lineHoriz.startsWith("Pred") )
		        		        SS += lineHoriz.substring(lineHoriz.lastIndexOf(" ")+1);
		             }
		             BufferedWriter bwSS = new BufferedWriter( new FileWriter(SSPath+fileName+".ss"));
		             bwSS.append(SS);
		             bwSS.close();
		       }//for
		         
//TODO : delete all files except FASTA ones	
		         
        }//try
		
		catch(IOException ioe){
			System.out.println(ioe.getMessage());
		}
		catch(InterruptedException iee ){
			System.out.println(iee.getMessage());
		}
 }
 //**********************************************************************************************************************************************   
        
}//class
