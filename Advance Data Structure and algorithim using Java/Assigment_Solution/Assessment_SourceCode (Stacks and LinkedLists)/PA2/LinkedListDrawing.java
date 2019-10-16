/* LinkedListDrawing
*  Anderson, Franceschi
*/

import javafx.scene.canvas.GraphicsContext;
import javafx.scene.paint.Color;
import javafx.scene.text.Font;
import java.util.ArrayList;

public class LinkedListDrawing
{
  private LinkedList list;
  private int xStart = 10;
  private int yStart =  50;
  private int height = 60;
  private int width1 = 80;
  private int width2 = 100;
  private int arrow = 2 * ( width2 - width1 );

  /**
   *  Default constructor   *
   **/
  public LinkedListDrawing( LinkedList list  )
  {
    this.list = list;
  } 
  
  /**
   *  @return int returns the length of a node when drawn
   **/
  public int nodeLength( )
  {
     return ( width1 + width2 ) / 2 + arrow;
  }
    
  /**
   *  Draws the whole list
   **/
  public void drawList( GraphicsContext gc )
  {
    gc.clearRect( 0, 0, Dimensions.APP_WIDTH, Dimensions.APP_HEIGHT );
  
    int x = xStart;
    int y = yStart;
    int i = 0;
    ArrayList<Integer> duplicateList = list.toArrayList( );
    for ( int value : duplicateList )
    {
      drawNode( gc, value, x, y );
      i++;
      x = x + ( width1 + width2 ) / 2 + arrow;
    }
    x = x + ( width2 - width1 ) / 2;
    if ( i > 0 )
      drawNull( gc, x, y );
  } // end drawList
    
  /**
   *  Draws the whole list
   **/
  public void drawListScrolled( GraphicsContext gc, int scrolled )
  {
    gc.clearRect( 0, 0, Dimensions.APP_WIDTH, Dimensions.APP_HEIGHT );
  
    int x = xStart - scrolled;
    int y = yStart;
    int i = 0;
    ArrayList<Integer> duplicateList = list.toArrayList( );
    for ( int value : duplicateList )
    {
      drawNode( gc, value, x, y );
      i++;
      x = x + ( width1 + width2 ) / 2 + arrow;
    }
    x = x + ( width2 - width1 ) / 2;
    if ( i > 0 )
      drawNull( gc, x, y );
  } // end drawList

  /** draw the node at current x,y coord **/
  public void drawNode( GraphicsContext gc, int value, int x, int y )
  {
      // draw the node representation
      gc.setStroke( Color.BLACK );
      gc.strokeRect( x, y, width1, height ); // main rectangle
      gc.strokeRect( x, y, width2, height );
      gc.strokeLine( x + ( width1 + width2 ) / 2, y + height / 2, 
                     x + ( width1 + width2 ) / 2 + arrow, y + height / 2 );  // arrow
      gc.strokeLine( x + ( width1 + width2 ) / 2 + arrow, y + height / 2, 
                     x + ( width1 + width2 ) / 2 + arrow - ( width2 - width1 ) / 2, y + height / 2 - height / 5 );  // arrow
      gc.strokeLine( x + ( width1 + width2 ) / 2 + arrow, y + height / 2, 
                     x + ( width1 + width2 ) / 2 + arrow - ( width2 - width1 ) / 2, y + height / 2 + height / 5 );  // arrow

      int fontSize = 24;
      Font font = new Font( "Courier New", fontSize );
      String str = "" + value;
      
      gc.setFont( font );
      gc.setFill( Color.BLUE );
      gc.fillText( str, x + width1 / 3 - width1 / 6, y + height / 2  + height / 10 ); // data as a string

  } // end draw

 /** draw NULL at current x,y coord **/
 public void drawNull( GraphicsContext gc, int x, int y )
 {
      // draw the node representation
      int fontSize = 24;
      Font font = new Font( "Courier New", fontSize );
      gc.setFont( font );
      gc.setFill( Color.BLUE );
      gc.fillText( "NULL", x, y + height / 2  + height / 10 );
 }
  
} // end LinkedListDrawing