package sns;

import java.sql.Connection;

import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


public class ChatMessagerMgr {

	private DBConnectionMgr pool;
 
	public ChatMessagerMgr() {
		pool = DBConnectionMgr.getInstance();
	
	}
	
	public int getMaxRoomId() {
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
	
	public int getMaxcahtId(int roomId) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int maxNum = 0;
		try {
			con = pool.getConnection();
			sql = "select max(chatID) from chat WHERE roomId = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, roomId);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				maxNum = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return maxNum;
	}
	
	// 자신이 포함된 채팅창 리스트
//	public ArrayList<ChatRoomBean> getChatRoomList(String userName){
//		Connection con = null;
//		PreparedStatement pstmt = null;
//		ResultSet rs = null;
//		ArrayList<ChatRoomBean> chatRoomList = new ArrayList<ChatRoomBean>();
//		String sql = null;
//		try {
//			con = pool.getConnection();
//			sql = "SELECT * FROM chatroom WHERE userEmail = ?";
//			pstmt = con.prepareStatement(sql);
//			pstmt.setString(1, userName);
//			rs = pstmt.executeQuery();
//			while(rs.next()) {
//				ChatRoomBean roomBean = new ChatRoomBean();
//				roomBean.setRoomId(rs.getInt("roomId"));
//				roomBean.setUserEmail(rs.getString("userEmail"));
//				roomBean.setCreateTime(rs.getString("createTime"));
//				chatRoomList.add(roomBean);
//			}
//		} catch (Exception e) {
//			e.printStackTrace();
//		} finally {
//			pool.freeConnection(con, pstmt, rs);
//		}
//		return chatRoomList;
//	}
	
	public ArrayList<ChatRoomBean> getChatRoomId(String userEmail) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<ChatRoomBean> roomId = new ArrayList<ChatRoomBean>();
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "SELECT DISTINCT cr.* " +
	                   "FROM chatroom cr " +
	                   "WHERE cr.roomId IN ( " +
	                   "    SELECT roomId " +
	                   "    FROM chatroom " +
	                   "    WHERE userEmail = ? " +
	                   ") AND cr.userEmail != ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, userEmail);
			pstmt.setString(2, userEmail);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				ChatRoomBean roomBean = new ChatRoomBean();
				roomBean.setRoomId(rs.getInt("roomId"));
				roomBean.setUserEmail(rs.getString("userEmail"));
				roomBean.setLastCheck(rs.getInt("lastCheck"));
				roomId.add(roomBean);
			}
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return roomId;
	}
	
	public ArrayList<ChatMessagerBean> getRecentChat() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		ArrayList<ChatMessagerBean> recentChat = new ArrayList<ChatMessagerBean>();
		try {
			con = pool.getConnection();
			sql = "SELECT c1.roomId, c1.chatID, c1.chatName, c1.chatContent, c1.chatTime " +
                    "FROM chat c1 " +
                    "INNER JOIN ( " +
                    "  SELECT roomId, MAX(chatID) AS maxChatID " +
                    "  FROM chat " +
                    "  GROUP BY roomId " +
                    ") c2 ON c1.roomId = c2.roomId AND c1.chatID = c2.maxChatID";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				ChatMessagerBean RCB = new ChatMessagerBean();
				RCB.setRoomId(rs.getInt("roomId"));
				RCB.setChatMessagerId(rs.getInt("chatId"));
				RCB.setUserEmail(rs.getString("chatName"));
				RCB.setMessage(rs.getString("chatContent").replaceAll(" ", "&nbsp;").replaceAll("<", "&lt").replaceAll(">", "&gt;").replaceAll("\n", "<br>"));
				RCB.setCreationDate(rs.getString("chatTime"));
				recentChat.add(RCB);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return recentChat;
	}
	
	
	public ArrayList<ChatRoomBean> getMyChatRoomId(String userEmail){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		ArrayList<ChatRoomBean> myRoomId = new ArrayList<ChatRoomBean>();
		try {
			con = pool.getConnection();
			sql = "SELECT * FROM chatroom WHERE userEmail = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, userEmail);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				ChatRoomBean roomBean = new ChatRoomBean();
				roomBean.setRoomId(rs.getInt("roomId"));
				roomBean.setUserEmail(rs.getString("userEmail"));
				roomBean.setLastCheck(rs.getInt("lastCheck"));
				myRoomId.add(roomBean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return myRoomId;
	}
	
	
	public ArrayList<ChatRoomBean> getChatUserName(String userEmail) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<ChatRoomBean> roomId = new ArrayList<ChatRoomBean>();
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "SELECT userEmail FROM chatroom WHERE roomId = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, userEmail);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				ChatRoomBean roomBean = new ChatRoomBean();
				roomBean.setRoomId(rs.getInt("roomId"));
				roomBean.setUserEmail(rs.getString("userEmail"));
				roomId.add(roomBean);
			}
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return roomId;
	}

	// 채팅방을 열떄의 번호 초기화
	public ArrayList<ChatMessagerBean> getChatListByRecent(int number, int roomId) {
		ArrayList<ChatMessagerBean> chatList = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Connection con = null;
		System.out.println("ddd"+number);

		String SQL = "SELECT * FROM CHAT WHERE chatTime > (SELECT MAX(chatID) - ? FROM CHAT) AND roomId = ? ORDER BY chatTime";
		try {
			con = pool.getConnection();
			pstmt = con.prepareStatement(SQL);
			pstmt.setInt(1, number);
			pstmt.setInt(2, roomId);
			rs = pstmt.executeQuery();

			chatList = new ArrayList<ChatMessagerBean>();

			while (rs.next()) {
				ChatMessagerBean chat = new ChatMessagerBean();
				chat.setChatMessagerId(rs.getInt("chatID"));
				chat.setUserEmail(rs.getString("chatName"));
				chat.setMessage(rs.getString("chatContent").replaceAll(" ", "&nbsp;").replaceAll("<", "&lt").replaceAll(">", "&gt;").replaceAll("\n", "<br>"));
				int chatTime = Integer.parseInt(rs.getString("chatTime").substring(11,13));
				String timeType = "오전";
				if(Integer.parseInt(rs.getString("chatTime").substring(11, 13)) >= 12) {
					timeType = "오후";
					chatTime -= 12;
				}
				chat.setCreationDate(rs.getString("chatTime").substring(0, 11)+" "+ timeType + " " + chatTime + ":" + rs.getString("chatTime").substring(14,16)+" ");
				chatList.add(chat);
			}
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return chatList;
	}
	
	// 열고난뒤 0.2초마다 db 리스트 최신화
	public ArrayList<ChatMessagerBean> getChatListByRecent(String chatID, int roomId) {
		ArrayList<ChatMessagerBean> chatList = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Connection con = null;
		System.out.println("ddd"+chatID);

		String SQL = "SELECT * FROM CHAT WHERE chatID > ? AND roomId = ? ORDER BY chatTime";
		try {
			con = pool.getConnection();
			pstmt = con.prepareStatement(SQL);
			pstmt.setInt(1, Integer.parseInt(chatID));
			pstmt.setInt(2, roomId);
			rs = pstmt.executeQuery();

			chatList = new ArrayList<ChatMessagerBean>();

			while (rs.next()) {
				ChatMessagerBean chat = new ChatMessagerBean();
				chat.setChatMessagerId(rs.getInt("chatID"));
				chat.setUserEmail(rs.getString("chatName"));
				chat.setMessage(rs.getString("chatContent").replaceAll(" ", "&nbsp;").replaceAll("<", "&lt").replaceAll(">", "&gt;").replaceAll("\n", "<br>"));
				int chatTime = Integer.parseInt(rs.getString("chatTime").substring(11,13));
				String timeType = "오전";
				if(Integer.parseInt(rs.getString("chatTime").substring(11, 13)) >= 12) {
					timeType = "오후";
					chatTime -= 12;
				}
				chat.setCreationDate(rs.getString("chatTime").substring(0, 11)+" "+ timeType + " " + chatTime + ":" + rs.getString("chatTime").substring(14,16)+" ");
				chatList.add(chat);
			}
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return chatList;
	}
	
	
	// 특정한 시간대에서 메시지를 가져오는 메소드
	public ArrayList<ChatMessagerBean> getChatList(String nowTime) {
		ArrayList<ChatMessagerBean> chatList = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Connection con = null;
		String SQL = "SELECT * FROM CHAT WHERE chatTime > ? ORDER BY chatTime";
		try {
			con = pool.getConnection();
			pstmt = con.prepareStatement(SQL);
			pstmt.setString(1, nowTime);
			rs = pstmt.executeQuery();
			chatList = new ArrayList<ChatMessagerBean>();

			while (rs.next()) {
				ChatMessagerBean chat = new ChatMessagerBean();
				chat.setChatMessagerId(rs.getInt("chatID"));
				chat.setUserEmail(rs.getString("chatName"));
				chat.setMessage(rs.getString("chatContent"));
				chat.setCreationDate(rs.getString("chatTime"));
				chatList.add(chat);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return chatList;
	}
	
	
	// 알람 기능을 위한 마지막으로 확인한 메세지번호 db에 저장
	public void insertLastCheck(int maxNum, int roomId, String userEmail) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "UPDATE chatroom SET lastCheck = ? WHERE roomId = ? AND userEmail = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, maxNum);
			pstmt.setInt(2, roomId);
			pstmt.setString(3, userEmail);
			pstmt.executeUpdate();
			con.close();
		}
		catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return;
	}
	
	public int lastCheck(int roomId, String userEmail) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int lastCheckNum = 0;
		try {
			con = pool.getConnection();
			sql = "SELECT lastCheck FROM chatroom WHERE roomId = ? AND userEmail = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, roomId);
			pstmt.setString(2, userEmail);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				lastCheckNum = rs.getInt("lastCheck");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return lastCheckNum;
	}
	
	public int checkRoom(String myEmail, String Email) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int roomId = 0;
		try {
			con = pool.getConnection();
			sql = "SELECT roomId " +
	               "FROM chatroom " +
	               "WHERE userEmail IN (?, ?) " +
	               "GROUP BY roomId " +
	               "HAVING COUNT(*) = 2";;
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, myEmail);
			pstmt.setString(2, Email);			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				roomId = rs.getInt("roomId");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return roomId;
	}
	
	public int inviteChat(String myEmail, String Email) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		int maxNum = getMaxRoomId() + 1; 
		try {
			con = pool.getConnection();
			sql = "INSERT INTO CHATROOM VALUES(?, ?, now(), 0)";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, maxNum);
			pstmt.setString(2, myEmail);
			pstmt.executeUpdate();
			pstmt.setInt(1, maxNum);
			pstmt.setString(2, Email);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return maxNum;
	}
	
	public int followAccept(String userEmail, String Email) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			System.out.println(userEmail+Email);
			con = pool.getConnection();
			sql = "UPDATE friendmanager SET friendSign = ? WHERE userEmail = ? AND friendEmail = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, 1);
			pstmt.setString(2, userEmail);
			pstmt.setString(3, Email);
			pstmt.executeUpdate();
			pstmt.setString(2, Email);
			pstmt.setString(3, userEmail);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return 1;
	}
	
	// input method 정상적인 값은 1 , 아니면 -1
	public int submit(int roomId, String chatName, String chatContent) {
		System.out.println("dao");
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Connection con = null;
		int maxNum = getMaxcahtId(roomId) + 1;
		String SQL = "INSERT INTO CHAT VALUES(?, ?, ?, ?, now())";
		try {
			con = pool.getConnection();
			pstmt = con.prepareStatement(SQL);
			pstmt.setInt(1, roomId);
			pstmt.setInt(2, maxNum);
			pstmt.setString(3, chatName);
			pstmt.setString(4, chatContent);
			pstmt.executeUpdate();
			con.close();
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return -1;
	}
	
	
	
}
