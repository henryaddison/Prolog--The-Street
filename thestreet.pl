/* Thanks very much to the brilliant "Learn Prolog Now!" book by Patrick Blackburn, Johan Bos and Kristina Striegnitz 
that Chris McMath introduced me to */

prefix(P,L) :- append(P,_,L).
suffix(S,L) :- append(_,S,L).
sublist(SubL,L) :- suffix(S,L),prefix(SubL,S).

nationalities(Nationalities):-
  member(english,Nationalities),
  member(japanese,Nationalities),
  member(spanish,Nationalities),
  member(ukrainian,Nationalities),
  member(norwegian,Nationalities).
pets(Pets):-
  member(zebra,Pets),
  member(dog,Pets),
  member(horse,Pets),
  member(fox,Pets),
  member(snail,Pets).
colours(Colours):-
  member(red,Colours),
  member(green,Colours),
  member(blue,Colours),
  member(ivory,Colours),
  member(yellow,Colours).
brands(Brands):-
  member(winston,Brands),
  member(luckystrike,Brands),
  member(chesterfields,Brands),
  member(kools,Brands),
  member(parliaments,Brands).
drinks(Drinks):-
  member(water,Drinks),
  member(coffee,Drinks),
  member(milk,Drinks),
  member(oj,Drinks),
  member(tea,Drinks).

/* Can define a house uniquely as an ordered 5-tuple [N,P,B,D,C] consisting of:
N: an owner's Nationality, 
P: a Pet,
B: a cigarette Brand, 
D: a Drink and 
C: a house Colour */
% TODO: use functions to make this less reliant on the order

/* House1 is the left neighbour House2 on a street made up of Houses if the list [House1, House2] is a sublist of Houses.
Consider a real street numbered 1 to 5 then we can consider Houses to be the list [1, 2, 3, 4, 5] 
Clearly in this example house number 3 is left neighbour of 4, and [3,4] is indeed a sublist, 
but [3, 5] isn't and we can see that [3, 5] is not a sublist (it goes [3, 4, 5]) */
leftneighbour(House1,House2,Houses):-
  sublist([House1,House2],Houses).

% House1 is to the right of House2 is equivalent to House2 being to the left of House1
rightneighbour(House1,House2,Houses):-leftneighbour(House2,House1,Houses).

% next to just means either House1 is to the left or the right of House2
nextto(House1,House2,Houses):-(leftneighbour(House1,House2,Houses);rightneighbour(House1,House2,Houses)).

street(Houses):-
  %setup our list of 5 houses
  Houses=[[N1,P1,B1,D1,C1],[N2,P2,B2,D2,C2],[N3,P3,B3,D3,C3],[N4,P4,B4,D4,C4],[N5,P5,B5,D5,C5]],
  % add in our restrictions to the houses and their ordering
  member([english,_,_,_,red],Houses),
  member([spanish,dog,_,_,_],Houses),
  member([_,_,_,coffee,green],Houses),
  member([ukrainian,_,_,tea,_],Houses),
  sublist([[_,_,_,_,ivory],[_,_,_,_,green]],Houses),
  member([_,snail,winston,_,_],Houses),
  member([_,_,kools,_,yellow],Houses),
  sublist([_,_,[_,_,_,milk,_],_,_],Houses),
  %first house has norwegian as its owner's nationality
  Houses=[[norwegian,_,_,_,_]|_],
  nextto([_,_,chesterfields,_,_],[_,fox,_,_,_],Houses),
  nextto([_,_,kools,_,_],[_,horse,_,_,_],Houses),
  member([_,_,luckystrike,oj,_],Houses),
  member([japanese,_,parliaments,_,_],Houses),
  nextto([_,_,_,_,blue],[norwegian,_,_,_,_],Houses),
  % ensure the houses are distinct (i.e. no two houses match on any of the five attributes
  nationalities([N1,N2,N3,N4,N5]),
  pets([P1,P2,P3,P4,P5]),
  colours([C1,C2,C3,C4,C5]),
  brands([B1,B2,B3,B4,B5]),
  drinks([D1,D2,D3,D4,D5]).

zebra(N):-street(Houses),member([N,zebra,_,_,_], Houses).
water(N):-street(Houses),member([N,_,_,water,_], Houses).
