package sns;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Vector;

public class ProfileMgr {
	private DBConnectionMgr pool;
	private final SimpleDateFormat SDF_DATE = new SimpleDateFormat("yyyy'.'  M'.' d'.' (E)");
	private final SimpleDateFormat SDF_TIME = new SimpleDateFormat("H:mm:ss");
	
	public ProfileMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	
	
	// 임시로그인 회원정보 가져오기
	public UserinfoBean getInfo(String userEmail) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		UserinfoBean bean = new UserinfoBean();
		try {
			con = pool.getConnection();
			sql = "select * from userinfo where userEmail = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, userEmail);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				bean.setUserName(rs.getString("userName"));
				bean.setUserGender(rs.getString("userGender"));
				bean.setUserNickName(rs.getString("userNickName"));
				bean.setUserEmail(rs.getString("userEmail"));
				bean.setUserPN(rs.getString("userPN"));
				bean.setUserSchool(rs.getString("userSchool"));
				bean.setUserAddress(rs.getString("userAddress"));
				bean.setUserSocial(rs.getString("userSocial"));
				bean.setUserImage(rs.getString("userImage"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return bean;
	}
	
	// 방명록 업데이트
	public GuestBookBean insertGuest(String userEmail, String gbComment) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		GuestBookBean bean = new GuestBookBean();
		try {
			con = pool.getConnection();
			sql = "select * from guestbook where userEmail = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, userEmail);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				sql = "update guestbook set gbComment = ? where userEmail = ?";
	            pstmt = con.prepareStatement(sql);
	            pstmt.setString(1, gbComment);
	            pstmt.setString(2, userEmail);
	            pstmt.executeUpdate();
			}else {
				sql = "insert guestbook( userEmail, gbComment )" +
						"values (?,?)";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, userEmail);
				pstmt.setString(2, gbComment);
				pstmt.executeUpdate();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return bean;
	}
	
	// 방명록 , 이미지 불러오기
	public GuestBookBean getGuest(String userEmail) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		GuestBookBean bean = new GuestBookBean();
		try {
			con = pool.getConnection();
			sql = "select * from guestbook where userEmail = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, userEmail);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				bean.setUserEmail(rs.getString("userEmail"));
				bean.setGbComment(rs.getString("gbComment"));
				bean.setGbBackGroundImage(rs.getString("gbBackGroundImage"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return bean;
	}
	
	// 프로필 사진 업데이트
	public GuestBookBean photoUpdate(String idkey, String userProfile) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		GuestBookBean bean = new GuestBookBean();
		try {
			con = pool.getConnection();
			sql = "select * from userinfo where userEmail = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1,idkey);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				sql = "update userinfo set userImage = ? where userEmail = ?";
	            pstmt = con.prepareStatement(sql);
	            pstmt.setString(1, userProfile);
	            pstmt.setString(2, idkey);
	            pstmt.executeUpdate();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return bean;
	}

    // 배경사진 사진 업데이트
	public GuestBookBean bgUpdate(String idkey, String userProfile) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		GuestBookBean bean = new GuestBookBean();
		try {
			con = pool.getConnection();
			sql = "select * from guestbook where userEmail = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, idkey);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				sql = "update guestbook set gbBackGroundImage = ? where userEmail = ?";
	            pstmt = con.prepareStatement(sql);
	            pstmt.setString(1, userProfile);
	            pstmt.setString(2, idkey);
	            pstmt.executeUpdate();
			}else {
				sql = "insert guestbook( userEmail, gbBackGroundImage )" +
						"values (?,?)";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, idkey);
				pstmt.setString(2, userProfile);
				pstmt.executeUpdate();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return bean;
	}
	
	// 회원정보 수정
	public UserinfoBean profUpdate(String idKey, String prof_gender, String prof_nikname, String prof_pn, String prof_school, String prof_adress, String prof_social) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		UserinfoBean bean = new UserinfoBean();
		try {
			con = pool.getConnection();
			sql = "select * from userinfo where userEmail = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, idKey);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				sql = "update userinfo set userGender=?, userNickName=?, userPN=?, userSchool=?, userAddress=?, userSocial=? where userEmail=?";
	            pstmt = con.prepareStatement(sql);
	            pstmt.setString(1, prof_gender);
	            pstmt.setString(2, prof_nikname);
	            pstmt.setString(3, prof_pn);
	            pstmt.setString(4, prof_school);
	            pstmt.setString(5, prof_adress);
	            pstmt.setString(6, prof_social);
	            pstmt.setString(7, idKey);
	            pstmt.executeUpdate();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return bean;
	}
	
	// 팔로우 정보
	public Vector<String> followInfo(String idKey) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<String> vlist= new Vector<String>();
		try {
			con = pool.getConnection();
			sql = "select friendEmail from friendmanager where userEmail = ? AND friendSign = 1";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, idKey);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				vlist.addElement(rs.getString("friendEmail"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
	public Vector<String> followerInfo(String idKey) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<String> vlist= new Vector<String>();
		try {
			con = pool.getConnection();
			sql = "select friendEmail from friendmanager where userEmail = ? AND friendSign = 0";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, idKey);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				vlist.addElement(rs.getString("friendEmail"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
	public Vector<String> followAccept(String idKey) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<String> vlist= new Vector<String>();
		try {
			con = pool.getConnection();
			sql = "select friendEmail from friendmanager where userEmail = ? AND friendSign = 1";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, idKey);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				vlist.addElement(rs.getString("friendEmail"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
	// 팔로우 수 가져오기
	public FollowBean getFollow(String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		FollowBean bean = new FollowBean();
		try {
			con = pool.getConnection();
			sql = "SELECT followNumber FROM follow WHERE useremail = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				bean.setFollowNumber(rs.getInt("followNumber"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return bean;
	}
	
	public String getUserPage(String v) {
		  return "profile.jsp?id=" + v;
		}
}	






