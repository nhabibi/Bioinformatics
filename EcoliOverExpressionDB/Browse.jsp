<%@page import="utility.DBManager"%>

<html>

	<head>
		<title>EcoliOverExpressionDB</title>
		<link rel="stylesheet" href="MyStyle.css">
    </head>
	
	<body >
			 <table align="center">
			 
					<tr><td  height="162" width="920" bgcolor="#C0C0C0"> <%@include file="Header.jsp" %> </td></tr>
					
					<tr><td height="auto" width="920"> <h1>Browse</h1> <hr>
					
					<%	
					   out.print( DBManager.query("select * from EcoliOverExpressionDB.dataset") );		                      
					%>
					
					</td></tr>
					                                                                
					<tr><td height="73" width="920"> <%@include file="Footer.jsp" %> </td></tr>
					
			 </table>
	</body>
	
</html>