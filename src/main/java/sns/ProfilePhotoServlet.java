package sns;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

@WebServlet("/sns/ProfilePhotoServlet")
public class ProfilePhotoServlet extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//HttpSession session = request.getSession();
		//String idKey = (String)session.getAttribute("idKey");
		//String idKey = request.getParameter("photoId");
		//System.out.println("idKey : " + idKey);

		response.sendRedirect("profile.jsp");
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		String fileName=null;

	//	String realPath=request.getServletContext().getRealPath("./sns/profile");
		String realPath= "C:/Jsp/sns-project/src/main/webapp/sns/profile";
		//String contextPath=request.getServletContext().getContextPath();
		String userProfile=null;
		
		System.out.println("realPath : " + realPath);
		//System.out.println("contextPath: "+contextPath);
		
		try {
			MultipartRequest multi=new MultipartRequest(
												request,
												realPath,
												1024*1024*2,
												"UTF-8"
												//new DefaultFileRenamePolicy()
												);
			fileName=multi.getFilesystemName("userProfile");
			String idKey = multi.getParameter("photoId");
			System.out.println("idKey : " + idKey);
			System.out.println("fileName:"+fileName);

			//userProfile=contextPath+"/sns/profile/"+fileName;
			userProfile="profile/"+fileName;
			System.out.println(userProfile);
			ProfileMgr pMgr = new ProfileMgr();
			pMgr.photoUpdate(idKey ,userProfile);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
