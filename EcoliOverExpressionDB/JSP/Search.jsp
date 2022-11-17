
<%@page import="java.util.Vector"%>
<%@page import="org.biojava3.data.sequence.*"%>
<%@page import="utility.DBManager"%>
<%@page import="utility.ProcessSequence"%>

<html>

	<head>
		<title>EcoliOverExpressionDB</title>
		<link rel="stylesheet" href="MyStyle.css">


                <script type="text/javascript">
                       
                        function putValueToTextBox(combo){
                                  
                                 var textBoxID =  'text_id_' + ( (combo.name).substring(11) );
                                 var textBox = document.getElementById( textBoxID );
                                 textBox.value = combo.value;
                        }
                </script>
        
        </head>
	
	<body >
			 <table align="center">
					<tr><td height="162" width="920" bgcolor="#C0C0C0"> <%@include file="Header.jsp" %> </td></tr>
					
					<tr><td height="auto" width="920"> 
					
					     <%
				               String formIsFilled = request.getParameter( "FormIsFilled" );
				               if ( "true".equals(formIsFilled) == true ){
				               
				                  String ID = request.getParameter("text_name_ID");
				                  String gene_name = request.getParameter("text_name_gene_name");
                                                  String sequence = request.getParameter("text_name_sequence");
				                  String vector = request.getParameter("text_name_vector");
				                  String host = request.getParameter("text_name_host");
				                  String inducer = request.getParameter("text_name_inducer");
				                  String temperature = request.getParameter("text_name_temperature");
				                  String expression_level = request.getParameter("text_name_expression_level");
				                 				                  
				                  
				                  String condition = "";
				                  
				                  if (!ID.isEmpty())  condition += "ID=" + "'" + ID + "'";
				                  
				                  if (!gene_name.isEmpty()){ 
				                       if(!condition.equals(""))  condition += " and ";
				                       condition += "gene_name=" + "'" + gene_name + "'";
				                  }
				              

                                                  if (!sequence.isEmpty()){

                                                      //for biojava sequence alignment.
                                                      sequence =  sequence.toUpperCase();
                                                      sequence = sequence.replaceAll("\\s+","");
                                                                                       
                                                      Vector<String> similar_sequences = new Vector<String>();   

         
                                                      FastaSequence fs = new FastaSequence( "" , sequence);                                                      
                                                      if ( SequenceUtil.isNucleotideSequence(fs) ){
                                                          
                                                          System.out.println("\n\n The sequence is GENE: " + sequence);
                                                          similar_sequences = ProcessSequence.findSimilarDNASequences(sequence);
                                                      }

                                                      else if ( SequenceUtil.isProteinSequence(sequence) ){
                  
                                                          System.out.println("\n\n The sequence is PROTEIN: " + sequence);
                                                          similar_sequences = ProcessSequence.findSimilarProteinSequences(sequence);
                                                      }
                                                      else{          
                                                          System.out.println("\n\n The sequence is INVALID: " + sequence);
                                                      }
 				                      
                                                      if(!condition.equals(""))  condition += " and ";
   				                     
                                                      condition += "gene_sequence=";  

                                                      //We add the given sequence outside the loop for some technical issues!
                                                      condition += "'";
                                                      condition += sequence;
                                                      condition += "'";
 
                                                      for(int i=1; i<similar_sequences.size(); ++i){
                                                         
                                                         condition += "or ";
                                                         condition += "gene_sequence=";
                                                         condition += "'";
                                                         condition += similar_sequences.get(i);
                                                         condition += "'";                                 
                                                      }
                                                   }

				                     
				                  if (!vector.isEmpty()){
				                       if(!condition.equals(""))  condition += " and ";
				                       condition += "vector=" + "'" + vector + "'";
				                  }
				                  				                  
				                  if (!host.isEmpty()){
				                       if(!condition.equals(""))  condition += " and ";
				                       condition += "host=" + "'" + host + "'";
				                  }
				               
				                  if (!inducer.isEmpty()){
				                       if(!condition.equals(""))  condition += " and ";
				                       condition += "inducer=" + "'" + inducer + "'";
				                  }
				                  
				                  if (!temperature.isEmpty()){
				                       if(!condition.equals(""))  condition += " and ";
				                       condition += "temperature=" + "'" + temperature + "'";
				                  }
				                  
				                  				                  
				                  if (!expression_level.isEmpty()){
				                       if(!condition.equals(""))  condition += " and ";			                      
				                       condition += "expression_level=" + "'" + expression_level + "'";
				                  }
                                                  
				                  		                  				                                
				                  if (!condition.equals("")){            
				                      out.print( DBManager.query("select distinct * from EcoliOverExpressionDB.dataset where " + condition) );
				                      out.println("<hr>");
				                  }
				                               
				               }//if    
				      				         	
						    out.println("<h1>Search Database</h1><hr>"
					           +"<form method='get' action='Search.jsp'>"
					           					               
					           + "<label>Database ID</label><br>"
                                                   + "<input type='text' name='text_name_ID'  id='text_id_ID' value=''>"
                                                   + "&nbsp;&nbsp;"
					           + DBManager.generateComboBoxForSearch("ID") 
                                                   + "<br><br>"					               
					           					               
					           + "<label>Gene Name</label><br>"
                                                   + "<input type='text' name='text_name_gene_name'  id='text_id_gene_name' value=''>"
                                                   + "&nbsp;&nbsp;"
					           + DBManager.generateComboBoxForSearch("gene_name") 
                                                   + "<br><br>"
					              
					          
                                                   + "<label>Gene Sequence (Nucleotide) or Protein Sequence (Single Letter Amino Acid)</label><br>"
                                                   + "<input type='text' name='text_name_sequence'  id='text_id_sequence' value=''>"       
                                                   + "<br><br>"
					        				               
					           + "<label>Vector</label><br>"
                                                   + "<input type='text' name='text_name_vector'  id='text_id_vector' value=''>"
                                                   + "&nbsp;&nbsp;"
					           + DBManager.generateComboBoxForSearch("vector") 
                                                   + "<br><br>"
					               
					           + "<label>Host Strain</label><br>"
                                                   + "<input type='text' name='text_name_host'  id='text_id_host' value=''>"
                                                   + "&nbsp;&nbsp;"
					           + DBManager.generateComboBoxForSearch("host") 
                                                   + "<br><br>"
					               
					           + "<label>Inducer Concentration</label><br>"
                                                   + "<input type='text' name='text_name_inducer'  id='text_id_inducer' value=''>"
                                                   + "&nbsp;&nbsp;"
					           + DBManager.generateComboBoxForSearch("inducer") 
                                                   + "<br><br>"
					               
					           + "<label>Induced Temperature</label><br>"
                                                   + "<input type='text' name='text_name_temperature'  id='text_id_temperature' value=''>"
                                                   + "&nbsp;&nbsp;"
					           + DBManager.generateComboBoxForSearch("temperature") 
                                                   + "<br><br>"
					              			               
					           + "<label>Expression Level</label><br>"
                                                   + "<input type='text' name='text_name_expression_level'  id='text_id_expression_level' value=''>"
                                                   + "&nbsp;&nbsp;"
					           + DBManager.generateComboBoxForSearch("expression_level") 
                                                   + "<br><br>"
					             					              
					           					               
					           +"<input type='hidden' name='FormIsFilled' value='true'/><br>"
					           +"<input type='submit' name='Submit' value='Search Database'><br>"		
						   +"</form>");
							   
						   %>							
							 
					</td> </tr>
					
					<tr> <td height="73" width="920"> <%@include file="Footer.jsp" %> </td> </tr>
			 </table>
	</body>
	
</html>