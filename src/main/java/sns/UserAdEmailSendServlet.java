package sns;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

@WebServlet("/sns/UserAdEmailSend")
public class UserAdEmailSendServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	public static final String SAVEFOLDER = "C:/Jsp/sns-project/src/main/webapp/sns/storage/";
	public static final String ENCODING = "UTF-8";
	public static final int MAXSIZE = 1024 * 1024 * 500; // 500MB
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8"); 
		response.setContentType("text/html; charset=utf-8");

		MultipartRequest multi = new MultipartRequest(request, SAVEFOLDER, MAXSIZE, 
		ENCODING, new DefaultFileRenamePolicy()); 
		 
		String [] userAllEmail = multi.getParameterValues("userAllEmail");
		for(int i=0;i<userAllEmail.length;i++)
			System.out.println(userAllEmail[i]);
		  
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

	    for(int i=0; i<fileList.length; i++) {
	       if(fileList[i].isFile()) { 
	          System.out.println(fileList[i]); 
	       }
	    }
	     
			/*
			 * File file = new File(filename); // 파일 삭제 if (file.exists()) { file.delete();
			 * }
			 */
	}		
}
	



