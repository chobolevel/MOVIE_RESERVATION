package event;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class EventDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	private List<Event> list;
	
	public EventDAO() {
		String url = "jdbc:oracle:thin:@//localhost:1521/xe";
		try {
			Class.forName("oracle.jdbc.OracleDriver");
			conn = DriverManager.getConnection(url, "system", "1234");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public int insertEvent(String title, String memo, String id, String password) {
		String sql = "insert into event values((select max(num) + 1 from event), ?, ?, sysdate, 0, (select max(num) + 1 from event), 0, 0, ?, ?)";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, title);
			pstmt.setString(2, memo);
			pstmt.setString(3, id);
			pstmt.setString(4, password);
			pstmt.executeUpdate();
			return 1;
			//게시글 등록 성공 : 1
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
		//게시글 등록 실패
	}
	
	public int deleteEvent(String num) {
		String sql = "delete from event where num = ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, num);
			pstmt.executeUpdate();
			return 1;
			//게시글 삭제 성공 : 1
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
		//게시글 삭제 실패 : -1
	}
	
	public int updateEvent(String title, String memo, String num) {
		String sql = "update event set title = ?, memo = ?, time = sysdate where num = ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, title);
			pstmt.setString(2, memo);
			pstmt.setString(3, num);
			pstmt.executeUpdate();
			return 1;
			//게시글 등록 성공 : 1
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
		//게시글 등록 실패
	}
	
	public Event selectEvent(String num) {
		String sql = "select * from event where num = ?";
		Event event = new Event();
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				event.setNum(rs.getString(1));
				event.setTitle(rs.getString(2));
				event.setMemo(rs.getString(3));
				event.setTime(rs.getString(4));
				event.setHit(rs.getString(5));
				event.setRef(rs.getString(6));
				event.setIndent(rs.getString(7));
				event.setStep(rs.getString(8));
				event.setId(rs.getString(9));
				event.setPassword(rs.getString(10));
			}
			else return event;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return event;
	}
	
	public List<Event> selectEvent() {
		String sql = "select * from event where indent = 0 order by num desc";
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				list = new ArrayList<Event> ();
				do {
					Event event = new Event();
					event.setNum(rs.getString(1));
					event.setTitle(rs.getString(2));
					event.setMemo(rs.getString(3));
					event.setTime(rs.getString(4));
					event.setHit(rs.getString(5));
					event.setRef(rs.getString(6));
					event.setIndent(rs.getString(7));
					event.setStep(rs.getString(8));
					event.setId(rs.getString(9));
					event.setPassword(rs.getString(10));
					list.add(event);
				} while(rs.next());
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public List<Event> selectEvent(int startRow, int pageSize) {
		String sql = "select * from event where num >= ? and num <= ? and indent = 0 order by num asc";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1,  (startRow - 1));
			pstmt.setInt(2,  (startRow - 1 + pageSize - 1));
			rs = pstmt.executeQuery();
			if(rs.next()) {
				list = new ArrayList<Event> ();
				do {
					Event event = new Event();
					event.setNum(rs.getString(1));
					event.setTitle(rs.getString(2));
					event.setMemo(rs.getString(3));
					event.setTime(rs.getString(4));
					event.setHit(rs.getString(5));
					event.setRef(rs.getString(6));
					event.setIndent(rs.getString(7));
					event.setStep(rs.getString(8));
					event.setId(rs.getString(9));
					event.setPassword(rs.getString(10));
					list.add(event);
				} while(rs.next());
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public String getCount() {
		String sql = "select count(*) from event";
		String count = "";
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				count = rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return count;
	}
	
	//댓글 관리 영역
	public List<Event> selectRefel(String num) {
		String sql = "select * from event where ref = ? and indent >= 1 order by step asc";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				list = new ArrayList<Event> ();
				do {
					Event event = new Event();
					event.setNum(rs.getString(1));
					event.setTitle(rs.getString(2));
					event.setMemo(rs.getString(3));
					event.setTime(rs.getString(4));
					event.setHit(rs.getString(5));
					event.setRef(rs.getString(6));
					event.setIndent(rs.getString(7));
					event.setStep(rs.getString(8));
					event.setId(rs.getString(9));
					event.setPassword(rs.getString(10));
					list.add(event);
				} while(rs.next());
			}
			else return list;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
		
	public int insertRefel(String m_ref, String m_step, String m_indent, String id, String password, String memo) {
		String sql = "update event set step = step + 1 where step = ? + 1 and indent >= ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, m_step);
			pstmt.setString(2, m_indent);
			pstmt.executeUpdate();
			//댓글 들어갈 자리를 만들어줌
			sql = "insert into event(num, id, password, memo, time, hit, ref, indent, step) values((select max(num) + 1 from event), ?, ?, ?, sysdate, 0, ?, ? + 1, ? + 1)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, password);
			pstmt.setString(3, memo);
			pstmt.setString(4, m_ref);
			pstmt.setString(5, m_indent);
			pstmt.setString(6, m_step);
			pstmt.executeUpdate();
			return 1;
			//댓글 등록 성공 : 1
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
		//댓글 등록 실패
	}
	
	public int updateRefel(String num, String memo) {
		String sql = "update event set memo = ? where num = ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memo);
			pstmt.setString(2, num);
			pstmt.executeUpdate();
			return 1;
			//댓글 수정 성공 : 1
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
		//댓글 수정 실패 : -1
	}
	
	public int deleteRefel(String num) {
		String sql = "delete from event where num = ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, num);
			pstmt.executeUpdate();
			return 1;
			//댓글 삭제 성공 : 1
		} catch (Exception e ) {
			e.printStackTrace();
		}
		return -1;
		//댓글 삭제 실패 : -1
	}
	
	public void upHit(String num) {
		String sql = "update event set hit = hit + 1 where num = ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, num);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
}
