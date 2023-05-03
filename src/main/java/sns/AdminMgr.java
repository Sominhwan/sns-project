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
	
	// 관리자 게시물 정보 검색
	public ArrayList<PostBean> searchPost(String userEmail) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		ArrayList<PostBean> postList = new ArrayList<PostBean>();
		try {
			con = pool.getConnection();
			sql = "select postId, userEmail, likeNum, imageName, videoName, shareNum, "
					+ "commentNum, creationDate, postReport "
					+ "from post where userEmail LIKE ? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "%" + userEmail + "%");
			rs = pstmt.executeQuery();
			while (rs.next()) {
				PostBean bean = new PostBean();
				bean.setPostId(rs.getInt(1));
				if(rs.getString(2)!=null) {
					bean.setUserEmail(rs.getString(2));
				} else {
					bean.setUserEmail("-");
				}
				bean.setLikeNum(rs.getInt(3));
				if(rs.getString(4)!=null) {
					bean.setImageName(rs.getString(4));
				} else {
					bean.setImageName("-");
				}
				if(rs.getString(5)!=null) {
					bean.setVideoName(rs.getString(5));
				} else {
					bean.setVideoName("-");
				}
				bean.setShareNum(rs.getInt(6));
				bean.setCommentNum(rs.getInt(7));		
				String tempDate = SDF_DATE.format(rs.getDate(8));
				if(tempDate!=null) {
					bean.setCreationDate(tempDate);
				} else {
					bean.setCreationDate("-");
				}
				bean.setPostReport(rs.getInt(9));
				postList.add(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return postList;
	}
	
	// 관리자 회원정보 삭제
	public void deleteUserInfo(String userEmail) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
		   con = pool.getConnection();
		   sql = "delete from userinfo where userEmail = ?";
		   pstmt = con.prepareStatement(sql);
		   pstmt.setString(1, userEmail);
		   pstmt.executeUpdate();
		    
		} catch (Exception e) {
		   e.printStackTrace();
		} finally {
		   pool.freeConnection(con, pstmt);
		}
	 }
		
	// 관리자 선택한 회원정보 선택 삭제
	public void deleteUserAllInfo(String userEmail) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
		   con = pool.getConnection();
		   sql = "delete from userinfo where userEmail in ?";
		   pstmt = con.prepareStatement(sql);
		   pstmt.setString(1, userEmail);
		   pstmt.executeUpdate();
			    
		} catch (Exception e) {
		   e.printStackTrace();
		} finally {
		   pool.freeConnection(con, pstmt);
		}
	 }
		
		
	// 관리자 게시물 삭제
	public void deletePostInfo(int postId) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
		   con = pool.getConnection();
		   sql = "delete from post where postId = ?";
		   pstmt = con.prepareStatement(sql);
		   pstmt.setInt(1, postId);
		   pstmt.executeUpdate();
		    
		} catch (Exception e) {
		   e.printStackTrace();
		} finally {
		   pool.freeConnection(con, pstmt);
		}
	 }
	
	// 관리자 게시물 선택 삭제
	public void deletePostAllInfo(int postId) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
		   con = pool.getConnection();
		   sql = "delete from post where postId = ?";
		   pstmt = con.prepareStatement(sql);
		   pstmt.setInt(1, postId);
		   pstmt.executeUpdate();
		    
		} catch (Exception e) {
		   e.printStackTrace();
		} finally {
		   pool.freeConnection(con, pstmt);
		}
	 }

	// 관리자 회원 주소 정보 검색 (광고 동의한 주소만)
	public ArrayList<UserinfoBean> searchUserEmail(String userEmail) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		ArrayList<UserinfoBean> userEmailList = new ArrayList<UserinfoBean>();
		try {
			con = pool.getConnection();
			sql = "select userEmail from userinfo where userAd = 1 and userEmail LIKE ? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "%" + userEmail + "%");
			rs = pstmt.executeQuery();
			while (rs.next()) {
				UserinfoBean bean = new UserinfoBean();
				bean.setUserEmail(rs.getString(1));
				userEmailList.add(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return userEmailList;
	}

	// 관리자 회원 휴대폰 정보 가져오기
	public ArrayList<UserinfoBean> getUserPN() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		ArrayList<UserinfoBean> userUserPNList = new ArrayList<UserinfoBean>();
		try {
			con = pool.getConnection();
			sql = "select userPN from userinfo where userAd = 1";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				UserinfoBean bean = new UserinfoBean();		
				bean.setUserPN(phone_format(rs.getString(1)));
				userUserPNList.add(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return userUserPNList;
	}
	
	// 휴대폰 번호 형식 전환
	public String phone_format(String number) {
		String regEx = "(\\d{3})(\\d{3,4})(\\d{4})";
	    return number.replaceAll(regEx, "$1-$2-$3");
	}
	
	// 메시지 내용 저장
	public void setSMS(SMSBean bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "insert sms(userPN,content,userRegTime) values(?,?,now())";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getUserPN());
			pstmt.setString(2, bean.getContent());			
			pstmt.executeUpdate();			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
		
	// 메시지 가져오기
	public ArrayList<SMSBean> getSMS() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		ArrayList<SMSBean> smsList = new ArrayList<SMSBean>();
		try {
			con = pool.getConnection();
			sql = "SELECT userPN, content, userRegTime FROM sms";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				SMSBean bean = new SMSBean();	
				bean.setUserPN(rs.getString(1));
				bean.setContent(rs.getString(2));
				bean.setUserRegTime(rs.getString(3));
				smsList.add(bean);
			}		
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return smsList;
	}
	
	// 월별 회원 정보수 가져오기
	public int getUserCount(int month) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int count = 0;
		try {
			con = pool.getConnection();
			sql = "SELECT COUNT(*) FROM userinfo WHERE MONTH(userRegTime) = ? AND YEAR(userRegTime) = 2023";
			pstmt = con.prepareStatement(sql);		
			pstmt.setInt(1, month);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return count;
	}	
	
	// 월별 총 게시물 수 가져오기
	public int getPostCount(int month) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int count = 0;
		try {
			con = pool.getConnection();
			sql = "SELECT COUNT(*) FROM post WHERE MONTH(creationDate) = ? AND YEAR(creationDate) = 2023";
			pstmt = con.prepareStatement(sql);		
			pstmt.setInt(1, month);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return count;
	}	
	
	// 상위 5개 종아요수 
	public ArrayList<PostBean> getLikeInfo() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		ArrayList<PostBean> postList = new ArrayList<PostBean>();
		try {
			con = pool.getConnection();
			sql = "SELECT postId, userEmail, likeNum, shareNum, commentNum, postReport FROM post ORDER BY likeNum desc LIMIT 5;";
			pstmt = con.prepareStatement(sql);		
			rs = pstmt.executeQuery();
			while(rs.next()) {
				PostBean bean = new PostBean();	
				bean.setPostId(rs.getInt(1));
				bean.setUserEmail(rs.getString(2));
				bean.setLikeNum(rs.getInt(3));
				bean.setShareNum(rs.getInt(4));
				bean.setCommentNum(rs.getInt(5));
				bean.setPostReport(rs.getInt(6));
				postList.add(bean);
			}	
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return postList;
	}	
	
	// 유저가 올린 상위 12개 게시물  
	public ArrayList<UserPostInfoBean> getPostInfo() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		ArrayList<UserPostInfoBean> userPostList = new ArrayList<UserPostInfoBean>();
		try {
			con = pool.getConnection();
			sql = "SELECT userEmail, COUNT(*) as count FROM post GROUP BY userEmail ORDER BY count DESC LIMIT 10;";
			pstmt = con.prepareStatement(sql);		
			rs = pstmt.executeQuery();
			while(rs.next()) {
				UserPostInfoBean bean = new UserPostInfoBean();	
				bean.setUserEmail(rs.getString(1));
				bean.setUserPostCount(rs.getInt(2));
				userPostList.add(bean);
			}	
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return userPostList;
	}	
	
	// 총 게시물 개수 가져오기
	public int getPostAllCount() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int count = 0;
		try {
			con = pool.getConnection();
			sql = "SELECT COUNT(*) AS count FROM post;";
			pstmt = con.prepareStatement(sql);		
			rs = pstmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return count;
	}	
	
	// 임시 데이터 저장
	public void postInsert(PostBean bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "insert post(userEmail,likeNum,imageName,shareNum,commentNum,creationDate,postReport)"	
					+ "values(?,?,?,?,?,now(),?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getUserEmail());
			pstmt.setInt(2, bean.getLikeNum());
			pstmt.setString(3, bean.getImageName());
			pstmt.setInt(4, bean.getShareNum());
			pstmt.setInt(5, bean.getCommentNum());
			pstmt.setInt(6, bean.getPostReport());
				
			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}	
			
	public static void main(String [] args) {
		AdminMgr mgr = new AdminMgr();
		String  [] userEmail = new String[50];
		int likeNum = 50;
		String imageName = "C:\\Jsp\\sns-project\\image.jpg";
		int shareNum = 100;
		int commentNum = 200;
		int []postReport = new int[50];
		
		for (int i = 0; i < 50; i++) {
			userEmail[i] = "email" + i + "@deu.ac.kr";
			postReport[i] = i;
		}
		
		for (int j = 0; j < 50; j++) {
			mgr.postInsert(new PostBean(userEmail[j], likeNum, imageName, shareNum, commentNum, 
					postReport[j]));
		}		
	}
		
	
}
