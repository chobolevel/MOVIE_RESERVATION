package product;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class ProductDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	private List<Product> list;
	
	public ProductDAO() {
		String url = "jdbc:oracle:thin:@//localhost:1521/xe";
		try {
			Class.forName("oracle.jdbc.OracleDriver");
			conn = DriverManager.getConnection(url, "system", "1234");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public List<Product> selectProduct() {
		String sql = "select * from product";
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				list = new ArrayList<Product> ();
				do {
					Product p = new Product();
					p.setP_code(rs.getString(1));
					p.setP_name(rs.getString(2));
					p.setP_qty(rs.getString(3));
					p.setP_price(rs.getString(4));
					list.add(p);
				} while(rs.next());
			}
			else return list;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public Product selectProduct(String p_code) {
		String sql = "select * from product where p_code = ?";
		Product p = new Product();
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, p_code);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				p.setP_code(rs.getString(1));
				p.setP_name(rs.getString(2));
				p.setP_qty(rs.getString(3));
				p.setP_price(rs.getString(4));
			}
			else return p;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return p;
	}
	
	public int up_qty(String p_qty, String p_code) {
		String sql = "update product set p_qty = p_qty + ? where p_code = ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, p_qty);
			pstmt.setString(2, p_code);
			pstmt.executeUpdate();
			return 1;
			//상품 재고량 수정 성공 : 1
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
		//상품 재고량 수정 실패 : -1
	}
	
	public int down_qty(String p_qty, String p_code) {
		String sql = "update product set p_qty = p_qty - ? where p_code = ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, p_qty);
			pstmt.setString(2, p_code);
			pstmt.executeUpdate();
			return 1;
			//상품 재고량 수정 성공 : 1
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
		//상품 재고량 수정 실패 : -1
	}
}
