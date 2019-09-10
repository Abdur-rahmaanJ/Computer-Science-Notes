package mapsql.sql.core;

import java.util.HashMap;
import java.util.Map;

public class Row {
	Map<String, String> data = new HashMap<String, String>();
	
	public Row(Map<String, String> data) {
		this.data = data;
	}

	public boolean satisfies(Condition where, TableDescription description) throws SQLException {
		if (where == null) return true;
		return where.evaluate(description, data);
	}

	public String get(String name) {
		return data.get(name);
	}

}
