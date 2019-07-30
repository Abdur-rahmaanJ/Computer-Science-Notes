package mapsql.sql.field;

import mapsql.sql.core.Field;
import mapsql.sql.core.SQLException;

public class CHARACTER extends AbstractField {
	private int characters;
	
	public CHARACTER(String name, int characters, boolean unique, boolean notnull) {
		super(name, Field.CHARACTER, unique, false, notnull);
		this.characters = characters;
	}
	
	public String validate(String input) throws SQLException {
		if (input.length() > characters) {
			return input.substring(0, characters);
		}
		return input;
	}

	@Override
	public String toFixedWidthString() {
		String out = "";
		if (characters > name.length()) {
			int padding = characters-name.length();
			for (int i = 0; i < padding/2; i++) {
				out += " ";
			}
			out += name;
			while (out.length() < characters) {
				out += " ";
			}
		} else {
			out += name;
		}
		return out;
	}

	@Override
	public String toFixedWidthString(String data) {
		String out = "";
		int padding = columnFixedWidth()-data.length();
		for (int i = 0; i < padding/2; i++) {
			out += " ";
		}
		out += data;
		while (out.length() < columnFixedWidth()) {
			out += " ";
		}
		return out;
	}
	
	@Override
	public int columnFixedWidth() {
		return Math.max(characters, name.length());
	}

	@Override
	public String defaultValue() {
		return "";
	}

	@Override
	public String toValue(String value) {
		return value;
	}
}
