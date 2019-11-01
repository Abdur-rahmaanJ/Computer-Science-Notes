package mapsql.sql.statement;

import java.util.Map;

import mapsql.sql.core.Field;
import mapsql.sql.core.Row;
import mapsql.sql.core.SQLException;
import mapsql.sql.core.SQLResult;
import mapsql.sql.core.SQLStatement;
import mapsql.sql.core.Table;
import mapsql.sql.core.TableDescription;
import mapsql.util.List;

public class CreateTable implements SQLStatement {
	private String name;
	private Field[] fields;
	
	public CreateTable(String name, Field[] fields) {
		this.name = name;
		this.fields = fields;
	}

	@Override
	public SQLResult execute(Map<String, Table> tables) throws SQLException {
		if (tables.containsKey(name)) throw new SQLException("Duplicate Table Name: " + name);
		
		final TableDescription description = new TableDescription(name, fields); 
		
		tables.put(name, new Table(description));
		
		// add a row recording the new table to the mapsql.tables table
		tables.get("mapsql.tables").insert(new String[] {"table"}, new String[] {name});
		
		return new SQLResult() {
			public String toString() {
				return "OK";
			}

			@Override
			public TableDescription description() {
				return description;
			}

			@Override
			public List<Row> rows() {
				return null;
			}
		};
	}

}
