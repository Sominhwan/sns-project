package sns;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Vector;

public class UserMgr {
	private DBConnectionMgr pool;
	private final SimpleDateFormat SDF_DATE = new SimpleDateFormat("yyyy'.'MM'.'d");
	private final SimpleDateFormat SDF_TIME = new SimpleDateFormat("H:mm:ss");
	
	public UserMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	
	// 일반 로그인
	public int userLogin(String userEmail, String userPwd) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		String email = null;
		String password = null;
		int flag = 0;
	
		try {
			con = pool.getConnection();
			sql = "select userEmail, userPwd from userinfo where userEmail = ? and userPwd = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, userEmail);
			pstmt.setString(2, userPwd);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				email = rs.getString(1);
				password = rs.getString(2);
				flag = 1;
			}
			if(email.equals("admin") && password.equals("12345678")) {
				flag = 2; // 관리자 모드 로그인 확인
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return flag;
	}
	
	// 네이버, 카카오 로그인
	public boolean userNaverLogin(String userSocialId) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		boolean flag = false;
	
		try {
			con = pool.getConnection();
			sql = "select userSocialId from userinfo where userSocialId = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, userSocialId);
			rs = pstmt.executeQuery();
			if (rs.next())
				flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return flag;
	}	
	
	// 관리자 로그인
	public boolean adminLogin(String adminId, String adminPwd) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		String email = null;
		String password = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "select mgEmail, pwd from manager where mgEmail = ? and pwd = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, adminId);
			pstmt.setString(2, adminPwd);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				flag = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return flag;
	}
	
	// 일반 회원가입
	public boolean join(UserinfoBean bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "insert userinfo(userName,userGender,userNickName,userEmail,userPwd,userPN,emailcertification,userImage,"
					+ "emailHash,userRegDate,userAd,userRegTime)"	
					+ "values(?,?,?,?,?,?,0,?,?,now(),?,now())";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getUserName());
			pstmt.setString(2, bean.getUserGender());
			pstmt.setString(3, bean.getUserNickName());
			pstmt.setString(4, bean.getUserEmail());
			pstmt.setString(5, bean.getUserPwd());
			pstmt.setString(6, bean.getUserPN());
			pstmt.setString(7, bean.getUserImage());
			pstmt.setString(8, bean.getEmailHash());
			pstmt.setInt(9, bean.getUserAd());
			
			if(pstmt.executeUpdate()==1)
				flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
	
	// 네이버, 카카오 회원가입
	public boolean snsJoin(UserinfoBean bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "insert userinfo(userName,userGender,userNickName,userEmail,userPN,userSocialId,"
					+ "emailcertification,userImage,"
					+ "userRegDate,userAd,userRegTime,userInfoType)"	
					+ "values(?,?,?,?,?,?,?,?,now(),?,now(),?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getUserName());
			pstmt.setString(2, bean.getUserGender());
			pstmt.setString(3, bean.getUserNickName());
			pstmt.setString(4, bean.getUserEmail());
			pstmt.setString(5, bean.getUserPN());
			pstmt.setString(6, bean.getUserSocialId());
			pstmt.setInt(7, bean.getEmailcertification());
			pstmt.setString(8, bean.getUserImage());		
			pstmt.setInt(9, bean.getUserAd());
			pstmt.setString(10, bean.getUserInfoType());
				
			if(pstmt.executeUpdate()==1)
				flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
		
	// 유저 이메일 가져오기
	public String getUserEmail(String emailHash) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "SELECT userEmail FROM userinfo WHERE emailHash = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, emailHash);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return null;
	}	
	
	// 유저 sns 이메일 중복 검증 및 이메일 가져오기
	public String getUserSnsEmail(String userSocialId) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "SELECT userEmail FROM userinfo WHERE userSocialId = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, userSocialId);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return "null";
	}
	
	// 유저 닉네임 가져오기
	public String getUserNickName(String userEmail) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "SELECT userNickName FROM userinfo WHERE userEmail = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, userEmail);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return null;
	}
	
	// 유저 프로필 가져오기
	public String getUserImage(String userImage) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "SELECT userImage FROM userinfo WHERE userEmail = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, userImage);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return null;
	}		
	
	// 이메일 검증 확인하기
	public int getEmailcertification(String userEmail) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "SELECT emailcertification FROM userinfo WHERE userEmail = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, userEmail);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return -1;
	}		
	
	// 이메일 검증하기
	public boolean setEmailcertification(String userEmail) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "UPDATE userinfo SET emailcertification = 1 WHERE userEmail = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, userEmail);
			if(pstmt.executeUpdate()==1)
				flag = true;	
		} catch (Exception e) {
			e.printStackTrace();
		
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
	
	// 아이디 찾기(이메일, 가입일자, 소셜가입 여부 확인)
	public UserinfoBean getID(String userName, String userNickName ) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		UserinfoBean bean = new UserinfoBean();
		try {
			con = pool.getConnection();
			sql = "SELECT userEmail, userRegDate, userInfoType "
					+ "FROM userinfo WHERE userName = ? and userNickName = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, userName);
			pstmt.setString(2, userNickName);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				bean.setUserEmail(rs.getString(1));
				String tempDate = SDF_DATE.format(rs.getDate(2));
				bean.setUserRegDate(tempDate);
				bean.setUserInfoType(rs.getString(3));
				return bean;
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return null;
	}		
	
	// 이메일이 존재하는지 확인(이메일, 소셜가입 여부 확인)
	public UserinfoBean getUserEmailCheck(String userEmail) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		UserinfoBean bean = new UserinfoBean();
		try {
			con = pool.getConnection();
			sql = "SELECT userEmail, userInfoType "
					+ "FROM userinfo WHERE userEmail = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, userEmail);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				bean.setUserEmail(rs.getString(1));		
				bean.setUserInfoType(rs.getString(2));
				return bean;
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return null;
	}	
	
	// 비밀번호 가져오기
	public String getUserPwd(String userEmail) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "SELECT userPwd "
					+ "FROM userinfo WHERE userEmail = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, userEmail);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1);		
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return "1";
	}	
	
	// 비밀번호 변경하기
	public boolean setPassword(String userEmail, String userPwd) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "UPDATE userinfo SET userPwd = ? WHERE userEmail = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, userPwd);
			pstmt.setString(2, userEmail);
			if(pstmt.executeUpdate()==1)
				flag = true;	
		} catch (Exception e) {
			e.printStackTrace();
			
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
}







