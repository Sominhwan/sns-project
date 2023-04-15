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
	
	// 로그인
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
	
	// 회원가입
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
	
/*	//로그인
	public int loginMember(String id, String pwd) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int mode = 0;
		// 0-id false, 1-id true pwd-false, 2-id&pwd true
		try {
			if (!checkId(id))
				return mode;
			con = pool.getConnection();
			sql = "select id, pwd from tblMember where id = ? and pwd = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pwd);
			rs = pstmt.executeQuery();
			if (rs.next())
				mode = 2;
			else
				mode = 1;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return mode;
	}
	
	
	//회원정보 가져오기
	public MemberBean getMember(String id) {
		//hobby => 10101 => {"1","0","1","0","1"}
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		MemberBean bean = new MemberBean();
		try {
			con = pool.getConnection();
			sql = "select * from tblMember where id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				bean.setId(rs.getString("id"));
				bean.setPwd(rs.getString("pwd"));
				bean.setName(rs.getString("name"));
				bean.setGender(rs.getString("gender"));
				bean.setBirthday(rs.getString("birthday"));
				bean.setEmail(rs.getString("email"));
				bean.setZipcode(rs.getString("zipcode"));
				bean.setAddress(rs.getString("address"));
				//hobby => 10101 => {"1","0","1","0","1"}
				//table에서 hobby을 가져옴.
				String hobby = rs.getString("hobby");
				//빈즈에 저장할 배열을 선언 -> 
				String hobbys[] = new String[5];
				for (int i = 0; i < hobbys.length; i++) {
					//hobbys[0]  = 
					hobbys[i] = hobby.substring(i, i+1);
				}
				bean.setHobby(hobbys);
				bean.setJob(rs.getString("job"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return bean;
	}
	
	//회원정보 수정
	public boolean updateMember(MemberBean bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "update tblMember set pwd=?, name=?, gender=?,"
					+ "birthday=?, email=?, zipcode=?, address=?,  "
					+ "hobby=?, job=? where id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getPwd());
			pstmt.setString(2, bean.getName());
			pstmt.setString(3, bean.getGender());
			pstmt.setString(4, bean.getBirthday());
			pstmt.setString(5, bean.getEmail());
			pstmt.setString(6, bean.getZipcode());
			pstmt.setString(7, bean.getAddress());
			String hobby[] = bean.getHobby();
			char hb[] = {'0','0','0','0','0'};
			String lists[] = {"인터넷", "여행", "게임", "영화", "운동"}; 
			if(hobby!=null) {
				for (int i = 0; i < hobby.length; i++) {
					for (int j = 0; j < lists.length; j++) {
						if(hobby[i].equals(lists[j])) {
							hb[j] = '1';
							
							break;
						}//---if
					}//---for2
				}//---for1
			}
			pstmt.setString(8, new String(hb));
			///////////////////////////////////
			pstmt.setString(9, bean.getJob());
			pstmt.setString(10, bean.getId());
			if(pstmt.executeUpdate()==1)
				flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
	
	///admin mode/////////////
	public Vector<MemberBean> getMemberList() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<MemberBean> vlist = new Vector<>();
		try {
			con = pool.getConnection();
			sql = "select * from tblMember";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				MemberBean bean = new MemberBean();
				bean.setId(rs.getString("id"));
				bean.setPwd(rs.getString("pwd"));
				bean.setName(rs.getString("name"));
				bean.setGender(rs.getString("gender"));
				bean.setBirthday(rs.getString("birthday"));
				bean.setEmail(rs.getString("email"));
				vlist.addElement(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
	//Admin Login
	public boolean adminCheck(String admin_id, String admin_pwd) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "select admin_id, admin_pwd from tblAdmin where admin_id = ? and admin_pwd = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, admin_id);
			pstmt.setString(2, admin_pwd);
			rs = pstmt.executeQuery();
			flag = rs.next();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con);
		}
		return flag;
	}
	
	//Send id, pwd
	public void sendAccount(String id) {
		MemberBean bean = getMember(id);
		String pwd = bean.getPwd();
		String title = "OOO.com에서 아이디와 비밀번호 전송합니다.";
		String content = "<font color='red'><b>id : " + id; 
		content+= " / pwd : " + pwd+"</b></font>";
		String toEmail = bean.getEmail();
		MailSend.send(title, content, toEmail);
	}*/
}







