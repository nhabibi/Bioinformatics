 package utility;
     
 import java.util.Date;
 import java.util.Properties;
 import javax.mail.Authenticator;
 import javax.mail.Message;
 //import javax.mail.Message.RecipientType;
 import javax.mail.PasswordAuthentication;
 import javax.mail.Session;
 import javax.mail.Transport;
 import javax.mail.internet.InternetAddress;
 import javax.mail.internet.MimeMessage;
     
     public class Email
     {
       public static void sendEmail(String from, String type, String message)
       {
      //String username = "ecolidb@gmail.com";
      //String password = "ecolidb1";
     
      String to = "narges.habibi@gmail.com";
      String subject = "New " + type + " has been recieved!";
      //String messageText = "Please check the database.";
      String messageText = message;
     
      boolean sessionDebug = true;
    
      Properties props = System.getProperties();
     
      props.setProperty("mail.smtp.auth", "true");
      props.put("mail.smtp.starttls.enable", "true");
      props.setProperty("mail.transport.protocol", "smtp");
      props.setProperty("mail.smtp.host", "smtp.gmail.com");
      props.put("mail.smtp.port", "587");
      Session mailSession = Session.getInstance(props, 
        new Authenticator() {
           protected PasswordAuthentication getPasswordAuthentication() {
           return new PasswordAuthentication("ecolidb@gmail.com", "ecolidb1");
           }
         });
       mailSession.setDebug(sessionDebug);
     
       Message msg = new MimeMessage(mailSession);
         try {
         msg.setFrom(new InternetAddress(from));
         InternetAddress[] address = { new InternetAddress(to) };
         msg.setRecipients(Message.RecipientType.TO, address);
     
         msg.setSubject(subject);
         msg.setSentDate(new Date());
         msg.setText(messageText);
     
         Transport.send(msg);
         }
         catch (Exception e) {
         e.printStackTrace();
         }
       }
     }

 