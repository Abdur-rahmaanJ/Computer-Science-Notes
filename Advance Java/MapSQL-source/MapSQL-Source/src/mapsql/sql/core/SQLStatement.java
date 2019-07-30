package mapsql.sql.core;

import java.util.Map;

/**
 * Main interface for all basic SQL Statements (CREATE TABLE, SELECT, INSERT,
 * UPDATE, ...)
 * 
 * @author Rem Collier
 *
 */
public interface SQLStatement extends SQLOperation {
	public SQLResult execute(Map<String, Table> tables) throws SQLException;
}
