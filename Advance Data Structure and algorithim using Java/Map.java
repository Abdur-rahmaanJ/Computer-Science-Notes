public interface Map<K, V> {
	public int size();

	public boolean isEmpty();

	public V get(K k);

	public V put(K k, V v);

	public V remove(K k);

	public Iterator<K> keys();

	public Iterator<V> values();

	public Iterator<Entry<K, V>> entries();
}
