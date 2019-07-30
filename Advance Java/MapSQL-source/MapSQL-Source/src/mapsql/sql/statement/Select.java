package mapsql.sql.statement;

import java.util.Map;

import mapsql.sql.core.Condition;
import mapsql.sql.core.SQLException;
import mapsql.sql.core.SQLResult;
import mapsql.sql.core.SQLStatement;
import mapsql.sql.core.Table;

public class Select implements SQLStatement {
	private String name;
	private String[] columns;
	private Condition where;
	
	public Select(String name, String[] columns, Condition where) {
		this.name = name;
		this.columns = columns;
		this.where = where;
	}
	
	public Select(String name, String[] columns) {
		this(name, columns, null);
	}
	
	@Override
	public SQLResult execute(Map<String, Table> tables) throws SQLException {
		Table table = tables.get(name);
		if (table == null) throw new SQLException("Unknown table: " + name);
		
		String[] cols = table.description().resolveColumns(columns); 
		
		return new SelectResult(table.description(), table.select(where), cols);
	}

}
