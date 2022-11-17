
<%@page import="utility.DBManager, java.io.File , javax.servlet.* , java.util.StringTokenizer" %>


<html>

	<head>
		<title>EcoliOverExpressionDB</title>
		<link rel="stylesheet" href="MyStyle.css">
    </head>
	
	<body >
			 <table align="center">
					<tr><td  height="162" width="920" bgcolor="#C0C0C0"> <%@include file="Header.jsp" %> </td></tr>
					
					<tr><td height="auto" width="920"> <h1>Download</h1> <hr><br>
					
					          <%
					            ServletContext context = request.getSession().getServletContext();
								String filePath = context.getRealPath("Dataset.csv");
								System.out.println("filePath is " + filePath);
													          					            
					            try{
					                File file = new File(filePath);
					                file.delete();
    		                    } 
    	                        catch(Exception e){ e.printStackTrace(); }
	        					            
	        					//process the filepath
	        					String queryFilePath =  "";
	        					StringTokenizer st =  new StringTokenizer(filePath , "\\");
	        					while (st.hasMoreElements()) {
	        					      
	        					      queryFilePath += st.nextElement() + "\\\\";
	        					}
	        					queryFilePath = queryFilePath.substring(0, queryFilePath.length()-2);
	        					System.out.println("queryFilePath is " + queryFilePath);      
	        					           
					            DBManager.saveAllDataInFile(queryFilePath);
					            
					           %>
					     
					          <p>EcoliOverExpressionDB is offered to the public as a freely available resource. If you use EcoliOverExpressionDB in your work, please cite: 
					          <p><br><br> 
                                                  EcoliOverExpressionDB: A Database of Recombinant Protein Overexpression in E. coli
                                                 <br><br>
                                                 (The paper is under review.)</p><br><br>
					          
					          <h2>Version 1.0</h2><hr>
					          <p>You can get all the data in CSV format <a href='Dataset.csv' style='text-decoration: none'>here.</a><br><br>
					                                                                   
					<tr><td height="73" width="920"> <%@include file="Footer.jsp" %> </td></tr>
			 </table>
	</body>
	
</html>