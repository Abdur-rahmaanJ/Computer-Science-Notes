package mapsql.util;

public interface Vector<E> extends Iterable<E> {
	public int size();
	public boolean isEmpty();
	public E elemAtRank(int rank);
	public E replaceAtRank(int rank, E element);
	public void insertAtRank(int rank, E element);
	public E removeAtRank(int rank);
}
