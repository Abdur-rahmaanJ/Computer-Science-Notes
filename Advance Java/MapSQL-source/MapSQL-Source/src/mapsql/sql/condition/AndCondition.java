package mapsql.sql.condition;

import java.util.Map;

import mapsql.sql.core.Condition;
import mapsql.sql.core.SQLException;
import mapsql.sql.core.TableDescription;

public class AndCondition implements Condition {
	private Condition left, right;
	
	public AndCondition(Condition left, Condition right) {
		this.left = left;
		this.right = right;
	}

	@Override
	public boolean evaluate(TableDescription description, Map<String, String> data) throws SQLException {
		return left.evaluate(description, data) && right.evaluate(description, data); 
	}
	
}
