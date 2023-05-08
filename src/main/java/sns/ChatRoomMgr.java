package sns;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class ChatRoomMgr {

	private DBConnectionMgr pool;
	
	public ChatRoomMgr(){
		pool = DBConnectionMgr.getInstance();
	}


	public int getMaxNum() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int maxNum = 0;
		try {
			con = pool.getConnection();
			sql = "select max(roomId) from chatroom";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) maxNum = rs.getInt(1);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return maxNum;
	}
	
	
	// 자신이 포함된 채팅창 리스트
	public ArrayList<ChatRoomBean> getChatRoomList(String userName){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<ChatRoomBean> chatRoomList = new ArrayList<ChatRoomBean>();
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "SELECT * FROM chatroom WHERE userEmail = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, userName);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				ChatRoomBean roomBean = new ChatRoomBean();
				roomBean.setRoomId(rs.getInt("roomId"));
				roomBean.setUserEmail(rs.getString("userEmail"));
				roomBean.setCreateTime(rs.getString("createTime"));
				chatRoomList.add(roomBean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return chatRoomList;
	}
	
	
}
