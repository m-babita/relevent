String truncateString(String data) {
  return (data.length >= 100) ? '${data.substring(0, 100)}...' : data;
}
