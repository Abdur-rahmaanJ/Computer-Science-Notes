package mapsql.sql.condition;

import java.util.Map;

import mapsql.sql.core.Field;
import mapsql.sql.core.SQLException;
import mapsql.sql.core.TableDescription;
import mapsql.sql.field.CHARACTER;

public class Like extends AbstractCondition {
	private String column;
	private String value;
	
	public Like(String column, String value) {
		this.column = column;
		this.value = value;
	}

	@SuppressWarnings("unchecked")
	@Override
	public boolean evaluate(TableDescription description, Map<String, String> data) throws SQLException {
		char ch='%';
		String forcheck=data.get(column);
		if(value.charAt(0)==ch){
			if(forcheck.startsWith(value.substring(1,value.length()))){
				return true;
			}
		}
		if(value.charAt(value.length()-1)==ch){
			if(forcheck.endsWith(value.substring(0,value.length()-1))){
				return true;
			}
		}
		if(value.charAt(0)==ch && value.charAt(value.length()-1)==ch){
			if(forcheck.contains(value.substring(1,value.length()-1))){
				return true;
			}
		}
		return false;
		
	}
}