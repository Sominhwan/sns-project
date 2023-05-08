package sns;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/sns/ProfileUpdateServlet")
public class ProfileUpdateServlet extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		ProfileMgr pMgr = new ProfileMgr();
		String idKey = request.getParameter("userEmail2");
		String prof_gender = request.getParameter("prof_gender");
		String prof_nikname = request.getParameter("prof_nikname");
		String prof_pn = request.getParameter("prof_pn");
		String prof_school = request.getParameter("prof_school");
		String prof_adress = request.getParameter("prof_adress");
		String prof_social = request.getParameter("prof_social");
		pMgr.profUpdate(idKey, prof_gender,prof_nikname,prof_pn,prof_school,prof_adress,prof_social);
		response.sendRedirect("profile.jsp");
	}

}
