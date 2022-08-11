package movie;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class MovieDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	private List<Movie> list;
	
	public MovieDAO() {
		String url = "jdbc:oracle:thin:@//localhost:1521/xe";
		try {
			Class.forName("oracle.jdbc.OracleDriver");
			conn = DriverManager.getConnection(url, "system", "1234");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public List<Movie> selectMovie() {
		String sql = "select * from movie";
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				list = new ArrayList<Movie> ();
				do {
					Movie movie = new Movie();
					movie.setM_code(rs.getString(1));
					movie.setM_name(rs.getString(2));
					movie.setM_price(rs.getString(3));
					movie.setM_director(rs.getString(4));
					movie.setM_actor(rs.getString(5));
					movie.setM_category(rs.getString(6));
					movie.setM_duration(rs.getString(7));
					list.add(movie);
				} while(rs.next());
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public Movie selectMovie(String m_code) {
		String sql = "select * from movie where m_code = ?";
		Movie movie = new Movie();
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,  m_code);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				list = new ArrayList<Movie> ();
				do {
					movie.setM_code(rs.getString(1));
					movie.setM_name(rs.getString(2));
					movie.setM_price(rs.getString(3));
					movie.setM_director(rs.getString(4));
					movie.setM_actor(rs.getString(5));
					movie.setM_category(rs.getString(6));
					movie.setM_duration(rs.getString(7));
				} while(rs.next());
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return movie;
	}
	
	public List<Movie> selectRank() {
		String sql = "select a.m_code, a.m_name, a.m_price, a.m_director, a.m_actor, a.m_category, a.m_duration, (select sum(order_cnt) from m_order where m_code = a.m_code) from movie a where (select sum(order_cnt) from m_order where m_code = a.m_code) > 0 order by 8 desc";
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				list = new ArrayList<Movie> ();
				do {
					Movie movie = new Movie();
					movie.setM_code(rs.getString(1));
					movie.setM_name(rs.getString(2));
					movie.setM_price(rs.getString(3));
					movie.setM_director(rs.getString(4));
					movie.setM_actor(rs.getString(5));
					movie.setM_category(rs.getString(6));
					movie.setM_duration(rs.getString(7));
					list.add(movie);
				} while(rs.next());
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
}
