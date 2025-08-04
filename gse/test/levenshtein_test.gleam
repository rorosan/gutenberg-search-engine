import gleam/test

pub fn test_levenshtein() {
  test.equal(levenshtein("kitten", "sitting"), 3)
  test.equal(levenshtein("flaw", "lawn"), 2)
  test.equal(levenshtein("gumbo", "gambol"), 2)
  test.equal(levenshtein("book", "back"), 2)
  test.equal(levenshtein("", "abc"), 3)
  test.equal(levenshtein("abc", ""), 3)
  test.equal(levenshtein("abc", "abc"), 0)
}
