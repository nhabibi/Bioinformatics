import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStreamReader;


public class PrepareSS {

	
	public void createAllSS(String SSDir){
		
		String[] list = new File(SSDir).list();
		 
        for(int i=0; i<list.length; ++i){
		
        	String fileName = list[i].substring(0, list[i].indexOf('.'));
        	//System.out.println(i + " " + fileName);
        	try{
        		BufferedReader br = new BufferedReader(new InputStreamReader(new FileInputStream( SSDir+list[i] )));
        		String ss = "";
        		String line;
        		while( !(line=br.readLine()).startsWith("#") ); 
        		while ( (line=br.readLine()) != null ){
        			if( line.startsWith("Pred") )
        				ss += line.substring(line.lastIndexOf(" ")+1);
        		}
        		BufferedWriter bw = new BufferedWriter( new FileWriter(SSDir+fileName+".ss"));
		        bw.append(ss);
		        bw.close();
        	}
        	catch(IOException ioe){
        		System.out.println(ioe.getMessage());
        	}
           
        }//for
    System.out.println("*********  createAllSS()Finished  ***********");
	}
//**************************************************************************************************************************	
	
}


















