module rec TYPES:
  sig
    type float64 = float
    type uint = int
    type float = TYPES.float64
    type binary = string
    type ref = TYPES.uint

    type expression_type = [
      | `block

      (* datatypes *)
      | `null
      | `list
      | `map
      | `bool
      | `int
      | `float
      | `string

      (* BIF *)
      | `raise
      | `case
      | `clause
      | `foreach
      | `log
      | `assign
      | `send
      | `cancel

      (* unary *)

      (* binary *)
      | `equal
      | `not_equal
    ]
    type content =
      [
        | `string of string
        | `expression of TYPES.expression
        | `document of TYPES.document
      ]
    type document_binding =
      [
        | `early
        | `late
      ]
    type state_type =
      [
        | `compound
        | `atomic
        | `parallel
        | `history_shallow
        | `history_deep
        | `initial
        | `final
      ]
    type transition_type =
      [
        | `targetless
        | `internal
        | `spontaneous
        | `history
        | `initial
      ]
    type document = Document.t
    type expression = Expression.t
    type invoke = Invoke.t
    type param = Param.t
    type state = State.t
    type transition = Transition.t
  end = TYPES
and Document:
  sig
    type t = {
      name: string option;
      states: TYPES.state list;
      transitions: TYPES.transition list;
    }
  end = Document
and Expression:
  sig
    type t = {
      t: TYPES.expression_type;
      bool_val: bool option;
      int_val: int option;
      float_val: float option;
      string_val: string option;
      args: t list;
    }
  end = Expression
and Invoke:
  sig
    type t = {
      t: TYPES.expression option;
      src: TYPES.expression option;
      id: TYPES.expression option;
      autoforward: bool;
      params: TYPES.param list;
      content: TYPES.content option;
      on_exit: TYPES.expression list;
    }
  end = Invoke
and Param:
  sig
    type t = {
      id: string;
      expression: TYPES.expression option;
    }
  end = Param
and State:
  sig
    type t = {
      t: TYPES.state_type;
      idx: TYPES.ref;
      id: string option;
      on_enter: TYPES.expression list;
      on_exit: TYPES.expression list;
      invocations: TYPES.invoke list;
      data: TYPES.expression list;
      donedata: TYPES.expression option;
      parent: TYPES.ref;
      children: TYPES.ref list;
      ancestors: TYPES.ref list;
      completion: TYPES.ref list;
      transitions: TYPES.ref list;
    }
  end = State
and Transition:
  sig
    type t = {
      t: TYPES.transition_type;
      idx: int;
      source: TYPES.ref;
      events: string list;
      condition: TYPES.expression option;
      on_transition: TYPES.expression list;
      targets: TYPES.ref list;
      conflicts: TYPES.ref list;
      exits: TYPES.ref list;
    }
  end = Transition

include TYPES

let bool_expr v =
  {
    Expression.t=`bool;
    bool_val=Some v;
    int_val=None;
    float_val=None;
    string_val=None;
    args=[];
  }

let int_expr v =
  {
    Expression.t=`int;
    bool_val=None;
    int_val=Some v;
    float_val=None;
    string_val=None;
    args=[];
  }

let float_expr v =
  {
    Expression.t=`float;
    bool_val=None;
    int_val=None;
    float_val=Some v;
    string_val=None;
    args=[];
  }

let string_expr v =
  {
    Expression.t=`string;
    bool_val=None;
    int_val=None;
    float_val=None;
    string_val=Some v;
    args=[];
  }

let complex_expr t args =
  {
    Expression.t=t;
    bool_val=None;
    int_val=None;
    float_val=None;
    string_val=None;
    args=args;
  }

let null = complex_expr `null []
