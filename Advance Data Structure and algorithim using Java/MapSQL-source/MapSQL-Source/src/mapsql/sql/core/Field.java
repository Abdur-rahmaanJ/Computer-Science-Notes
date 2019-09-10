package mapsql.sql.core;

public interface Field {
	public static final String CHARACTER 							= "CHAR";
	public static final String INTEGER	 							= "INTEGER";

	public String name();
	public String type();

	public String validate(String input) throws SQLException;
	public String toFixedWidthString();
	public int columnFixedWidth();
	public String toFixedWidthString(String string);
	public String defaultValue();
	public Object toValue(String value) throws SQLException;
	public boolean isUnique();
	public boolean isNotNull();
	public boolean isAutoIncrement();
}
