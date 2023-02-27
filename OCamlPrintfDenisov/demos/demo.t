  $ cat << EOF | ./demo.exe -
  > let id = fun x -> x
  > let ignore = printf
  > ;;
  > EOF
  val id : ('1 -> '1) = <fun>
  val ignore : ('3 format -> '3) = <fun>

  $ cat << EOF | ./demo.exe -
  > let ignore = printf "%b\n" true
  > ;;
  > EOF
  true
  val ignore : unit = ()

  $ cat << EOF | ./demo.exe -
  > let ignore = printf "%b\n" "text"
  > ;;
  > EOF
  Error: unification failed on bool and string

  $ cat << EOF | ./demo.exe -
  > let ignore = printf "abc\n"
  > ;;
  > EOF
  abc
  val ignore : unit = ()

  $ cat << EOF | ./demo.exe -
  > let ignore = printf "%d\n" 1 
  > ;;
  > EOF
  1
  val ignore : unit = ()

  $ cat << EOF | ./demo.exe -
  > let ignore = printf "%d %d\n" 42 
  > ;;
  > EOF
  val ignore : (int -> unit) = <fun>

  $ cat << EOF | ./demo.exe -
  > let myprintf = printf
  > let ignore = myprintf "%d\n" 2
  > ;;
  > EOF
  2
  val myprintf : ('1 format -> '1) = <fun>
  val ignore : unit = ()

  $ cat << EOF | ./demo.exe -
  > let rec print_list = fun print_elm -> fun l ->
  > match l with
  > | [] -> ()
  > | hd :: tl -> printf "%a; %a" print_elm hd (print_list print_elm) tl
  > let ignore = printf "[%a]\n" (print_list (printf "%d")) (1 :: 19 :: -4 :: [])
  > ;;
  > EOF
  [1; 19; -4; ]
  val print_list : (('4 -> unit) -> ('4 list -> unit)) = <fun>
  val ignore : unit = ()

  $ cat << EOF | ./demo.exe -
  > let rec print_list = fun print_elm -> fun l ->
  > match l with
  > | [] -> ()
  > | hd :: tl -> printf "%a; %a" print_elm hd (print_list print_elm) tl
  > let ignore = printf "[%a]\n" (print_list (printf "%d")) (false :: true :: [])
  > ;;
  > EOF
  Error: unification failed on int and bool

  $ cat << EOF | ./demo.exe -
  > let rec map = fun f -> fun l -> match l with 
  > | [] -> []
  > | a::l -> let r = f a in r :: map f l
  > let n = 5 :: 7 :: 9:: []
  > let sq = fun x -> x * x
  > let sqs = map sq n
  > ;;
  > EOF
  val map : (('4 -> '8) -> ('4 list -> '8 list)) = <fun>
  val n : int list = [5; 7; 9]
  val sq : (int -> int) = <fun>
  val sqs : int list = [25; 49; 81]

  $ cat << EOF | ./demo.exe -
  > let rec fix = fun f -> fun eta -> f (fix f) eta
  > let fact =
  > fix (fun fact -> fun n ->
  >  match n with
  >  | 0 -> 1
  >  | m -> m * fact (n - 1))
  > let fact5 = fact 5
  > ;;
  > EOF
  val fix : ((('2 -> '5) -> ('2 -> '5)) -> ('2 -> '5)) = <fun>
  val fact : (int -> int) = <fun>
  val fact5 : int = 120
