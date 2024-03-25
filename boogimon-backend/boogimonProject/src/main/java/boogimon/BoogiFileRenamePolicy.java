package boogimon;
import java.io.File;
import java.io.IOException;
import java.util.concurrent.ThreadLocalRandom;

import com.oreilly.servlet.multipart.FileRenamePolicy;

public class BoogiFileRenamePolicy implements FileRenamePolicy {
	
	public File rename(File f) {
		byte[] temp = new byte[3];
		ThreadLocalRandom.current().nextBytes(temp);

		StringBuilder sb = new StringBuilder();
		for (byte a : temp) {
			sb.append(String.format("%02x", a));
		}
		String randomString = sb.toString();

		String uniqueFileName = Long.toString(System.currentTimeMillis()) + randomString;

		String name = f.getName();
		String ext = null;

		int dot = name.lastIndexOf(".");
		if (dot != -1) {
			ext = name.substring(dot); // includes "."
		} else {
			ext = "";
		}

		String tempName = uniqueFileName + ext;
		f = new File(f.getParent(), tempName);
		if (createNewFile(f)) {
			return f;
		}

		int count = 0;
		while (!createNewFile(f) && count < 9999) {
			count++;
			String newName = uniqueFileName + count + ext;
			f = new File(f.getParent(), newName);
		}

		return f;
	}

	private boolean createNewFile(File f) {
		try {
			return f.createNewFile();
		} 
		catch (IOException ignored) {
			return false;
		}
	}
}