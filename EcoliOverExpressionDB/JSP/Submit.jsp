
<%@page import="utility.Email,utility.DBManager"%>

<html>

	<head>
		<title>EcoliOverExpressionDB</title>
		<link rel="stylesheet" href="MyStyle.css">
    </head>
	
	<body >
		
			
      <script type="text/javascript">
      
//****************************************************************************************************************************************************
      
        function submitForm(){
        
       			//if( validateRequiredFields() & validateEmail() ){  document.forms['submitNewDataForm'].submit(); }
       			if( validateEmail() ){  document.forms['submitNewDataForm'].submit(); }
        }
//****************************************************************************************************************************************************      	
	/* 	function validateRequiredFields(){
		       
             	var RequiredFields = "email,gene_name,gene_id,gene_sequence,vector,host,inducer,temperature,expression_level,yield,reference,note";
             	
				var FieldList = RequiredFields.split(",");
				var BadList = new Array();
				for(var i = 0; i < FieldList.length; i++) {
				    var s = eval('document.submitNewDataForm.' + FieldList[i] + '.value');
					//s = StripSpacesFromEnds(s);
					if(s.length < 1) { BadList.push(FieldList[i]); }
				}//for
				
				if(BadList.length < 1) { return true; }
				
				else{				
					for(var i = 0; i < BadList.length; i++) { 
						document.getElementById( BadList[i] + 'EmptyErrorMsg').innerHTML = "<p style='color:red'>This field can not be empty.</p>";
					}
					return false;
				}//else	
				
		}//function
		
	    function StripSpacesFromEnds(s){
	    
					while((s.indexOf(' ',0) == 0) && (s.length> 1)) { s = s.substring(1,s.length); }
					while((s.lastIndexOf(' ') == (s.length - 1)) && (s.length> 1)) {
						 s = s.substring(0,(s.length - 1));
					}
					if((s.indexOf(' ',0) == 0) && (s.length == 1)) { s = ''; }
					return s;
		} */
//*******************************************************************************************************************************************************
	    function validateEmail(){
	    
				var emailRegEx = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i;
				var result = emailRegEx.test(submitNewDataForm.email.value);
				if(result == false){
				   document.getElementById('emailFormatErrorMsg').innerHTML = "<p style='color:red'>The format of the email address is not valid.</P>";
				}
				return result;
		}
//*******************************************************************************************************************************************************
		function onDropDownChange(column) {
		
		        var e = document.getElementById(column + '_combo');    
		   		var selectedValue = e.options[e.selectedIndex].value; 
                //alert(selectedValue);
          		document.getElementById(column).value = selectedValue;
       	}
//*******************************************************************************************************************************************************
    </script>			
			
									
			 <table align="center">
					<tr><td height="162" width="920" bgcolor="#C0C0C0"> <%@include file="Header.jsp" %> </td></tr>
					
					<tr><td height="auto" width="920">
					     
					          <%
				               String formIsFilled = request.getParameter( "FormIsFilled" );
				               if ( "true".equals(formIsFilled) == true ){;
				                  
				                  String email = request.getParameter("email");
				                  String gene_name = request.getParameter("gene_name");
				                  String gene_id = request.getParameter("gene_id");
                                                  String gene_sequence = request.getParameter("gene_sequence");
				                  String vector = request.getParameter("vector");
				                  String host = request.getParameter("host");
				                  String inducer = request.getParameter("inducer");
				                  String temperature = request.getParameter("temperature");
				                  String expression_level = request.getParameter("expression_level");
                                                  String yield = request.getParameter("yield");
				                  String reference = request.getParameter("reference");
				                  String note = request.getParameter("note");	                  
				                  
				                                 
				                  boolean result = DBManager.insertNewData(email, gene_name, gene_id,
				                  gene_sequence, vector, host, inducer, temperature, expression_level, 
                                                  yield, reference, note);
				                 
				                  if(result == true){
				                                     out.println("<br><br><p style='color:red'> Thanks! Your data has been recorded. We will contact you soon.</p>"
				                                     +"<br><p>You have submitted the following information: </p><br>"
				                                     +"Your email address -> " + email + "<br>"
				                                     +"Gene name -> " + gene_name + "<br>"
				                                     +"Gene ID -> " + gene_id + "<br>"
                                                                     +"Gene nucleotide sequence -> " + gene_sequence + "<br>"
				                                     +"Vector -> " + vector + "<br>"
				                                     +"E. coli strain -> " + host + "<br>"
				                                     +"Inducer concentration -> " + inducer + "<br>"
				                                     +"Temperature after induction -> " + temperature + " °C" + "<br>"
				                                     +"Expression level -> " + expression_level + "<br>"
				                                     +"Yield -> " + yield + "<br>"
				                                     +"Reference -> " + reference + "<br>"
				                                     +"Note -> " + note + "<br>"
				                                     );
				                             
                                                                     String message = 
                                                                     "Email address -> " + email + "\n" 
				                                     +"Gene name -> " + gene_name + "\n"
				                                     +"Gene ID -> " + gene_id + "\n"
                                                                     +"Gene nucleotide sequence -> " + gene_sequence + "\n"
				                                     +"Vector -> " + vector + "\n"
				                                     +"E. coli strain -> " + host + "\n"
				                                     +"Inducer concentration -> " + inducer + "\n"
				                                     +"Temperature after induction -> " + temperature + " °C" + "\n"
				                                     +"Expression level -> " + expression_level + "\n"
				                                     +"Yield -> " + yield + "\n"
				                                     +"Reference -> " + reference + "\n"
				                                     +"Note -> " + note + "\n";

				                                     Email.sendEmail(email, "data", message);
				                 }
				                 else{
				                      out.println("<br><br><p style='color:red'> Sorry! there is a problem in recording your data. Please try again.</p>"
				                                     +"<br><a href='Submit.jsp'><p>Submit new data.</p></a>");
				                 }
							   }
							
							   else{		     
					      
					               out.println("<h1>Submit New Data</h1><hr>"
					               +"<p>Please use the form below to send us your data.</p><br>"
					               
					               +"<form method='get' action='Submit.jsp' name='submitNewDataForm'>"
					               
					               +"<label for='Email Address'>Your email address</label><br><input type='text' name='email' value='' style='WIDTH: 210px;'>"
					               +"<div id='emailFormatErrorMsg'></div>"
							       +"<div id='emailEmptyErrorMsg'></div>"
							       +"<br><br>"
					               
					               +"<label for='Gene Name'>Gene/Protein name</label><br><input type='text' name='gene_name' value='' style='WIDTH: 210px;'>"
					               +"&nbsp;&nbsp;"
					               //+ DBManager.generateComboBoxForSubmit("gene_name")
					               +"<div id='gene_nameEmptyErrorMsg'></div>"
					               +"<br><br>"
					               
					               +"<label for='Gene ID'>Gene ID (e.g. GenBank ID)</label><br><input type='text' name='gene_id' value='' style='WIDTH: 210px;'>"
					               +"&nbsp;&nbsp;"
					               //+ DBManager.generateComboBoxForSubmit("gene_id")
					               +"<div id='gene_idEmptyErrorMsg'></div>"
					               +"<br><br>"

                                                       +"<label for='Gene Sequence'>Gene nucleotide sequence</label><br><input type='text' name='gene_sequence' value='' style='WIDTH: 210px;'>"
					               +"<div id='gene_sequenceEmptyErrorMsg'></div>"
    					               +"<br><br>"
					        				               
					               +"<label for='Vector'>Vector</label><br><input type='text' name='vector' value='' style='WIDTH: 210px;'>"
					               +"&nbsp;&nbsp;"
					               //+ DBManager.generateComboBoxForSubmit("vector")
					               +"<div id='vector_emailEmptyErrorMsg'></div>"
					               +"<br><br>"					               
					               
					               +"<label for='host'>E. coli strain</label><br><input type='text' name='host' style='WIDTH: 210px;'>"
					               +"&nbsp;&nbsp;"
					               //+ DBManager.generateComboBoxForSubmit("host")
					               +"<div id='hostEmptyErrorMsg'></div>"
					               +"<br><br>"					               					               
					             
					               +"<label for='Inducer Concentration'>Inducer concentration (e.g. 1 mM IPTG)</label><br><input type='text' name='inducer' value='' style='WIDTH: 210px;'>"
					               +"&nbsp;&nbsp;"
					               //+ DBManager.generateComboBoxForSubmit("inducer") 
					               +"<div id='inducerEmptyErrorMsg'></div>"
					               +"<br><br>"					               
					               
					               +"<label for='Induced Temperature'>Temperature after induction (°C)</label><br><input type='text' name='temperature' value='' style='WIDTH: 210px;'>"
					               +"&nbsp;&nbsp;"
					               //+ DBManager.generateComboBoxForSubmit("temperature")
					               +"<div id='temperatureEmptyErrorMsg'></div>"
					               +"<br><br>"					               
					          					               
					               +"<label for='Yield'>Yield (mg/l)</label><br><input type='text' name='yield' value='' style='WIDTH: 210px;'>"
					               +"&nbsp;&nbsp;"
					               //+ DBManager.generateComboBoxForSubmit("yield")
					               +"<div id='yieldEmptyErrorMsg'></div>"
					               +"<br><br>"
           
					               +"<label for='Reference'>Reference</label><br><input type='text' name='reference' value='' style='WIDTH: 210px;'>"
					               +"<div id='referenceEmptyErrorMsg'></div>"
					               +"<br><br>"
			              				               
					               +"<label for='Note'>Note</label><br><input type='text' name='note' value='-' style='WIDTH: 210px;'>"
					               +"<div id='noteEmptyErrorMsg'></div>"
					               +"<br><br>"

                                                       +"<label for='Expression Level'>Expression level</label><br><input type='text' name='expression_level' value='' style='WIDTH: 210px;'>"
					               +"&nbsp;&nbsp;"
					               //+ DBManager.generateComboBoxForSubmit("expression_level")
                                                       +"<br><br>"
                                                       +"Definition. There are 3 categories for expression level (Low, Medium and High), "
                                                       +"based on the appearance of the recombinant protein band in SDS-PAGE of total cell extract."
                                                       +"<ul>"
                                                       +"<li>"
                                                       +"High: The recombinant protein band appears thick and inflated, easily identified even without comparing to control (>20% total protein)."
                                                       +"</li>"
                                                       +"<li>"
                                                       +"Medium: The recombinant protein band is identified only when compared to controls (induced vs. uninduced/control)."
                                                       +"</li>"
                                                       +"<li>"
                                                       +"Low: The recombinant protein band cannot be identified even when compared to controls but other more sensitive techniques indicate presence of the recombinant protein."
                                                       +"</li>"
                                                       +"</ul>"
					               +"<div id='expression_levelEmptyErrorMsg'></div>"
					               +"<br><br>"					             
					            		
			               
					               +"<input type='hidden' name='FormIsFilled' value='true'/>"
					               +"<input type='button' name='Submit' value='Submit data'  onclick='submitForm();'/>"	
					               
					               +"<p style='color:red'>* Please fill in all fields if possible.<p>"
					               	
						 +"</form>");
						 }//else
						 %>
					</td></tr>
					               
					<tr><td height="73" width="920"> <%@include file="Footer.jsp" %> </td></tr>
			 </table>
	</body>
	
</html>