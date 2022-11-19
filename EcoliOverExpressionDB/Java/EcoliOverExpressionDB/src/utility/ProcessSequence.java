     package utility;
     
     import java.io.BufferedReader;
     import java.io.IOException;
     import java.io.InputStreamReader;
     import java.util.Vector;
     import java.util.regex.Pattern;
     
     import org.biojava3.alignment.Alignments;
     import org.biojava3.alignment.Alignments.PairwiseSequenceAlignerType;
     import org.biojava3.alignment.Alignments.PairwiseSequenceScorerType;
     import org.biojava3.alignment.SimpleGapPenalty;
     import org.biojava3.alignment.SimpleSubstitutionMatrix;
     import org.biojava3.alignment.SubstitutionMatrixHelper;
     import org.biojava3.alignment.template.SequencePair;
     import org.biojava3.alignment.template.SubstitutionMatrix;
     import org.biojava3.core.sequence.DNASequence;
     import org.biojava3.core.sequence.ProteinSequence;
     import org.biojava3.core.sequence.compound.AmbiguityDNACompoundSet;
     import org.biojava3.core.sequence.compound.AminoAcidCompound;
     import org.biojava3.core.sequence.compound.AminoAcidCompoundSet;
     import org.biojava3.core.sequence.compound.NucleotideCompound;
      
       
     public class ProcessSequence
     {
    	 
//****************************************************************************************************************************************************    	 
       public static Vector<String> findSimilarProteinSequences(String query_seq){
    	       	    	   
    	   /*Algorithm: 
    	           1-Receive a protein sequences.
    	           2-Retrieve all the gene sequences from the database.
    	           3-Translate all the sequences in the DB to Proteins.
    	           4-Write a function to find all the similar translated sequences to the given protein.
    	           5-Return the gene sequences corresponding to the similar translated sequences.     
    	  */
    	   
    	    final int SIMILARITY_THREASHOLD = 100;
            
    	    Vector<String> similar_sequences = new Vector<String>();
    	    
    	    Vector<String> gene_seuqences = DBManager.findAllSequences();
	        
	        Vector<String> protein_sequences = translateGenesToProteins(gene_seuqences);
	        
	        ProteinSequence query;
	        try{
	        	//Try is just because of the below line!
	        	query = new ProteinSequence(query_seq, AminoAcidCompoundSet.getAminoAcidCompoundSet());
	        	                  	        
		        for(int i=1; i< (protein_sequences.size()-1); ++i){
		        	   	        	
		        	String nextTargetSeq = protein_sequences.get(i);
		        	ProteinSequence target = new ProteinSequence(nextTargetSeq, AminoAcidCompoundSet.getAminoAcidCompoundSet());
		        	 
		        	SubstitutionMatrix<AminoAcidCompound> matrix = new SimpleSubstitutionMatrix<AminoAcidCompound>();
		       
		      		/*
		      		SimpleGapPenalty gapP = new SimpleGapPenalty();
		      		gapP.setOpenPenalty((short)5);
		      		gapP.setExtensionPenalty((short)2);
		      		*/
		      		
		      		SequencePair<ProteinSequence, AminoAcidCompound> psa = Alignments.getPairwiseAlignment(query, target,
		                                                                                                    PairwiseSequenceAlignerType.LOCAL, 
		                                                                                                    new SimpleGapPenalty(),
		                                                                                                    matrix);
		       
		      		Vector<ProteinSequence> TwoSeq = new Vector<ProteinSequence>();
		      		TwoSeq.add(query);
		      		TwoSeq.add(target);
		      		int[] score =Alignments.getAllPairsScores(TwoSeq,
		      				                                  PairwiseSequenceScorerType.LOCAL,//PairwiseSequenceScorerType.LOCAL_IDENTITIES,//PairwiseSequenceScorerType.LOCAL,//PairwiseSequenceScorerType.LOCAL_SIMILARITIES,
		      				                                  new SimpleGapPenalty(),
		      				                                  matrix);    	      		
		         	System.out.print(i + ":\n");
		      		System.out.println(psa);
		      		System.out.println("Score= " + score[0] + "\n\n");
	   	        
	   	        if (score[0] > SIMILARITY_THREASHOLD)  similar_sequences.add( gene_seuqences.get(i) );
		     
		        }//for 
		        
	        }//try
	        
	        catch(Exception cntr){
	        	System.out.println( cntr.getMessage() );	       	
	        }
	           	       
	   return similar_sequences;
    	
       }
//****************************************************************************************************************************************************    	 
    
       public static Vector<String> translateGenesToProteins(Vector<String> genes){
    	     
    	   Vector<String> translated_genes = new Vector<String>();
    	   
    	   for(int i=1; i<genes.size()-1; ++i){
    		    
    		   DNASequence dna = new DNASequence(genes.get(i));
    		   ProteinSequence protein = dna.getRNASequence().getProteinSequence();
    		   translated_genes.add(protein.toString());
    	   }
    	   
    	   return translated_genes;
    	   
       } 
//****************************************************************************************************************************************************       
       //Global alignments, which attempt to align every residue in every sequence, are most useful when the sequences in the query set are similar and of roughly equal size. (This does not mean global alignments cannot end in gaps.) A general global alignment technique is the Needleman–Wunsch algorithm, which is based on dynamic programming. Local alignments are more useful for dissimilar sequences that are suspected to contain regions of similarity or similar sequence motifs within their larger sequence context. The Smith–Waterman algorithm is a general local alignment method also based on dynamic programming.

       public static Vector<String> findSimilarDNASequences(String query_seq) {
         	 
    	        final int SIMILARITY_THREASHOLD = 600;
       
    	        Vector<String> gene_seuqences = DBManager.findAllSequences();
    	        Vector<String> similar_sequences = new Vector<String>();
    	        
    	        DNASequence query = new DNASequence(query_seq, AmbiguityDNACompoundSet.getDNACompoundSet());
    	                  	        
    	        for(int i=1; i< (gene_seuqences.size()-1); ++i){
    	        	   	        	
    	        	String nextTargetSeq = gene_seuqences.get(i);
    	        	DNASequence target = new DNASequence(nextTargetSeq, AmbiguityDNACompoundSet.getDNACompoundSet());
    	        	 
    	      		SubstitutionMatrix<NucleotideCompound> matrix = SubstitutionMatrixHelper.getNuc4_4();
    	       
    	      		SimpleGapPenalty gapP = new SimpleGapPenalty();
    	      		gapP.setOpenPenalty((short)5);
    	      		gapP.setExtensionPenalty((short)2);
    	       
    	      		SequencePair<DNASequence, NucleotideCompound> psa = Alignments.getPairwiseAlignment(query, target,
    	      						                                                                    PairwiseSequenceAlignerType.LOCAL,
    	      		     			                                                                    gapP, matrix);
    	      		Vector<DNASequence> TwoSeq = new Vector<DNASequence>();
    	      		TwoSeq.add(query);
    	      		TwoSeq.add(target);
    	      		int[] score =Alignments.getAllPairsScores(TwoSeq,
    	      				                                  PairwiseSequenceScorerType.LOCAL,//PairwiseSequenceScorerType.LOCAL_IDENTITIES,//PairwiseSequenceScorerType.LOCAL,//PairwiseSequenceScorerType.LOCAL_SIMILARITIES,
                                                              gapP, matrix);    	      		
    	        	System.out.print(i + ": ");
    	      		System.out.println(psa);
    	      		System.out.println("Score: " + score[0] + "\n\n");
	    	        
	    	        if (score[0] > SIMILARITY_THREASHOLD)  similar_sequences.add( gene_seuqences.get(i) );
    	     
    	        }//for         	        
    	           	       
    	   return similar_sequences;
       }
//****************************************************************************************************************************************************       
       public static void checkSequence(){
    	  
    	   System.out.println("Enter the sequence: ");
           BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
           String seq = "";
           try
           {
              String nextLine;
           while ((nextLine = br.readLine()) != null)
              {
                seq = seq + nextLine;
              } } catch (IOException ioe) { System.out.println("IO error trying to read the sequence!"); }
            System.out.println("\n\nSequence you have entered:\n" + seq);
       
           seq = seq.toUpperCase();
           seq = seq.replaceAll("\\s", "");
           seq = seq.replaceAll("[0-9]", "");
           System.out.println("\n\nSequence after phase1:\n" + seq);
        
           boolean correct = Pattern.matches("[ATCG]+", seq);
           if (correct)
              System.out.println("\n\nSequence is CORRECT.");
           else {
              System.out.println("\n\nSequence is WRONG.");
           }
           seq = seq.replaceAll("[^ATCG]", "");
           System.out.println("\n\nSequence after phase2:\n" + seq); 
    	   
       }
//****************************************************************************************************************************************************       
       public static void main(String[] args)
       {
    	   //DBManager.findAllSequences();
    	   //findSimilarDNASequences("ATGGGCAGCAGCCATCATCATCATCATCACAGCAGCGGCCTGGTGCCGCGCGGCAGCCATATGGCTAGCATGTCGGACTCAGAAGTCAATCAAGAAGCTAAGCCAGAGGTCAAGCCAGAAGTCAAGCCTGAGACTCACATCAATTTAAAGGTGTCCGATGGATCTTCAGAGATCTTCTTCAAGATCAAAAAGACCACTCCTTTAAGAAGGCTGATGGAAGCGTTCGCTAAAAGACAGGGTAAGGAAATGGACTC");
    	   //findSimilarProteinSequences("MRHIAHTQRCLSRLTSLVALLLIVLPMVFSPAHSCGPGRGLGRHRARNLYPLVLKQTIPNLSEYTNSASGPLEGVIRRDSPKFKDLVPNYNRDILFRDEEGTGADRLMSKRCKEKLNVLAYSVMNEWPGIRLLVTESWDEDYHHGQESLHYEGRAVTIATSDRDQSKYGMLARLAVEAGFDWVSYVSRRHIYCSVKSDSSISSHVHGCFTPESTALLESGVRKPLGELSIGDRVLSMTANGQAVYSEVILFMDRNLEQMQNFVQLHTDGGAVLTVTPAHLVSVWQPESQKLTFVFADRIEEKNQVLVRDVETGELRPQRVVKVGSVRSKGVVAPLTREGTIVVNSVAASCYAVINSQSLAHWGLAPMRLLSTLEAWLPAKEQLHSSPKVVSSAQQQNGIHWYANALYKVKDYVLPQSWRHD");
    	   checkSequence();
       }
//****************************************************************************************************************************************************       
     }
 