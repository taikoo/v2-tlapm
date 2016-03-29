open Expr_visitor
open Simple_expr_ds
open Any_simple_expr

(* type 'a esacc = ESAcc of simple_expr * Expr_ds.term_db * simple_term_db * 'a *)
type esacc = simple_expr

(*	       
let get_simple (simple_expr,term_db,simple_term_db,any) = simple_expr
let get_term_db (simple_expr,term_db,simple_term_db,any) = term_db
let get_simple_term_db (simple_expr,term_db,simple_term_db,any) = simple_term_db
let get_any (simple_expr,term_db,simple_term_db,any) = any
						     	 								
let set_simple (_,term_db,simple_term_db,any) simple_expr = (simple_expr,term_db,simple_term_db,any)
let set_term_db (simple_expr,_,simple_term_db,any) term_db = (simple_expr,term_db,simple_term_db,any)
let set_simple_term_db (simple_expr,term_db,_,any) simple_term_db = (simple_expr,term_db,simple_term_db,any)
let set_any (simple_expr,term_db,simple_term_db,_) any = (simple_expr,term_db,simple_term_db,any)
 *)
	       
class expr_to_simple_expr = object(self)
  inherit [esacc] visitor as super

  (* failsafe against using this on the module / proof level *)
  method context _ _ = failwith "Can not convert full contexts!"
  method mule _ _ = failwith "Can not convert modules!"
  method entry _ _ = failwith "Can not convert entries!"

  method at acc x = failwith "Remove at first."
  method decimal acc x = E_decimal ({mantissa = x.mantissa; exponent = x.exponent}:simple_decimal)
  method label acc x = failwith "Remove first."
  method let_in acc x = failwith "Remove first."
  method numeral acc x = acc
  method op_appl acc x = acc
  method strng acc x = E_string ({value = x.value}:simple_strng)
  method binder acc x = acc
  method lambda acc x = acc

  method expr_or_op_arg acc x = acc
  method assume_prove acc x = acc
  method new_symb acc x = acc
  method op_def acc x = acc
  method user_defined_op acc x = acc

  method builtin_op acc x = acc
  method op_arg acc x = acc
  method formal_param acc x = acc
  method op_decl acc x = acc

  method expr_or_module_or_module_instance acc x = acc
                                
                         
end

