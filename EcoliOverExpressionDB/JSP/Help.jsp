
<html>

	<head>
		<title>EcoliOverExpressionDB</title>
		<link rel="stylesheet" href="MyStyle.css">
    </head>
	
	<body >
			 <table align="center">
					<tr><td height="162" width="920" bgcolor="#C0C0C0"> <%@include file="Header.jsp" %> </td></tr>
					
					<tr><td height="auto" width="920"> 

					         <h1>How to Use EcoliOverExpressionDB</h1><hr><br><br>
					          

                                                 <h2>Database Content</h2><hr>
					         <p> 
                                                 Each database entry contains data of the expression condition and expression result, 
                                                 including:
                                                 <ul>
                                                     <li>Gene name</li>
                                                     <li>Gene ID</li>
                                                     <li>Gene sequence (e.g. GenBank ID)</li>
                                                     <li>Vector name</li>
                                                     <li>E. coli strain name</li> 
                                                     <li>Inducer concentration (e.g. Arabinose, Autoinduction, IPTG, lactose)</li>
                                                     <li>Temperature after induction</li>
                                                     <li>Expression level (Low, Medium or High)</li>
                                                     <li>Expression yield (mg/l)</li>
                                                     <li>Reference paper</li>
                                                     <li>Note</li>
                                                 </ul>
                                                 <p>
                                                 
                                                 <br>

                                                 <P>
                                                 For the "Expression Level" field, we consider 3 categories "Low, Medium and High",
                                                       based on the appearance of the recombinant protein band in SDS-PAGE of total cell extract:
                                                       <ul>
                                                       <li>
                                                       High: The recombinant protein band appears thick and inflated, easily identified even without comparing to control (>20% total protein).
                                                       </li>
                                                       <li>
                                                       Medium: The recombinant protein band is identified only when compared to controls (induced vs. uninduced/control).
                                                       </li>
                                                       <li>
                                                       Low: The recombinant protein band cannot be identified even when compared to controls but other more sensitive techniques indicate presence of the recombinant protein.
                                                       </li>
                                                       </ul>
                                                 <P>
                                                 
                                                 <br>

                                                 <P>
                                                 You can take a look at the "Browse" page or obtain the database through "Download"
                                                 page to see how the database looks like.
                                                 </p>
                                                
                                                 <br><br>					         
                                                 

                                                 <h2>How to Search</h2><hr>
					         <p> 
                                                 In the "Search" page, you can query the database based-on the one or more fields.
                                                 The values of the fields can be determined through drop-down menus.
                                                 </p><br><br>					         				         
					         

					         <h2>How to Submit A New Record</h2><hr>
					         <p>
                                                 In the "Submit" page, you can send us the data of your protein overexpression experiments
                                                 in E. coli.
                                                 Please kindly provide us with the values for all the fields.
                                                 </p><br><br>
					        			         				         
					                  
					</td></tr>
					
					<tr><td height="73" width="920"> <%@include file="Footer.jsp" %> </td></tr>
			 </table>
	</body>
	
</html>