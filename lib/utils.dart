

sum(a, b) => a + b;
num avg(data, mapping) => data.map(mapping).reduce(sum) / data.length;