String truncateString(String data) {
  return (data.length >= 120) ? '${data.substring(0, 120)}...' : data;
}
