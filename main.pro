domains
    genre = string
    list[T] = [] ; [T | list[T]].

class cinema(
    integer id,
    string name,
    string address,
    string phone,
    integer seats
).

class movie(
    integer id,
    string title,
    integer year,
    string director,
    string genre
).

class show(
    integer cinemaId,
    integer movieId,
    string date,
    string time,
    integer revenue
).

clauses
    cinema(1, "Cinema 1", "Address 1", "Phone 1", 200).
    cinema(2, "Cinema 2", "Address 2", "Phone 2", 150).
    cinema(3, "Cinema 3", "Address 3", "Phone 3", 180).
    cinema(4, "Cinema 4", "Address 4", "Phone 4", 220).
    cinema(5, "Cinema 5", "Address 5", "Phone 5", 250).
    cinema(6, "Cinema 6", "Address 6", "Phone 6", 200).
    cinema(7, "Cinema 7", "Address 7", "Phone 7", 230).
    cinema(8, "Cinema 8", "Address 8", "Phone 8", 150).
    cinema(9, "Cinema 9", "Address 9", "Phone 9", 180).
    cinema(10, "Cinema 10", "Address 10", "Phone 10", 200).
    cinema(11, "Cinema 11", "Address 11", "Phone 11", 190).
    cinema(12, "Cinema 12", "Address 12", "Phone 12", 210).
    cinema(13, "Cinema 13", "Address 13", "Phone 13", 230).
    cinema(14, "Cinema 14", "Address 14", "Phone 14", 170).
    cinema(15, "Cinema 15", "Address 15", "Phone 15", 190).

    movie(1, "Movie 1", 2023, "Director 1", "Genre 1").
    movie(2, "Movie 2", 2023, "Director 2", "Genre 2").
    movie(3, "Movie 3", 2023, "Director 3", "Genre 3").
    movie(4, "Movie 4", 2023, "Director 4", "Genre 1").
    movie(5, "Movie 5", 2023, "Director 5", "Genre 2").

    show(1, 1, "2023-05-09", "15:30", 150).
    show(2, 2, "2023-05-09", "18:00", 180).
    show(3, 3, "2023-05-09", "13:00", 200).
    show(4, 4, "2023-05-09", "16:30", 120).
    show(5, 5, "2023-05-09", "20:00", 220).
    show(6, 1, "2023-05-09", "21:30", 230).
    show(7, 2, "2023-05-09", "00:00", 150).
    show(8, 3, "2023-05-09", "22:00", 180).
    show(9, 4, "2023-05-09", "00:30", 200).
    show(10, 5, "2023-05-09", "15:00", 250).
    show(11, 1, "2023-05-09", "16:00", 180).
    show(12, 2, "2023-05-09", "19:30", 200).
    show(13, 3, "2023-05-09", "12:30", 210).
    show(14, 4, "2023-05-09", "15:00", 140).
    show(15, 5, "2023-05-09", "17:30", 230).

clauses
    cinema_address_by_genre(Genre: string, Address: string) :-
        cinema(CinemaId, _, Address, _, _),
        show(CinemaId, MovieId, _, _, _),
        movie(MovieId, _, _, _, Genre).

    count_cinemas(Count: integer) :-
        findall(_, cinema(_, _, _, _, _), Cinemas),
        length(Cinemas, Count).

    average_seats(Average: integer) :-
        findall(Seats, cinema(_, _, _, _, Seats), SeatsList),
        sum_list(SeatsList, TotalSeats),
        count_cinemas(Count),
        Average is TotalSeats div Count.

    cinema_revenue(CinemaId: integer, TotalRevenue: integer) :-
        findall(Revenue, show(CinemaId, _, _, _, Revenue), Revenues),
        sum_list(Revenues, TotalRevenue).

    popular_cinema(CinemaId: integer, Threshold: integer) :-
        cinema_revenue(CinemaId, TotalRevenue),
        TotalRevenue > Threshold.

    addresses_of_cinemas(CinemaAddresses: list[string]) :-
        findall(Address, cinema(_, _, Address, _, _), CinemaAddresses).

    addresses_by_director_genre(Director: string, Genre: string, Addresses: list[string]) :-
        findall(Address, (cinema_address_by_genre(Genre, Address), movie(_, _, _, Director, _)), Addresses).

    average_seats_in_cinemas(Average: integer) :-
        average_seats(Average).

    popular_cinemas(Threshold: integer, PopularCinemas: list[integer]) :-
        findall(CinemaId, popular_cinema(CinemaId, Threshold), PopularCinemas).

    total_revenue_for_cinema(CinemaId: integer, TotalRevenue: integer) :-
        cinema_revenue(CinemaId, TotalRevenue).

    generate_solutions(List: list[string]) :-
        List = [Address || cinema(_, _, Address, _, _)].

    print_elements([]).
    print_elements([Head | Tail]) :-
        write(Head), nl,
        print_elements(Tail).

    search_element(Element: string, [Element | _]).
    search_element(Element: string, [_ | Tail]) :-
        search_element(Element, Tail).

    calculate_count(List: list[T], Count: integer) :-
        length(List, Count).

    calculate_max(List: list[integer], Max: integer) :-
        max_list(List, Max).

    calculate_min(List: list[integer], Min: integer) :-
        min_list(List, Min).

    calculate_avg(List: list[integer], Average: integer) :-
        sum_list(List, Sum),
        length(List, Count),
        Average is Sum / Count.

    return_value(Value: integer) :-
        Value = 10.

    return_count(Count: integer) :-
        count_cinemas(Count).

    return_max(Max: integer) :-
        findall(Seats, cinema(_, _, _, _, Seats), SeatsList),
        calculate_max(SeatsList, Max).

    return_min(Min: integer) :-
        findall(Revenue, show(_, _, _, _, Revenue), Revenues),
        calculate_min(Revenues, Min).

    return_avg(Average: integer) :-
        findall(Seats, cinema(_, _, _, _, Seats), SeatsList),
        calculate_avg(SeatsList, Average).

    return_cinema_addresses(CinemaAddresses: list[string]) :-
        addresses_of_cinemas(CinemaAddresses).

    return_addresses_by_director_genre(Director: string, Genre: string, Addresses: list[string]) :-
        addresses_by_director_genre(Director, Genre, Addresses).
