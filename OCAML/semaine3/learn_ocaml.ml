let rec cpt (xs : 'a list) : int = 
  match xs with 
  |x :: xs' -> (cpt xs') + 1
  |_ -> 0

let len_eq_3 (xs : 'a list) : bool = 
  cpt xs = 3
  
let len_ge_3 (xs : 'a list) : bool = 
  cpt xs >= 3
  
let len_lt_3 (xs : 'a list) : bool = 
  cpt xs < 3

let len_comp_3 (xs : 'a list) : int =
  if (cpt xs > 3) then 1
  else if (cpt xs = 3) then 0
  else (-1)

let snd (xs:'a list) : 'a =
  match xs with
  | a:: b :: l -> b
  | _ -> raise Not_found
    
let swap_hd_snd (xs:'a list) : 'a list =
  match xs with
  | a:: b :: l -> b :: a :: l
  | _ -> xs
    
let hd_0 (xs:int list) : bool =
  match xs with
  | 0 :: l -> true
  | _ -> false
    
let eq_hd (x0:'a) (xs:'a list) : bool =
  match xs with
  | [] -> false
  | (a :: l) -> (a = x0) 

let hd_fst (xs:('a*'b) list) : 'a =
  match xs with 
  |[] -> raise Not_found
  |(a,b) :: l -> a
    
let rec swap_hd_fst (xs:('a*'a) list) : ('a*'a) list =
  match xs with
  |[] -> [] 
  |(a,b) :: xs -> (b, a) :: xs
    
let hd_hd (xs:('a list) list) : 'a =
  match xs with 
  |[] -> raise Not_found
  |it :: l -> 
      match it with
      |[] -> raise Not_found
      |itt :: ll -> itt 
      
    
let rec rem_hd_hd (xs:('a list) list) : ('a list) list =
  match xs with 
  |[] -> []
  |it :: l -> 
      match it with
      |[] -> [] :: l
      |itt :: ll -> ll :: l

(* Q1 *)
let rec repeat (n:int) (x:'a) : 'a list  = 
  if(n <= 0) then []  
  else x :: (repeat (n - 1) x)


(* Q2 *)
let rec range_i (i:int) (j:int) : (int list) =
  if(i>j) then []
  else i :: (range_i (i+1) j)

(* Q3 *)
let rec range_n (x:int) (n:int) : (int list) =
  if(n<=0) then []
  else (range_n x (n-1)) @[x+n-1]

  (* list_scheme_red *)

  let rec prod (xs:float list) : float =
    match xs with
    |[] -> 1.0 
    |x :: l -> x *. prod l
  
  let rec sum_round (xs:float list) : int =
    match xs with
    |[] -> 0
    |x :: l -> (int_of_float x) + sum_round l
  
  let rec parenthese (xs:string list) : string =
    match xs with
    |[] -> ""
    |x :: l -> "("^x^")"^(parenthese l)
                         
  let rec flatten (xss:('a list) list) : 'a list =
    match xss with
    |[] -> []
    |xs :: l -> xs @ flatten l
  
  let rec sum_tuple (cs:(int*int) list) : int =
    match cs with
    |[] -> 0
    |(x, y) :: l -> x + y + sum_tuple l
  
  let rec reduce (f:'a -> 'b -> 'b) (xs:'a list) (b:'b) : 'b =
    match xs with
    |[] -> b
    |x :: l -> f x (reduce f l b)

  (* merge_sort *)
  (* Q1 *)
let rec merge (xs:'a list) (ys:'a list) : 'a list =
  match (xs, ys) with
  |([], yss) -> yss
  |(xss, []) -> xss
  |(x :: xss, y :: yss) -> if(x < y) 
      then x :: merge xss ys
      else y :: merge xs yss

(* Q2 *)
let rec split (xs:'a list) : ('a list * 'a list) =
  match xs with
  |[] -> [], []
  |[x] -> ([x],[])
  |x :: y :: xss-> let (a, b) = split xss 
      in x :: a, y :: b

(* Q3 *)
let rec merge_sort (xs:'a list) : 'a list =
  match xs with 
  |[] -> []
  |[a] -> [a]
  |_ -> let la, lb = split xs in
      merge (merge_sort la) (merge_sort lb)
(* Q4 *)
let rec merge_gen (cmp:'a -> 'a -> bool) (xs:'a list) (ys:'a list) : 'a list =
  match (xs, ys) with
  |([], yss) -> yss
  |(xss, []) -> xss
  |(x :: xss, y :: yss) -> if(cmp x y) 
      then x :: merge_gen cmp xss ys
      else y :: merge_gen cmp xs yss
  
(* Q5 *)
let rec merge_sort_gen (cmp:'a -> 'a -> bool) (xs:'a list) : 'a list =
  match xs with 
  |[] -> []
  |a :: l -> merge_gen cmp [a] (merge_sort_gen cmp l)

(* Q6 *)

let sort (xs:(int*int) list) : (int*int) list =
  let cmp = fun (a, b) (c, d) -> (a+b < c+d) in
  match xs with 
  |[] -> []
  |[a] -> [a]
  |_ -> let la, lb = split xs in
      merge_gen cmp (merge_sort_gen cmp la) (merge_sort_gen cmp lb)