//naive implementation, use memoization and dynamic programming to optimize it for large strings
import gleam/list
import gleam/string
import gleam/int
import gleam/io
import gleam/order

pub fn levenshtein(a: String, b: String) -> Int {
  levenshtein_helper(
    string.to_graphemes(a),
    string.to_graphemes(b),
    list.length(string.to_graphemes(a)),
    list.length(string.to_graphemes(b))
  )
}

fn min3 (x: Int, y: Int, z: Int) -> Int{
    int.min(int.min(x,y),z)
}

fn levenshtein_helper(a: List(String), b: List(String), len_a: Int, len_b: Int) -> Int {
  case a, b {
    [], [] -> 0
    [], _  -> len_b
    _, [] -> len_a
    [a_head,..a_tail], [b_head,..b_tail] -> min3(
        levenshtein_helper(a_tail, [b_head , ..b_tail], len_a - 1, len_b) + 1,
        levenshtein_helper([a_head,..a_tail], b_tail, len_a, len_b - 1) + 1,
        case a_head,b_head{
            a_head,b_head if a_head==b_head->levenshtein_helper(a_tail, b_tail, len_a - 1, len_b - 1)
            _,_->levenshtein_helper(a_tail, b_tail, len_a - 1, len_b - 1)+1}
        )
    }
}

pub fn nearest_str_with_lv_dist(req:String,list_str:List(String))->String
{
    let l = list.map(list_str,fn(x:String){#(levenshtein(req,x),x)})
    let sorted_l = list.sort(l,by:fn(x,y){case x.0<y.0
                                  {True->order.Lt
                                  False->order.Gt}})
    case list.first(sorted_l){
        Ok(a)->a.1
        _->""
    }
}

pub fn list_str_with_lv_distance(req:String,_len_list:Int,list_str:List(String))->List(String)
{
    let l = list.map(list_str,fn(x:String){#(levenshtein(req,x),x)})
    let sorted_l = list.sort(l,by:fn(x,y){case x.0<y.0
                                  {True->order.Lt
                                  False->order.Gt}})
    case list.first(sorted_l){
        Ok(a)->[a.1]
        _->[""]
    }
}

// Example usage
pub fn main() {
  let distance = levenshtein("kitten", "sitting")
  io.println(int.to_string(distance))
  let l: List(String) = ["Moby Dick","moby kich","feyman","wolle soyinka","philippe Simo","Moi, moche et méchant"]
  echo list_str_with_lv_distance("kick",3,l)

}
