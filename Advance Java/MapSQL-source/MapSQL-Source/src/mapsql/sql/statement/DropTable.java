package mapsql.sql.statement;

import java.util.Map;

import mapsql.sql.condition.Equals;
import mapsql.sql.core.Condition;
import mapsql.sql.core.Row;
import mapsql.sql.core.SQLException;
import mapsql.sql.core.SQLResult;
import mapsql.sql.core.SQLStatement;
import mapsql.sql.core.Table;
import mapsql.sql.core.TableDescription;
import mapsql.util.List;

public class DropTable implements SQLStatement {
	private String name;
	
	public DropTable(String name) {
		this.name = name;
	}
	
	@Override
	public SQLResult execute(Map<String, Table> tables) throws SQLException {
		return new SQLResult() {
			public String toString() {
				return "OK";
			}

			@Override
			public TableDescription description() {
				return null;
			}

			@Override
			public List<Row> rows() {
				return null;
			}
		};
	}

}
