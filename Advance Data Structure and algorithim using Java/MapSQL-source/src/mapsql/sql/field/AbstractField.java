package mapsql.sql.field;

import mapsql.sql.core.Field;

public abstract class AbstractField implements Field {
	protected String name;
	private String type;
	private boolean unique;
	private boolean notnull;
	private boolean autoIncrement;
	
	public AbstractField(String name, String type, boolean unique, boolean autoIncrement, boolean notnull) {
		this.name = name;
		this.type = type;
		this.unique = unique;
		this.notnull = notnull;
		this.autoIncrement = autoIncrement;
	}
	
	public String name() {
		return name;
	}
	
	public String type() {
		return type;
	}

	public boolean isUnique() {
		return unique;
	}
	
	public boolean isNotNull() {
		return notnull;
	}
	
	public boolean isAutoIncrement() {
		return autoIncrement;
	}
}
