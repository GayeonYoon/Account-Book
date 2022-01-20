package account;

public class Account {
	private String fintech_use_num;
	private String account_alias;
	private String bank_code_std;
	private String bank_code_sub;
	private String bank_name;
	private String account_num_masked;
	private String account_holder_name;
	private String account_type;
	private String inquiry_agree_yn;
	private String inquiry_agree_dtime;
	private String transfer_agree_yn;
	private String transfer_agree_dtime;
	private String account_state;

	public String getFintech_use_num() {
		return fintech_use_num;
	}

	public void setFintech_use_num(String fintech_use_num) {
		this.fintech_use_num = fintech_use_num;
	}

	public String getAccount_alias() {
		return account_alias;
	}

	public void setAccount_alias(String account_alias) {
		this.account_alias = account_alias;
	}

	public String getBank_code_std() {
		return bank_code_std;
	}

	public void setBank_code_std(String bank_code_std) {
		this.bank_code_std = bank_code_std;
	}

	public String getBank_code_sub() {
		return bank_code_sub;
	}

	public void setBank_code_sub(String bank_code_sub) {
		this.bank_code_sub = bank_code_sub;
	}

	public String getBank_name() {
		return bank_name;
	}

	public void setBank_name(String bank_name) {
		this.bank_name = bank_name;
	}

	public String getAccount_num_masked() {
		return account_num_masked;
	}

	public void setAccount_num_masked(String account_num_masked) {
		this.account_num_masked = account_num_masked;
	}

	public String getAccount_holder_name() {
		return account_holder_name;
	}

	public void setAccount_holder_name(String account_holder_name) {
		this.account_holder_name = account_holder_name;
	}

	public String getAccount_type() {
		return account_type;
	}

	public void setAccount_type(String account_type) {
		this.account_type = account_type;
	}

	public String getInquiry_agree_yn() {
		return inquiry_agree_yn;
	}

	public void setInquiry_agree_yn(String inquiry_agree_yn) {
		this.inquiry_agree_yn = inquiry_agree_yn;
	}

	public String getInquiry_agree_dtime() {
		return inquiry_agree_dtime;
	}

	public void setInquiry_agree_dtime(String inquiry_agree_dtime) {
		this.inquiry_agree_dtime = inquiry_agree_dtime;
	}

	public String getTransfer_agree_yn() {
		return transfer_agree_yn;
	}

	public void setTransfer_agree_yn(String transfer_agree_yn) {
		this.transfer_agree_yn = transfer_agree_yn;
	}

	public String getTransfer_agree_dtime() {
		return transfer_agree_dtime;
	}

	public void setTransfer_agree_dtime(String transfer_agree_dtime) {
		this.transfer_agree_dtime = transfer_agree_dtime;
	}

	public String getAccount_state() {
		return account_state;
	}

	public void setAccount_state(String account_state) {
		this.account_state = account_state;
	}

	@Override
	public String toString() {
		return "ResList [fintech_use_num=" + fintech_use_num + ", account_alias=" + account_alias + ", bank_code_std="
				+ bank_code_std + ", bank_code_sub=" + bank_code_sub + ", bank_name=" + bank_name
				+ ", account_num_masked=" + account_num_masked + ", account_holder_name=" + account_holder_name
				+ ", account_type=" + account_type + ", inquiry_agree_yn=" + inquiry_agree_yn + ", inquiry_agree_dtime="
				+ inquiry_agree_dtime + ", transfer_agree_yn=" + transfer_agree_yn + ", transfer_agree_dtime="
				+ transfer_agree_dtime + ", account_state=" + account_state + "]";
	}

}
