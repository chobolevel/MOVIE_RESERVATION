package p_order;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class P_orderDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	private List<P_order> list;
	
	public P_orderDAO() {
		String url = "jdbc:oracle:thin:@//localhost:1521/xe";
		try {
			Class.forName("oracle.jdbc.OracleDriver");
			conn = DriverManager.getConnection(url, "system", "1234");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public int insertP_order(String p_code, String id, String address, String request, String order_qty, String total) {
		String sql = "insert into p_order values((select max(p_orderno) + 1 from p_order), ?, ?, ?, ?, ?, ?)";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, address);
			pstmt.setString(2, request);
			pstmt.setString(3, order_qty);
			pstmt.setString(4, total);
			pstmt.setString(5, id);
			pstmt.setString(6, p_code);
			pstmt.executeUpdate();
			return 1;
			//상품 주문 성공 : 1
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
		//상품 주문 실패 : -1;
	}
	
	public List<P_order> selectP_order(String id) {
		String sql = "select a.p_orderno, a.address, a.p_code, b.p_name, a.order_qty, a.total from p_order a, product b where a.p_code = b.p_code and id = ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				list = new ArrayList<P_order> ();
				do {
					P_order order = new P_order();
					order.setP_orderno(rs.getString(1));
					order.setP_address(rs.getString(2));
					order.setP_code(rs.getString(3));
					order.setP_name(rs.getString(4));
					order.setP_order_qty(rs.getString(5));
					order.setP_total(rs.getString(6));;
					list.add(order);
				} while(rs.next());
			}
			else return list;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public P_order select_order(String orderno) {
		String sql = "select * from p_order where p_orderno = ?";
		P_order order = new P_order();
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, orderno);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				order.setP_orderno(rs.getString(1));
				order.setP_address(rs.getString(2));
				order.setP_request(rs.getString(3));
				order.setP_order_qty(rs.getString(4));
				order.setP_total(rs.getString(5));
				order.setId(rs.getString(6));;
				order.setP_code(rs.getString(7));
			}
			else return order;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return order;
	}
	
	public int update_p_order(String address, String req, String order_qty, String total, String p_orderno) {
		String sql = "update p_order set address = ?, request = ?, order_qty = ?, total = ? where p_orderno = ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, address);
			pstmt.setString(2, req);
			pstmt.setString(3, order_qty);
			pstmt.setString(4, total);
			pstmt.setString(5, p_orderno);
			pstmt.executeUpdate();
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public int delete_p_order(String p_orderno) {
		String sql = "delete from p_order where p_orderno = ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, p_orderno);
			pstmt.executeUpdate();
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
}
