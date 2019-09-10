package mapsql.sql.statement;

import java.util.Map;

import mapsql.sql.core.Condition;
import mapsql.sql.core.Row;
import mapsql.sql.core.SQLException;
import mapsql.sql.core.SQLResult;
import mapsql.sql.core.SQLStatement;
import mapsql.sql.core.Table;
import mapsql.sql.core.TableDescription;
import mapsql.util.List;

public class Update implements SQLStatement {
	private String name;
	private String[] columns;
	private String[] values;
	private Condition where;
	
	public Update(String name, String[] columns, String[] values, Condition where) {
		this.name = name;
		this.columns = columns;
		this.values = values;
		this.where = where;
	}
	
	public Update(String name, String[] columns, String[] values) {
		this(name, columns, values, null);
	}
	
	@Override
	public SQLResult execute(Map<String, Table> tables) throws SQLException {
		if (name.equals("mapsql.tables")) throw new SQLException("Table 'mapsql.tables' cannot be modified");
		final Table table = tables.get(name);
		if (table == null) throw new SQLException("Unknown table: " + name);
		
		// Here we are just checking that the columns we have provided are correct
		table.description().resolveColumns(columns);
		
		table.update(columns, values, where);

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
