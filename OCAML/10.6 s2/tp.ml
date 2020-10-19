(*tp semaine 3*)
(*EX4*)
let less_divider (i: int) (n: int) : int = 
	let rec loop (a: int) (n: int) = 
		if(n mod a = 0) then a
		else loop (a+1) n
	in if ((i<2) || (n<2)) then raise(Invalid_argument "i or n can not be greater than 2 from less_divider")
	else loop i n

let prime (n: int) = 
	if ((less_divider 2 n) = n) then true
	else false

let prime_next (n: int) = 
	let rec loop (a: int) = 
		if(prime a = true) then a
		else loop (a+1)
	in loop n

let nth_prime (n: int) : int = 
	let rec loop (a: int) (p: int) = 
		if (a = 0) then p
		else loop (a-1) (prime_next (p+1))
	in loop n 2


(*EX5*)

let f (a: float) (x: float) : float = (x+.(a/.x))/.2.

let sqrt_n (n: int) (a: float) (x0: float) : float =
	let rec loop (m: int) (x: float) = 
		if (m = 0) then x
		else loop (m-1) (f a x)
	in if ((a < 0.) || (n < 0)) then raise(Invalid_argument "a or n can not be negative from sqrt_n")
	else loop n x0

let eq_eps (e: float) (x: float) (y: float) : bool = 
	if ((abs_float (x-.y)) < e) then true
	else false

let _ = assert( (eq_eps 0.0001 3. 3.1) = false)
let _ = assert( (eq_eps 0.0001 (-2.0000001) (-2.000002)) = true)

let sqrt_x (e: float) (a: float) (x0: float) : float = 
	let rec loop (x: float) = 
		if (eq_eps e x (f a x)) then (f a x)
		else (loop (f a x))
	in if (e < 0.) then raise(Invalid_argument "e can not be negative from sqrt_x")
	else loop x0