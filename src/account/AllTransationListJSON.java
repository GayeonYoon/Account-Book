package account;

public class AllTransationListJSON {
	private String json;
	private AllTransationListJSON() {}
    
	public static AllTransationListJSON getInstance() {
        return LazyHolder.INSTANCE;
    }

    private static class LazyHolder {
        private static final AllTransationListJSON INSTANCE = new AllTransationListJSON();
    }

	public String getJson() {
		return json;
	}

	public void setJson(String json) {
		this.json = json;
	}
}
