//The goal here is to create the inverted index for the search engine
// The principle : get all the links in a page and for each word, attribute them
// to a link

import gleam/dict
import gleam/list
//import gleam/set
import gleam/string

// type Book {
//     name(String)
//     url(String)
// }
//This is a simple function to get started. Next option : levenstein distance
pub fn simple_nearest_string(
  str: String,
  list_str: List(String),
) -> List(String) {
  case list_str {
    [] -> []
    [a] ->
      case string.contains(does: a, contain: str) {
        True -> [a]
        False -> []
      }
    [a, ..rest] ->
      list.flatten([
        simple_nearest_string(str, [a]),
        simple_nearest_string(str, rest),
      ])
  }
}


pub fn create_inverted_index(
  links: List(String),
) -> dict.Dict(String, List(String)) {
    let l_links = list.map(links,fn(x){string.lowercase(x)}) //l_links = lowercase_links
  case l_links {
    [] -> dict.from_list([#("", [""])])
    [a] ->
      dict.from_list(list.map(string.split(a, on: " "), fn(x) { #(x, [a]) }))
    [b, ..rest] ->
      dict.combine(create_inverted_index([b]),create_inverted_index(rest),fn(v,vv){list.append(v,vv)})
  }
}

pub fn main() {
   let list_book_names = [
        "A Room with a View by E. M. Forster (4931)",
        "The Moby Dick; Or, The Whale by Herman Melville (3997)",
        "Gulliver's Travels into Several Remote Regions of the World by Jonathan Swift (3935)",
        "Emma by Jane Austen (3890)",
        "The Complete Works of William Shakespeare by William Shakespeare (3641)",
        "Frankenstein; Or, The Modern Prometheus by Mary Wollstonecraft Shelley (3640)",
        "A Modest Proposal by Jonathan Swift (3608)",
        "The Mysterious Stranger, and Other Stories by Mark Twain (3443)",
        "Right Ho, Jeeves by P. G. Wodehouse (3388)",
        "A The Enchanted April by Elizabeth Von Arnim (3279)",
        "The Imaginary Invalid by Molière (3177)"
    ]
  let index_list_str = create_inverted_index(list_book_names)
  echo res |> dict.keys
  let index_list_str =
}
