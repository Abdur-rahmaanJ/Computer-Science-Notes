/* Node
*  Anderson, Franceschi
*/

public class Node
{
  /**  reference to the next node in the list **/
  private Node nextNode;

  /**  the data object held by this node **/
  private int data;

  /**
   *  Constructor
   *  construct a new node with the given Object as data
   *
   **/
  public Node( int data )
  {
    this.data = data;
    nextNode = null;
  }

  /**
   *  Constructor
   *  construct a new node with the int as data
   *  and references to the next node.
   *
  **/
  public Node( int data, Node nextNode )
  {
    this.data = data;
    this.nextNode = nextNode;
  }

  /**
   *  mutator for nextNode
   *  @param nextNode new value for nextNode
   *  @return a reference to this Node
   **/
  public Node setNext( Node nextNode )
  {
    this.nextNode = nextNode;
    return this;
  }

  /**
   *  accessor for nextNode
   *  @return reference to the next node, or null if there is no next node
   *
  **/
  public Node getNext( )
  {
    return nextNode;
  }

  /**
   *  mutator for data
   *  @param data  new value for data
   *  @return a reference to this object
  **/
  public Node setData( int data )
  {
    this.data = data;
    return this;
  }

  /**
   *  accessor for data
   *  @return  data value held by this node
   *
  **/
  public int getData( )
  {
    return data;
  }

} // end Node class