package sns;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.Vector;
import java.io.File;

import javax.servlet.http.HttpServletRequest;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;


public class PostMgr {
	private DBConnectionMgr pool;
	//사진 저장폴더
	private static final String  SAVEFOLDER = "C:\\Jsp\\sns-project\\src\\main\\webapp\\sns\\photo";
	private static final String ENCODING = "UTF-8";
	private static int MAXSIZE = 5*1024*1024;
	
	public PostMgr() {
		try {
			pool=DBConnectionMgr.getInstance();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	//게시물 만들기
		public void insertPost(HttpServletRequest req) {
			Connection con=null;
			PreparedStatement pstmt=null;
			String sql=null;
			try {
				con = pool.getConnection();
				File dir=new File(SAVEFOLDER);
				if(!dir.exists())/*존재하지않으면*/{
					dir.mkdirs();//상위폴더가 없어도 생성가능
					//mkdir:상위폴더가 없으면 생성불가
				}
				MultipartRequest multi = new MultipartRequest(req, SAVEFOLDER,MAXSIZE, ENCODING, new DefaultFileRenamePolicy());
				
				String imageName = null;
				if(multi.getFilesystemName("imageName")!=null) {
					imageName=multi.getFilesystemName("imageName");
				}
				sql="insert into post(userEmail,likeNum,imageName,videoName,shareNum,commentNum,creationDate,postReport) VALUES(?, ?,?, ?,?,?,now(),?);";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, multi.getParameter("userEmail"));
				pstmt.setInt(2, 0);
				pstmt.setString(3, imageName);
				pstmt.setString(4, null);
				pstmt.setInt(5, 0);
				pstmt.setInt(6, 0);
				pstmt.setInt(7,0);
				pstmt.executeUpdate();
				} catch (Exception e) {
					e.printStackTrace();
				} finally {
					pool.freeConnection(con, pstmt);
				}
		}
		//비디오
		public void insertvideo(HttpServletRequest req) {
		    Connection con = null;
		    PreparedStatement pstmt = null;
		    String sql = null;
		    try {
		        con = pool.getConnection();
		        File dir = new File(SAVEFOLDER);
		        if (!dir.exists()) {
		            dir.mkdirs();
		        }

		        MultipartRequest multi = new MultipartRequest(req, SAVEFOLDER, MAXSIZE, ENCODING, new DefaultFileRenamePolicy());

		        String videoName = null;
		        Enumeration files = multi.getFileNames();
		        if (files.hasMoreElements()) {
		            String name = (String) files.nextElement();
		            videoName = multi.getFilesystemName(name);
		        }

		        sql = "INSERT INTO post (userEmail, likeNum, imageName, videoName, shareNum, commentNum, creationDate, postReport) VALUES (?, ?, ?, ?, ?, ?, now(), ?)";
		        pstmt = con.prepareStatement(sql);
		        pstmt.setString(1, multi.getParameter("userEmail"));
		        pstmt.setInt(2, 0);
		        pstmt.setString(3, null);
		        pstmt.setString(4, videoName);
		        pstmt.setInt(5, 0);
		        pstmt.setInt(6, 0);
		        pstmt.setInt(7, 0);
		        pstmt.executeUpdate();
		    } catch (Exception e) {
		        e.printStackTrace();
		    } finally {
		        pool.freeConnection(con, pstmt);
		    }
		}
	//하트 카운트
	public void upHCnt(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "update post set likeNum=likeNum+1 where postId=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt);
			}
		}
	//하트마이너스
	public void minusHCnt(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "update post set likeNum=likeNum-1 where postId=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt);
			}
		}
	//댓글플러스
	public void upComment(int num){
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "update post set commentNum=commentNum+1 where postId=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt);
			}
	}
	//댓글마이너스
	public void downComment(int num){
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "update post set commentNum=commentNum-1 where postId=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt);
			}
	}
	//게시물 신고 누적증가
	public void upReport(int num) {
		Connection con=null;
		PreparedStatement pstmt=null;
		String sql=null;
		try {
			con = pool.getConnection();
			sql = "update post set postReport=postReport+1 where postId=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt);
			}
	}
	
	//freind의 게시물리스트
		public PostBean friendimage(String email) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			PostBean bean=new PostBean();
			try {
				con = pool.getConnection();
				sql = "select * from post where userEmail=? order by postId desc";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, email);
				rs = pstmt.executeQuery();
				
				while (rs.next()) {
					bean.setPostId(rs.getInt(1));
					bean.setUserEmail(rs.getString(2));
					bean.setLikeNum(rs.getInt(3));
					bean.setImageName(rs.getString(4));
					bean.setVideoName(rs.getString(5));
					bean.setShareNum(rs.getInt(6));
					bean.setCommentNum(rs.getInt(7));
					bean.setCreationDate(rs.getString(8));
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return bean;
		}
	//본인을 제외한 게시물리스트
	public PostBean listPBlog(String email) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		PostBean bean=new PostBean();
		try {
			con = pool.getConnection();
			sql = "select * from post where userEmail!=? order by postId desc";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, email);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				bean.setPostId(rs.getInt(1));
				bean.setUserEmail(rs.getString(2));
				bean.setLikeNum(rs.getInt(3));
				bean.setImageName(rs.getString(4));
				bean.setVideoName(rs.getString(5));
				bean.setShareNum(rs.getInt(6));
				bean.setCommentNum(rs.getInt(7));
				bean.setCreationDate(rs.getString(8));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return bean;
	}
	//프렌드 이메일의 image가져오기
	public PostBean postImage(String email) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		PostBean bean=new PostBean();
		try {
			con = pool.getConnection();
			sql = "select * from post where userEmail=? order by postId desc";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, email);
			rs = pstmt.executeQuery();
			System.out.println(email);
			while (rs.next()) {
				bean.setPostId(rs.getInt(1));
				bean.setUserEmail(rs.getString(2));
				bean.setLikeNum(rs.getInt(3));
				bean.setImageName(rs.getString(4));
				bean.setVideoName(rs.getString(5));
				bean.setShareNum(rs.getInt(6));
				bean.setCommentNum(rs.getInt(7));
				bean.setCreationDate(rs.getString(8));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return bean;
	}
	//특정한 값을 포함한 모든 결과 가져오기
	public PostBean search(String userNickName){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		PostBean bean=new PostBean();
		try {
			con=pool.getConnection();
			sql="select * from post where userEmail LIKE ?";
			pstmt.setString(1, "%"+userNickName+"%");
			rs=pstmt.executeQuery();
			while(rs.next()) {
				bean.setPostId(rs.getInt(1));
				bean.setUserEmail(rs.getString(2));
				bean.setLikeNum(rs.getInt(3));
				bean.setImageName(rs.getString(4));
				bean.setVideoName(rs.getString(5));
				bean.setShareNum(rs.getInt(6));
				bean.setCommentNum(rs.getInt(7));
				bean.setCreationDate(rs.getString(8));
				bean.setPostReport(rs.getInt(9));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(con,pstmt,rs);
		}
		return bean;
	}
	public Vector<PostBean> listPostsByUserAndFriend(String friendEmail) {
	    Connection con = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    String sql = null;
	    Vector<PostBean> vlist = new Vector<PostBean>();
	    
	    try {
	      con = pool.getConnection();
	      sql = "SELECT * FROM post WHERE userEmail=? ORDER BY postId DESC";
	      pstmt = con.prepareStatement(sql);
	      pstmt.setString(1, friendEmail);
	      rs = pstmt.executeQuery();
	      
	      while (rs.next()) {
	        PostBean bean = new PostBean();
	        bean.setPostId(rs.getInt(1));
	        bean.setUserEmail(rs.getString(2));
	        bean.setLikeNum(rs.getInt(3));
	        bean.setImageName(rs.getString(4));
	        bean.setVideoName(rs.getString(5));
	        bean.setShareNum(rs.getInt(6));
	        bean.setCommentNum(rs.getInt(7));
	        bean.setCreationDate(rs.getString(8));
	        vlist.addElement(bean);
	      }
	    } catch (Exception e) {
	      e.printStackTrace();
	    } finally {
	      pool.freeConnection(con, pstmt, rs);
	    }
	    
	    return vlist;
	  }
	public Vector<PostBean> userpost(String userEmail) {
	    Connection con = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    String sql = null;
	    Vector<PostBean> vlist = new Vector<PostBean>();
	    
	    try {
	      con = pool.getConnection();
	      sql = "SELECT * FROM post WHERE userEmail=? ORDER BY postId DESC";
	      pstmt = con.prepareStatement(sql);
	      pstmt.setString(1, userEmail);
	      rs = pstmt.executeQuery();
	      
	      while (rs.next()) {
	        PostBean bean = new PostBean();
	        bean.setPostId(rs.getInt(1));
	        bean.setUserEmail(rs.getString(2));
	        bean.setLikeNum(rs.getInt(3));
	        bean.setImageName(rs.getString(4));
	        bean.setVideoName(rs.getString(5));
	        bean.setShareNum(rs.getInt(6));
	        bean.setCommentNum(rs.getInt(7));
	        bean.setCreationDate(rs.getString(8));
	        vlist.addElement(bean);
	      }
	    } catch (Exception e) {
	      e.printStackTrace();
	    } finally {
	      pool.freeConnection(con, pstmt, rs);
	    }
	    
	    return vlist;
	  }
	
	// 랜덤으로 이미지 30개 가져오기 
	public ArrayList<PostBean> getRandomImage() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		ArrayList<PostBean> userImageList = new ArrayList<PostBean>();
		try {
			con = pool.getConnection();
			sql = "select imageName from post order by rand() limit 30;";
			pstmt = con.prepareStatement(sql);		
			rs = pstmt.executeQuery();
			while(rs.next()) {
				PostBean bean = new PostBean();	
				bean.setImageName(rs.getString(1));
				userImageList.add(bean);
			}	
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return userImageList;
	}		
}
