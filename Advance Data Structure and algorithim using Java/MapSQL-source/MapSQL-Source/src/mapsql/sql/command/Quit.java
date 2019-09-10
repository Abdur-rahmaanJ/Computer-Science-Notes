package mapsql.sql.command;

import mapsql.sql.core.SQLCommand;
import mapsql.sql.core.SQLException;
import mapsql.sql.core.SQLManager;

public class Quit implements SQLCommand {
	@Override
	public String execute(SQLManager manager) throws SQLException {
		System.out.println("Bye Bye!");
		System.exit(0);
		return null;
	}

}
