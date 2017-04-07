

sum(a, b) => a + b;
num avg(data, mapping) => data.map(mapping).reduce(sum) / data.length;

key(Map map, value) {
  for(String key in map.keys) {
    if(map[key] == value) {
      return key;
    }
  }

  return null;
}