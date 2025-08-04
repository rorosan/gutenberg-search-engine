// IMPORTS ---------------------------------------------------------------------
import gleam/string
//import gleam/dict
import lustre
import lustre/attribute
import lustre/element.{type Element}
import lustre/element/html
import lustre/event
import index
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
        False -> model
      }
  }
}

// VIEW ------------------------------------------------------------------------
fn view(model: Model) -> Element(Msg) {
    let index_list_str : List(String) =["(3890)", "a", "stranger,", "(3177)", "dick;", "p.", "(3997)", "molière", "works", "emma", "whale", "and", "other", "forster", "gulliver's", "william", "room", "(3443)", "mary", "april", "melville", "several", "complete", "wodehouse", "the", "frankenstein;", "remote", "elizabeth", "mark", "jeeves", "twain", "arnim", "jonathan", "jane", "(3935)", "mysterious", "(4931)", "(3608)", "enchanted", "swift", "by", "von", "proposal", "wollstonecraft", "g.", "of", "view", "herman", "shakespeare", "world", "austen", "(3388)", "(3641)", "m.", "modern", "with", "(3279)", "imaginary", "prometheus", "ho,", "stories", "moby", "regions", "e.", "(3640)", "travels", "shelley", "invalid", "right", "or,", "modest", "into"]
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
      //html.text(string.join(levenshtein.nearest_string_with_levenshtein_distance(model,index_list_str),with:"\n")),
      html.text("ici"),
      html.text("!"),
    ])
  ])
}
