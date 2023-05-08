package sns;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;

@WebServlet("/sns/ProfileBgPhotoServlet")
public class ProfileBgPhotoServlet extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.sendRedirect("profile.jsp");
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		String fileName=null;
		String userProfile=null;
		
		String realPath= "C:/Jsp/sns-project/src/main/webapp/sns/bgimages";
		System.out.println("realPath : " + realPath);
		
		try {
			MultipartRequest multi=new MultipartRequest(
												request,
												realPath,
												1024*1024*2,
												"UTF-8"
												//new DefaultFileRenamePolicy()
												);
			fileName=multi.getFilesystemName("backimage");
			String idKey = multi.getParameter("backId");
			System.out.println("idKey : " + idKey);
			System.out.println("fileName:"+fileName);

			//userProfile=contextPath+"/sns/profile/"+fileName;
			userProfile="bgimages/"+fileName;
			System.out.println(userProfile);
			ProfileMgr pMgr = new ProfileMgr();
			pMgr.bgUpdate(idKey ,userProfile);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
