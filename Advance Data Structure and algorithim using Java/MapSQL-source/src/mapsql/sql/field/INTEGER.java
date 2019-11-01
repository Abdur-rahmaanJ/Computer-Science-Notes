package mapsql.sql.field;

import mapsql.sql.core.Field;
import mapsql.sql.core.SQLException;

public class INTEGER extends AbstractField {
	private int counter = 1;
	
	public INTEGER(String name, boolean unique, boolean autoIncrement, boolean notnull) {
		super(name, Field.INTEGER, unique, notnull, autoIncrement);
	}
	
	public String validate(String input) throws SQLException {
		try {
			Integer.parseInt(input);
		} catch (NumberFormatException e) {
			throw new SQLException("Invalid input for '" + name + "': Expected INTEGER but got: '" + input + "'");
		}
		return input;
	}

	@Override
	public String toFixedWidthString() {
		String out = "";
		if (10 > name.length()) {
			int padding = 10-name.length();
			for (int i = 0; i < padding/2; i++) {
				out += " ";
			}
			out += name;
			while (out.length() < 10) {
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
		return Math.max(10, name.length());
	}

	@Override
	public String defaultValue() {
		if (isAutoIncrement()) {
			return "" + (counter++);
		}
		return "0";
	}

	@Override
	public Integer toValue(String value) throws SQLException {
		try {
			return Integer.parseInt(value);
		} catch (NumberFormatException e) {
			throw new SQLException("Invalid input for '" + name + "': Expected INTEGER but got: '" + value + "'");
		}
	}
}
