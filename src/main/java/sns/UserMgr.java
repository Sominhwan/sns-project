package sns;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;

public class UserMgr {
	private DBConnectionMgr pool;
	private final SimpleDateFormat SDF_DATE = new SimpleDateFormat("yyyy'.'  M'.' d'.' (E)");
	private final SimpleDateFormat SDF_TIME = new SimpleDateFormat("H:mm:ss");
	
	public UserMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	
	// 일반 로그인
	public boolean userLogin(String userEmail, String userPwd) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		boolean flag = false;
	
		try {
			con = pool.getConnection();
			sql = "select userEmail, userPwd from userinfo where userEmail = ? and userPwd = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, userEmail);
			pstmt.setString(2, userPwd);
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
	
	// 네이버 로그인
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
	
	// 네이버 회원가입
	public boolean naverJoin(UserinfoBean bean) {
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
		return null;
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
}







