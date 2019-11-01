package mapsql.sql.condition;

import java.util.Map;

import mapsql.sql.core.Field;
import mapsql.sql.core.SQLException;
import mapsql.sql.core.TableDescription;

public class NotEqual extends AbstractCondition {
	private String column;
	private String value;
	
	public NotEqual(String column, String value) {
		this.column = column;
		this.value = value;
	}

	@SuppressWarnings("unchecked")
	@Override
	public boolean evaluate(TableDescription description, Map<String, String> data) throws SQLException {
		Field field = description.findField(column);
		return comparator.compare(field.toValue(data.get(column)), field.toValue(value)) != 0;
	}

}
