(* Junhao Zhang "Freddie" ID# 11356533 *)

(* 1. *)
fun in_list (x,[])=false | in_list (x,(y::ys)) = if x=y then true else (in_list (x,ys))

(* 2. *)
fun intersection ([],[]) = [] | intersection ([],(x::xs)) = [] | intersection ((y::ys), []) = [] | intersection ((s::ss), (t::ts)) = if (in_list (s, (t::ts))) then s::(intersection (ss, (t::ts))) else intersection (ss, (t::ts))

(* 3. *)
fun union x [] = x | union [] y = y | union (s::ss) (t::ts) = if (in_list (s, (t::ts)))=false then s::(union ss (t::ts)) else (union ss (t::ts))

(* 4. *)
fun filter x [] = [] | filter x (z::zs) = if x(z) then z::(filter x zs) else (filter x zs)

(* 5. *)
fun groupNr a [] = [] | groupNr a b = let fun groupr x [] = [] | groupr 0 y = [] | groupr x (y::ys) = y::(groupr (x-1) ys) in let fun groupz s [] = [] | groupz s (t::ts) = if (s=0) then (t::ts) else (if (length (t::ts))<s then (t::ts) else (groupz (s-1) ts)) in if (length b)> a then (groupr a b)::(groupNr a (groupz a b)) else b::(groupNr a []) end end
fun groupNl a [] = [] | groupNl a b = let fun revv [] = [] | revv (t::ts) = (rev t)::(revv ts) in revv (rev (groupNr a (rev b))) end

(* 6. *)
fun sep [] = ([],[]) | sep [a] = ([a],[]) | sep (m::ms::mss) = let val (x,y) = (sep mss) in (m::x, ms::y) end
fun merge _ [] y = y | merge _ x [] = x | merge func (x::xs) (y::ys) = if func(x,y) then x::(merge func xs (y::ys)) else y::(merge func (x::xs) ys)
fun mergesort _ [] = [] | mergesort _ [a] = [a] | mergesort func (x::xs) = let val (a,b) = (sep (x::xs)); val a = mergesort func a; val b = mergesort func b in (merge func a b) end

(* 7. *)
datatype either = ImAString of string | ImAnInt of int
datatype eitherTree = Leaf of either | Node of either*eitherTree*eitherTree
fun eitherSearch (Leaf x) num = if (x=(ImAnInt(num))) then true else false | eitherSearch (Node (i, l,r)) num = if (i=(ImAnInt(num))) then true else if (eitherSearch l num) then true else if (eitherSearch r num) then true else false
val eitherTest = let val root = Node((ImAString "this is root"), Node((ImAString "z"), (Node ((ImAnInt 651), (Node((ImAString "e"), (Leaf(ImAnInt 10000)), (Leaf(ImAnInt 100000)))), (Leaf (ImAnInt 99)))), Node((ImAnInt 65156), (Node ((ImAnInt 69884), (Node ((ImAString "a"), (Leaf(ImAnInt 3)),(Leaf(ImAString "Nihaoma")))), Node ((ImAString "b"), (Leaf(ImAString "lol")),(Leaf(ImAString "a"))))), (Node ((ImAnInt 54), (Node ((ImAString "c"), (Leaf(ImAString ":P")), (Leaf(ImAnInt 10)))), (Node ((ImAString "d"), (Leaf(ImAnInt 100)), (Leaf(ImAnInt 1000)))))))), (Node ((ImAnInt 8949265), (Node ((ImAString "p"), (Node ((ImAString "a"), (Leaf(ImAnInt 3)),(Leaf(ImAString "Nihaoma")))), (Node ((ImAString "b"), (Leaf(ImAString "lol")),(Leaf(ImAString "a")))))), (Node((ImAnInt 6), (Node ((ImAString "b"), (Leaf(ImAString "lol")),(Leaf(ImAString "a")))), (Leaf(ImAString "hey"))))))) in (eitherSearch root 3, eitherSearch root 4) end

(* 8. *)
datatype 'a Tree = LEAF of 'a | NODE of ('a Tree) list
fun treeToString f t = let fun func (LEAF x) = [f x] | func (NODE []) = ["()"] | func (NODE y) = ["("] @ (List.concat (map func y)) @ [")"] in String.concat(func t) end

(* 9. *)
fun perms [] = [[]] | perms (x::xs) = let fun rot y [] = [[y]] | rot y (z::zs) = (y::z::zs)::(List.map(fn f => z::f) (rot y zs)) in List.concat( List.map (fn f => rot x f) (perms xs)) end