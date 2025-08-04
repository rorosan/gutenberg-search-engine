//import gleam/dict
import gleam/list

//import gleam/set
import gleam/string

fn select_closest_string(req: String, ind: List(String)) -> List(String) {
  list.filter(ind, fn(x) { string.contains(does: req, contain: x) })
}

pub fn main() {
  let distance =
    select_closest_string("sasolati", ["solution", "silu", "sale", "sasol"])
  echo distance
}
