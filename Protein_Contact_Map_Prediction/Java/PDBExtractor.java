import java.io.*;
import java.util.StringTokenizer;


public class PDBExtractor {

   private static final int NUMBER_OF_COLUMNS = 12;
     
//*****************************************************************************************************************************
     /*
     -Just extracts the FIRST chain if there are more. Usually the first chain is A, 
      but at this time, I don't know if there are some files that they don't have A 
      chain or the A chain is not the first chain.
     -Ignore these files: 
        1-multi-MODEL files,
        2-have HETATM records at first or in the middle of ATOM records
        3-have ANISOU at first or in the middle of ATOM records
        4-with ATOM lines which with less than 12 column,
        5-with missing residues,
        6-residue number is (a number+ a letter) at first or anywhere
        7-an AA (or more than one AA), dose not have a CB atom
        8-amino acid is not a standard one (one of 20 AA). for example AMET, BMET, etc.
       
     */
     public void extract(String srcPath,String destPath) {
    	 
    	 
    	 try{
    		 String[] list = new File(srcPath).list();
    	     //for every PDB file
    		 
    		 //BufferedWriter invalidFiles = new BufferedWriter(new OutputStreamWriter(new FileOutputStream( destPath+"invalidFiles.txt")));
    		 
    	     for(int i=0;i<list.length;++i){
    	    	 
    		     BufferedReader br = new BufferedReader(new InputStreamReader(new FileInputStream( srcPath+list[i] )));
    		     String fileName = list[i].substring(0, list[i].indexOf('.'));
    		     
    		     System.out.println("==> Extract PDB file "+i+": "+fileName);
    		     
    		     boolean savePDB = true;
    		     boolean AAHasCB = false;
    		     String epdb = "";
    		     String preLine = "";
    		     String line = br.readLine();
    		     while ( !line.startsWith("ATOM") ){ 
    		    	 preLine = line;
    		    	 line = br.readLine();
    		     }
    		     
    		     //check 1 and 2 (at first) and 3 (at first)
    		     if(preLine.startsWith("MODEL") || preLine.startsWith("HETATM") || preLine.startsWith("ANISOU")){
    		    	 System.out.println("Starts with MODEL or HETATM or ANISOU");
    		    	 continue;
    		     }
    		     
    		     int preResidueNumber;
    		     int residueNumber = getStartResidueNumber(line);
    		     
    		     //check 3 and 6 for first ATOM record. If first ATOM record has less than 12 column or is (number+letter), the method returns MIN_VALUE
    		     if(residueNumber == Integer.MIN_VALUE){
    		    	 System.out.println("The first ATOM record has less than 12 columns or is (number+letter)");
    		    	 continue;
    		     }
    		     
    		     while ( !line.startsWith("TER") ){
    		    	 
    		    	 //check 2 (in the middle) and 3 (in the middle)
    		    	 if(line.startsWith("HETATM") || line.startsWith("ANISOU")){
    		    		 System.out.println("HETATM or ANISOU in the middle of ATOM records");
    		    		 savePDB = false;
    		    		 break;
    		    	 }
    		    	 
    		    	 StringTokenizer st = new StringTokenizer(line);
    		    	 
    		    	 //check 4
    		    	 if (st.countTokens() != NUMBER_OF_COLUMNS){
    		    		 System.out.println("Number of columns is less than 12");
    		    		 savePDB = false;
    		    		 break;
    		    	 }
    		    		 
                     st.nextToken();//1
                     st.nextToken();//2
                     String atom = st.nextToken();//3
                     String aminoAcid = st.nextToken();//4
                     st.nextToken();//5
                     preResidueNumber = residueNumber;
                     String residueNumberToken = st.nextToken();
                     //check 6
                     try{
                    	 residueNumber = Integer.parseInt(residueNumberToken);//6
                     }
                     catch(Exception e){
                    	System.out.println("Residue number is (number+letter): "+residueNumberToken); 
                    	savePDB =false;
                    	break;
                     }
                     String x = st.nextToken();//7
                     String y = st.nextToken();//8
                     String z = st.nextToken();//9
                     
                     //check 5. the residueNumber must be same as previous record or it must be 1 more.
                     if( ! (residueNumber == preResidueNumber || residueNumber == preResidueNumber+1) ){
                    	 System.out.println("Missing residues, preResidueNumber: "+preResidueNumber+", residueNumber: "+residueNumber);
                    	 savePDB = false;
                    	 break;
                     }
                     
                     //check 7. if we have passed over an AA without seeing a CB atom, so we ignore the file.
                     if( (residueNumber == preResidueNumber+1) && AAHasCB==false ){
                    	 //invalidFiles.append(fileName+"\t");
                         //invalidFiles.append("\n");
                    	 System.out.println("The atom dose not have CB atom.");
                    	 savePDB = false;
                    	 break;
                     }
                          
                     if( aminoAcid.equals("GLY") && atom.equals("CA") )
                        atom = "CB";
                         
                     if( atom.equals("CB") ){
                       	int aminoAcidCode = getAminoAcidCode(aminoAcid);
                       	AAHasCB = true; //for "check 7"
                       
                       	//check 8
                       	if(aminoAcidCode == -1){
                       		System.out.println("Non-standard Amino Acid: "+aminoAcid);
                       		savePDB = false;
                       		break;
                       	}
                       	
                        epdb += aminoAcidCode +"," + x + "," + y + "," + z + "\n";
                     }
                           		    	 
    		    	 line = br.readLine();
    		    	 
    		     }//while
    		     if (savePDB == true){ //check if in the middle of the way, something is wrong.
    		    	 BufferedWriter bw = new BufferedWriter( new FileWriter(destPath+fileName+".epdb"));
 		             bw.append(epdb);
 		             bw.close();
    		     }//if
    		     
    	     }//for i
    	     
    	     //invalidFiles.close();
    	     
    	 }//try
    	 catch(IOException ioe){
    		System.out.println(ioe.getMessage()); 
    	 }
     System.out.println("********** PDBExctractor() Finished. *************");	 
     }//extract()
//*****************************************************************************************************************************
     private int getStartResidueNumber(String firstATOMRecord){
    	 
    	 StringTokenizer st = new StringTokenizer(firstATOMRecord);
    	 if(st.countTokens() != NUMBER_OF_COLUMNS){
    		 return Integer.MIN_VALUE;//never will be used! just for Java compiler!!!
    	 }
    	 else{
    		 st.nextToken();
    		 st.nextToken();
    		 st.nextToken();
    		 st.nextToken();
    		 st.nextToken();
    		 try{
    		    int number = Integer.parseInt(st.nextToken());
    		    return number;
    		 }
    		 catch(Exception e){
    			 return Integer.MIN_VALUE;
    		 }
    	 }
    	   	 
     }
//*****************************************************************************************************************************
     private int getAminoAcidCode(String aminoAcid) {

         if (aminoAcid.equals("ALA")) {
             return 1;
         } else if (aminoAcid.equals("ARG")) {
             return 2;
         } else if (aminoAcid.equals("ASN")) {
             return 3;
         } else if (aminoAcid.equals("ASP")) {
             return 4;
         } else if (aminoAcid.equals("CYS")) {
             return 5;
         } else if (aminoAcid.equals("GLN")) {
             return 6;
         } else if (aminoAcid.equals("GLU")) {
             return 7;
         } else if (aminoAcid.equals("GLY")) {
             return 8;
         } else if (aminoAcid.equals("HIS")) {
             return 9;
         } else if (aminoAcid.equals("ILE")) {
             return 10;
         } else if (aminoAcid.equals("LEU")) {
             return 11;
         } else if (aminoAcid.equals("LYS")) {
             return 12;
         } else if (aminoAcid.equals("MET")) {
             return 13;
         } else if (aminoAcid.equals("PHE")) {
             return 14;
         } else if (aminoAcid.equals("PRO")) {
             return 15;
         } else if (aminoAcid.equals("SER")) {
             return 16;
         } else if (aminoAcid.equals("THR")) {
             return 17;
         } else if (aminoAcid.equals("TRP")) {
             return 18;
         } else if (aminoAcid.equals("TYR")) {
             return 19;
         } else if (aminoAcid.equals("VAL")) {
             return 20;
         } /*else if (aminoAcid.equals("ASX")) {
             return 21;
         } else if (aminoAcid.equals("GLX")) {
             return 22;
         }else if (aminoAcid.equals("XAA")) {
             return 23;
         }*/else {
             return -1;
         }

     }//getAminoAcidCode()
 //***************************************************************************************************************************    
      
} //Class


