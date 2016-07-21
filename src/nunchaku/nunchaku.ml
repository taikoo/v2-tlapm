open Tla_pb
open Tla_simple_pb
open Nun_pb
open Nun_pb_fmt
open Nun_sexp
open Nun_mod
       
type nunchaku_result = nun_mod
let nunchaku_result_printer = nun_mod_to_string

let call_nunchaku nun_pb_ast =
  let nun_file = "tmp.nun" in
  let sexp_file = "tmp.sexp" in
  let oc = open_out nun_file in
  let fft = Format.formatter_of_out_channel oc in
  print_statement_list fft nun_pb_ast;
  let call = "nunchaku -o sexp "^nun_file^" > "^sexp_file in
  ignore(Sys.command call);
  sexp_parser sexp_file

              
let nunchaku settings obligation =
  let tla_pb_ast = obligation in
  let tla_simple_pb_ast = tla_pb_to_tla_simple_pb tla_pb_ast in
  let nun_pb_ast = simple_obl_to_nun_ast tla_simple_pb_ast in
  let nun_sexp_ast = call_nunchaku nun_pb_ast in
  let nun_mod_ast = nun_sexp_to_nun_mod nun_sexp_ast in
  nun_mod_ast

    

(* let print_nunchaku obligations output_file = *)
(*   (\*val: obligation list -> unit*\) *)
(*   let print_obl out no obl = *)
(*     let oc = open_out (output_file ^ "/" ^ (string_of_int no) ^ ".nun") in *)
(*     let fft = formatter_of_out_channel oc in *)
(*     fprintf fft "%a" Simple_obligation_formatter.fmt_nunchaku (Simple_obligation.obligation_to_simple_obligation obl); *)
(*     fprintf fft "@.%!"; *)
(*     close_out oc; *)
(*     no+1 *)
(*   in *)
(*   let for_each_obligation = print_obl output_file in *)
(*   List.fold_left for_each_obligation 1 obligations *)
