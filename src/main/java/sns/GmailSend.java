package sns;


import java.util.Properties;
import java.util.Vector;

import javax.activation.CommandMap;
import javax.activation.DataHandler;
import javax.activation.FileDataSource;
import javax.activation.MailcapCommandMap;
import javax.mail.Address;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.Multipart;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;

public class GmailSend {	
	private static class SMTPAuthenticator extends Authenticator {
		public PasswordAuthentication getPasswordAuthentication() {
			return new PasswordAuthentication("photalk2@gmail.com", "qymxisfpnahvqyjw");
		}
	}
	public static void send(String title, String content, String toEmail) {
		Properties p = new Properties();

		p.put("mail.smtp.starttls.enable", "true");
		// 이메일 발송을 처리해줄 SMTP서버
		p.put("mail.smtp.host", "smtp.gmail.com");
		// SMTP 서버의 인증을 사용한다는 의미
		p.put("mail.smtp.auth", "true");
		// TLS의 포트번호는 587이며 SSL의 포트번호는 465이다.
		p.put("mail.smtp.port", "587");
		// soket문제와 protocol문제 해결
		p.put("mail.smtp.ssl.trust", "smtp.gmail.com");
		p.put("mail.smtp.socketFactory.fallback", "false");
		p.put("mail.smtp.ssl.protocols", "TLSv1.2");
		
		try {
			Authenticator auth = new SMTPAuthenticator();
			Session session = Session.getInstance(p, auth);
			session.setDebug(true); 
			MimeMessage msg = new MimeMessage(session);
			String message = content;
			msg.setSubject(title);
			Address fromAddr = new InternetAddress("photalk2@gmail.com"); 
			msg.setFrom(fromAddr);
			Address toAddr = new InternetAddress(toEmail); 
			msg.addRecipient(Message.RecipientType.TO, toAddr);
			msg.setContent(message, "text/html;charset=KSC5601");
			Transport.send(msg);
		} catch (Exception e) { 
			e.printStackTrace();
		}
	}
	
	public static void sendAll(String title, String content, String []toEmail, Vector<String> attach) {
		Properties p = new Properties();

		p.put("mail.smtp.starttls.enable", "true");
		// 이메일 발송을 처리해줄 SMTP서버
		p.put("mail.smtp.host", "smtp.gmail.com");
		// SMTP 서버의 인증을 사용한다는 의미
		p.put("mail.smtp.auth", "true");
		// TLS의 포트번호는 587이며 SSL의 포트번호는 465이다.
		p.put("mail.smtp.port", "587");
		// soket문제와 protocol문제 해결
		p.put("mail.smtp.ssl.trust", "smtp.gmail.com");
		p.put("mail.smtp.socketFactory.fallback", "false");
		p.put("mail.smtp.ssl.protocols", "TLSv1.2");
		
		try {
			Authenticator auth = new SMTPAuthenticator();
			Session session = Session.getInstance(p, auth);
			session.setDebug(true); 
			// 메일 헤더 셋팅(보내는 이메일, 받는 이메일)
			MimeMessage msg = new MimeMessage(session);
			Address fromAddr = new InternetAddress("photalk2@gmail.com"); 
			msg.setFrom(fromAddr);
			msg.setSubject(title);
			// 받는 이메일 배열
			InternetAddress[] toAddr = new InternetAddress[toEmail.length]; 
			for(int i=0;i<toEmail.length;i++) {
				toAddr[i] = new InternetAddress(toEmail[i]);
			}
			msg.setRecipients(Message.RecipientType.TO, toAddr);
			
			// 메일 바디 셋팅(첨부파일, 메일 내용)
			MimeBodyPart mbp = new MimeBodyPart();
			mbp.setContent(content, "text/html;charset=KSC5601");
				
			// 첨부파일 셋팅
			Multipart messageMulti = new MimeMultipart();
			messageMulti.addBodyPart(mbp);
			for(int i = 0 ; i<attach.size() ; i++) {
				MimeBodyPart mbp2 = new MimeBodyPart();
				FileDataSource fds = new FileDataSource(attach.get(i)); // 파일 읽어오기
				mbp2.setDataHandler(new DataHandler(fds)); // 파일 첨부
				mbp2.setFileName(fds.getName());
				if (!attach.get(i).equals("")) {
					messageMulti.addBodyPart(mbp2);
				}
			}

			msg.setContent(messageMulti);
			// 첨부할 파일 확장자 정의
			MailcapCommandMap MailcapCmdMap = (MailcapCommandMap) CommandMap.getDefaultCommandMap();
			MailcapCmdMap.addMailcap("text/html;; x-java-content-handler=com.sun.mail.handlers.text_html");
			MailcapCmdMap.addMailcap("text/xml;; x-java-content-handler=com.sun.mail.handlers.text_xml");
			MailcapCmdMap.addMailcap("text/plain;; x-java-content-handler=com.sun.mail.handlers.text_plain");
			MailcapCmdMap.addMailcap("multipart/*;; x-java-content-handler=com.sun.mail.handlers.multipart_mixed");
			MailcapCmdMap.addMailcap("message/rfc822;; x-java-content-handler=com.sun.mail.handlers.message_rfc822");
			CommandMap.setDefaultCommandMap(MailcapCmdMap);
			
			Transport.send(msg);
			
			System.out.println("message sent successfully...");
		} catch (Exception e) { 
			e.printStackTrace();
		}
	}
}

