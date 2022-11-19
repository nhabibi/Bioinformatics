
<%@page import="utility.Email"%>
<%@page import="utility.DBManager"%>

<html>

	<head>
		<title>EcoliOverExpressionDB</title>
		<link rel="stylesheet" href="MyStyle.css">
    </head>
	
	<body>
	
	 <script type="text/javascript">
        
//******************************************************************************************************
      
        function submitForm(){
        
       			 if( validateRequiredFields() & validateEmail() ){  document.forms['contactForm'].submit(); }
        }
//******************************************************************************************************      	
		function validateRequiredFields(){
		       
             	var RequiredFields = "name,email,subject,message";
             	
				var FieldList = RequiredFields.split(",");
				var BadList = new Array();
				for(var i = 0; i < FieldList.length; i++) {
				
				    //Just to clear the previous RED messages from the fields which have been corrected and filled.
				    document.getElementById( FieldList[i] + 'EmptyErrorMsg').innerHTML = "<p style='color:white'></p>";
				    
					var s = eval('document.contactForm.' + FieldList[i] + '.value');
					s = StripSpacesFromEnds(s);
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
		}
//******************************************************************************************************
	    function validateEmail(){
	            
	            document.getElementById('emailFormatErrorMsg').innerHTML = "<p style='color:white'></p>";
	            
				var emailRegEx = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i;
				var result = emailRegEx.test(contactForm.email.value);
				if(result == false){
				   document.getElementById('emailFormatErrorMsg').innerHTML = "<p style='color:red'>The format of the email address is not valid.</p>";
				}
				return result;
		}
//******************************************************************************************************
	</script>
	
							
			 <table align="center">
					<tr><td height="162" width="920" bgcolor="#C0C0C0"> <%@include file="Header.jsp" %> </td></tr>
					
					<tr><td height="auto" width="920">
					     
					          <%
				               String formIsFilled = request.getParameter( "FormIsFilled" );
				               if ( "true".equals(formIsFilled) == true ){;
				                  String name = request.getParameter("name");
				                  String email = request.getParameter("email");
				                  String subject = request.getParameter("subject");
				                  String message = request.getParameter("message");
				                  boolean result = DBManager.insertFeedback(name, email, subject, message);
				                  if (result == true){
				                  	                  out.println("<br><br><p style='color:red'> Thanks! Your comment has been recorded and"
				                  	                  + " will be responded soon.</p>");
				                                      //+"<br><a href='Contact.jsp'><p>Send a new comment.</p></a>");

                                                                     String body = 
                                                                     "Name -> " + name + "\n"
                                                                     +"Email address -> " + email + "\n" 
				                                     +"Subject -> " + subject + "\n"
				                                     +"Message -> " + message + "\n";

				                                      Email.sendEmail(email, "comment", body);
				                  }
				                  else{
				                       out.println("<br><br><p style='color:red'> Sorry! There is a problem in recording your comment."
				                  	                  + " Please try again.</p>");
				                  }
							   }
							 
						 else{
							        out.println("<h1>Contact</h1><hr><br>"
							        +"<p>Soft Computing Research Group (SCRG)<br>Faculty of Computing<br>"
							        +"Universiti Teknologi Malaysia (UTM)<br>Johor, Malaysia, 81310.<br><br>"
							        +"Narjeskhatoon Habibi: narges.habibi@gmail.com <br></p><br><br>"
							        +"<h2>Questions/Feedback Form</h2><hr>"
							        +"<p>Please use the form below to send your comments or questions to us.</p><br>"
							        
							        +"<form method='get'  action='Contact.jsp'  name='contactForm'>"
							        
							        +"<label for='Name'>Name</label><br><input type='text' name='name' value=''>"
							        +"<div id='nameEmptyErrorMsg'></div>"
							        +"<br><br>"
							        
							        +"<label for='Email'>Email</label><br><input type='text' name='email' value=''>"
							        +"<div id='emailFormatErrorMsg'></div>"
							        +"<div id='emailEmptyErrorMsg'></div>"
							        +"<br><br>"
							        
							        +"<label for='Subject'>Subject</label><br><input type='text' name='subject' value=''>"
							        +"<div id='subjectEmptyErrorMsg'></div>"
							        +"<br><br>"
							        
							        +"<label for='Message'>Message</label><br><textarea name='message' rows='10' cols='30'></textarea>"
							        +"<div id='messageEmptyErrorMsg'></div>"
							        +"<br><br>"
							        
							        +"<input type='hidden' name='FormIsFilled' value='true'/>"
							        
							        +"<input type='button' name='Submit' value='Send message'  onclick='submitForm();'/><br>"
							        
							        +"<p style='color:red'>* All the fields are mandatory.<p>"
							        
							        
							        +"</form>");
						  }//else
						  %>
							 			
					</td></tr>
					
					<tr><td height="73" width="920"> <%@include file="Footer.jsp" %> </td></tr>
			 </table>
	</body>
	
</html>