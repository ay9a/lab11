
:- use_module(library(readutil)).

% Start the game
start :-
    writeln('Hi. This is the "Name Game".'),
    writeln('You will be given a set of English letters in which you will add, delete or move to create your name.'),
    game([a,b,c]).


% Display the menu
game(Letters) :-
    nl,
    writeln('Choose from the following:'),
    writeln('1- Display the current set of letters'),
    writeln('2- Add a letter'),
    writeln('3- Add a letter at the top'),
    writeln('4- Add a letter at the bottom'),
    writeln('5- Delete a letter'),
    writeln('6- Delete all letters'),
    writeln('7- Exit'),
    write('Enter your choice...'),
    read_line_to_string(user_input, Choice),
    handle_choice(Choice, Letters).


% Handle user choices
handle_choice("1", Letters) :-
    writeln(Letters),
    game(Letters).

handle_choice("2", Letters) :-
    write('Enter the letter: '),
    read_line_to_string(user_input, Input),
    atom_string(Letter, Input),
    write('Enter the position: '),
    read_line_to_string(user_input, PosInput),
    number_string(Pos, PosInput),
    insert_letter(Pos, Letter, Letters, NewLetters),
    game(NewLetters).

handle_choice("3", Letters) :-
    write('Enter the letter: '),
    read_line_to_string(user_input, Input),
    atom_string(Letter, Input),
    NewLetters = [Letter|Letters],
    game(NewLetters).

handle_choice("4", Letters) :-
    write('Enter the letter: '),
    read_line_to_string(user_input, Input),
    atom_string(Letter, Input),
    append(Letters, [Letter], NewLetters),
    game(NewLetters).

handle_choice("5", Letters) :-
    write('Enter the letter to delete: '),
    read_line_to_string(user_input, Input),
    atom_string(Letter, Input),
    ( select(Letter, Letters, NewLetters) ->
        true
    ;
        writeln('Letter not found.'),
        NewLetters = Letters
    ),
    game(NewLetters).

handle_choice("6", _) :-
    game([]).

handle_choice("7", _) :-
    writeln('Goodbye!').

handle_choice(_, Letters) :-
    writeln('Invalid choice.'),
    game(Letters).


% Insert a letter at a given position
insert_letter(1, Letter, Letters, [Letter|Letters]).

insert_letter(Pos, Letter, [H|T], [H|NewT]) :-
    Pos > 1,
    NextPos is Pos - 1,
    insert_letter(NextPos, Letter, T, NewT).
