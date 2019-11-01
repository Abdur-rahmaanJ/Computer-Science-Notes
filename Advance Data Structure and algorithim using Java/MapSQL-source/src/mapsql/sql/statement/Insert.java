package mapsql.sql.statement;

import java.util.Map;

import mapsql.sql.core.Row;
import mapsql.sql.core.SQLException;
import mapsql.sql.core.SQLResult;
import mapsql.sql.core.SQLStatement;
import mapsql.sql.core.Table;
import mapsql.sql.core.TableDescription;
import mapsql.util.List;

public class Insert implements SQLStatement {
	private String name;
	private String[] columns;
	private String[] values;
	
	public Insert(String name, String[] columns, String[] values) {
		this.name = name;
		this.columns = columns;
		this.values = values;
	}
	
	@Override
	public SQLResult execute(Map<String, Table> tables) throws SQLException {
		if (name.equals("mapsql.tables")) throw new SQLException("Table 'mapsql.tables' cannot be modified");

		final Table table = tables.get(name);
		if (table == null) throw new SQLException("Unknown table: " + name);

		table.description().checkForNotNulls(columns);
		
		String[] cols = table.description().resolveColumns(columns);
		
		table.insert(cols, values);
		return new SQLResult() {

			@Override
			public TableDescription description() {
				return table.description();
			}

			@Override
			public List<Row> rows() {
				return null;
			}
			
			public String toString() {
				return "OK";
			}
		};
	}

}
