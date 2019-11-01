package mapsql.shell.core;

import mapsql.shell.parser.ASTAndCondition;
import mapsql.shell.parser.ASTAssignment;
import mapsql.shell.parser.ASTAssignments;
import mapsql.shell.parser.ASTChar;
import mapsql.shell.parser.ASTColumns;
import mapsql.shell.parser.ASTCondition;
import mapsql.shell.parser.ASTCreateTable;
import mapsql.shell.parser.ASTDelete;
import mapsql.shell.parser.ASTDropTable;
import mapsql.shell.parser.ASTField;
import mapsql.shell.parser.ASTIdentifier;
import mapsql.shell.parser.ASTInsert;
import mapsql.shell.parser.ASTInt;
import mapsql.shell.parser.ASTModifier;
import mapsql.shell.parser.ASTNumber;
import mapsql.shell.parser.ASTOrCondition;
import mapsql.shell.parser.ASTQuit;
import mapsql.shell.parser.ASTSelect;
import mapsql.shell.parser.ASTSource;
import mapsql.shell.parser.ASTStart;
import mapsql.shell.parser.ASTString;
import mapsql.shell.parser.ASTUnsignedNumber;
import mapsql.shell.parser.ASTUpdate;
import mapsql.shell.parser.ASTValues;
import mapsql.shell.parser.ASTWildcard;
import mapsql.shell.parser.MapSQLVisitor;
import mapsql.shell.parser.SimpleNode;
import mapsql.sql.command.Quit;
import mapsql.sql.command.Sources;
import mapsql.sql.condition.AndCondition;
import mapsql.sql.condition.Equals;
import mapsql.sql.condition.GreaterThan;
import mapsql.sql.condition.GreaterThanOrEqual;
import mapsql.sql.condition.LessThan;
import mapsql.sql.condition.LessThanOrEqual;
import mapsql.sql.condition.Like;
import mapsql.sql.condition.NotEqual;
import mapsql.sql.condition.OrCondition;
import mapsql.sql.core.Condition;
import mapsql.sql.core.Field;
import mapsql.sql.core.SQLOperation;
import mapsql.sql.core.SQLStatement;
import mapsql.sql.field.CHARACTER;
import mapsql.sql.field.INTEGER;
import mapsql.sql.statement.CreateTable;
import mapsql.sql.statement.Delete;
import mapsql.sql.statement.DropTable;
import mapsql.sql.statement.Insert;
import mapsql.sql.statement.Select;
import mapsql.sql.statement.Update;
import mapsql.util.LinkedList;
import mapsql.util.List;

public class SQLVisitor implements MapSQLVisitor {

	private SimpleNode child(SimpleNode node, int index) {
		return (SimpleNode) node.jjtGetChild(index);
	}
	
	@Override
	public Object visit(ASTStart node, Object data) {
		List<SQLOperation> operations = new LinkedList<SQLOperation>();
		for (int i=0; i < node.jjtGetNumChildren(); i++) {
			operations.insertLast((SQLOperation) child(node, i).jjtAccept(this, data));
		}
		return operations;
	}

	@Override
	public Object visit(ASTCreateTable node, Object data) {
		String name = child(node,0).jjtGetValue().toString();
		Field[] fields = new Field[node.jjtGetNumChildren()-1];
		for (int i=1; i< node.jjtGetNumChildren(); i++) {
			fields[i-1] = (Field) child(node, i).jjtAccept(this, data);
		}
		return new CreateTable(name, fields);
	}

	@Override
	public Object visit(ASTSelect node, Object data) {
		if (node.jjtGetNumChildren() == 2) {
			return new Select(child(node, 1).jjtGetValue().toString(), (String[]) child(node, 0).jjtAccept(this, data));
		}
		return new Select(child(node, 1).jjtGetValue().toString(), (String[]) child(node, 0).jjtAccept(this, data), (Condition) child(node, 2).jjtAccept(this, data));
	}

	@Override
	public Object visit(ASTInsert node, Object data) {
		return new Insert(child(node, 0).jjtGetValue().toString(), (String[]) child(node, 1).jjtAccept(this, data), (String[]) child(node, 2).jjtAccept(this, data));
	}

	@Override
	public Object visit(ASTUpdate node, Object data) {
		Assignments assignments = (Assignments) child(node, 1).jjtAccept(this, data);
		if (node.jjtGetNumChildren() == 2) {
			return new Update(child(node,0).jjtGetValue().toString(), assignments.columns, assignments.values);
		} else {
			return new Update(child(node,0).jjtGetValue().toString(), assignments.columns, assignments.values, (Condition) child(node, 2).jjtAccept(this, data));
		}
	}

	@Override
	public Object visit(ASTDelete node, Object data) {
		if (node.jjtGetNumChildren() == 1) {
			return new Delete(child(node,0).jjtGetValue().toString());
		} else {
			return new Delete(child(node,0).jjtGetValue().toString(), (Condition) child(node, 1).jjtAccept(this, data));
		}
	}

	@Override
	public Object visit(ASTDropTable node, Object data) {
		return new DropTable(child(node, 0).jjtGetValue().toString());
	}

	@Override
	public Object visit(ASTSource node, Object data) {
		return new Sources(child(node,0).jjtAccept(this, data).toString());
	}
	
	@Override
	public Object visit(ASTQuit node, Object data) {
		return new Quit();
	}

	/**
	 * This is used to return assignments for the SQL INSERT statement
	 * @author Rem Collier
	 *
	 */
	private class Assignments {
		String[] columns;
		String[] values;

		public Assignments(int size) {
			columns = new String[size];
			values = new String[size];
		}
	}
	
	@Override
	public Object visit(ASTAssignments node, Object data) {
		Assignments assignments = new Assignments(node.jjtGetNumChildren());
		for (int i=0; i < node.jjtGetNumChildren(); i++) {
			SimpleNode n = child(node, i);
			if (!n.jjtGetValue().equals("=")) {
				throw new SQLParseException("Encountered " + n.jjtGetValue() + " but expected = at line " + n.jjtGetFirstToken().beginLine + ", column " + n.jjtGetFirstToken().beginColumn);
			}
			assignments.columns[i] = child(n,0).jjtGetValue().toString(); 
			assignments.values[i] = child(n,1).jjtAccept(this, data).toString();
		}
		return assignments;
	}

	@Override
	public Object visit(ASTColumns node, Object data) {
		String[] columns = new String[node.jjtGetNumChildren()];
		for (int i=0; i < node.jjtGetNumChildren(); i++) {
			columns[i] = child(node, i).jjtGetValue().toString();
		}
		return columns;
	}

	@Override
	public Object visit(ASTValues node, Object data) {
		String[] values = new String[node.jjtGetNumChildren()];
		for (int i=0; i < node.jjtGetNumChildren(); i++) {
			values[i] = child(node, i).jjtAccept(this, data).toString();
		}
		return values;
	}

	@Override
	public Object visit(ASTField node, Object data) {
		return child(node, 1).jjtAccept(this, child(node, 0).jjtGetValue());
	}

	@Override
	public Object visit(ASTChar node, Object data) {
		int characters = Integer.parseInt(child(node, 0).jjtAccept(this, data).toString());
		
		boolean unique = false;
		boolean notnull = false;
		for (int i=1; i < node.jjtGetNumChildren(); i++) {
			if (child(node, i).jjtGetValue().equals("UNIQUE")) {
				unique = true;
			} else if (child(node, i).jjtGetValue().equals("NOT NULL")) {
				notnull = true;
			}
		}
		return new CHARACTER(data.toString(), characters, unique, notnull);
	}

	@Override
	public Object visit(ASTInt node, Object data) {
		boolean unique = false;
		boolean autoincrement = false;
		boolean notnull = false;
		for (int i=0; i < node.jjtGetNumChildren(); i++) {
			if (child(node, i).jjtGetValue().equals("UNIQUE")) {
				unique = true;
			} else if (child(node, i).jjtGetValue().equals("AUTO_INCREMENT")) {
				autoincrement = true;
			} else if (child(node, i).jjtGetValue().equals("NOT NULL")) {
				notnull = true;
			}
		}
		return new INTEGER(data.toString(), unique, notnull, autoincrement);
	}

	@Override
	public Object visit(ASTNumber node, Object data) {
		String out = "";
		if (node.jjtGetValue() != null) out += node.jjtGetValue().toString(); 
		return out + child(node, 0).jjtGetValue().toString();
	}

	@Override
	public Object visit(ASTOrCondition node, Object data) {
		if (node.jjtGetNumChildren() == 1) {
			return child(node, 0).jjtAccept(this, null);
		}
		return new OrCondition((Condition) child(node, 0).jjtAccept(this, null), (Condition) child(node, 1).jjtAccept(this, null));
	}

	@Override
	public Object visit(ASTAndCondition node, Object data) {
		if (node.jjtGetNumChildren() == 1) {
			return child(node, 0).jjtAccept(this, null);
		}
		return new AndCondition((Condition) child(node, 0).jjtAccept(this, null), (Condition) child(node, 1).jjtAccept(this, null));
	}

	@Override
	public Object visit(ASTCondition node, Object data) {
		String operator = node.jjtGetValue().toString();
		
		if (operator.equals("=")) {
			return new Equals(child(node, 0).jjtGetValue().toString(), child(node, 1).jjtAccept(this, data).toString());
		} else if (operator.equals("<")) {
			return new LessThan(child(node, 0).jjtGetValue().toString(), child(node, 1).jjtAccept(this, data).toString());
		} else if (operator.equals(">")) {
			return new GreaterThan(child(node, 0).jjtGetValue().toString(), child(node, 1).jjtAccept(this, data).toString());
		} else if (operator.equals("<=")) {
			return new LessThanOrEqual(child(node, 0).jjtGetValue().toString(), child(node, 1).jjtAccept(this, data).toString());
		} else if (operator.equals(">=")) {
			return new GreaterThanOrEqual(child(node, 0).jjtGetValue().toString(), child(node, 1).jjtAccept(this, data).toString());
		} else if (operator.equals("<>")) {
			return new NotEqual(child(node, 0).jjtGetValue().toString(), child(node, 1).jjtAccept(this, data).toString());
		} else if (operator.equals("LIKE")) {
			System.out.println(child(node, 1).jjtAccept(this, data));
			child(node, 1).dump("");
			return new Like(child(node, 0).jjtGetValue().toString(), child(node, 1).jjtAccept(this, data).toString());
		}
		return null;
	}

	@Override
	public Object visit(ASTString node, Object data) {
		String out = node.jjtGetValue().toString();
		if (out.charAt(0) == '\"' || out.charAt(0) == '\'') {
			out = out.substring(1, out.length()-1);
		}
		return out;
	}
	
	// ------------------------------------------------------------------------------
	// The methods below are not used but must remain to implement the MapSQLVisitor
	// interface
	// ------------------------------------------------------------------------------
	@Override
	public Object visit(SimpleNode node, Object data) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Object visit(ASTModifier node, Object data) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Object visit(ASTIdentifier node, Object data) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Object visit(ASTUnsignedNumber node, Object data) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Object visit(ASTWildcard node, Object data) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Object visit(ASTAssignment node, Object data) {
		// TODO Auto-generated method stub
		return null;
	}
}
