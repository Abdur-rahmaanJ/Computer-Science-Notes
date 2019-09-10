package mapsql.util;

import java.util.Arrays;
import java.util.Iterator;

public class ArrayVector<E> implements Vector<E> {
	private E[] array;
	private int size;
	
	@SuppressWarnings("unchecked")
	public ArrayVector() {
		size = 0;
		array = (E[]) new Object[1];
	}
	
	@Override
	public int size() {
		return size;
	}

	@Override
	public boolean isEmpty() {
		return size == 0;
	}

	@Override
	public E elemAtRank(int rank) {
		if (rank < 0 || rank >= size) throw new RankOutOfBoundsException();
		
		return array[rank];
	}

	@Override
	public E replaceAtRank(int rank, E element) {
		if (rank < 0 || rank >= size) throw new RankOutOfBoundsException();

		E temp = array[rank];
		array[rank] = element;
		return temp;
	}

	@Override
	public void insertAtRank(int rank, E element) {
		if (rank < 0 || rank > size) throw new RankOutOfBoundsException();
		
		if (size == array.length) {
			array = Arrays.copyOf(array, array.length*2);
		}
		
		for (int i=size; i > rank; i--) {
			array[i] = array[i-1];
		}

		array[rank] = element;
		size++;
	}

	@Override
	public E removeAtRank(int rank) {
		if (rank < 0 || rank >= size) throw new RankOutOfBoundsException();

		E temp = array[rank];
		for (int i=rank; i < size; i++) { 
			array[i] = array[i+1];
		}
		
		size--;
		return temp;
	}

	@Override
	public String toString() {
		String output = "";
		for (int i=0; i < array.length; i++) {
			output += array[i] + " ";
		}
		return output;
	}

	@Override
	public Iterator<E> iterator() {
		return new Iterator<E>() {
			private int rank = 0;
			
			@Override
			public boolean hasNext() {
				return rank < size();
			}

			@Override
			public E next() {
				return elemAtRank(rank++);
			}

			@Override
			public void remove() {
				// TODO Auto-generated method stub
			}
		};
	}
}
