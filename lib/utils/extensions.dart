String truncateString(String data) {
  return (data.length >= 95) ? '${data.substring(0, 100)}...' : data;
}
