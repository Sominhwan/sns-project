package sns;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class PostlikeMgr {
	private DBConnectionMgr pool;
	public PostlikeMgr() {
		try {
			pool = DBConnectionMgr.getInstance();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public boolean postLike(String userEmail, int postId) {
		Connection con=null;
		PreparedStatement pstmt=null;
		String sql=null;
		ResultSet rs=null;
		boolean flag=false;
		try {
			
			con = pool.getConnection();
			sql = "SELECT * FROM postlike WHERE userEmail=? AND postId=?;";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, userEmail);
			pstmt.setInt(2, postId);
			rs=pstmt.executeQuery();
			flag = rs.next();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt,rs);
		}
		return flag;
	}
	public void insertPostlike(String userEmail, int postId) {
		Connection con=null;
		PreparedStatement pstmt=null;
		String sql=null;
		try {
			con=pool.getConnection();
			sql="insert into postlike(postId,userEmail,likeNum) values(?,?,?)";
			
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, postId);
			pstmt.setString(2, userEmail);
			pstmt.setInt(3, 1);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(con, pstmt);
		}
		
	}
	public void deletePostlike(String userEmail, int postId) {
		Connection con=null;
		PreparedStatement pstmt=null;
		String sql=null;
		try {
			con=pool.getConnection();
			sql="delete from postlike where userEmail=? and postId=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, userEmail);
			pstmt.setInt(2, postId);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(con, pstmt);
		}
		
	}
}
