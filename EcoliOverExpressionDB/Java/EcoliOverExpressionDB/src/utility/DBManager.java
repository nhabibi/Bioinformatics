package utility;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

 
public class DBManager
{
   private static Connection con;
   
 //***********************************************************************************************************************
   private static void connectToDB()
   {
     try
     {
      //if (con == null) {
         Class.forName("com.mysql.jdbc.Driver");
         con = DriverManager.getConnection("jdbc:mysql://localhost:3306/EcoliOverExpressionDB", "root", "muFFin!@#456");
      //}
      } catch (Exception e) {
       e.printStackTrace();
     }
   }
 //*********************************************************************************************************************** 
   private static void disconnectFromDB()
   {
     try
     {  con.close();  }
      catch (Exception e) {
      e.printStackTrace();
     }
   }
 //***********************************************************************************************************************
   public static String query(String sql)
   {
    connectToDB();
 
     //System.out.println("\n>>>>>>>>>>>>>>>>>>>>" + sql);
     try
     {
       PreparedStatement pst = con.prepareStatement(sql);
       ResultSet rs = pst.executeQuery(sql);
       String html = "";
 
       if (!rs.isBeforeFirst()) { html = html + "<p style='color:red'>Your query did not match any records. Please try again.</p>"; }
     
       else
       {
    	  
    	 int rowcount = 0;
    	 if (rs.last()) {
    	     rowcount = rs.getRow();
    	     rs.beforeFirst(); // 
    	 }
    	 
    	 html = html + "<p style='color:red'>" + rowcount + " result(s) found: <br><br></p>";   
    	 
         html = html + "<table  border='1'  bgcolor='#CCCCFF' >";
         html = html + "<tr  bgcolor='#FFFF00'  align='center'><td>ID</td><td>Gene Name</td><td>Gene ID</td><td>Vector</td><td>E. coli Strain</td><td>Inducer Concentration </td><td>Temperature After Induction (°C)</td><td>Expression Level</td><td>Yield (mg/l)</td><td>Reference</td><td>Note</td><td>Gene Sequence</td></tr>";
 
         while (rs.next())
         {
           String s1 = rs.getString("ID");
           String s2 = rs.getString("gene_name");
           String s3 = rs.getString("gene_id");
           String s4 = rs.getString("gene_sequence");
           String s5 = rs.getString("vector");
           String s6 = rs.getString("host");
           String s7 = rs.getString("inducer");
           String s8 = rs.getString("temperature");
           String s9 = rs.getString("expression_level");
           String s10 = rs.getString("yield");
           String s11 = rs.getString("reference");
           String s12 = rs.getString("note");
           
 
           html = html + "<tr>";
 
           html = html + 
             "<td>" + s1 + "</td>" + 
             "<td>" + s2 + "</td>" + 
             "<td>" + s3 + "</td>" + 
             "<td>" + s5 + "</td>" + 
             "<td>" + s6 + "</td>" + 
             "<td>" + s7 + "</td>" + 
             "<td>" + s8 + "</td>" + 
             "<td>" + s9 + "</td>" + 
             "<td>" + s10 + "</td>" + 
             "<td>" + s11 + "</td>" + 
             "<td>" + s12 + "</td>" +
             "<td>" + s4 + "</td>"; 
            
      
           html = html + "</tr>";
          }//while
         
          html = html + "</table>";
          
         }//else
       
         disconnectFromDB();
         return html;
          }
          catch (Exception e)
          {
         e.printStackTrace();
          }
       disconnectFromDB();
       return null;
       }
 //***********************************************************************************************************************      
        public static void saveAllDataInFile(String path)
        {
         connectToDB();
      
         String sql = "SELECT * INTO OUTFILE '" + 
         path + "' " + 
         "FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '\"' LINES TERMINATED BY '\n' " + 
         "FROM( " + 
         "(SELECT 'ID', 'gene_name', 'gene_id', 'gene_sequence', 'vector', 'host', 'inducer'," + 
         " 'temperature', 'expression_level', 'yield', 'reference', 'note') " + 
         "UNION " + 
         "(SELECT * FROM EcoliOverExpressionDB.dataset)  " + 
         ") AS temp";
      
         System.out.println("\n>>>>>>>>>>>>>>>>>>>>" + sql);
         try
         {
           PreparedStatement pst = con.prepareStatement(sql);
           pst.executeQuery(sql);
         } catch (Exception e) {
           e.printStackTrace();
         }
         disconnectFromDB();
        }
 //***********************************************************************************************************************     
        public static boolean insertFeedback(String name, String email, String subject, String message)
        {
         connectToDB();
      
         String sql = "INSERT INTO EcoliOverExpressionDB.feedback (name, email, subject, message) VALUES (?,?,?,?)";
         try {
         PreparedStatement pst = con.prepareStatement(sql);
      
         pst.setString(1, name);
         pst.setString(2, email);
         pst.setString(3, subject);
         pst.setString(4, message);
         pst.executeUpdate();
      
         System.out.println("\n>>>>>>>>>>>>>>>>>>>>" + pst);
         disconnectFromDB();
         return true;
         }
         catch (Exception e) {
         e.printStackTrace();
        }
         disconnectFromDB();
         return false;
        }
 //***********************************************************************************************************************      
        public static boolean insertNewData(String Email, String Gene_Name, String Gene_ID, String Gene_Sequence, String Vector, String Host, String Inducer, String Temperature, String Expression_Level, String Yield, String Reference, String Note)
        {
         connectToDB();
      
         String sql = "INSERT INTO EcoliOverExpressionDB.new_data (email, gene_name, gene_id, gene_sequence, vector, host, inducer, temperature, expression_level, yield, reference, note)VALUES (?,?,?,?,?,?,?,?,?,?,?,?)";
         try
         {
         PreparedStatement pst = con.prepareStatement(sql);
      
         pst.setString(1, Email);
         pst.setString(2, Gene_Name);
         pst.setString(3, Gene_ID);
         pst.setString(4, Gene_Sequence);
         pst.setString(5, Vector);
         pst.setString(6, Host);
         pst.setString(7, Inducer);
         pst.setString(8, Temperature);
         pst.setString(9, Expression_Level);
         pst.setString(10, Yield);
         pst.setString(11, Reference);
         pst.setString(12, Note);
         
      
         pst.executeUpdate();
      
         System.out.println("\n>>>>>>>>>>>>>>>>>>>>" + pst);
      
         disconnectFromDB();
         return true;
          }
          catch (Exception e)
          {
         e.printStackTrace();
         }
         disconnectFromDB();
         return false;
        }
 //***********************************************************************************************************************    
        public static String generateComboBoxForSubmit(String column)
        {
         String sql = "select distinct " + column + " from EcoliOverExpressionDB.dataset";
      
         connectToDB();
         try
         {
         PreparedStatement pst = con.prepareStatement(sql);
         ResultSet rs = pst.executeQuery(sql);
      
         String html = "<select  onchange='onDropDownChange(\"" + 
         column + "\");'  " + 
         "style='width=300'  " + 
         "id='" + column + "_combo" + "'  " + 
         ">";
      
         while (rs.next()) {
             html = html + "<option  value='" + 
             rs.getString(column) + "'>" + rs.getString(column) + "</option>";
         }
         disconnectFromDB();
         return html + "</select>";
         }
         catch (Exception e)
         {
         e.printStackTrace();
         }
        disconnectFromDB();
        return "";
        }
  //***********************************************************************************************************************    
        public static String generateComboBoxForSearch(String column)
        {
        String sql = "select distinct " + column + " from EcoliOverExpressionDB.dataset";
      
        connectToDB();
        try
        {
         PreparedStatement pst = con.prepareStatement(sql);
         ResultSet rs = pst.executeQuery(sql);
      
         String html = "<select  style='width=300'  "  +
         		       "name='combo_name_" + column + "'  "  + 
        		       "id='combo_id_" + column + "'  "  +
                       "onChange='putValueToTextBox(this);' " +  
                       ">";
         
         html += "<option selected> Choose ... </option>";
         
         rs.next();
         
         while (rs.next()) {
           html = html + "<option  value='" + 
             rs.getString(column) + "'>" + rs.getString(column) + "</option>";
            }
         disconnectFromDB();
         return html + "</select>";
          }
          catch (Exception e)
          {
         e.printStackTrace();
          }
       disconnectFromDB(); 
       return "";
        }
     

//***********************************************************************************************************************

     public static Vector<String> findAllSequences(){
           	 
    	 connectToDB();
    	 
    	 String sql = "select * from EcoliOverExpressionDB.dataset where gene_sequence != '?'";
    	 Vector<String> sequences = new Vector<String>();
         
         try
         {
           PreparedStatement pst = con.prepareStatement(sql);
           ResultSet rs = pst.executeQuery(sql);
           
           while (rs.next()){
            
        	   sequences.addElement( rs.getString("gene_sequence") );
             
           }  
           
             disconnectFromDB();
             
             return sequences;
                
         }//try
        
         catch (Exception e)
         {
             e.printStackTrace();
         }
         
         disconnectFromDB();
         return null;   
    }

//***********************************************************************************************************************
     } 