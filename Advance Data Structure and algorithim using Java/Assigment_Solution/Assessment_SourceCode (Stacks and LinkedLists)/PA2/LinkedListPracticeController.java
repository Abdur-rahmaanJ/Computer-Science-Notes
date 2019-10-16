/** LinkedListPracticeController
*   Anderson, Franceschi
*/
import java.util.Random;

import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.geometry.*;
import javafx.scene.*;
import javafx.scene.canvas.Canvas;
import javafx.scene.canvas.GraphicsContext;
import javafx.scene.control.*;
import javafx.scene.layout.*;
import javafx.scene.paint.*; 
import javafx.scene.control.ScrollPane.ScrollBarPolicy;
import javafx.beans.value.*;
import javafx.stage.Stage;

import javafx.animation.AnimationTimer;

public class LinkedListPracticeController 
{
 public final int SIZE = 15;

 LinkedList list;
 LinkedListDrawing drawing;
  
 private int key;
  
 @FXML private BorderPane bp;
 @FXML private HBox hBox1;
 @FXML private VBox vBox1;
  
 @FXML private TextField value; 
 @FXML private Button insert;
 @FXML private Button delete;
 @FXML private Button traverse;
 @FXML private Button count;
 @FXML private Button clear;
 @FXML private TextArea comments;
 String commentsText = "";
 
 private int activity; // 0=fill; 1=print; 2=set; 3=count; 4=find

 private Pane pane;
 private ScrollPane scrollPane;
 private Canvas canvas; 
 private GraphicsContext gc;
 private ScrollBar scrollBar;

 private int offset;
 private boolean started;

 public void initialize( )
 { 
   list = new LinkedList( ); 
   drawing = new LinkedListDrawing( list );    
       
   pane = new Pane( );
   bp.setCenter( pane );
   pane.setStyle( "-fx-background-color:#FFFFDD" );
   canvas = new Canvas( Dimensions.APP_WIDTH, 
                        Dimensions.APP_HEIGHT );
   gc = canvas.getGraphicsContext2D( );
   
   scrollBar = new ScrollBar( );
   scrollBar.valueProperty( ).addListener( new ChangeListener<Number>( ) {
            public void changed( ObservableValue<? extends Number> ov,
                Number oldVal, Number newVal ) { 
                int lengthOfList = ( int ) ( ( list.count( ) + 1.5 ) * drawing.nodeLength( ) ); 
                int threshold = Dimensions.APP_WIDTH / drawing.nodeLength( );
                if ( list.count( ) < threshold )
                  offset = 0;
                else
                  offset = ( int ) ( ( lengthOfList - Dimensions.APP_WIDTH ) * ( double ) newVal.intValue( ) / 100 );
                draw( gc );
            }
        });  
 }
 
 public void draw( GraphicsContext gc )
 {
   gc.clearRect( 0, 0, canvas.getWidth( ), canvas.getHeight( ) );
   drawing.drawListScrolled( gc, offset );
 }

 @FXML protected void activity( ActionEvent event ) 
 {
   if ( !started )
   { 
     pane.getChildren( ).addAll( canvas, scrollBar );
     
     Scene scene = bp.getScene( );
     int width = ( int ) scene.getWidth( );
     
     scrollBar.setPrefWidth( width - vBox1.getWidth( ) );
     started = true;
   }
   
   disableButtons( true );
   if ( event.getSource( ) == insert )
   {
     activity = 0;
     // insert data
     insert( );
   }
   else if ( event.getSource( ) == delete )
   {
     activity = 1;
     // delete data
     delete( );
   } 
   else if ( event.getSource( ) == traverse )
   {
     activity = 2;
     // traverse
     traverse( );
   }
   else if ( event.getSource( ) == count )
   {
     activity = 3;
     // compute count
     count( );
   } 
   else if ( event.getSource( ) == clear )
   {
     activity = 4;
     // clear list
     clear( );
     // display list
   }
   comments.appendText( "" );
   disableButtons( false );
 }

 public void disableButtons( boolean state )
 {
   insert.setDisable( state );
   delete.setDisable( state );
   traverse.setDisable( state );
   count.setDisable( state );
   clear.setDisable( state );
 }
 
 public void insert( )
 {
   try
   {
     int i = Integer.parseInt( value.getText( ) );
     if ( i < 0 || i > 9999 )
        throw new Exception( );
     commentsText += "inserting " + i + "\n";
     comments.setText( commentsText );
     list.insert(i);      
     drawing.drawListScrolled( gc, offset );
   }
   catch ( Exception e )
   {
     commentsText += "invalid value\n";
     comments.setText( commentsText );
   }
 }
 // end of insert method

 public void delete( )
 {
   try
   {
     int i = Integer.parseInt( value.getText( ) );
     commentsText += "deleting " + i + "\n";
     comments.setText( commentsText );
     if ( ! list.delete(i) ) {
        commentsText += i + " not found\n";
        comments.setText( commentsText );
     }
        
     drawing.drawListScrolled( gc, offset );
   }
   catch ( Exception e )
   {
     commentsText += "invalid value\n";
     comments.setText( commentsText );
   }
 }
 
 public void traverse( )
 {
   commentsText += list.toString( ) + "\n";
   comments.setText( commentsText );
 }

 public void clear( )
 {
   list.clear( );
   commentsText += "clearing the list\n";
   comments.setText( commentsText );
   drawing.drawListScrolled( gc, offset );
 }
 
 public void count( )
 {
   int count = list.count( );
   commentsText += "# of elements in list: " + count + "\n";
   comments.setText( commentsText );
 }    
}