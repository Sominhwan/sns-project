package sns;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

public class AdminMgr {
	private DBConnectionMgr pool;
	private final SimpleDateFormat SDF_DATE = new SimpleDateFormat("yyyy'.'MM'.'d");
	private final SimpleDateFormat SDF_TIME = new SimpleDateFormat("H:mm:ss");
	public AdminMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	
	// 관리자 회원정보 검색
	public ArrayList<UserinfoBean> search(String userName) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		ArrayList<UserinfoBean> userList = new ArrayList<UserinfoBean>();
		try {
			con = pool.getConnection();
			sql = "select userName, userNickName, userEmail, userSocialId, userPN, "
					+ "userAddress, emailcertification, userInfoType, userRegDate "
					+ "from userinfo where userName LIKE ? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "%" + userName + "%");
			rs = pstmt.executeQuery();
			while (rs.next()) {
				UserinfoBean bean = new UserinfoBean();
				if(rs.getString(1)!=null) {
					bean.setUserName(rs.getString(1));
				} else {
					bean.setUserName("-");
				}
				if(rs.getString(2)!=null) {
					bean.setUserNickName(rs.getString(2));
				} else {
					bean.setUserNickName("-");
				}
				if(rs.getString(3)!=null) {
					bean.setUserEmail(rs.getString(3));
				} else {
					bean.setUserEmail("-");
				}
				if(rs.getString(4)!=null) {
					bean.setUserSocialId(rs.getString(4));
				} else {
					bean.setUserSocialId("-");
				}
				if(rs.getString(5)!=null) {
					bean.setUserPN(rs.getString(5));
				} else {
					bean.setUserPN("-");
				}
				if(rs.getString(6)!=null) {
					bean.setUserAddress(rs.getString(6));
				} else {
					bean.setUserAddress("-");
				}
				if(rs.getString(7)!=null) {
					bean.setEmailcertification(rs.getInt(7));
				} else {
					bean.setEmailcertification(0);
				}
				if(rs.getString(8)!=null) {
					bean.setUserInfoType(rs.getString(8));
				} else {
					bean.setUserInfoType("-");
				}
				String tempDate = SDF_DATE.format(rs.getDate(9));
				if(tempDate!=null) {
					bean.setUserRegDate(tempDate);
				} else {
					bean.setUserRegDate("-");
				}
				userList.add(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return userList;
	}
}
