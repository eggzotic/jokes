enum Flag {
  nsfw('NSFW'),
  religious('Religious'),
  political('Political'),
  racist('Racist'),
  sexist('Sexist'),
  explicit('Explicit');

  const Flag(this.label);
  final String label;
}
