package mapsql.sql.core;

import java.util.Map;

public interface Condition {
	public boolean evaluate(TableDescription description, Map<String, String> data) throws SQLException;
}
