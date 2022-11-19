import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.FilenameFilter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.util.Random;
import java.util.StringTokenizer;
import java.util.Vector;


public class SAMFeatures {

  static final String SAM_PATH = "F:\\Bio\\workspace\\Thesis\\SAM\\";
  static final int    AMINO_ACID_NUMBER = 20;
  static final int    STR4_ALPHABET_NUMBER = 21;
  static final int    BURIAL_ALPHABET_NUMBER = 11;
  static final String MSA_EXT = ".msa";
  static final String THIN_MSA_EXT = ".thinmsa";
  static final String CONTIGENCY_TABLE_EXT = ".ct";
  static final String JOINT_ENTROPY_EXT = ".je";
  static final String RANK_JOINT_ENTROPY_EXT = ".rankje";
  static final String PROPENSITY_EXT = ".prop";
  static final String RANK_PROPENSITY_EXT = ".rankprop";
  static final String MUTUAL_INFORMATION_EXT = ".mi";
  static final String RANK_MUTUAL_INFORMATION_EXT = ".rankmi"; 
  static final String NUMERIC_THIN_MSA_EXT = ".numericthinmsa";
  static final String SS_EXT = ".ss";
  static final String BURIAL_EXT = ".burial";
  static final String ENTROPY_EXT = ".ent";
  static final String NUMBER_OF_PAIRS_EXT = ".nop";
  static final String AA_DISTRIBUTION_EXT = ".aad";
  static final String MSA_LESS_THAN_15_FILE = "list15.lessthan15";
  static final double SEQ_SIMILARITY_THR = 0.62;
  
                              //********************Public Methods********************//
  
  public void extractMSA(){
		
		FilenameFilter fnf = new A2MFilenameFilter();
		String[] list = new File(SAM_PATH).list(fnf);
        for(int n=0; n<list.length; ++n){
        
        	//String fileName = list[n].substring(0, list[n].indexOf('.'));
        	String fileName = list[n].substring(0,list[n].indexOf("_"));
        	try{
        		BufferedReader br1 = new BufferedReader(new InputStreamReader(new FileInputStream( SAM_PATH+list[n] )));
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
        		
        		//replace X, B and Z char with a random amino acid
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
        		BufferedWriter bw1 = new BufferedWriter( new FileWriter(SAM_PATH+fileName+MSA_EXT));
                for(int i=0;i<MSA.length;++i){
                	//bw1.append(i + " " + MSA[i] + "\n");
                	bw1.append(MSA[i] + "\n");
                }
	            bw1.close();
	                                 
        	}//try
        	catch(IOException ioe){
        		System.out.println(ioe.getMessage());
        	}
        }//for
        System.out.println("*********  extractMSAs()Finished  ***********");
   }
 //******************************************************************************************************************************
  public void thinMSA(){

	  FilenameFilter fnf = new MSAFilenameFilter();
	  String[] list = new File(SAM_PATH).list(fnf);
	  
	  for(int n=0; n<list.length; ++n){
      
    	String fileName = list[n].substring(0, list[n].indexOf('.'));
    	
    	System.out.println("Thin "+fileName);
    	
      	String MSA[] = readFileToArray(SAM_PATH+fileName+MSA_EXT);
      	Vector<String> tempVector = new Vector<String>();
      	//keep the fist one
      	tempVector.addElement(MSA[0]);
      	for(int k=1;k<MSA.length;++k){ //check every sequence
      		boolean flag = true;
      		for(int m=0;m<tempVector.size() && flag==true;++m){ //we want to compare the sequence with all of kept sequences
      		    double similarity = similarity2Seq(MSA[k],(String)tempVector.elementAt(m));
      		    if(similarity > SEQ_SIMILARITY_THR)   flag = false;
      	    }
      		if(flag==true)   tempVector.addElement(MSA[k]);
      	}//for
      	
      	if(tempVector.size() > 1){
      		String[] thinMSA = new String[tempVector.size()];
      	    for(int i=0;i<tempVector.size();++i)
      		    thinMSA[i] = tempVector.elementAt(i);
      	
      	    writeArrayToFile(thinMSA,SAM_PATH+fileName+THIN_MSA_EXT);
      	}//if
      	
      }//for
      
      System.out.println("********* thinMSAs()Finished  ***********");

  }
  
//******************************************************************************************************************************
  public void jointEntropyAndPropensity(){
	  
	  //# Table for weighted contacts/weighted possible with separation >= 9
	  double[][] pair_propensities = {
				 {0.0049,0.00262,0.00275,0.00254,0.00418,0.00217,0.00243,0.00402,0.00361,0.00554,0.00555,0.00224,0.0043,0.00579,0.00327,0.00364,0.00364,0.00383,0.00507,0.00543},
				 {0.00262,0.00187,0.00227,0.00308,0.00289,0.00271,0.00188,0.00288,0.00253,0.00272,0.00301,0.00132,0.00264,0.00335,0.00259,0.00266,0.00257,0.00303,0.0035,0.00295},
				 {0.00275,0.00227,0.00341,0.00273,0.00302,0.00203,0.00223,0.00348,0.00306,0.0028,0.00271,0.00217,0.00279,0.00335,0.00297,0.00324,0.0032,0.00292,0.00342,0.00286},
				 {0.00254,0.00308,0.00273,0.00196,0.0022,0.00133,0.00169,0.00293,0.00356,0.00234,0.00212,0.00337,0.00231,0.0027,0.00259,0.00316,0.0028,0.00234,0.00299,0.00255},
				 {0.00418,0.00289,0.00302,0.00219,0.0113,0.0018,0.00229,0.00399,0.00407,0.00453,0.00467,0.00186,0.00428,0.00541,0.00284,0.0038,0.00346,0.00514,0.00468,0.00556},
				 {0.00217,0.00271,0.00203,0.00133,0.0018,0.00111,0.00147,0.00213,0.00246,0.00237,0.0022,0.00263,0.00188,0.00231,0.00235,0.0024,0.00228,0.00226,0.00269,0.00228},
				 {0.00243,0.00188,0.00223,0.00169,0.00229,0.00147,0.00197,0.00268,0.00209,0.00298,0.00262,0.00183,0.00248,0.00315,0.00263,0.00258,0.00265,0.00276,0.003,0.00278},
				 {0.00402,0.00288,0.00348,0.00293,0.00399,0.00213,0.00268,0.00455,0.00376,0.0036,0.00355,0.00245,0.00373,0.00431,0.00353,0.00414,0.00378,0.00347,0.00433,0.00389},
				 {0.00361,0.00253,0.00306,0.00356,0.00407,0.00246,0.00209,0.00376,0.00444,0.00366,0.00366,0.00199,0.00332,0.00447,0.00307,0.00387,0.00371,0.00365,0.0043,0.00361},
				 {0.00554,0.00272,0.0028,0.00234,0.00453,0.00237,0.00298,0.0036,0.00366,0.00882,0.00851,0.00262,0.00626,0.00774,0.00341,0.0036,0.00433,0.00584,0.00646,0.00827},
				 {0.00555,0.00301,0.00271,0.00212,0.00467,0.0022,0.00262,0.00355,0.00366,0.00851,0.00786,0.00244,0.0057,0.00695,0.00358,0.00337,0.00401,0.00445,0.00584,0.00813},
				 {0.00224,0.00132,0.00217,0.00337,0.00186,0.00263,0.00183,0.00245,0.00199,0.00262,0.00244,0.00135,0.00213,0.00291,0.00212,0.00235,0.00218,0.0027,0.00326,0.00254},
				 {0.0043,0.00264,0.00279,0.00231,0.00428,0.00188,0.00248,0.00373,0.00332,0.00626,0.0057,0.00213,0.00509,0.00666,0.00315,0.00331,0.00352,0.00501,0.00552,0.00583},
				 {0.00579,0.00335,0.00335,0.0027,0.00541,0.00231,0.00315,0.00431,0.00447,0.00774,0.00695,0.00291,0.00666,0.0088,0.00434,0.00424,0.00425,0.00532,0.00656,0.007},
				 {0.00327,0.00259,0.00297,0.00259,0.00284,0.00235,0.00263,0.00353,0.00307,0.00341,0.00358,0.00212,0.00315,0.00434,0.00342,0.00312,0.0032,0.00405,0.00464,0.0035},
				 {0.00364,0.00266,0.00324,0.00316,0.0038,0.0024,0.00258,0.00414,0.00387,0.0036,0.00337,0.00235,0.00331,0.00424,0.00312,0.00387,0.00362,0.0034,0.00366,0.00381},
				 {0.00364,0.00257,0.0032,0.0028,0.00346,0.00228,0.00265,0.00378,0.00371,0.00433,0.00401,0.00218,0.00352,0.00425,0.0032,0.00362,0.00354,0.00324,0.00384,0.00434},
				 {0.00383,0.00303,0.00292,0.00234,0.00514,0.00226,0.00276,0.00347,0.00365,0.00584,0.00445,0.0027,0.00501,0.00532,0.00405,0.0034,0.00324,0.00334,0.00523,0.00452},
				 {0.00507,0.0035,0.00342,0.00299,0.00468,0.00269,0.003,0.00433,0.0043,0.00646,0.00584,0.00326,0.00552,0.00656,0.00464,0.00366,0.00384,0.00523,0.00611,0.00609},
				 {0.00543,0.00295,0.00286,0.00255,0.00556,0.00228,0.00278,0.00389,0.00361,0.00827,0.00813,0.00254,0.00583,0.007,0.0035,0.00381,0.00434,0.00452,0.00609,0.00834},
	  };
	  
	  FilenameFilter fnf = new ThinMSAFilenameFilter();
	  String[] list = new File(SAM_PATH).list(fnf);
      for(int n=0; n<list.length; ++n){  	  
       	String fileName = list[n].substring(0, list[n].indexOf('.'));
    	
    	System.out.print("Compute paired-column features for "+fileName+", ");  

    	String[] thinMSA = readFileToArray(SAM_PATH+fileName+THIN_MSA_EXT);
    	 	
    	int pLen = thinMSA[0].length();
    	int NALIGN = thinMSA.length;
    	double[][] jointEntropy = new double[pLen][pLen];
    	double[][] propensity = new double[pLen][pLen]; 
    	//double[][] mutualInformation = new double[pLen][pLen];
    	int[][] numericMSA = MSAintoNumericMSA(thinMSA, pLen, NALIGN);
    	writeMatrixToFile(numericMSA, SAM_PATH+fileName+NUMERIC_THIN_MSA_EXT);
    	
    	for(int i=0;i<pLen;++i){
    		int[] colI = new int[NALIGN];  for(int s=0;s<NALIGN;++s)  colI[s] = numericMSA[s][i];
    		for(int j=i;j<pLen;++j){
        		int[] colJ = new int[NALIGN];  for(int s=0;s<NALIGN;++s)  colJ[s] = numericMSA[s][j];
        		int[][] CT = contigencyTable(colI,colJ,NALIGN);
    			int sumCT = sumContigencyTable(CT);
    			
  /* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Mutual Information %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% */    			
   			
    			/*double miOriginal = MI(CT);
    			double[] miRandoms = new double[50];
    			for(int p=0;p<50;++p){
    			    colJ = permute(colJ);
    			    CT = contigencyTable(colI,colJ,NALIGN);
    			    miRandoms[p] = MI(CT);
    		    }
    			
    			double m1=0,m2=0;
    			for(int m=0;m<miRandoms.length;++m){
    				m1 += miRandoms[m];
    			    m2 += Math.pow(miRandoms[m], 2);
    			}
    			m1 /= miRandoms.length;
    			m2 /= miRandoms.length;
    			
    			double alpha = (m1*m1)/(m2-(m1*m1));
    			double beta  = (m2-(m1*m1))/m1;
    			
    			double probabilityMIOriginal = ( Math.pow(miOriginal,alpha-1) * Math.pow(Math.E,miOriginal/beta) ) / ( Math.pow(beta,alpha) * factorial((int)alpha-1) ); 
    			mutualInformation[i][j] = sumCT * probabilityMIOriginal;*/
    			
/*  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Join_Entropy and Propensity %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% */ 
    			
    			for(int x=0;x<AMINO_ACID_NUMBER;++x){
    				for(int y=0;y<AMINO_ACID_NUMBER;++y){
    					
    					if( CT[x][y]==0 )   
    						jointEntropy[i][j] += 0; //cause (log(0) == -Infinity) in Java and the overall result would be NaN. According to "Shannon Entropy" it is set to zero.
    					else{
    						double pxy = (CT[x][y]*1.0)/(sumCT*1.0);
    						jointEntropy[i][j] += pxy * Math.log(pxy);
    					}//else
    					
    					propensity[i][j] += CT[x][y] * pair_propensities[x][y];
    					
    				}//for y
    			}//for x
    			
    			if(jointEntropy[i][j] != 0 )   jointEntropy[i][j] *= -1;
    			
	   			propensity[i][j] = (propensity[i][j]*1.0) / (sumCT*1.0);
	   			
/* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% */ 
    		    
    		}//for j
    	}//for i
    	
 /*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% */  
    	
    	jointEntropy = copyTopToDown(jointEntropy);
    	propensity  = copyTopToDown(propensity);
    	
    	writeMatrixToFile(jointEntropy, SAM_PATH+fileName+JOINT_ENTROPY_EXT);
    	int[][] rankJointEntropy = rank(jointEntropy);
    	writeMatrixToFile(rankJointEntropy,SAM_PATH+fileName+RANK_JOINT_ENTROPY_EXT);
    	
    	writeMatrixToFile(propensity, SAM_PATH+fileName+PROPENSITY_EXT);
    	int[][] rankPropensity = rank(propensity);
    	writeMatrixToFile(rankPropensity, SAM_PATH+fileName+RANK_PROPENSITY_EXT);
    	 	
    	/*writeDoubleMatrixToFile(mutualInformation, SAM_PATH+fileName+MUTUAL_INFORMATION_EXT);
    	int[][] rankMutualInformation = rank(mutualInformation);
    	writeIntMatrixToFile(rankMutualInformation, SAM_PATH+fileName+RANK_MUTUAL_INFORMATION_EXT);*/
    	
      }//for n
      System.out.println("********* jointEntropyAndPropensities()Finished  ***********");
  }
//******************************************************************************************************************************
  public void numberOfPairs(){
 
	  FilenameFilter fnf = new ThinMSAFilenameFilter();
	  String[] list = new File(SAM_PATH).list(fnf);
      for(int n=0; n<list.length; ++n){  
    	System.out.print(n+", ");
       	String fileName = list[n].substring(0, list[n].indexOf('.'));
    
    	String[] thinMSA = readFileToArray(SAM_PATH+fileName+THIN_MSA_EXT);
    	 	
    	int pLen = thinMSA[0].length();
    	int NALIGN = thinMSA.length;
    	int[][] nop = new int[pLen][pLen];  
    	int[][] numericMSA = MSAintoNumericMSA(thinMSA, pLen, NALIGN);
    	
    	for(int i=0;i<pLen;++i){
    		int[] colI = new int[NALIGN];  for(int s=0;s<NALIGN;++s)  colI[s] = numericMSA[s][i];
    		for(int j=i;j<pLen;++j){
    			int[] colJ = new int[NALIGN];  for(int s=0;s<NALIGN;++s)  colJ[s] = numericMSA[s][j];
    			for(int m=0;m<NALIGN;++m){
    		    	   int firstAA  = colI[m] - 1;
    		    	   int secondAA = colJ[m] - 1;
    		    	   //we omit sequences which have a gap in either column.
    		    	   if(firstAA>=0 && secondAA>=0)
    		    		  ++nop[i][j];
    		    }
    		}
    	 }
    	nop = copyTopToDown(nop);
    	writeMatrixToFile(nop,SAM_PATH+fileName+NUMBER_OF_PAIRS_EXT);
    	
      }	
      
      System.out.println("\n********* numberOfPairs()Finished  ***********");
  }
 //******************************************************************************************************************************
    public void entropyAndAADistribution(){
    	
    	 FilenameFilter fnf = new ThinMSAFilenameFilter();
   	     String[] list = new File(SAM_PATH).list(fnf);
         for(int n=0; n<list.length; ++n){  
       	    System.out.print(n+", ");
          	String fileName = list[n].substring(0, list[n].indexOf('.'));
       
       	    String[] thinMSA = readFileToArray(SAM_PATH+fileName+THIN_MSA_EXT);
       	 	int pLen = thinMSA[0].length();
       	    int NALIGN = thinMSA.length;  
       	    int[][] numericMSA = MSAintoNumericMSA(thinMSA, pLen, NALIGN);
       	    double[] entropy = new double[pLen];
       	    double[][] AADistribution = new double[pLen][AMINO_ACID_NUMBER];
       	    for(int i=0;i<pLen;++i){//position ith
       	    	int sum=0;
       	    	int[] AACounts = new int[AMINO_ACID_NUMBER];
       	    	for(int j=0;j<NALIGN;++j){
       	    		int AACode = numericMSA[j][i]-1;
       	    		if(AACode >= 0){
       	    			sum++;
       	    			AACounts[AACode]++;
       	    		}
       	    	}
       	    	for(int s=0;s<AMINO_ACID_NUMBER;++s){
       	    		AADistribution[i][s] = (AACounts[s]*1.0)/(sum*1.0);
       	    		double px = (AACounts[s]*1.0)/(sum*1.0);
       	    		if(px == 0)  entropy[i] += 0;//According to Shanon formula
       	    		else         entropy[i] += px * Math.log(px); 
       	    	}
       	    	if(entropy[i] != 0)  entropy[i] *= -1;
       	    	
       	    }//position ith
         	writeMatrixToFile(AADistribution,SAM_PATH+fileName+AA_DISTRIBUTION_EXT);
       	    writeArrayToFile(entropy,SAM_PATH+fileName+ENTROPY_EXT);
         }   
         System.out.println("\n*********  entropyAndAADistribution()Finished  ***********");   
    } 
  //******************************************************************************************************************************
   public void extractSS(){
   	 //str4-alphabet: A B C D E F G H I J K L M P Q R S T U V W
   	 try{
   	     FilenameFilter fnf = new SSFilenameFilter();
   	     String[] list = new File(SAM_PATH).list(fnf);
            for(int n=0; n<list.length; ++n){  	  
         	     BufferedReader br = new BufferedReader(new InputStreamReader(new FileInputStream(SAM_PATH+list[n])));
         	     String fileName = list[n].substring(0, list[n].indexOf('_'));
         	     br.readLine();//we don't need the first line
         	     String line;
         	     String ss="";
         	     while( (line=br.readLine()) != null )  	 ss += line;
         	     int pLen = ss.length();
         	     int[][] PSS = new int[pLen][STR4_ALPHABET_NUMBER];
         	     
         	     for(int i=0;i<pLen;++i){
         	    		 if(ss.charAt(i)=='A')
         	    			 PSS[i][0] = 1;
         	    		 else if(ss.charAt(i)=='B')
         	    			 PSS[i][1] = 1;
         	    		 else if(ss.charAt(i)=='C')
         	    			 PSS[i][2] = 1;
         	    		 else if(ss.charAt(i)=='D')
         	    			 PSS[i][3] = 1;
         	    		 else if(ss.charAt(i)=='E')
         	    			 PSS[i][4] = 1;
         	    		 else if(ss.charAt(i)=='F')
         	    			 PSS[i][5] = 1;
         	    		 else if(ss.charAt(i)=='G')
         	    			 PSS[i][6] = 1;
         	    		 else if(ss.charAt(i)=='H')
         	    			 PSS[i][7] = 1;
         	    		 else if(ss.charAt(i)=='I')
         	    			 PSS[i][8] = 1;
         	    		 else if(ss.charAt(i)=='J')
         	    			 PSS[i][9] = 1;
         	    		 else if(ss.charAt(i)=='K')
         	    			 PSS[i][10] = 1;
         	    		 else if(ss.charAt(i)=='L')
         	    			 PSS[i][11] = 1;
         	    		 else if(ss.charAt(i)=='M')
         	    			 PSS[i][12] = 1;
         	    		 else if(ss.charAt(i)=='P')
         	    			 PSS[i][13] = 1;
         	    		 else if(ss.charAt(i)=='Q')
         	    			 PSS[i][14] = 1;
         	    		 else if(ss.charAt(i)=='R')
         	    			 PSS[i][15] = 1;
         	    		 else if(ss.charAt(i)=='S')
         	    			 PSS[i][16] = 1;
         	    		 else if(ss.charAt(i)=='T')
         	    			 PSS[i][17] = 1;
         	    		 else if(ss.charAt(i)=='U')
         	    			 PSS[i][18] = 1;
         	    		 else if(ss.charAt(i)=='V')
         	    			 PSS[i][19] = 1;
         	    		else if(ss.charAt(i)=='W')
        	    			 PSS[i][20] = 1;
         	    		 else
         	    			 System.out.println("Error in extractSS(), "+fileName+": "+ss.charAt(i));
         	    	 }//for every position
         	    	
         	     	 writeMatrixToFile(PSS, SAM_PATH+fileName+SS_EXT);   	    
                  }
   	 }
   	 catch(Exception e){
   		 System.out.println(e.getMessage());
   	 }
            System.out.println("********* extractSS()Finished  ***********");
    }
   //******************************************************************************************************************************
    public void extractBurial(){
   	 //11-near-backbone-burial-alphabet: A B C D E F G H I J K
    	try{
      	     FilenameFilter fnf = new BURIALFilenameFilter();
      	     String[] list = new File(SAM_PATH).list(fnf);
               for(int n=0; n<list.length; ++n){  	  
            	     BufferedReader br = new BufferedReader(new InputStreamReader(new FileInputStream(SAM_PATH+list[n])));
            	     String fileName = list[n].substring(0, list[n].indexOf('_'));
            	     br.readLine();//we don't need the first line
            	     String line;
            	     String bur="";
            	     while( (line=br.readLine()) != null )  	 bur += line;
            	     int pLen = bur.length();
            	     int[][] burial = new int[pLen][BURIAL_ALPHABET_NUMBER];
            	     
            	     for(int i=0;i<pLen;++i){
            	    		 if(bur.charAt(i)=='A')
            	    			 burial[i][0] = 1;
            	    		 else if(bur.charAt(i)=='B')
            	    			 burial[i][1] = 1;
            	    		 else if(bur.charAt(i)=='C')
            	    			 burial[i][2] = 1;
            	    		 else if(bur.charAt(i)=='D')
            	    			 burial[i][3] = 1;
            	    		 else if(bur.charAt(i)=='E')
            	    			 burial[i][4] = 1;
            	    		 else if(bur.charAt(i)=='F')
            	    			 burial[i][5] = 1;
            	    		 else if(bur.charAt(i)=='G')
            	    			 burial[i][6] = 1;
            	    		 else if(bur.charAt(i)=='H')
            	    			 burial[i][7] = 1;
            	    		 else if(bur.charAt(i)=='I')
            	    			 burial[i][8] = 1;
            	    		 else if(bur.charAt(i)=='J')
            	    			 burial[i][9] = 1;
            	    		 else if(bur.charAt(i)=='K')
            	    			 burial[i][10] = 1;
            	    		 else
            	    			 System.out.println("Error in extractBurial(): "+bur.charAt(i));
            	    	 }
            	    	
            	     	 writeMatrixToFile(burial, SAM_PATH+fileName+BURIAL_EXT);   	    
               }
      	 }
      	 catch(Exception e){
      		 System.out.println(e.getMessage());
      	 }

        System.out.println("********* extractBurial()Finished  ***********");	 
    }
 //******************************************************************************************************************************

   public void findMSALessThan15(){
    	
    try{	
    	String LESS_THAN_15_MSA_LIST_PATH = "F:\\Bio\\workspace\\Thesis\\";
    	FilenameFilter fnf = new ThinMSAFilenameFilter();
 	    String[] list = new File(SAM_PATH).list(fnf);
 	    BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(LESS_THAN_15_MSA_LIST_PATH+MSA_LESS_THAN_15_FILE)));
        for(int n=0; n<list.length; ++n){  	  
       	    BufferedReader br = new BufferedReader(new InputStreamReader(new FileInputStream(SAM_PATH+list[n])));
       	    String fileName = list[n].substring(0, list[n].indexOf('.'));
       	    int lines = 0;
       	    while( (br.readLine()) != null )  ++lines;
       	    if( lines<15 ) {
       	    	bw.append(fileName+"\n");
       	    }
        }
        bw.close();
    }
    catch(IOException ioe){
    	System.out.println(ioe.getMessage());
    }
    
    System.out.println("********* findMSALessThan15()Finished  ***********");
    	
  }    
 //******************************************************************************************************************************
    
                              //********************Private Methods-Computational********************//
    
    
    private int[][] contigencyTable(int[] colI,int[] colJ,int NALIGN){
   
  	   int[][] CT = new int[AMINO_ACID_NUMBER][AMINO_ACID_NUMBER];
         for(int m=0;m<NALIGN;++m){
      	   int firstAA  = colI[m] - 1;
      	   int secondAA = colJ[m] - 1;
      	   //we omit sequences which have a gap in either column.
      	   if(firstAA>=0 && secondAA>=0)
      		  CT[firstAA][secondAA]++;
         }  
         return CT;
    }  		  
 //******************************************************************************************************************************
    private int sumContigencyTable(int[][] matrix){
    	
    	int sumCT=0;
    	for(int i=0;i<matrix.length;++i)
    		for(int j=0;j<matrix[0].length;++j)
    			sumCT += matrix[i][j];
    	return sumCT;
    }
 //******************************************************************************************************************************
   private double[][]  copyTopToDown(double[][] matrix){
    //Copy the top half of a square matrix to its down half
    	int matrixLen = matrix.length;
    	for(int i=0;i<matrixLen;++i)
    		for(int j=i+1;j<matrixLen;++j)
    			matrix[j][i] = matrix[i][j];
    			
        return matrix;
    }
 //******************************************************************************************************************************
   private int[][]  copyTopToDown(int[][] matrix){
    //Copy the top half of a square matrix to its down half
    	int matrixLen = matrix.length;
    	for(int i=0;i<matrixLen;++i)
    		for(int j=i+1;j<matrixLen;++j)
    			matrix[j][i] = matrix[i][j];
    			
        return matrix;
    }
//******************************************************************************************************************************
  private int[][] rank(double[][] matrix){
	  
	 int matrixRowsNumber = matrix.length;
	 int matrixColsNumber = matrix[0].length;
	 ValueAndIndices[] array = new ValueAndIndices[matrixRowsNumber*matrixColsNumber];
	 
	 for(int i=0;i<matrixRowsNumber;++i){
		 for(int j=0;j<matrixColsNumber;++j){
			 ValueAndIndices vAi = new ValueAndIndices();
			 vAi.setValue(matrix[i][j]);
			 vAi.setI(i);
			 vAi.setJ(j);
			 array[(i)*matrixColsNumber + j] = vAi; 
		 }
	 }
	 
	 //for(int n=0;n<array.length;++n)   System.out.println(array[n].getValue()); System.out.println();
	 
	 //sort the array
	 int min = 0;
	 for(int i=0;i<array.length-1;++i){
		 min = i;
		 for(int j=i+1;j<array.length;++j){
			 if(array[j].getValue() < array[min].getValue())
				 min = j;
		 }
		 if(min != i){
			 ValueAndIndices temp = new ValueAndIndices();
			 temp = array[i];
			 array[i] = array[min];
			 array[min] = temp;
		 }
	 }
	 
	 //for(int n=0;n<array.length;++n)   System.out.println(array[n].getValue()); System.out.println();

	 //write the rank of every entry into a matrix
	 int[][] rankMatrix = new int[matrixRowsNumber][matrixColsNumber];
	 rankMatrix[array[0].getI()][array[0].getJ()] = 1;
	 int rankTemp = 1;
	 for(int n=1;n<array.length;++n){
		 if(array[n].getValue() != array[n-1].getValue())  ++rankTemp;
		 rankMatrix[array[n].getI()][array[n].getJ()] = rankTemp;
	 }
	 
	 return rankMatrix;	  
 }
//******************************************************************************************************************************
  private int[][] MSAintoNumericMSA(String[] MSA,int proteinLen,int NALIGN){
 	  
	   int[][] numericMSA = new int[NALIGN][proteinLen];
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
//******************************************************************************************************************************
  private double similarity2Seq(String seq1,String seq2){
	  //assume 2 sequences have identical length
	  if(seq1.length() != seq2.length()){
		  System.out.println("Error: 2 seq don't have equal lengths");
		  System.out.println("seq1 = "+seq1);
		  System.out.println("seq2 = "+seq2);
	      return -1;
	      
	  }
	  else{
	      int match = 0;
	      for(int i=0;i<seq1.length();++i)
		      if(seq1.charAt(i) == seq2.charAt(i))
			      ++match;
	      
	      double matchPercent = (match*1.0) / (seq1.length()*1.0);
	      //if(matchPercent >= SEQ_SIMILARITY_THR)   System.out.println(matchPercent);
	      return matchPercent;
	  }
  }
//******************************************************************************************************************************  
  
                              //********************Private Methods-Read&Write********************//
  
//******************************************************************************************************************************
  private void writeArrayToFile(String[] array,String filePath){
 	 
 	 try{
    		BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(new FileOutputStream( filePath )));
    		for(int i=0;i<array.length;++i)
    			bw.append(array[i]+"\n");
    		bw.close();
 	 }
    	 catch(Exception e){
    		System.out.println(e.getMessage());
    	 }	 
  }
//******************************************************************************************************************************
  private void writeArrayToFile(double[] array,String filePath){
  	
  	try{
  		BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(new FileOutputStream( filePath )));
  		for(int i=0;i<array.length;++i){
  			bw.append(array[i]+"");
  		    bw.append("\n");
  		}    
  		bw.close();
 	    }
  	catch(Exception e){
  		System.out.println(e.getMessage());
  	}
  	
   }
 //******************************************************************************************************************************
  private void writeMatrixToFile(double[][] matrix,String filePath){
 	 	 
 	 	 try{
 	    		BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(new FileOutputStream( filePath )));
 	    		for(int i=0;i<matrix.length;++i){
 	    			for(int j=0;j<matrix[0].length;++j)
 	    				bw.append(matrix[i][j] + "\t");
 	    		    bw.append("\n");
 	    		}    
 	    		bw.close();
 	 	 }
 	    	 catch(Exception e){
 	    		System.out.println(e.getMessage());
 	    	 }	 
 	  }
 //******************************************************************************************************************************
  private void writeMatrixToFile(int[][] matrix,String filePath){
 	 
 	 try{
    		BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(new FileOutputStream( filePath )));
    		for(int i=0;i<matrix.length;++i){
    			for(int j=0;j<matrix[0].length;++j)
    				bw.append(matrix[i][j] + "\t");
    		    bw.append("\n");
    		}    
    		bw.close();
 	 }
    	 catch(Exception e){
    		System.out.println(e.getMessage());
    	 }	 
  }
//******************************************************************************************************************************
  private String[] readFileToArray(String filePath){
 	 
 	 try{
    	BufferedReader br = new BufferedReader(new InputStreamReader(new FileInputStream( filePath )));
    	String line = "";
 	    Vector<String> tempVector = new Vector<String>();
 	    //due to non-determined number of lines, I first add them to a vector. 
    	while((line=br.readLine())!=null)     tempVector.addElement(line);
 		br.close();
    	//then save the vector to an array
 		String[] array = new String[tempVector.size()];
 		for(int i=0;i<tempVector.size();++i)  array[i] = (String)tempVector.elementAt(i);
 		return array;
      }
      catch(Exception e){
    	System.out.println(e.getMessage());
      }
    	 
      return null;
  }
//******************************************************************************************************************************
  /*public int[][] readCTFileToMatrix(String filePath){
 	 
 	  try{
 	   		BufferedReader br = new BufferedReader(new InputStreamReader(new FileInputStream( filePath )));
 			int[][] matrix = new int[AMINO_ACID_NUMBER][AMINO_ACID_NUMBER];
 	   		for(int i=0;i<AMINO_ACID_NUMBER;++i){
            	StringTokenizer st = new StringTokenizer(br.readLine());            	 
            	for(int j=0;j<AMINO_ACID_NUMBER;++j){
            		matrix[i][j] = Integer.parseInt(st.nextToken());
               	}
            }
 	   		br.close();
 	   		return matrix;
 	     }
 	   	 catch(Exception e){
 	   		System.out.println(e.getMessage());
 	   	 }
 	   	 
 	   	 return null;
  }
*/
  
//*****************************************************************************************************************************
 /*public double MI(int[][] CT){
	 
 	double mi = 0;
 	int CTRowsNumber = CT.length;
 	int CTColsNumber = CT[0].length;
 	int sumCT = sumContigencyTable(CT);
 	for(int i=0;i<CTRowsNumber;++i){
 		int sumRow=0;
 		for(int n=0;n<CTColsNumber;++n) sumRow += CT[i][n];
 		if( sumRow != 0){
 			double pk = sumRow/sumCT;
 			for(int j=0;j<CT[0].length;++j){ 
 				int sumCol=0;
 				double pj = sumCol/sumCT;
     			for(int n=0;n<CTRowsNumber;++n) sumCol += CT[n][j]; 
     			double pjk = CT[i][j]/sumCT;
     		    mi += pjk * Math.log(pjk/(pj*pk))	;	
 			}
 		}
 	}
 	
 	return mi;   	    
	 
 }*/
//******************************************************************************************************************************
/* public int[] permute(int[] array){
 	 	        
 	      int[] r = new int[array.length];
 	      Random generator = new Random();
 	      int n = array.length;
 	      
 	      for (int i = 0; i < array.length; i++){
 	         int pos = generator.nextInt(n);
 	         r[i] = array[pos];
 	         array[pos] = array[n - 1];
 	         n--; 
 	      }
 	      return r;   	   
 }*/
//******************************************************************************************************************************
 /*public int factorial(int x){
 	
 	int fact = 0;
 	while (x!=0) fact += x--;
 	return fact;
 }*/
//******************************************************************************************************************************
 /* public void contigencyTables(){

	  //System.out.println("Time at the begin of contigencyTables(): ");
	  
	  FilenameFilter fnf = new ThinMSAFilenameFilter();
	  String[] list = new File(SAM_PATH).list(fnf);
      for(int n=0; n<list.length; ++n){  	  
    	String fileName = list[n].substring(0, list[n].indexOf('.'));
    	
    	System.out.println("Compute CT for "+fileName);  

    	String[] thinMSA = readFileToStringArray(SAM_PATH+fileName+THIN_MSA_EXT);
    	int pLen = thinMSA[0].length();
    	int NALIGN = thinMSA.length;
    	int[][] numericMSA = MSAintoNumericMSA(thinMSA, pLen, NALIGN);
    	//for every pair column:
    	for(int i=0;i<pLen;++i){
    		for(int j=i;j<pLen;++j){
    			int[][] CT = new int[AMINO_ACID_NUMBER][AMINO_ACID_NUMBER];
    			for(int m=0;m<NALIGN;++m){
    				int firstAA  = numericMSA[m][i] - 1;
    				int secondAA = numericMSA[m][j] - 1;
    				//we omit sequences which have a gap in either column.
    				if(firstAA>=0 && secondAA>=0){
    					CT[firstAA][secondAA]++;
    					//CT[secondAA][firstAA]++;
    				}
    			} 	
    			//write the CT to a file
    			writeIntMatrixToFile(CT, SAM_PATH+fileName+"_"+i+"_"+j+CONTIGENCY_TABLE_EXT);
    		}
    	}
    	
      }//for
      
	  //System.out.println("Time at the end of contigencyTables(): ");
      System.out.println("********* contigencyTables()Finished  ***********");

  }*/
//******************************************************************************************************************************
 /*public void jointEntropies(){
	  
	  FilenameFilter fnf = new ThinMSAFilenameFilter();
	  String[] list = new File(SAM_PATH).list(fnf);
     for(int n=0; n<list.length; ++n){  	  
      	String fileName = list[n].substring(0, list[n].indexOf('.'));
   	
   	//System.out.println("Compute Joint_Entropy for "+fileName);  

   	String[] thinMSA = readFileToStringArray(SAM_PATH+fileName+THIN_MSA_EXT);
   	
   	//for(int i=0;i<thinMSA.length;++i)  System.out.println(thinMSA[i]);
   	
   	int pLen = thinMSA[0].length();
   	//int NALIGN = thinMSA.length;
   	double[][] jointEntropy = new double[pLen][pLen];
   	for(int i=0;i<pLen;++i){
   		for(int j=0;j<pLen;++j){
   			int[][] CT = readCTFileToIntMatrix(SAM_PATH+fileName+"_"+Math.min(i,j)+"_"+Math.max(i,j)+CONTIGENCY_TABLE_EXT);
   			int sumCT=0;
   			for(int a=0;a<AMINO_ACID_NUMBER;++a)
   				for(int b=0;b<AMINO_ACID_NUMBER;++b)
   					sumCT += CT[a][b];
   			//System.out.println("NALIGN== "+NALIGN + " And sumCT== "+sumCT);
   			//double sumProb=0;
   			for(int x=0;x<AMINO_ACID_NUMBER;++x){
   				for(int y=0;y<AMINO_ACID_NUMBER;++y){
   					//System.out.println("CT["+a+"]["+b+"]= "+CT[a][b]);
   					//System.out.println((double)2/3);
   					//double arg = 2.0/3.0;
   					//System.out.println(Math.log(arg));
   					//System.out.println(Math.log(arg));
   					//System.out.println("Log(CT["+a+"]["+b+"])= "+Math.log((double)(CT[a][b]/NALIGN)));
   					//sumProb += (CT[x][y]*1.0)/(sumCT*1.0);
   					//System.out.println("CT["+x+"]["+y+"] == "+CT[x][y] + "     ");
   					if( CT[x][y]==0 )   
   						jointEntropy[i][j] += 0; //cause (log(0) == -Infinity) in Java and the overall result would be NaN. According to "Shannon Entropy" it is set to zero.
   					else{
   						double pxy = (CT[x][y]*1.0)/(sumCT*1.0);
   						//System.out.println(pxy);
   						jointEntropy[i][j] += pxy * Math.log(pxy);
   						//System.out.println("pxy == "+pxy+"     pxy * Math.log(pxy)== " +pxy * Math.log10(pxy)+"    jointEntropy[i][j]== "+jointEntropy[i][j]);
   					}//else
   				}//for y
   			}//for x
   			//System.out.println("sumProb for "+i+ " and " + j + " = " +sumProb);
   			if(jointEntropy[i][j] != 0 )   jointEntropy[i][j] *= -1;
   		}//for j
   	}//for i
   	
   	writeDoubleMatrixToFile(jointEntropy, SAM_PATH+fileName+JOINT_ENTROPY_EXT);
   	int[][] rankJointEntropy = rank(jointEntropy);
   	writeIntMatrixToFile(rankJointEntropy,SAM_PATH+fileName+RANK_JOINT_ENTROPY_EXT);
   	
     }//for n
     System.out.println("********* jointEntropy()Finished  ***********");
 }*/
//******************************************************************************************************************************
/*public void propensities(){
	 
	 //# Table for weighted contacts/weighted possible with separation >= 9
	 double[][] pair_propensities = {
			 {0.0049,0.00262,0.00275,0.00254,0.00418,0.00217,0.00243,0.00402,0.00361,0.00554,0.00555,0.00224,0.0043,0.00579,0.00327,0.00364,0.00364,0.00383,0.00507,0.00543},
			 {0.00262,0.00187,0.00227,0.00308,0.00289,0.00271,0.00188,0.00288,0.00253,0.00272,0.00301,0.00132,0.00264,0.00335,0.00259,0.00266,0.00257,0.00303,0.0035,0.00295},
			 {0.00275,0.00227,0.00341,0.00273,0.00302,0.00203,0.00223,0.00348,0.00306,0.0028,0.00271,0.00217,0.00279,0.00335,0.00297,0.00324,0.0032,0.00292,0.00342,0.00286},
			 {0.00254,0.00308,0.00273,0.00196,0.0022,0.00133,0.00169,0.00293,0.00356,0.00234,0.00212,0.00337,0.00231,0.0027,0.00259,0.00316,0.0028,0.00234,0.00299,0.00255},
			 {0.00418,0.00289,0.00302,0.00219,0.0113,0.0018,0.00229,0.00399,0.00407,0.00453,0.00467,0.00186,0.00428,0.00541,0.00284,0.0038,0.00346,0.00514,0.00468,0.00556},
			 {0.00217,0.00271,0.00203,0.00133,0.0018,0.00111,0.00147,0.00213,0.00246,0.00237,0.0022,0.00263,0.00188,0.00231,0.00235,0.0024,0.00228,0.00226,0.00269,0.00228},
			 {0.00243,0.00188,0.00223,0.00169,0.00229,0.00147,0.00197,0.00268,0.00209,0.00298,0.00262,0.00183,0.00248,0.00315,0.00263,0.00258,0.00265,0.00276,0.003,0.00278},
			 {0.00402,0.00288,0.00348,0.00293,0.00399,0.00213,0.00268,0.00455,0.00376,0.0036,0.00355,0.00245,0.00373,0.00431,0.00353,0.00414,0.00378,0.00347,0.00433,0.00389},
			 {0.00361,0.00253,0.00306,0.00356,0.00407,0.00246,0.00209,0.00376,0.00444,0.00366,0.00366,0.00199,0.00332,0.00447,0.00307,0.00387,0.00371,0.00365,0.0043,0.00361},
			 {0.00554,0.00272,0.0028,0.00234,0.00453,0.00237,0.00298,0.0036,0.00366,0.00882,0.00851,0.00262,0.00626,0.00774,0.00341,0.0036,0.00433,0.00584,0.00646,0.00827},
			 {0.00555,0.00301,0.00271,0.00212,0.00467,0.0022,0.00262,0.00355,0.00366,0.00851,0.00786,0.00244,0.0057,0.00695,0.00358,0.00337,0.00401,0.00445,0.00584,0.00813},
			 {0.00224,0.00132,0.00217,0.00337,0.00186,0.00263,0.00183,0.00245,0.00199,0.00262,0.00244,0.00135,0.00213,0.00291,0.00212,0.00235,0.00218,0.0027,0.00326,0.00254},
			 {0.0043,0.00264,0.00279,0.00231,0.00428,0.00188,0.00248,0.00373,0.00332,0.00626,0.0057,0.00213,0.00509,0.00666,0.00315,0.00331,0.00352,0.00501,0.00552,0.00583},
			 {0.00579,0.00335,0.00335,0.0027,0.00541,0.00231,0.00315,0.00431,0.00447,0.00774,0.00695,0.00291,0.00666,0.0088,0.00434,0.00424,0.00425,0.00532,0.00656,0.007},
			 {0.00327,0.00259,0.00297,0.00259,0.00284,0.00235,0.00263,0.00353,0.00307,0.00341,0.00358,0.00212,0.00315,0.00434,0.00342,0.00312,0.0032,0.00405,0.00464,0.0035},
			 {0.00364,0.00266,0.00324,0.00316,0.0038,0.0024,0.00258,0.00414,0.00387,0.0036,0.00337,0.00235,0.00331,0.00424,0.00312,0.00387,0.00362,0.0034,0.00366,0.00381},
			 {0.00364,0.00257,0.0032,0.0028,0.00346,0.00228,0.00265,0.00378,0.00371,0.00433,0.00401,0.00218,0.00352,0.00425,0.0032,0.00362,0.00354,0.00324,0.00384,0.00434},
			 {0.00383,0.00303,0.00292,0.00234,0.00514,0.00226,0.00276,0.00347,0.00365,0.00584,0.00445,0.0027,0.00501,0.00532,0.00405,0.0034,0.00324,0.00334,0.00523,0.00452},
			 {0.00507,0.0035,0.00342,0.00299,0.00468,0.00269,0.003,0.00433,0.0043,0.00646,0.00584,0.00326,0.00552,0.00656,0.00464,0.00366,0.00384,0.00523,0.00611,0.00609},
			 {0.00543,0.00295,0.00286,0.00255,0.00556,0.00228,0.00278,0.00389,0.00361,0.00827,0.00813,0.00254,0.00583,0.007,0.0035,0.00381,0.00434,0.00452,0.00609,0.00834},
	 };
		
	 FilenameFilter fnf = new ThinMSAFilenameFilter();
	 String[] list = new File(SAM_PATH).list(fnf);
    for(int n=0; n<list.length; ++n){  	  
     	    String fileName = list[n].substring(0, list[n].indexOf('.'));
  	
		   	//System.out.println("Compute propensitiy for "+fileName);  
		
		   	String[] thinMSA = readFileToStringArray(SAM_PATH+fileName+THIN_MSA_EXT);
		   	
		   	//for(int i=0;i<thinMSA.length;++i)  System.out.println(thinMSA[i]);
		   	
		   	int pLen = thinMSA[0].length();
		   	//int NALIGN = thinMSA.length;
		   	double[][] propensity = new double[pLen][pLen];
		   	for(int i=0;i<pLen;++i){
		   		for(int j=0;j<pLen;++j){
		   			
		   			int[][] CT = readCTFileToIntMatrix(SAM_PATH+fileName+"_"+Math.min(i,j)+"_"+Math.max(i,j)+CONTIGENCY_TABLE_EXT);
		   			
		   			int sumCT=0;
		   			for(int a=0;a<AMINO_ACID_NUMBER;++a)
	    				for(int b=0;b<AMINO_ACID_NUMBER;++b)
	    					sumCT += CT[a][b];
		   			for(int x=0;x<AMINO_ACID_NUMBER;++x){
						for(int y=0;y<AMINO_ACID_NUMBER;++y){
				            propensity[i][j] += CT[x][y] * pair_propensities[x][y];
						}//y
		   			}//x
		   			propensity[i][j] = (propensity[i][j]*1.0) / (sumCT*1.0);
		   		}//j
		   	}//i
	    	writeDoubleMatrixToFile(propensity, SAM_PATH+fileName+PROPENSITY_EXT);
	    	int[][] rankPropensity = rank(propensity);
	    	writeIntMatrixToFile(rankPropensity, SAM_PATH+fileName+RANK_PROPENSITY_EXT);
	    	
    }//n
    System.out.println("********* propensities()()Finished  ***********");
}*/
//******************************************************************************************************************************  
  
  
                               //********************Utility Classes********************//
  
 //##############################################################################################################################\
  class MSAFilenameFilter implements FilenameFilter{
	  
	  public boolean accept(File dir,String name){
		  
		 
		  String path = dir+name;
		  if( path.endsWith(MSA_EXT) )
			  return true;
		  else
			  return false;
	  }
 }
//##############################################################################################################################\
  class ThinMSAFilenameFilter implements FilenameFilter{
	  
	  public boolean accept(File dir,String name){
		  
		 
		  String path = dir+name;
		  if( path.endsWith(THIN_MSA_EXT) )
			  return true;
		  else
			  return false;
	  }
 }

//##############################################################################################################################\
class A2MFilenameFilter implements FilenameFilter{
	  
	  public boolean accept(File dir,String name){
		  
		 
		  String path = dir+name;
		  if( path.endsWith(".a2m") )
			  return true;
		  else
			  return false;
	  }
  }
//##############################################################################################################################\
class SSFilenameFilter implements FilenameFilter{
	  
	  public boolean accept(File dir,String name){
		  
		 
		  String path = dir+name;
		  if( path.endsWith("_A_PDBID_CHAIN_SEQUENCE.t06.str4.seq") )
			  return true;
		  else
			  return false;
	  }
}
//##############################################################################################################################\
class BURIALFilenameFilter implements FilenameFilter{
	  
	  public boolean accept(File dir,String name){
		  
		 
		  String path = dir+name;
		  if( path.endsWith("_A_PDBID_CHAIN_SEQUENCE.t06.near-backbone-11.seq") )
			  return true;
		  else
			  return false;
	  }
}

//##############################################################################################################################\
class ValueAndIndices{
	
	private double value;
	private int i;
	private int j;
	
	public void setValue(double value){
		this.value = value;
	}
	public void setI(int i){
		this.i = i;
	}
	public void setJ(int j){
		this.j = j;
	}
	
	public double getValue(){
		return value;
	}
	public int getI(){
		return i;
	}
	public int getJ(){
		return j;
	}
}
//##############################################################################################################################\

}














