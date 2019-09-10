package mapsql.sql.core;

import java.util.HashMap;
import java.util.Map;

import mapsql.sql.field.CHARACTER;

public class SQLManager {
	private Map<String, Table> tables = new HashMap<String, Table>();
	
	public SQLManager() {
		tables.put("mapsql.tables", new Table(new TableDescription("mapsql.tables", new Field[] { new CHARACTER("table", 100, true, true) })));
		try {
			tables.get("mapsql.tables").insert(new String[] {"table"}, new String[] {"mapsql.tables"});
		} catch (SQLException e) {
			// should never happen
		}
	}
	
	/**
	 * Execute an SQL Statement
	 * 
	 * @param statement
	 * @return
	 * @throws SQLException
	 */
	public SQLResult execute(SQLStatement statement) throws SQLException {
		return statement.execute(tables);
	}

	/**
	 * Execute an SQL command
	 * 
	 * @param command
	 * @return
	 * @throws SQLException
	 */
	public String execute(SQLCommand command) throws SQLException {
		return command.execute(this);
	}

	/**
	 * This method is used where it is not clear whether the operation is
	 * a statement or a command.
	 * @param operation
	 * @return
	 * @throws SQLException 
	 */
	public String execute(SQLOperation operation) throws SQLException {
		if (operation instanceof SQLStatement) {
			return execute((SQLStatement) operation).toString();
		} else {
			return execute((SQLCommand) operation).toString();
		}
	}
}
