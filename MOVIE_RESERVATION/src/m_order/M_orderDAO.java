package m_order;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class M_orderDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	private List<String> list;
	private List<M_order> m_list;
	
	public M_orderDAO() {
		String url = "jdbc:oracle:thin:@//localhost:1521/xe";
		try {
			Class.forName("oracle.jdbc.OracleDriver");
			conn = DriverManager.getConnection(url, "system", "1234");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public List<M_order> selectM_order(String id) {
		String sql = "select a.orderno, a.m_code, b.m_name, a.m_time, a.order_seat, a.order_price from m_order a, movie b where a.m_code = b.m_code and id = ? order by orderno desc";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				m_list = new ArrayList<M_order> ();
				do {
					M_order m_order = new M_order();
					m_order.setOrderno(rs.getString(1));
					m_order.setM_code(rs.getString(2));
					m_order.setM_name(rs.getString(3));
					m_order.setM_time(rs.getString(4));
					m_order.setOrder_seat(rs.getString(5));
					m_order.setOrder_price(rs.getString(6));
					m_list.add(m_order);
				} while(rs.next());
			}
			else return m_list;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return m_list;
	}
	
	public M_order select_order(String orderno) {
		String sql = "select * from m_order where orderno = ?";
		M_order order = new M_order();
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, orderno);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				order.setOrderno(rs.getString(1));
				order.setM_time(rs.getString(2));
				order.setOrder_seat(rs.getString(3));
				order.setOrder_cnt(rs.getString(4));
				order.setOrder_price(rs.getString(5));
				order.setM_code(rs.getString(6));
			}
			else return order;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return order;
	}
	
	public List<String> selectSeat(String movie, String time) {
		String sql = "select order_seat from m_order where m_code = ? and m_time = ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, movie);
			pstmt.setString(2, time);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				list = new ArrayList<String> ();
				do {
					String[] seat = rs.getString(1).split(",");
					for(int i = 0; i < seat.length; i++) {
						list.add(seat[i]);
					}
				} while(rs.next());
			}else return new ArrayList<String> ();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public List<String> selectSeat(String movie, String time, String orderno) {
		String sql = "select order_seat from m_order where m_code = ? and m_time = ? and not orderno = ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, movie);
			pstmt.setString(2, time);
			pstmt.setString(3, orderno);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				list = new ArrayList<String> ();
				do {
					String[] seat = rs.getString(1).split(",");
					for(int i = 0; i < seat.length; i++) {
						list.add(seat[i]);
					}
				} while(rs.next());
			}else return new ArrayList<String> ();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public int insertM_order(String m_time, String order_seat, String order_cnt, String order_price, String m_code, String id) {
		String sql = "insert into m_order values((select max(orderno) + 1 from m_order), ?, ?, ?, ?, ?, ?)";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, m_time);
			pstmt.setString(2, order_seat);
			pstmt.setString(3, order_cnt);
			pstmt.setString(4, order_price);
			pstmt.setString(5, m_code);
			pstmt.setString(6, id);
			pstmt.executeUpdate();
			sql = "update m_member set point = point + ? where id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(order_price) / 10);
			pstmt.setString(2, id);
			pstmt.executeUpdate();
			//포인트 적립
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}
	
	public int updateM_order(String m_code, String m_time, String order_seat, int order_cnt, int order_price, String orderno) {
		String sql = "update m_order set m_code = ?, m_time = ?, order_seat = ?, order_cnt = ?, order_price = ? where orderno = ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, m_code);
			pstmt.setString(2, m_time);
			pstmt.setString(3, order_seat);
			pstmt.setInt(4,  order_cnt);
			pstmt.setInt(5, order_price);
			pstmt.setString(6, orderno);
			pstmt.executeUpdate();
			return 1;
			//예매 정보 수정 성공 : 1
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
		//예매 정보 수정 실패
	}
	
	public int deleteM_order(String orderno) {
		String sql = "delete from m_order where orderno = ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, orderno);
			pstmt.executeUpdate();
			return 1;
			//삭제 성공 : 1
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
		//삭제 실패 : -1
	}
}
