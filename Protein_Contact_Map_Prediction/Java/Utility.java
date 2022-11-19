import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileWriter;
import java.io.FilenameFilter;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.util.zip.GZIPInputStream;


public class Utility {

//****************************************************************************************************************************************
	public static void cleanDir(String dir){
		
		try{
			Process proc = Runtime.getRuntime().exec("cmd.exe /C del /q "+dir);
			
			// any error message?
            StreamGobbler errorGobbler = new StreamGobbler(proc.getErrorStream(), "ERROR");            
            
            // any output?
            StreamGobbler outputGobbler = new StreamGobbler(proc.getInputStream(), "OUTPUT");
                
            // kick them off
            errorGobbler.start();
            outputGobbler.start();
                                    
            // any error???
            int exitVal = proc.waitFor();
            System.out.println("ExitValue: " + exitVal);        

     	}
		catch(IOException ioe){
			System.out.println(ioe.getMessage());
		}
		catch(InterruptedException ie){
			System.out.println(ie.getMessage());
		}
		catch (Throwable t)
        {
          t.printStackTrace();
        }

	}
//****************************************************************************************************************************************	
	//Note: this function only can generate fasta files from extracted pdb file in my format! 
	static public void generateFasta(String PDBPath,String FastaPath){
    	
    	try {
    		
    	     String[] list = new File(PDBPath).list();
		     for(int i=0; i<list.length; ++i){
			    //Read protein file in format: "AA x y z"
			    BufferedReader brPDB = new BufferedReader(new InputStreamReader(new FileInputStream( PDBPath+list[i] )));
			    String fileName = list[i].substring(0, list[i].indexOf('.'));
		   	    String fasta = ">"+fileName+":A|PDBID|CHAIN|SEQUENCE\n";
		        String linePDB = brPDB.readLine();
		        while(linePDB != null){
			         int AANumber= new Integer(linePDB.substring(0,linePDB.indexOf(','))).intValue();
		             switch (AANumber){
		                    case 1: fasta  += "A";break;
		                    case 2: fasta  += "R";break;
		                    case 3: fasta  += "N";break;
		                    case 4: fasta  += "D";break;
		                    case 5: fasta  += "C";break;
		                    case 6: fasta  += "E";break;
		                    case 7: fasta  += "Q";break;
		                    case 8: fasta  += "G";break;
		                    case 9: fasta  += "H";break;
		                    case 10: fasta += "I";break;
		                    case 11: fasta += "L";break;
		                    case 12: fasta += "K";break;
		                    case 13: fasta += "M";break;
		                    case 14: fasta += "F";break;
		                    case 15: fasta += "P";break;
		                    case 16: fasta += "S";break;
		                    case 17: fasta += "T";break;
		                    case 18: fasta += "W";break;
		                    case 19: fasta += "Y";break;
		                    case 20: fasta += "V";break;
		                    default: fasta += "?";
		             }//switch
		             linePDB = brPDB.readLine();
		        }//while
		        //Generate FASTA file
		        BufferedWriter bwFasta = new BufferedWriter( new FileWriter(FastaPath+fileName+".fasta"));
		        bwFasta.append(fasta);
		        bwFasta.close();
		  }//for
     }//try
     catch(IOException ioe){
    	 System.out.println(ioe.getMessage());
     }//catch
     System.out.println("********* generateFasta() Finished **********");
   }
//****************************************************************************************************************************************
	
	 static public void unzipGZFiles(String zipPath,String unzipPath) {

             FilenameFilter fnf = new gzFilenameFilter();
             String[] list = new File(zipPath).list(fnf);

             System.out.println("Number of zipped files: " + list.length);

             String tempName = "";
             String name, line;
             File file;
             BufferedWriter bw;
             BufferedReader br;
            
             for (int i=0; i < list.length; ++i) {
            	 try {
	                 //create unzipped file
	                 tempName = list[i].substring(0, list[i].lastIndexOf('.'));
	                 name = unzipPath + "\\" + tempName;
	                 file = new File(name);
	                 file.createNewFile();
	                 bw = new BufferedWriter(new FileWriter(name));
	                 //open gzipped file
	                 br = new BufferedReader(new InputStreamReader(new
	                         GZIPInputStream(new FileInputStream(zipPath + "\\" +
	                         list[i]))));
	                 line = br.readLine();
	                 for (int j = 0; line != null; ++j) {
	                     bw.append(line);
	                     bw.append('\n');
	                     line = br.readLine();
	                 }
	                 bw.close();
	                 br.close();
	   
	                 System.out.println("i= "+i+ ", Name= "+tempName); 
	              }//try
                 catch (IOException ioe) {
                       System.out.println("In unzipGZFiles(): " + ioe.getMessage() + " :" + tempName);
                 }
             }//for
             System.out.println("****** Unziiping Finished ******");
        
     }
	//****************************************************************************************************************************************
    static public void moveFiles(String extension, String accordingToDir, String SrcDir, String DestDir){
	
	
    		String[] list = new File(accordingToDir).list();
    		 
    		try{
    	        for(int i=0; i<list.length; ++i){
    			
    	        	String fileName = list[i].substring(0, list[i].lastIndexOf('.'));
    	        	Runtime.getRuntime().exec("cmd.exe /C move " + SrcDir + fileName + extension + " " + DestDir);
    	        }//for
    	        
    		}//try
    	    catch(IOException ioe){
    	    	System.out.println(ioe.getMessage());
    	    }
    	        	        	
    	    System.out.println("*********  moveFiles()Finished  ***********");
    	
    	}
  //*******************************************************************************************************************************************	
    static public void copyFiles(String extension, String accordingToDir, String SrcDir, String DestDir){
    	
    	
		String[] list = new File(accordingToDir).list();
		 
		try{
	        for(int i=0; i<list.length; ++i){
			
	        	String fileName = list[i].substring(0, list[i].lastIndexOf('.'));
	        	Runtime.getRuntime().exec("cmd.exe /C copy " + SrcDir + fileName + extension + " " + DestDir);
	        }//for
	        
		}//try
	    catch(IOException ioe){
	    	System.out.println(ioe.getMessage());
	    }
	        	        	
	    System.out.println("*********  copyFiles()Finished  ***********");
	
	}

//*******************************************************************************************************************************************
  static public void copyPDB(){
	   
   try{
	   FilenameFilter fnf = new gzFilenameFilter();
	   String[] list = new File("F:\\Bio\\workspace\\Thesis\\SAM\\").list(fnf);
	   for(int i=0;i<list.length;++i){
		   String fileName = list[i].substring(0, list[i].indexOf('_'));
	       Runtime.getRuntime().exec("cmd.exe /C copy " + "F:\\Bio\\Implement\\DataSet\\pdbselect-pdb\\" + fileName + ".pdb" + " " + "F:\\Bio\\workspace\\Thesis\\PDB\\" );
	   }
   }
   catch(Exception e){
	   System.out.println(e.getMessage());
   }
	
   System.out.println("*********  copyPDB()Finished  ***********");
 }
//*******************************************************************************************************************************************
 /* static public void renameFile(String from,String to){
	  
	  try{
		  Runtime.getRuntime().exec("cmd.exe /C move "+from+" "+to);
	  }
	  catch(Exception e){
		  System.out.println(e.getMessage());
	  }
  }
*/  
//*******************************************************************************************************************************************
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
}
class gzFilenameFilter implements FilenameFilter{
	  
	  public boolean accept(File dir,String name){
		  		 
		  String path = dir+name;
		  if( path.endsWith(".gz") )
			  return true;
		  else
			  return false;
	  }
}
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class StreamGobbler extends Thread
{
    InputStream is;
    String type;
    
    StreamGobbler(InputStream is, String type)
    {
        this.is = is;
        this.type = type;
    }
    
    public void run()
    {
        try
        {
            InputStreamReader isr = new InputStreamReader(is);
            BufferedReader br = new BufferedReader(isr);
            String line=null;
            while ( (line = br.readLine()) != null)
                System.out.println(type + ">" + line);    
            } catch (IOException ioe)
              {
                ioe.printStackTrace();  
              }
    }
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
