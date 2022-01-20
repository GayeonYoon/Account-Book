package account;

import java.io.IOException;
import java.util.HashMap;

@SuppressWarnings("serial")
public class ResListMap extends HashMap<Integer, Account> {
	private static ResListMap singleObj = null;

	public static ResListMap getInstance() throws IOException {
		if (singleObj == null) {
			singleObj = new ResListMap();
		}
		return singleObj;
	}
}