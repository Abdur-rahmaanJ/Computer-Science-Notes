/* StackArray
*  Anderson, Franceschi
*/

public class StackArray
{
 // CAPACITY can be changed to any value from 1 to 10
 // If changed, recompile this file and StackArrayDrawing.java
 public static final int CAPACITY = 10; 

 private int [] stack;
 private int top;

 public StackArray( )
 {
  stack = new int[CAPACITY];
  top = -1;
 }

 /** push method
 *   @param    value  value to be pushed onto the stack
 *   @return   true if successful, false if unsuccessful
 */
 public boolean push( int value )
 {
    // ***** 1. Student code starts here *****
    // stack is an int array instance variable representing
    // the array that stores our stack

    // top is an instance variable representing
    // the index of the top of the stack

    // CAPACITY is a constant instance variable representing
    // the size of the array stack

    // The push method adds the argument value
    // to the top of the stack, if it is possible
    // Add your code here
    
    if( top >= CAPACITY - 1 ) // stack is full 
      return false;
    else
    {
      stack[++top] = value; 
      return true;  // replace this dummy return statement
    }
    // end of student code, part 1
 }

 /** pop method
 *   @return   the value of the top element of the stack, if
 *             successful
 */
 public int pop( ) throws DataStructureException
 {
    // ***** 2. Student code restarts here *****
    // stack is an int array instance variable representing
    // the array that stores our stack

    // top is an instance variable representing
    // the index of the top of the stack

    // CAPACITY is a constant instance variable representing
    // the size of the array stack

    // The pop method deletes the element
    // at the top of the stack, if it is possible
    // Code the pop method here
    
    if ( top >= 0 )
      return stack[top--];
     
    else
      throw new DataStructureException( "Stack is empty: cannot pop" );
    // end of student code, part 2
 }
 
 @Override
 public boolean equals( Object o )
 {
   if ( ! ( o instanceof StackArray ) )
     return false;
   else
   {
     StackArray sa = ( StackArray ) o;
     if ( top != sa.top )
     {
       System.out.println( "top = " + top + "; and sa.top = " + sa.top );
       return false;
     }
     else
     {
       for ( int i = 0; i <= top; i++ )
       {
         if ( stack[i] != ( sa.stack )[i] )
           return false;
       }
       return true;
     }
   }
 }
 
 public StackArray copy( )
 {
   StackArray clone = new StackArray( );
   clone.top = top;
   for ( int i = 0; i <= top; i++ )
   {
     ( clone.stack )[i] = stack[i];
   }
   return clone;
 }
 
 public void updateValue( int index, int value )
 {
   if ( index >= 0 && index < CAPACITY )
     stack[index] = value;
 }
 
 public int getValue( int index ) throws DataStructureException
 {
   if ( index >= 0 && index < CAPACITY )
     return stack[index];
   else
     throw new DataStructureException( "Out of bounds index" );
 }

 public void updateTopUp( )
 {
   if ( top < CAPACITY - 1 )
     top++;
 }
 
 public void updateTopDown( )
 {
   if ( top >= 0 )
     top--;
 }
 
 public int get( int index )
 {
  return stack[index];
 }

 public int getTop( )
 {
  return top;
 }

}
