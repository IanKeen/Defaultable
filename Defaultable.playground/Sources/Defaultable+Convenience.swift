import Foundation

public typealias DefaultableArray<T> = Defaultable<[T], EmptyArray<[T]>>

public typealias DefaultableDictionary<K: Hashable, V> = Defaultable<Dictionary<K, V>, EmptyDictionary<K, V>>

public typealias DefaultableNumeric<N: Numeric> = Defaultable<N, Zero<N>>
