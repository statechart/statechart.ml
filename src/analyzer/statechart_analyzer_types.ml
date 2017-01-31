module rec TYPES:
  sig
    type expr = Expr of string | ExprValue of string | ExprUnset
    type document_binding =
      [
        | `early
        | `late
      ]
    type history_type =
      [
        | `shallow
        | `deep
      ]
    type transition_type =
      [
        | `external_
        | `internal
      ]
    (* Core *)
    type document = Document.t
    type state = State.t
    type parallel = Parallel.t
    type transition = Transition.t
    type initial = Initial.t
    type final = Final.t
    type on_entry = OnEntry.t
    type on_exit = OnExit.t
    type history = History.t
    (* Executable *)
    type raise = Raise.t
    type case = Case.t
    type case_clause = CaseClause.t
    type foreach = Foreach.t
    type log = Log.t
    (* Data Model *)
    type data_model = DataModel.t
    type data = Data.t
    type assign = Assign.t
    type done_data = DoneData.t
    type content = Content.t
    type param = Param.t
    type script = Script.t
    (* External *)
    type send = Send.t
    type cancel = Cancel.t
    type invoke = Invoke.t
    type finalize = Finalize.t

    type statechart_el =
      | Document of document
      | State of state
      | Parallel of parallel
      | Transition of transition
      | Initial of initial
      | Final of final
      | OnEntry of on_entry
      | OnExit of on_exit
      | History of history

      | Raise of raise
      | Case of case
      | CaseClause of case_clause
      | Foreach of foreach
      | Log of log

      | DataModel of data_model
      | Data of data
      | Assign of assign
      | DoneData of done_data
      | Content of content
      | Param of param
      | Script of script

      | Send of send
      | Cancel of cancel
      | Invoke of invoke
      | Finalize of finalize
      | Other

  end = TYPES
and Document:
  sig
    type t = {
      name: string option;
      initial: string list;
      data_model: string option;
      binding: TYPES.document_binding;
      children: TYPES.statechart_el list;
    }
  end = Document
and State:
  sig
    type t = {
      id: string option;
      initial: string list;
      children: TYPES.statechart_el list;
    }
  end = State
and Parallel:
  sig
    type t = {
      id: string option;
      children: TYPES.statechart_el list;
    }
  end = Parallel
and Transition:
  sig
    type t = {
      event: string list;
      cond: string option;
      target: string list;
      t: TYPES.transition_type;
      children: TYPES.statechart_el list;
    }
  end = Transition
and Initial:
  sig
    type t = {
      children: TYPES.statechart_el list;
    }
  end = Initial
and Final:
  sig
    type t = {
      id: string option;
      children: TYPES.statechart_el list;
    }
  end = Final
and OnEntry:
  sig
    type t = {
      children: TYPES.statechart_el list;
    }
  end = OnEntry
and OnExit:
  sig
    type t = {
      children: TYPES.statechart_el list;
    }
  end = OnExit
and History:
  sig
    type t = {
      id: string option;
      children: TYPES.statechart_el list;
      t: TYPES.history_type;
    }
  end = History
and Raise:
  sig
    type t = {
      event: string option;
    }
  end = Raise
and Case:
  sig
    type t = {
      children: TYPES.case_clause list
    }
  end = Case
and CaseClause:
  sig
    type t = {
      cond: string option;
      children: TYPES.statechart_el list;
    }
  end = CaseClause
and Foreach:
  sig
    type t = {
      array: string option;
      item: string option;
      index: string option;
      children: TYPES.statechart_el list;
    }
  end = Foreach
and Log:
  sig
    type t = {
      label: string option;
      expr: string option;
    }
  end = Log
and DataModel:
  sig
    type t = {
      children: TYPES.statechart_el list;
    }
  end = DataModel
and Data:
  sig
    type t = {
      id: string option;
      src: string option;
      expr: string option;
      children: string option; (* TODO make this a more complex type *)
    }
  end = Data
and Assign:
  sig
    type t = {
      location: string option;
      expr: string option;
      children: string option; (* TODO make this a more complex type *)
    }
  end = Assign
and DoneData:
  sig
    type t = {
      children: TYPES.statechart_el list;
    }
  end = DoneData
and Content:
  sig
    type t = {
      expr: string option;
      children: string option; (* TODO make this a more complex type *)
    }
  end = Content
and Param:
  sig
    type t = {
      name: string option;
      expr: string option;
      location: string option;
    }
  end = Param
and Script:
  sig
    type t = {
      src: string option;
      children: string option;
    }
  end = Script
and Send:
  sig
    type t = {
      event: TYPES.expr;
      target: TYPES.expr;
      t: TYPES.expr;
      id: TYPES.expr;
      delay: TYPES.expr;
      namelist: string list;
      children: TYPES.statechart_el list;
    }
  end = Send
and Cancel:
  sig
    type t = {
      sendid: TYPES.expr;
    }
  end = Cancel
and Invoke:
  sig
    type t = {
      t: TYPES.expr;
      src: TYPES.expr;
      id: TYPES.expr;
      namelist: string list;
      autoforward: bool option;
      children: TYPES.statechart_el list;
    }
  end = Invoke
and Finalize:
  sig
    type t = {
      children: TYPES.statechart_el list;
    }
  end = Finalize

include TYPES
