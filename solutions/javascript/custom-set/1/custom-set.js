const uniq = array => array.filter((item, i) => !array.includes(item, i + 1)); 

export class CustomSet {
  #elements;
  
  constructor(elements = []) {
    this.#elements = uniq(elements);
  }

  empty() {
    return this.#elements.length === 0;
  }

  contains(element) {
    return this.#elements.includes(element);
  }

  add(element) {
    if (!this.contains(element)) this.#elements.push(element);
    return this;
  }

  subset(superset) {
    return this.#elements.every(superset.contains.bind(superset));
  }

  disjoint(other) {
    return !this.#elements.some(other.contains.bind(other));
  }

  eql(other) {
    return this.subset(other) && other.subset(this);
  }

  union(other) {
    return new CustomSet(this.#elements.concat(other.#elements));
  }

  intersection(other) {
    return new CustomSet(this.#elements.filter(other.contains.bind(other)));
  }

  difference(other) {
    return new CustomSet(this.#elements.filter(element => !other.contains(element)));
  }
}
