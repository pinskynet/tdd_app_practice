mixin DataMapper<M, E> {
  E toEntity();
  M fromEntity(E entity) => throw UnimplementedError();
}
