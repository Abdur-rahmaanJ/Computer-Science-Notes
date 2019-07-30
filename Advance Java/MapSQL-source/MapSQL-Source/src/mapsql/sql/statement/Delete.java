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

public class Delete implements SQLStatement {
	private String name;
	private Condition where;
	
	public Delete(String name, Condition where) {
		this.name = name;
		this.where = where;
	}
	
	public Delete(String name) {
		this(name, null);
	}
	
	@Override
	public SQLResult execute(Map<String, Table> tables) throws SQLException {
		if (name.equals("mapsql.tables")) throw new SQLException("Table 'mapsql.tables' cannot be modified");

		final Table table = tables.get(name);
		if (table == null) throw new SQLException("Unknown table: " + name);
		
		table.delete(where);

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
