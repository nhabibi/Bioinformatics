import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.FilenameFilter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.Random;
import java.util.Vector;


public class SAMExtractor {

	public void extractAllMSA(String path){
		
		FilenameFilter fnf = new a2mFilenameFilter();
		String[] list = new File(path).list(fnf);
        for(int n=0; n<list.length; ++n){
        
        	//String fileName = list[n].substring(0, list[n].indexOf('.'));
        	String fileName = list[n].substring(0,list[n].indexOf("_"));
        	try{
        		BufferedReader br1 = new BufferedReader(new InputStreamReader(new FileInputStream( path+list[n] )));
        		Vector<String> MSAVector = new Vector<String>();
        		String line;
        		//due to non-determined number of sequences, I first add them to a vector.
        		while((line=br1.readLine()) != null){

        			    if(!line.startsWith(">"))
        			    	MSAVector.addElement(line);
        	    }
        		br1.close();
        		
        		//then save the vector to a array
        		String[] MSAtemp = new String[MSAVector.size()];
        		for(int i=0;i<MSAVector.size();++i){
        			MSAtemp[i] = (String)MSAVector.elementAt(i);
        		}
        		
        		int targetLen = MSAtemp[0].length();

		        //now remove lower case characters from aligned sequences
        		//int correctSeq = 0;
        		for(int i=0;i<MSAtemp.length;++i){
	            	MSAtemp[i] = MSAtemp[i].replaceAll("[a-z]", "");
	            }
        		
        		//replace X,B and Z char with a amino acid
        		Random random = new Random(System.currentTimeMillis());
        		float rand = 0;
        		for(int i=0;i<MSAtemp.length;++i){
        			for(int j=0;j<targetLen;++j){
        				String seq = MSAtemp[i];
        				if(seq.charAt(j) == 'B'){
        					rand = random.nextFloat();
        					if(rand < 0.5)                    MSAtemp[i] = seq.replaceFirst("B", "N");
        					else                              MSAtemp[i] = seq.replaceFirst("B", "D");
        				}
        				else if(seq.charAt(j) == 'Z'){
        					rand = random.nextFloat();
        					if(rand < 0.5)                    MSAtemp[i] = seq.replaceFirst("Z", "Q");
        					else                              MSAtemp[i] = seq.replaceFirst("Z", "E");
        				}
        				else if(seq.charAt(j) == 'X'){
        					rand = random.nextFloat();
        					if( rand>=0 && rand<0.05)         MSAtemp[i] = seq.replaceFirst("X", "A");
        					else if( rand>=0.05 && rand<0.1)  MSAtemp[i] = seq.replaceFirst("X", "R");
        					else if( rand>=0.1 && rand<0.15)  MSAtemp[i] = seq.replaceFirst("X", "N");
        					else if( rand>=0.15 && rand<0.2)  MSAtemp[i] = seq.replaceFirst("X", "D");
        					else if( rand>=0.2 && rand<0.25)  MSAtemp[i] = seq.replaceFirst("X", "C");
        					else if( rand>=0.25 && rand<0.3)  MSAtemp[i] = seq.replaceFirst("X", "E");
        					else if( rand>=0.3 && rand<0.35)  MSAtemp[i] = seq.replaceFirst("X", "Q");
        					else if( rand>=0.35 && rand<0.4)  MSAtemp[i] = seq.replaceFirst("X", "G");
        					else if( rand>=0.4 && rand<0.45)  MSAtemp[i] = seq.replaceFirst("X", "H");
        					else if( rand>=0.45 && rand<0.5)  MSAtemp[i] = seq.replaceFirst("X", "I");
        					else if( rand>=0.5 && rand<0.55)  MSAtemp[i] = seq.replaceFirst("X", "L");
        					else if( rand>=0.55 && rand<0.6)  MSAtemp[i] = seq.replaceFirst("X", "K");
        					else if( rand>=0.6 && rand<0.65)  MSAtemp[i] = seq.replaceFirst("X", "M");
        					else if( rand>=0.65 && rand<0.7)  MSAtemp[i] = seq.replaceFirst("X", "F");
        					else if( rand>=0.7 && rand<0.75)  MSAtemp[i] = seq.replaceFirst("X", "P");
        					else if( rand>=0.75 && rand<0.8)  MSAtemp[i] = seq.replaceFirst("X", "S");
        					else if( rand>=0.8 && rand<0.85)  MSAtemp[i] = seq.replaceFirst("X", "T");
        					else if( rand>=0.85 && rand<0.9)  MSAtemp[i] = seq.replaceFirst("X", "W");
        					else if( rand>=0.9 && rand<0.95)  MSAtemp[i] = seq.replaceFirst("X", "Y");
        					else if( rand>=0.95 && rand<=1)   MSAtemp[i] = seq.replaceFirst("X", "V");
        				}
        			}//for
        		 }//for
        					
        		
        		String[] MSA = MSAtemp;
        		//now save the purified multiple sequence alignment to a file
        		//BufferedWriter bw1 = new BufferedWriter( new FileWriter(path+fileName+".msa1"));
        		BufferedWriter bw2 = new BufferedWriter( new FileWriter(path+fileName+".msa"));
                for(int i=0;i<MSA.length;++i){
                	//bw1.append(MSA[i] + "\n");
                	bw2.append(i + " " + MSA[i] + "\n");
                }
                //bw1.close();
	            bw2.close();
	                          
  /*              //now call a method to compute correlated mutation
		        System.out.println("Calling calculateCMA() for: " + fileName);
		        float[][] CMA = calculateCMA(MSA);
		        
		        //now save the correlated mutation to a file
		    	BufferedWriter bw3 = new BufferedWriter( new FileWriter(path+fileName+".cma"));
		        for(int i=0;i<targetLen;++i){
		    		for(int j=0;j<targetLen;++j){
		    			bw3.append(i + "\t" + j + "\t" + CMA[i][j]+"\n");
		    		}
		    	    //bw3.append("\n");
		    	}
			    bw3.close();
  */
		        
        	}//try
        	catch(IOException ioe){
        		System.out.println(ioe.getMessage());
        	}
        }//for
        System.out.println("*********  createAllMSA()Finished  ***********");
   }
//*******************************************************************************************************************	
private float[][] calculateCMA(String[] MSA){
    	
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
    	
    		int NALIGN = MSA.length;	
    		int proteinLen = MSA[0].length();
    		 		
    		//a proteinLen*proteinLen Matrix
	        short[][] numericMSA =  MSAintoNumericMSA(MSA,proteinLen,NALIGN);
	    	float[][] CMA = new float[proteinLen][proteinLen];
	    	
	/*    	//for every position (residue) generate a NALIGN*NALIGN matrix and save all of them in a matrix (3D)
	    	float[][][] allPositionSpecificMatrix = new float[proteinLen][NALIGN][NALIGN];
	    	for(int r=0;r<proteinLen;++r){
	    		for(int i=0;i<NALIGN;++i){
	    			for(int j=0;j<NALIGN;++j){
	    				allPositionSpecificMatrix[r][i][j] = McLachlan1971[numericMSA[i][r]-1][numericMSA[j][r]-1];
	    		    }
	    		}
	    	}
	    	//Calculate the average of each position's matrix and save them in a proteinLen array
            float[] avgArray = new float[proteinLen];
            for(int n=0;n<proteinLen;++n){
            	for(int i=0;i<NALIGN;++i)
            		for(int j=0;j<NALIGN;++j)
            			avgArray[n] += allPositionSpecificMatrix[n][i][j];
                avgArray[n] /= NALIGN*NALIGN;
            }

	    	//Calculate the "correlation coefficient" for every residue pair
	    	for(int i=0;i<proteinLen;++i){
	    		for(int j=0;j<proteinLen;++j){
	    			for(int n=0;n<NALIGN;++n){
	    				for(int m=0;m<NALIGN;++m){
	    					CMA[i][j] += covariance(allPositionSpecificMatrix[i][n][m],allPositionSpecificMatrix[j][n][m],avgArray[i],avgArray[j]);
	    				}
	    			}
	    			CMA[i][j] /= NALIGN*NALIGN;
	    		}
	    	}
*/
	    	
	    	//Calculate the average of each position's matrix and save them in a proteinLen array
            float[] avgArray = new float[proteinLen];
            for(int n=0;n<proteinLen;++n){
            	for(int i=0;i<NALIGN;++i)
            		for(int j=0;j<NALIGN;++j){
            			if(numericMSA[i][n]==0 || numericMSA[j][n]==0)
            				avgArray[n] += 0;
            			else
            				avgArray[n] += McLachlan1971[(numericMSA[i][n])-1][(numericMSA[j][n])-1];
            				/*try{
            			        avgArray[n] += McLachlan1971[(numericMSA[i][n])-1][(numericMSA[j][n])-1];
            				}
            			    catch(Exception e){
            			    	if(Character.isLetter(MSA[i].charAt(n))){
            			       	   System.out.println("n=,i=" +n + "," + i);
            			       	   System.out.println(MSA[i].length());
            			       	   System.out.println(MSA[j].length());
            			    	}
            			    	if(Character.isLetter(MSA[j].charAt(n))){
             			    	   System.out.println("n=,j="+ n + "," + j);
             			    	   System.out.println(MSA[i].length());
           			       	       System.out.println(MSA[j].length());
            			    	}
            			    	else
            			    		System.out.println(e.getMessage());
            			    }*/
            			    
            		}
                avgArray[n] /= NALIGN*NALIGN;
            }
           //Calculate the standard deviation for each position's matrix and save them in a proteinLen array
            float[] varArray = new float[proteinLen];
            for(int n=0;n<proteinLen;++n){
            	int tempVar = 0;
            	for(int i=0;i<NALIGN;++i)
            		for(int j=0;j<NALIGN;++j){
            			if(numericMSA[i][n]==0 || numericMSA[j][n]==0)
            				tempVar += 0;
            			else
            			    tempVar += Math.pow( ( McLachlan1971[(numericMSA[i][n])-1][(numericMSA[j][n])-1] - avgArray[n] ) , 2 );
            			
            		}
                varArray[n] = (float) Math.sqrt( tempVar/(NALIGN*NALIGN-1) );
            }

	    	//Calculate the "correlation coefficient" for every residue pair
	    	for(int i=0;i<proteinLen;++i){
	    		for(int j=0;j<proteinLen;++j){
	    			for(int n=0;n<NALIGN;++n){
	    				for(int m=0;m<NALIGN;++m){
	    					int aain = numericMSA[n][i]; int aaim = numericMSA[m][i]; int aajn = numericMSA[n][j]; int aajm = numericMSA[m][j];
	    					int similarityAAi = 0; int similarityAAj = 0;
	    					if(aain==0 || aaim==0)  similarityAAi = 0;
	    					if(aajn==0 || aajm==0)  similarityAAj = 0;
	    					if(similarityAAi==0 || similarityAAj==0)
	    						CMA[i][j] += (0-avgArray[i]) * (0-avgArray[j]);
	    					else
	    					    CMA[i][j] += (McLachlan1971[(numericMSA[n][i])-1][(numericMSA[m][i])-1] - avgArray[i]) * (McLachlan1971[(numericMSA[n][j])-1][(numericMSA[m][j])-1] - avgArray[j]);
	    				}
	    			}
	    			if(varArray[i]==0 || varArray[j]==0)
	    				 CMA[i][j] = -2;
	    			else {
	    			     CMA[i][j] /= (NALIGN*NALIGN) * (varArray[i]*varArray[j]);
	    			     CMA[i][j] = Math.abs(CMA[i][j]);
	    			}
	    		}
	    	}

	    	
	    	return CMA;
   }
	
//**************************************************************************************************************************S
public short[][] MSAintoNumericMSA(String[] MSA,int proteinLen,int NALIGN){
 	  
	   //Runtime rt = Runtime.getRuntime();
	   //System.out.println("Free memory = " + rt.freeMemory());
 	   short[][] numericMSA = new short[NALIGN][proteinLen];
 	   for(int i=0;i<NALIGN;++i){
 		   
 		  for(int j=0;j<proteinLen;++j){
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
 		         } else if (MSA[i].charAt(j) == '-'){
 		        	numericMSA[i][j] = 0;
 		         }else{
 		        	 numericMSA[i][j] = -1;
 		         }
 		   }//for
 	   }//for
 	   return numericMSA;
    }
  //****************************************************************************************************************************
    public void refineCMAFiles(String path){
	
    	FilenameFilter fnf = new cmaFilenameFilter();
		String[] list = new File(path).list(fnf);
        for(int n=0; n<list.length; ++n){
            try{
            	String fileName = list[n].substring(0,list[n].indexOf("."));
    		    BufferedReader br = new BufferedReader(new InputStreamReader(new FileInputStream( path+list[n] )));
        		BufferedWriter bw = new BufferedWriter( new FileWriter(path+fileName+".cma"));
                br.readLine(); //header line
                String line;
                while( (line=br.readLine()) != null )
                	 bw.append(line + "\n");
                br.close();
                bw.close();
                
                //System.out.println(fileName + " refined." );
            }
            catch(IOException ioe){
            	System.out.println(ioe.getMessage());
            }
        }
        System.out.println("*********  refineCMAFiles()Finished  ***********");
    }
    

//##############################################################################################################################\

   class a2mFilenameFilter implements FilenameFilter{
	  
	  public boolean accept(File dir,String name){
		  
		 
		  String path = dir+name;
		  if( path.endsWith(".a2m") )
			  return true;
		  else
			  return false;
	  }
  }
  
//##############################################################################################################################\

  class cmaFilenameFilter implements FilenameFilter{
	  
	  public boolean accept(File dir,String name){
		  		 
		  String path = dir+name;
		  if( path.endsWith(".cma") )
			  return true;
		  else
			  return false;
	  }
  }

}//class