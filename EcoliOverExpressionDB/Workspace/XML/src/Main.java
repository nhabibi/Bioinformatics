
import javax.xml.stream.*;
import java.io.*;

public class Main {

	public static void main(String args[]){
		
	   try{
		 
	 		FileReader fr = new FileReader("D:\\Dropbox\\Thesis\\Datasets\\New\\TagetTrack\\CESG\\CESG.xml");
			
			XMLInputFactory factory = XMLInputFactory.newInstance();
			XMLStreamReader parser = factory.createXMLStreamReader(fr);
			
			while (true) {
			    int event = parser.next();
			    if (event == XMLStreamConstants.END_DOCUMENT) {
			       parser.close();
			       break;
			    }
			    if (event == XMLStreamConstants.START_ELEMENT) {
			        System.out.println(parser.getLocalName());
			    }
			}
			
	   }//try
	   
	   catch(FileNotFoundException fnfe) { System.out.println( fnfe.getMessage() ); }
	   catch(XMLStreamException xse) { System.out.println( xse.getMessage() ); }
	   
	}//main
	
}//Main
