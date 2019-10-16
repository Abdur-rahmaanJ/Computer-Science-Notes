/* The DataStructureException Class
   Anderson, Franceschi
*/
import java.util.NoSuchElementException;

public class DataStructureException extends NoSuchElementException
{
  /** constructor
  * @param s error message
  */
  public DataStructureException( String s )
  {
     super( s );
  }
}