package mapsql.sql.core;

import mapsql.util.List;

public interface SQLResult {
	public TableDescription description();
	public List<Row> rows();
}
