package sns;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;


public class CommentMgr {

	private DBConnectionMgr pool;
	
	public CommentMgr() {
		try {
			pool = DBConnectionMgr.getInstance();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	//답글 달기
	public void insertReply(CommentBean bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			
			con = pool.getConnection();
			sql = "insert comment(postId,userEmail,commentDetail,commentParrent,commentChild,commentDate,commentCorrect)values(?,?,?,?,?,now(),?) ";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, bean.getPostId());
			pstmt.setString(2, bean.getUserEmail());
			pstmt.setString(3, bean.getCommentDetail());
			pstmt.setString(4, bean.getCommentParrent());
			pstmt.setString(5, bean.getCommentChild());
			pstmt.setString(6, null);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	//답글확인
	public boolean replycheck(int commentId) {
		Connection con=null;
		PreparedStatement pstmt=null;
		String sql=null;
		ResultSet rs=null;
		boolean flag=false;
		try {
			con = pool.getConnection();
			sql = "SELECT * FROM comment WHERE commentParrent=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, commentId);
			rs=pstmt.executeQuery();
			flag = rs.next();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt,rs);
		}
		return flag;
	}
	public void insertPReply(CommentBean bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			
			con = pool.getConnection();
			sql = "insert comment(postId,userEmail,commentDetail,commentParrent,commentChild,commentDate,commentCorrect)values(?,?,?,?,?,now(),?) ";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, bean.getPostId());
			pstmt.setString(2, bean.getUserEmail());
			pstmt.setString(3, bean.getCommentDetail());
			pstmt.setString(4, bean.getCommentParrent());
			pstmt.setString(5, bean.getCommentChild());
			pstmt.setString(6, null);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}

	//덧글 삭제
	public void deletePReply(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "delete from comment where commentId=? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	
	//덧글 전부삭제
	public void deleteAllPReply(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "delete from comment where postId=? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	public void updateComment(int commentId, String commentDetail) {
	    Connection con = null;
	    PreparedStatement pstmt = null;
	    String sql = null;
	    try {
	        con = pool.getConnection();
	        sql = "UPDATE comment SET commentDetail = ?, commentCorrect = NOW() WHERE commentId = ?";
	        pstmt = con.prepareStatement(sql);
	        pstmt.setString(1, commentDetail);
	        pstmt.setInt(2, commentId);
	        pstmt.executeUpdate();
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        pool.freeConnection(con, pstmt);
	    }
	}
	
	//덧글 리스트
	public Vector<CommentBean> listPReply(int num){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql2=null;
		Vector<CommentBean> vlist = new Vector<CommentBean>();
		try {
			con = pool.getConnection();
			sql2="WITH RECURSIVE CTE AS (\n"
					+ " SELECT commentId,postId,userEmail,commentDetail,commentParrent,commentChild,commentDate,commentCorrect,convert(commentId,char)as path\n"
					+ " FROM comment\n"
					+ " WHERE commentParrent IS NULL\n"
					+ " AND postId=?\n"
					+ " UNION ALL\n"
					+ " SELECT uc.commentId,uc.postId,uc.userEmail,uc.commentDetail,uc.commentParrent,uc.commentChild,uc.commentDate,uc.commentCorrect,concat(CTE.commentId,'-',uc.commentId)AS path\n"
					+ " FROM comment uc\n"
					+ " INNER JOIN CTE ON uc.commentParrent=CTE.commentId\n"
					+ "       WHERE uc.postId=?\n"
					+ ")\n"
					+ "SELECT commentId,postId,userEmail,commentDetail,commentParrent,commentChild,commentDate,commentCorrect,path\n"
					+ "FROM CTE\n"
					+ "ORDER BY CONVERT(SUBSTRING_INDEX(path,'-',1),UNSIGNED) ASC,commentId ASC, CONVERT(SUBSTRING_INDEX(path,'-',2),UNSIGNED) ASC, commentId ASC";
			pstmt = con.prepareStatement(sql2);
			pstmt.setInt(1, num);
			pstmt.setInt(2, num);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				CommentBean bean = new CommentBean();
				bean.setCommentId(rs.getInt(1));
				bean.setPostId(rs.getInt(2));
				bean.setUserEmail(rs.getString(3));
				bean.setCommentDetail(rs.getString(4));
				bean.setCommentParrent(rs.getString(5));
				bean.setCommentChild(rs.getString(6));
				bean.setCommentDate(rs.getString(7));
				bean.setCommentCorrect(rs.getString(8));
				vlist.addElement(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
		//댓글리스트:검색기능,페이지 및 블럭처리
		//limit 시작번호,가져올 개수
		public Vector<CommentBean> getBoardList(String keyField, String keyWord, int start, int cnt){
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			Vector<CommentBean> vlist=new Vector<CommentBean>();
			try {
				con = pool.getConnection();
				if(keyWord.trim().equals("")||keyWord==null) {
					//검색이 아닌경우
					sql = "select * from comment order by ref desc,pos limit ?,?";
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1, start);
					pstmt.setInt(2, cnt);
				}
				else {
					sql = "select * from tblBoard where "+keyField+" like ? order by ref desc,pos limit ?,?";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, "%"+keyWord+"%");
					pstmt.setInt(2, start);
					pstmt.setInt(3, cnt);
				}
				rs = pstmt.executeQuery();
				while(rs.next()) {
					CommentBean bean = new CommentBean();
					bean.setCommentId(rs.getInt("commentId"));
					bean.setPostId(rs.getInt("postId"));
					bean.setUserEmail(rs.getString("userEmail"));
					bean.setCommentDetail(rs.getString("commentDetail"));
					bean.setCommentParrent(rs.getString("commentParent"));
					bean.setCommentChild(rs.getString("commentChild"));
					bean.setCommentDate(rs.getString("commentDate"));
					bean.setCommentCorrect(rs.getString("commentCorrect"));
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