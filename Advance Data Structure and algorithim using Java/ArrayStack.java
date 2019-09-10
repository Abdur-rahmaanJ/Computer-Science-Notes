
public class ArrayStack {
	private Object[] array = null;
	private int top = 0;
	
	public ArrayStack() {
		this(20);
	}
	
	public ArrayStack(int capacity) {
		array = new Object[capacity];
	}
	
	public int size() {
		return top;
	}
	
	public boolean isEmpty() {
		return top == 0;
	}
	
	public void push(Object value) {
		if (top == array.length) throw new StackFullException();
		array[top++] = value;
	}
	
	public Object top() {
		if (top == 0) throw new StackEmptyException(); 
		return array[top-1];
	}

	public Object pop() {
		if (top == 0) throw new StackEmptyException();
		
		Object temp = array[--top];
		array[top] = null;
		return temp;
	}
	
	public String toString() {
		String out = "[" + top + " / " + array.length + "]";
		for (int i=0;i<array.length; i++) {
			out += " " + array[i];
		}
		return out;
	}
	
	public static void main(String[] args) {
		ArrayStack stack = new ArrayStack();
		
		stack.push("rem");
		stack.push(2l);
		System.out.println(stack);

		stack.pop();
		System.out.println(stack);
		
		stack.push(4l);
		System.out.println(stack);

		stack.push(3l);
		System.out.println(stack);

		stack.pop();
		System.out.println(stack);
		
		stack.push(6l);
		System.out.println(stack);

		stack.push(12l);
		System.out.println(stack);

		stack.pop();
		System.out.println(stack);
		
		stack.push(5l);
		System.out.println(stack);

		stack.push(9l);
		System.out.println(stack);

		stack.pop();
		System.out.println(stack);

		stack.push(3l);
		System.out.println(stack);
		
		long total = 0;
		int count = 0;
		while (!stack.isEmpty()) {
			total += (Long) stack.pop();
			count++;
		}
		System.out.println("average: " + (total/count));
	}
}
