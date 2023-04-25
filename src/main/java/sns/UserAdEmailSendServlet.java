package sns;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.jsp.PageContext;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.oreilly.servlet.multipart.Part;


@WebServlet("/sns/UserAdEmailSend")
public class UserAdEmailSendServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	public static final String SAVEFOLDER = "C:/Jsp/sns-project/src/main/webapp/sns/storage/";
	// 업로드 파일명 인코딩
	public static final String ENCODING = "UTF-8";
	// 업로드 파일 크기
	public static final int MAXSIZE = 1024 * 1024 * 100; // 100MB
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8"); 
		response.setContentType("text/html; charset=utf-8"); 
		String[] userAllEmail = request.getParameterValues("userAllEmail");
		for(int i=0; i<userAllEmail.length;i++)
			System.out.println(userAllEmail[i]);
		
		
		
	    //request = (HttpServletRequest)PageContext.getRequest();
	    Part filePart = (Part) request.getPart("fileName");
	    String fileName = ((javax.servlet.http.Part) filePart).getSubmittedFileName();
	    System.out.println(fileName);
		/*
		 * MultipartRequest multi = new MultipartRequest(request, SAVEFOLDER, MAXSIZE,
		 * ENCODING, new DefaultFileRenamePolicy()); File uploadFile =
		 * multi.getFile("fileName"); System.out.println(uploadFile); long
		 * uploadFile_length = uploadFile.length();
		 */
		
		
	}

}
