package sns;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Collections;
import java.util.Comparator;
import java.util.Vector;

public class FriemdmanagerMgr {
	private DBConnectionMgr pool;
	
	public FriemdmanagerMgr() {
		try {
			pool=DBConnectionMgr.getInstance();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	//친구 추가
	public void followfirend(String userEmail,String followEmail) {
		Connection con=null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			FriendmanagerBean bean=new FriendmanagerBean();
			con=pool.getConnection();
			sql="insert into friendmanager(userEmail,friendEmail,friendSign) values(?,?,?)";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1,userEmail);
			pstmt.setString(2,followEmail);
			pstmt.setInt(3, 0);
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		
	}
	//친구에서 삭제
		public void delFriend(String userEmail,String followEmail) {
			Connection con=null;
			PreparedStatement pstmt = null;
			String sql = null;
			try {
				con=pool.getConnection();
				sql="delete from friendmanager where userEmail=? AND friendEmail=?";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1,userEmail);
				pstmt.setString(2, followEmail);
				pstmt.executeUpdate();
				
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt);
			}
		}
	//친구가 되어있는지 체크
	public boolean friendCheck(String userEmail, String friendEmail) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql=null;
		boolean flag=false;
		try {
			con=pool.getConnection();
			sql="SELECT friendSign FROM friendmanager WHERE userEmail=? and friendEmail=? and friendSign=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(2, userEmail);
			pstmt.setString(1, friendEmail);
			pstmt.setInt(3, 0);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				flag=true;
			}
			return flag;
		}
		catch (Exception e){
			e.printStackTrace();
		}
		finally {
			pool.freeConnection(con, pstmt,rs);
		}
		return flag;
	}
	//userEmail값이랑 friendsign이 0인경우만 5명불러오기
	public Vector<FriendmanagerBean> listfMember(String email) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<FriendmanagerBean> vlist = new Vector<FriendmanagerBean>();
		try {
			con = pool.getConnection();
			sql = "select * from friendmanager where userEmail =? and friendsign=0 order by friendIndex limit 5";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, email);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				FriendmanagerBean bean = new FriendmanagerBean();
				bean.setFriendIndex(rs.getString(1));
				bean.setUserEmail(rs.getString(2));
				bean.setFriendEmail(rs.getString(3));
				bean.setFriendSign(rs.getInt(4));
				vlist.addElement(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	//친구목록 승인 0에서 1
		public void friendallow(String userEmail, String friendEmail) {
			Connection con=null;
			PreparedStatement pstmt = null;
			String sql = null;
			try {
				con=pool.getConnection();
				sql="update friendmanager set friendSign=1 where userEmail=? and friendEmail=?";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, userEmail);
				pstmt.setString(2, friendEmail);
				pstmt.executeUpdate();
				
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt);
			}
		}
	
		public Vector<PostBean> friendlist(String email) {
			  Connection con = null;
			  PreparedStatement pstmt = null;
			  String sql = null;
			  FriendmanagerBean bean = new FriendmanagerBean();
			  Vector<PostBean> uplist = new Vector<PostBean>();
			  try {
			    con = pool.getConnection();
			    sql = "select friendEmail from friendmanager where userEmail=? and friendSign=1";
			    pstmt = con.prepareStatement(sql);
			    pstmt.setString(1, email);
			    ResultSet rs = pstmt.executeQuery();
			    UserinfoMgr umgr = new UserinfoMgr();
			    PostMgr pmgr = new PostMgr();
			    while (rs.next()) {
			      String friendEmail = rs.getString(1);
			      Vector<PostBean> friendPosts = pmgr.listPostsByUserAndFriend(friendEmail);
			      uplist.addAll(friendPosts);
			    }
			    Vector<PostBean> myPosts = pmgr.userpost(email);
			    uplist.addAll(myPosts);
			    Collections.sort(uplist, new Comparator<PostBean>() {
			        public int compare(PostBean post1, PostBean post2) {
			          return Integer.compare(post2.getPostId(), post1.getPostId());
			        }
			      });
			    
			  } catch (Exception e) {
			    e.printStackTrace();
			  } finally {
			    pool.freeConnection(con, pstmt);
			  }
			  
			  return uplist;
		}
		//friendEmail의 값 불러오기
		public Vector<FriendmanagerBean> friend(String email) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			Vector<FriendmanagerBean> vlist = new Vector<FriendmanagerBean>();
			try {
				con = pool.getConnection();
				sql = "select * from friendmanager where userEmail =?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, email);
				rs = pstmt.executeQuery();
				while (rs.next()) {
					FriendmanagerBean bean = new FriendmanagerBean();
					bean.setFriendIndex(rs.getString(1));
					bean.setUserEmail(rs.getString(2));
					bean.setFriendEmail(rs.getString(3));
					bean.setFriendSign(rs.getInt(4));
					vlist.addElement(bean);
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return vlist;
		}
		//탐색창에 불러올 친구추가된 email 가져오기
		public Vector<FriendmanagerBean> friendpost(String email) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			Vector<FriendmanagerBean> vlist = new Vector<FriendmanagerBean>();
			try {
				con = pool.getConnection();
				sql = "select * from friendmanager where userEmail =? and friendSign=1";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, email);
				rs = pstmt.executeQuery();
				while (rs.next()) {
					FriendmanagerBean bean = new FriendmanagerBean();
					bean.setFriendIndex(rs.getString(1));
					bean.setUserEmail(rs.getString(2));
					bean.setFriendEmail(rs.getString(3));
					bean.setFriendSign(rs.getInt(4));
					vlist.addElement(bean);
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return vlist;
		}
}
