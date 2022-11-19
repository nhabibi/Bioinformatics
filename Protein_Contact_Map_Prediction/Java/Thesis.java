

public class Thesis {

	public static void main(String[] args) {
		
		//Utility.copyPDB();
		
		//PDBExtractor pdbExt = new PDBExtractor();
		//pdbExt.extract("F:\\Bio\\workspace\\Thesis\\PDB\\", "F:\\Bio\\workspace\\Thesis\\SAM\\");
						
		//Utility.generateFasta("F:\\Bio\\workspace\\Thesis\\epdb\\","F:\\Bio\\workspace\\Thesis\\FASTA\\");
				   
		//Utility.unzipGZFiles("F:\\Bio\\workspace\\Thesis\\SAM\\","F:\\Bio\\workspace\\Thesis\\SAM\\");
		SAMFeatures samFeatures = new SAMFeatures();
		//samFeatures.extractMSA();	
	    //samFeatures.thinMSA();
		//samFeatures.extractSS();
		//samFeatures.extractBurial();
		//samFeatures.jointEntropyAndPropensity();
		//samFeatures.numberOfPairs();
		//samFeatures.entropyAndAADistribution();
		samFeatures.findMSALessThan15();
		
	    //Utility.copyFiles(".rankje", "C:\\Users\\Narges\\Documents\\MATLAB\\Thesis-Karplus\\Train\\TrainData\\", "F:\\Bio\\workspace\\Thesis\\SAM\\", "C:\\Users\\Narges\\Documents\\MATLAB\\Thesis-Karplus\\Train\\JETrainData\\");
	    //Utility.copyFiles(".rankje", "C:\\Users\\Narges\\Documents\\MATLAB\\Thesis-Karplus\\Test\\TestData\\", "F:\\Bio\\workspace\\Thesis\\SAM\\", "C:\\Users\\Narges\\Documents\\MATLAB\\Thesis-Karplus\\Test\\JETestData\\");
	    //Utility.copyFiles(".rankprop", "C:\\Users\\Narges\\Documents\\MATLAB\\Thesis-Karplus\\Train\\TrainData\\", "F:\\Bio\\workspace\\Thesis\\SAM\\", "C:\\Users\\Narges\\Documents\\MATLAB\\Thesis-Karplus\\Train\\PropensityTrainData\\");
	    //Utility.copyFiles(".rankprop", "C:\\Users\\Narges\\Documents\\MATLAB\\Thesis-Karplus\\Test\\TestData\\", "F:\\Bio\\workspace\\Thesis\\SAM\\", "C:\\Users\\Narges\\Documents\\MATLAB\\Thesis-Karplus\\Test\\PropensityTestData\\");
	    
		
	}
}














