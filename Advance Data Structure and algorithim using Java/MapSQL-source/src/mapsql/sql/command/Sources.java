package mapsql.sql.command;  // Import the File class
import java.io.IOException;

import mapsql.shell.core.SQLVisitor;
import mapsql.shell.parser.MapSQL;
import mapsql.shell.parser.ParseException;
import mapsql.shell.parser.SimpleNode;
import mapsql.sql.core.SQLCommand;
import mapsql.sql.core.SQLException;
import mapsql.sql.core.SQLManager;
import mapsql.sql.core.SQLOperation;
import mapsql.util.List;

import java.io.BufferedReader;
import java.io.ByteArrayInputStream;
import java.io.FileReader;

public class Sources implements SQLCommand {
	private String filename;
	
	public Sources(String filename) {
		this.filename = filename;
	}
	
	@Override
	public String execute(SQLManager manager) throws SQLException {
		BufferedReader reader;
		try {
			reader = new BufferedReader(new FileReader(filename));
			String line = reader.readLine();
			while (line != null) {
				{
					try {
						SimpleNode n = new MapSQL(new ByteArrayInputStream( line.getBytes() ) ).Start();

						List<SQLOperation> operations = (List<SQLOperation>) n.jjtAccept(new SQLVisitor(), null);
						for (SQLOperation operation : operations) {
							System.out.println(manager.execute(operation));
						}
					} 
					catch (ParseException e) {
						System.out.println(e.getMessage());
					}
					catch (SQLException e) {
						System.out.println(e.getMessage());
					}
					
				}
				// read next line
				line = reader.readLine();
			}
			reader.close();
		} catch (IOException e) {
			return "File Not Found.Check Folder";
		}
	
    
		return "ok";
	}
}