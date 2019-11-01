package mapsql.sql.condition;

import java.util.Comparator;
import java.util.Map;

import mapsql.sql.core.Condition;
import mapsql.sql.core.Field;
import mapsql.sql.core.SQLException;
import mapsql.sql.core.TableDescription;
import mapsql.util.IncomparableException;

public class LessThanOrEqual extends AbstractCondition {
	private String column;
	private String value;
	
	public LessThanOrEqual(String column, String value) {
		this.column = column;
		this.value = value;
	}

	@SuppressWarnings("unchecked")
	@Override
	public boolean evaluate(TableDescription description, Map<String, String> data) throws SQLException {
		Field field = description.findField(column);
		return comparator.compare(field.toValue(data.get(column)), field.toValue(value)) <= 0;
	}

}
