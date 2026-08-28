String toStringException(Exception exception) {
  return exception.toString().replaceFirst('Exception:', '').trim();
}
