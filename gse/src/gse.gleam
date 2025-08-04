// IMPORTS ---------------------------------------------------------------------
import gleam/string
//import gleam/dict
import lustre
import lustre/attribute
import lustre/element.{type Element}
import lustre/element/html
import lustre/event
import index
import gse_search
import levenshtein

// MAIN ------------------------------------------------------------------------

pub fn main() {
  let app = lustre.simple(init, update, view)
  let assert Ok(_) = lustre.start(app, "#app", Nil)

  Nil
}

// MODEL -----------------------------------------------------------------------

/// The `Model` is the state of our entire application.
///
type Model =
  String

fn init(_) -> Model {
  ""
}


// UPDATE ----------------------------------------------------------------------

type Msg {
  UserUpdatedName(String)
}

fn update(model: Model, msg: Msg) -> Model {
  case msg {
    UserUpdatedName(name) ->
      case string.length(name) <= 50 {
        True -> name
        False -> autocomplete(model,index_list_str)
      }
  }
}

// VIEW ------------------------------------------------------------------------
fn view(model: Model) -> Element(Msg) {
  html.div([attribute.class("p-32 mx-auto w-full max-w-2xl space-y-4")], [
    html.label([attribute.class("flex gap-2")], [
      html.span([], [html.text("Rechercher un bouquin : ")]),
      html.input([
        attribute.value(model),
        event.on_input(UserUpdatedName),
        attribute.class("border border-slate-400 px-1 rounded"),
        attribute.class("focus:outline-none focus:border-blue-500"),
      ]),
    ]),
    html.p([], [
      html.text("Hello there, "),
      html.text(string.join(index.nearest_string_with_levenshtein_distance(model,index_list_str),with:"\n")),
      html.text("!"),
    ])
  ])
}
