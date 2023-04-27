package sns;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;
import java.util.Vector;
import java.util.regex.Pattern;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

@WebServlet("/sns/UserAdEmailSend")
public class UserAdEmailSendServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	public static final String SAVEFOLDER = "C:/Jsp/sns-project/src/main/webapp/sns/attachFile/";
	public static final String ENCODING = "UTF-8";
	public static final int MAXSIZE = 1024 * 1024 * 500; // 500MB
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8"); 
		response.setContentType("text/html; charset=utf-8");

		MultipartRequest multi = new MultipartRequest(request, SAVEFOLDER, MAXSIZE, ENCODING, new DefaultFileRenamePolicy());  
		String []userAllEmail = multi.getParameterValues("userAllEmail");
		StringBuilder stringBuilder = new StringBuilder();

		for (int i = 0; i < userAllEmail.length; i++) {
		  stringBuilder.append(userAllEmail[i]);
		}

		String allEmail = stringBuilder.toString();	
		Pattern pattern = Pattern.compile(",");
		String[] toEmail = pattern.split(allEmail);	
		
		String titleInput = multi.getParameter("titleInput");			
		String content = multi.getParameter("mailContent");
		System.out.println(content);
		ArrayList saveFiles = new ArrayList();
		ArrayList originFiles = new ArrayList();
		  
		Enumeration fileNames = multi.getFileNames();
	    while(fileNames.hasMoreElements()) {
	    	String file = (String) fileNames.nextElement();
	    	saveFiles.add(multi.getFilesystemName(file));
	        originFiles.add(multi.getOriginalFileName(file));
	    }
	     
	    File dir = new File(SAVEFOLDER);
	    File[] fileList = dir.listFiles(); // 디렉토리의 모든 파일 리스트 가져오기
	    String [] getFilePath = new String[fileList.length];
	    for(int i=0; i<fileList.length; i++) {
	       if(fileList[i].isFile()) { 
	          getFilePath[i] = fileList[i].getAbsolutePath();
	       }
	    }
	    // 메일 전송 성공시 true 값 반환 후 메일 전송 완료 json 파일 전달
	    if(sendMail(toEmail,titleInput,content,getFilePath)) { 
	    	// 이메일 전송 완료 후 파일 삭제
	    	for(int i=0; i<fileList.length; i++) { 
	    		if(fileList[i].isFile()) {
	    			fileList[i].delete(); 
	    		} 
	    	}
		
	    	JSONObject jobj = new JSONObject();
	    	jobj.put("result", "메일 전송 완료");
	    	PrintWriter out = response.getWriter();
	    	out.print(jobj.toString());
	    	out.close();
	    } else {
	    	for(int i=0; i<fileList.length; i++) { 
	    		if(fileList[i].isFile()) {
	    			fileList[i].delete(); 
	    		} 
	    	}	    	 	
	    }
	}
	
	public boolean sendMail(String []email, String title, String content, String [] getFilePath) {			
		Vector<String> attachmentFiles = new Vector<String>();
		for(int i=0;i<getFilePath.length;i++)
			attachmentFiles.add(getFilePath[i]);	
		return GmailSend.sendAll(title, content, email, attachmentFiles);	
	}
}
	



