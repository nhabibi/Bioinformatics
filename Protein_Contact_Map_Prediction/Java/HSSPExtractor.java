import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.Vector;


public class HSSPExtractor {
	
		
	public void extractSC(String HSSPDir,String FASTADir){
		
		String[] list = new File(FASTADir).list();
		for(int i=0; i<list.length; ++i){
			
        	String fileName = list[i].substring(0, list[i].indexOf('.'));
        	try{
        		BufferedReader brFasta = new BufferedReader(new InputStreamReader(new FileInputStream( FASTADir+list[i] )));
        		brFasta.readLine();//Useless line
        		int proteinLen = (brFasta.readLine()).toCharArray().length;
        		
        		//System.out.println("Processing " +HSSPDir+fileName+".hssp");
        		
        		BufferedReader brHSSP = new BufferedReader(new InputStreamReader(new FileInputStream( HSSPDir+fileName+".hssp" )));
        		String sc = "";
        		String line;
        		while(!(line=brHSSP.readLine()).startsWith("## SEQUENCE PROFILE AND ENTROPY") );
        		brHSSP.readLine(); //Useless line
        		for(int n=1;n<=proteinLen;++n){
        			
        			double weight = new Double((line = brHSSP.readLine()).substring(line.lastIndexOf(" ")+1)).doubleValue();
        			sc += weight+"\n";
        		}
        		BufferedWriter bw = new BufferedWriter( new FileWriter(HSSPDir+fileName+".sc"));
		        bw.append(sc);
		        bw.close();
        	}
        	catch(IOException ioe){
        		System.out.println(ioe.getMessage());
        	}
           
        }//for
    System.out.println("*********  extractSC()Finished  ***********");
	}
//***********************************************************************************************************************
	
   public void extractCMA(String HSSPDir,String FASTADir){
		
	    String[] list = new File(FASTADir).list();
		for(int i=0; i<list.length; ++i){
			
        	String fileName = list[i].substring(0, list[i].indexOf('.'));
        	System.out.println("generate .msa for: " +fileName);
        	try{
        		BufferedReader brFasta = new BufferedReader(new InputStreamReader(new FileInputStream( FASTADir+list[i] )));
        		brFasta.readLine();//Useless line
        		int proteinLen = (brFasta.readLine()).toCharArray().length;
        		
        		BufferedReader brHSSP = new BufferedReader(new InputStreamReader(new FileInputStream( HSSPDir+fileName+".hssp" )));
        		
        		String line;
        		while ( !(line=brHSSP.readLine()).startsWith("NALIGN") );
        		int NALIGN = new Integer(line.substring(line.lastIndexOf(" ")+1)).intValue();
        		int numberOfAlignmentSections = NALIGN/70;
        		if (NALIGN%70 != 0) numberOfAlignmentSections += 1;
        		if( NALIGN<70 ) numberOfAlignmentSections = 1;
        		String[] MSA = new String[proteinLen];
        		for(int n=0;n<proteinLen;++n)
        			MSA[n] = "";
        		int counter=0;
        		System.out.println("numberOfAlignmentSections= "+ numberOfAlignmentSections);
        		while( counter != numberOfAlignmentSections ){
        			line = brHSSP.readLine();
        			if(line.startsWith("## ALIGNMENTS")){
        				
        				brHSSP.readLine(); //useless
        				for(int j=0;j<proteinLen;++j){
        					line = brHSSP.readLine();
        					System.out.println(line);
        					MSA[j] += line.substring(51);
        				}//for
        				counter++;
        				System.out.println("counter= "+counter);
        			}//if
        		}//while
        		BufferedWriter bw = new BufferedWriter( new FileWriter(HSSPDir+fileName+".msa"));
        		for(int k=0;k<proteinLen;++k){
        			bw.append(MSA[k]+"\n");
        		}
		        bw.close();
		        
		        System.out.println("Calling calculateCMA() for: " + fileName);
		        calculateCMA(HSSPDir,fileName,MSA,proteinLen,NALIGN);
		        
        	}//try
        	catch(IOException ioe){
        		System.out.println(ioe.getMessage());
        	}//catch
            
        	        	
        }//for
    System.out.println("*********  extractMSA()Finished  ***********");
	
	}
//**************************************************************************************************************************S	
    private void calculateCMA(String HSSPDir,String fileName,String[] MSA,int proteinLen,int NALIGN){
    	
    	int[][] McLachlan1971 = {
    	    	{8,	2,	3,	3,	1,	3,	4,	3,	3,	2,	2,	3,	3,	1,	4,	4,	3,	1,	1,	3,  0},
    	    	{2,	8,	3,	1,	1,	5,	3,	3,	5,	1,	2,	5,	1,	1,	3,	4,	3,	3,	2,	2,  0},
    	    	{3,	3,	8,	5,	1,	4,	4,	3,	4,	1,	1,	4,	2,	0,	1,	5,	3,	0,	2,	1,  0},
    	    	{3,	1,	5,	8,	1,	4,	5,	3,	4,	0,	1,	3,	2,	1,	3,	3,	3,	0,	1,	1,  0},
    	    	{1,	1,	1,	1,	9,	0,	0,	1,	3,	1,	0,	0,	3,	0,	0,	2,	2,	2,	1,	1,  0},
    	    	{3,	5,	4,	4,	0,	8,	5,	2,	4,	0,	3,	4,	3,	0,	3,	4,	3,	2,	1,	2,  0},
    	    	{4,	3,	4,	5,	0,	5,	8,	3,	2,	1,	1,	4,	1,	0,	4,	4,	4,	1,	2,	2,  0},
    	    	{3,	3,	3,	3,	1,	2,	3,	8,	2,	1,	1,	3,	1,	0,	3,	3,	2,	1,	0,	2,  0},
    	    	{3,	5,	4,	4,	3,	4,	2,	2,	8,	2,	2,	4,	3,	4,	3,	3,	4,	3,	4,	2,  0},
    	    	{2,	1,	1,	0,	1,	0,	1,	1,	2,	8,	5,	1,	5,	3,	1,	2,	3,	3,	3,	5,  0},
    	    	{2,	2,	1,	1,	0,	3,	1,	1,	2,	5,	8,	2,	6,	5,	1,	2,	3,	3,	3,	5,  0},
    	    	{3,	5,	4,	3,	0,	4,	4,	3,	4,	1,	2,	8,	1,	0,	3,	3,	3,	1,	1,	2,  0},
    	    	{3,	1,	2,	2,	3,	3,	1,	1,	3,	5,	6,	1,	8,	5,	1,	2,	3,	1,	2,	4,  0},
    	    	{1,	1,	0,	1,	0,	0,	0,	0,	4,	3,	5,	0,	5,	9,	1,	2,	1,	6,	6,	3,  0},
    	    	{4,	3,	1,	3,	0,	3,	4,	3,	3,	1,	1,	3,	1,	1,	8,	3,	3,	0,	0,	2,  0},
    	    	{4,	4,	5,	3,	2,	4,	4,	3,	3,	2,	2,	3,	2,	2,	3,	8,	5,	3,	3,	2,  0},
    	    	{3,	3,	3,	3,	2,	3,	4,	2,	4,	3,	3,	3,	3,	1,	3,	5,	8,	2,	1,	3,  0},
    	    	{1,	3,	0,	0,	2,	2,	1,	1,	3,	3,	3,	1,	1,	6,	0,	3,	2,	9,	6,	2,  0},
    	    	{1,	2,	2,	1,	1,	1,	2,	0,	4,	3,	3,	1,	2,	6,	0,	3,	1,	6,	9,	3,  0},
    	    	{3,	2,	1,	1,	1,	2,	2,	2,	2,	5,	5,	2,	4,	3,	2,	2,	3,	2,	3,	8,  0},
    	    	{0, 0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0}
             };
    	
    	try{
    		System.out.println("proteinLen= "+proteinLen+ " , NALIGN= " + NALIGN);
    		
	    	//a proteinLen*proteinLen Matrix
	    	float[][] CMA = new float[proteinLen][proteinLen];
	        int[][] numericMSA = MSAintoNumericMSA(MSA,proteinLen,NALIGN);
	    	//for every position (residue) generate a proteinLen*proteinLen matrix and save all of them in a matrix (3D)
	    	float[][][] allPositionSpecificMatrix = new float[proteinLen][NALIGN][NALIGN];
	    	for(int r=0;r<proteinLen;++r){
	    		for(int i=0;i<NALIGN;++i){
	    			for(int j=0;j<NALIGN;++j){
	    				allPositionSpecificMatrix[r][i][j] = McLachlan1971[numericMSA[r][i] - 1][numericMSA[r][j] - 1];
	    		    }
	    		}
	    	}
	    	//Generate a proteinLen*proteinLen matrix by averaging corresponding entries of all  above matrices
	    	float[][] avgMatrix = new float[NALIGN][NALIGN];
	    	for(int i=0;i<NALIGN;++i){
	    		for(int j=0;j<NALIGN;++j){
	    			for(int r=0;r<proteinLen;++r){
	    				avgMatrix[i][j] += allPositionSpecificMatrix[r][i][j];
	    			}
	    			avgMatrix[i][j] /= proteinLen;
	    		}
	    	}
	    	//Calculate the "correlation coefficient" for every residue pair
	    	for(int i=0;i<proteinLen;++i){
	    		for(int j=0;j<proteinLen;++j){
	    			for(int n=0;n<NALIGN;++n){
	    				for(int m=0;m<NALIGN;++m){
	    					CMA[i][j] += covariance(allPositionSpecificMatrix[i][n][m],allPositionSpecificMatrix[j][n][m],avgMatrix[n][m],avgMatrix[n][m]);
	    				}
	    			}
	    			CMA[i][j] /= NALIGN*NALIGN;
	    		}
	    	}
	    	//write CMA to a file
	    	BufferedWriter bw = new BufferedWriter( new FileWriter(HSSPDir+fileName+".cma"));
	    	for(int i=0;i<proteinLen;++i){
	    		for(int j=0;j<proteinLen;++j){
	    			bw.append(CMA[i][j]+" ");
	    		}
	    	    bw.append("\n");
	    	}
		    bw.close();
    	}
    	catch(IOException ioe){
    		System.out.println(ioe.getMessage());
    	}
    }
	
//**************************************************************************************************************************S
   private double covariance(float x,float y,float meanx,float meany){
	   
	   return ( (x-meanx)*(y-meany) ) / ( Math.sqrt(meanx)*Math.sqrt(meany) );
   }
//**************************************************************************************************************************S    
   public int[][] MSAintoNumericMSA(String[] MSA,int proteinLen,int NALIGN){
 	   
 	   int[][] numericMSA = new int[proteinLen][NALIGN];
 	   for(int i=0;i<proteinLen;++i)
 		   for(int j=0;j<NALIGN;++j)
 			   if (MSA[i].charAt(j) == 'A') {
 		            numericMSA[i][j] = 1;
 		         } else if (MSA[i].charAt(j) == 'R') {
 		        	numericMSA[i][j] = 2;
 		         } else if (MSA[i].charAt(j) == 'N') {
 		        	numericMSA[i][j] = 3;
 		         } else if (MSA[i].charAt(j) == 'D') {
 		        	numericMSA[i][j] = 4;
 		         } else if (MSA[i].charAt(j) == 'C') {
 		        	numericMSA[i][j] = 5;
 		         } else if (MSA[i].charAt(j) == 'E') {
 		        	numericMSA[i][j] = 6;
 		         } else if (MSA[i].charAt(j) == 'Q') {
 		        	numericMSA[i][j] = 7;
 		         } else if (MSA[i].charAt(j) == 'G') {
 		        	numericMSA[i][j] = 8;
 		         } else if (MSA[i].charAt(j) == 'H') {
 		        	numericMSA[i][j] = 9;
 		         } else if (MSA[i].charAt(j) == 'I') {
 		        	numericMSA[i][j] = 10;
 		         } else if (MSA[i].charAt(j) == 'L') {
 		        	numericMSA[i][j] = 11;
 		         } else if (MSA[i].charAt(j) == 'K') {
 		        	numericMSA[i][j] = 12;
 		         } else if (MSA[i].charAt(j) == 'M') {
 		        	numericMSA[i][j] = 13;
 		         } else if (MSA[i].charAt(j) == 'F') {
 		        	numericMSA[i][j] = 14;
 		         } else if (MSA[i].charAt(j) == 'P') {
 		        	numericMSA[i][j] = 15;
 		         } else if (MSA[i].charAt(j) == 'S') {
 		        	numericMSA[i][j] = 16;
 		         } else if (MSA[i].charAt(j) == 'T') {
 		        	numericMSA[i][j] = 17;
 		         } else if (MSA[i].charAt(j) == 'W') {
 		        	numericMSA[i][j] = 18;
 		         } else if (MSA[i].charAt(j) == 'Y') {
 		        	numericMSA[i][j] = 19;
 		         } else if (MSA[i].charAt(j) == 'V') {
 		        	numericMSA[i][j] = 20;
 		         } else if (MSA[i].charAt(j) == ' '){
 		        	numericMSA[i][j] = 21;
 		         } else if (MSA[i].charAt(j) == '.'){
 		        	 numericMSA[i][j] = 22;
 		         }else{
 		        	 numericMSA[i][j] = -1;
 		         }
 	   return numericMSA;
    }
  //**************************************************************************************************************************** 
}








