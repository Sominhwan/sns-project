package sns;

import java.io.File;
import java.util.StringTokenizer;

public class UtilMgr {
	public static void delete(String s) {
		File file = new File(s);
		if (file.isFile()) {
			file.delete();
		}
	}
}