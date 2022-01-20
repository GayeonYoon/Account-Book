package member;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class MemberDAO {

	private final String JDBC_DRIVER = "oracle.jdbc.driver.OracleDriver";
	private final String JDBC_URL = "jdbc:oracle:thin:@localhost:1521:xe";
	private final String USER = "scott";
	private final String PASS = "1111";

	public MemberDAO() {
		try {
			Class.forName(JDBC_DRIVER);
		} catch (Exception e) {
			System.out.println("Error : JDBC ����̹� �ε� ����");
		}
	}
	public boolean insertMember(MemberDTO bean) {
		Connection conn = null;
		PreparedStatement ptmt = null;
		String sql = null;
		boolean flag = false;
		try {
			conn = DriverManager.getConnection(JDBC_URL, USER, PASS);
			sql = "INSERT INTO MEMBER VALUES (?,?,?,?,?,?,?,?)";
			ptmt = conn.prepareStatement(sql);
			ptmt.setString(1, bean.getId());
			ptmt.setString(2, bean.getName());
			ptmt.setString(3, bean.getPwd());
			ptmt.setString(4, bean.getEmail());
			ptmt.setBoolean(5, bean.getAuth());
			ptmt.setString(6, bean.getAccess_token());
			ptmt.setString(7, bean.getUser_seq_no());
			ptmt.setInt(8, 0);
			if (ptmt.executeUpdate() == 1) {
				flag = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			Util.close(conn, ptmt);
		}
		return flag;
	}

	// update
	public boolean updateMember(MemberDTO bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = DriverManager.getConnection(JDBC_URL, USER, PASS);
			sql = "update member set pwd=nvl(?,pwd),email=nvl(?,email) where id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getPwd());
			pstmt.setString(2, bean.getEmail());
			pstmt.setString(3, bean.getId());
			if (pstmt.executeUpdate() == 1)
				flag = true;
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			Util.close(con, pstmt);
		}
		return flag;
	}

	// delete
	public boolean deleteMember(String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = DriverManager.getConnection(JDBC_URL, USER, PASS);
			sql = "DELETE FROM MEMBER WHERE id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			if (pstmt.executeUpdate() == 1)
				flag = true;
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			Util.close(con, pstmt);
		}
		return flag;
	}

	public boolean checkId(String id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		boolean flag = false;
		try {
			conn = DriverManager.getConnection(JDBC_URL, USER, PASS);
			System.out.println(USER);
			sql = "SELECT ID FROM MEMBER WHERE ID = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			flag = rs.next();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			Util.close(conn, pstmt, rs);
		}
		return flag;
	}

	public boolean loginMember(String id, String pwd) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		boolean check = false;

		try {
			conn = DriverManager.getConnection(JDBC_URL, USER, PASS);
			sql = "SELECT * FROM MEMBER WHERE ID = ? AND PWD = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pwd);
			rs = pstmt.executeQuery();
			check = rs.next();
			System.out.println(check);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			Util.close(conn, pstmt, rs);
		}
		return check;
	}

	@SuppressWarnings("unused")
	public MemberDTO getMember(String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		boolean check = false;
		MemberDTO member = new MemberDTO();

		try {
			con = DriverManager.getConnection(JDBC_URL, USER, PASS);
			sql = "SELECT * FROM MEMBER WHERE ID = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();

			check = rs.next();

			member.setId(rs.getString(1));
			member.setName(rs.getString(2));
			member.setPwd(rs.getString(3));
			member.setEmail(rs.getString(4));
			member.setAuth(rs.getInt(5));
			member.setAccess_token(rs.getString(6));
			member.setUser_seq_no(rs.getString(7));
			member.setGoalExpense(rs.getInt(8));

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			Util.close(con, pstmt, rs);
		}
		return member;
	}

	public boolean updateAuth(String id) {
		Connection conn = null;
		PreparedStatement ptmt = null;
		String sql = null;
		boolean flag = false;

		try {
			conn = DriverManager.getConnection(JDBC_URL, USER, PASS);
			sql = "UPDATE MEMBER SET AUTH = ? WHERE ID = ?";
			ptmt = conn.prepareStatement(sql);
			ptmt.setInt(1, 1);
			ptmt.setString(2, id);
			if (ptmt.executeUpdate() == 1) {
				flag = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			Util.close(conn, ptmt);
		}
		return flag;
	}

	public boolean updateToken(String access_token, String user_seq_no, String id) {
		Connection conn = null;
		PreparedStatement ptmt = null;
		String sql = null;
		boolean flag = false;

		try {
			conn = DriverManager.getConnection(JDBC_URL, USER, PASS);
			sql = "UPDATE MEMBER SET ACCESS_TOKEN = ?, USER_SEQ_NO=?  WHERE ID = ?";
			ptmt = conn.prepareStatement(sql);
			ptmt.setString(1, access_token);
			ptmt.setString(2, user_seq_no);
			ptmt.setString(3, id);
			if (ptmt.executeUpdate() == 1) {
				flag = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			Util.close(conn, ptmt);
		}
		return flag;
	}

	public boolean updateGoalExpense(String id, int cost) {
		Connection conn = null;
		PreparedStatement ptmt = null;
		String sql = null;
		boolean flag = false;

		try {
			conn = DriverManager.getConnection(JDBC_URL, USER, PASS);
			sql = "UPDATE MEMBER SET GOALEXPENSE = ? WHERE ID = ?";
			ptmt = conn.prepareStatement(sql);
			ptmt.setInt(1, cost);
			ptmt.setString(2, id);
			if (ptmt.executeUpdate() == 1) {
				flag = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			Util.close(conn, ptmt);
		}
		return flag;
	}
}
