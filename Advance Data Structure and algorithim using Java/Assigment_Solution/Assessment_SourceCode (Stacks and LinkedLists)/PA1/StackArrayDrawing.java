/* StackArrayDrawing
*  Anderson, Franceschi
*/

import javafx.scene.paint.Color;
import javafx.scene.canvas.GraphicsContext;
import javafx.scene.shape.ArcType;
import javafx.scene.text.Font;

public class StackArrayDrawing
{
 public static final int XSTART = 150;
 public static final int YSTART = 400;
 public static final int WIDTH = 200;
 public static final int HEIGHT = 35;

 private StackArray sa;

 private boolean pushSuccess;
 private boolean popSuccess;
 private int pushedValue;
 private int poppedValue;

 private boolean operation; // true for push, false for pop
 private String description = "";
 private boolean started;
 
 private String message;

 public StackArrayDrawing( )
 {
  sa = new StackArray( );
  message = "";
 }

 public void setMessage( String message )
 {
   this.message = message;
 }

 public boolean simulatePush( StackArray otherSa, int value )
 {
   if ( otherSa.getTop( ) >= StackArray.CAPACITY - 1 ) // stack is full 
      return false;
    else
    {
      otherSa.updateValue( otherSa.getTop( ) + 1 , value );
      otherSa.updateTopUp( );
      return true;
    }
 }
 
 public int simulatePop( StackArray otherSa )
 {
   if ( otherSa.getTop( ) < 0 ) // stack is empty 
      throw new DataStructureException( "Empty stack: cannot pop" );
    else
    {
      int value = otherSa.getValue( otherSa.getTop( ) );
      otherSa.updateTopDown( );
      return value;
    }
 }

 public void setPushSuccess( boolean newPushSuccess )
 {
  started = true;
  pushSuccess = newPushSuccess;
 }

 public void setPopSuccess( boolean newPopSuccess )
 {
  popSuccess = newPopSuccess;
 }

 public void setPushedValue( int newPushedValue )
 {
  pushedValue = newPushedValue;
 }

 public void setPoppedValue( int newPoppedValue )
 {
  poppedValue = newPoppedValue;
 }

 public void setOperation( boolean newOperation )
 {
  operation = newOperation;
 }

 public void setStarted( boolean newStarted )
 {
  started = newStarted;
 }

 public boolean push( int value )
 {
  return ( sa.push( value ) );
 }

 public int pop( ) throws DataStructureException
 {
  try
  {
    return( sa.pop( ) );
  }
  catch ( DataStructureException dse )
  {
    throw new DataStructureException( dse.getMessage( ) );
  }
 }

 public void draw( GraphicsContext gc )
 {
  Font largeFont = new Font( Dimensions.LARGE_FONT_SIZE );
  gc.setFont( largeFont );

  // clear the stack drawing
  gc.clearRect( 0, 0, Dimensions.APP_WIDTH, Dimensions.APP_HEIGHT );
 
  // draw the empty stack and indices
  gc.setStroke( Color.NAVY );
  drawEmptyStack( gc );

  // draw the stack contents
  gc.setStroke( Color.RED );
  drawStackContents( gc );

  // draw top
  gc.setStroke( Color.BLACK );
  drawTop( gc );
  drawDescription( gc );
 }

 public void drawEmptyStack( GraphicsContext gc )
 {
  for ( int i = 0; i < StackArray.CAPACITY; i++ )
  {
   gc.strokeRect( XSTART, YSTART - i * HEIGHT, WIDTH, HEIGHT );
   gc.setFill( Color.NAVY );
   gc.fillText( "" + i,
        XSTART - WIDTH / 4, (int) ( YSTART - ( i - 0.7 ) * HEIGHT ) );
  }
 }

 public void drawStackContents( GraphicsContext gc )
 {
  int i = 0;
  gc.setStroke( Color.BLACK );
  gc.setFill( Color.BLACK );
  for ( i = 0; i <= sa.getTop( ); i++ )
  {
   gc.fillText( "" + sa.get( i ),
        XSTART + WIDTH / 2 - 5, (int) ( YSTART - ( i - 0.7 ) * HEIGHT ) );
  }
  gc.setStroke( Color.RED );
  gc.setFill( Color.RED );
  for ( i = sa.getTop( ) + 1; i < StackArray.CAPACITY; i++ )
  {
   gc.fillText( "" + sa.get( i ),
        XSTART + WIDTH / 2 - 5, (int) ( YSTART - ( i - 0.7 ) * HEIGHT ) );
  }
 }

 public void drawTop( GraphicsContext gc )
 {
  gc.setFill( Color.BLACK );
  gc.fillText( "top",
  XSTART - WIDTH / 2, (int) ( YSTART - ( sa.getTop( ) - 0.7 ) * HEIGHT ) );
 }

 public void drawDescription( GraphicsContext gc )
 {
  gc.fillText( message, XSTART + WIDTH + 20, YSTART / 2 );
 }
}
