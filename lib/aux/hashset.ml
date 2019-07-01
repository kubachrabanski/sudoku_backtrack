type 'a t = ('a, unit) Hashtbl.t

let create = Hashtbl.create

let empty () = Hashtbl.create 0

let add t x = Hashtbl.add t x ()

let init n f =
    let set = create n in
    for i = 0 to n - 1 do
        add set (f i)
    done; set

let remove = Hashtbl.remove

let length = Hashtbl.length

let mem = Hashtbl.mem

let iter f = Hashtbl.iter (fun x _ -> f x)

