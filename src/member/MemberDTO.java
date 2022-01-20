package member;

public class MemberDTO {

	private String id;
	private String pwd;
	private String name;
	private String email;
	private boolean auth;
	private String access_token;
	private String user_seq_no;
	private int goalExpense;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public boolean getAuth() {
		return auth;
	}

	public void setAuth(int auth) {
		this.auth = auth == 1 ? true : false;
	}

	public int getGoalExpense() {
		return goalExpense;
	}

	public void setGoalExpense(int goalExpense) {
		this.goalExpense = goalExpense;
	}

	public String getAccess_token() {
		return access_token;
	}

	public void setAccess_token(String access_token) {
		this.access_token = access_token;
	}

	public String getUser_seq_no() {
		return user_seq_no;
	}

	public void setUser_seq_no(String user_seq_no) {
		this.user_seq_no = user_seq_no;
	}

	@Override
	public String toString() {
		return "MemberDTO [id=" + id + ", pwd=" + pwd + ", name=" + name + ", email=" + email + ", auth=" + auth
				+ ", access_token=" + access_token + ", user_seq_no=" + user_seq_no + ", goalExpense=" + goalExpense
				+ "]";
	}

}
