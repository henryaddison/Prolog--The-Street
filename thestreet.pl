prefix(P,L) :- append(P,_,L).
suffix(S,L) :- append(_,S,L).
sublist(SubL,L) :- suffix(S,L),prefix(SubL,S).

nationalities(Nationalities):-member(english,Nationalities),member(japanese,Nationalities),member(spanish,Nationalities),member(ukrainian,Nationalities),member(norwegian,Nationalities).
pets(Pets):-member(zebra,Pets),member(dog,Pets),member(horse,Pets),member(fox,Pets),member(snail,Pets).
colours(Colours):-member(red,Colours),member(green,Colours),member(blue,Colours),member(ivory,Colours),member(yellow,Colours).
brands(Brands):-member(winston,Brands),member(luckystrike,Brands),member(chesterfields,Brands),member(kools,Brands),member(parliaments,Brands).
drinks(Drinks):-member(water,Drinks),member(coffee,Drinks),member(milk,Drinks),member(oj,Drinks),member(tea,Drinks).

% Can define a house uniquely as ordered 5-tuple [N,P,B,D,C] consisting of an owner's Nationality, a Pet, a cigarette Brand, a Drink and a house Colour
% TODO: use functions to make this less reliant on the order

% House1 is the left of House2 on a street made up of Houses if the list [House1, House2] is a sublist of Houses
leftof(House1,House2,Houses):-
	sublist([House1,House2],Houses).
% House1 is to the right of House2 is equivalent to House2 being to the left of House1
rightof(House1,House2,Houses):-leftof(House2,House1,Houses).

% next to just means either House1 is to the left or the right of House2
nextto(House1,House2,Houses):-(leftof(House1,House2,Houses);rightof(House1,House2,Houses)).

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
	Houses=[[norwegian,_,_,_,_]|_],
	(sublist([[_,_,chesterfields,_,_],[_,fox,_,_,_]],Houses);sublist([[_,fox,_,_,_],[_,_,chesterfields,_,_]],Houses)),
	(sublist([[_,_,kools,_,_],[_,horse,_,_,_]],Houses);sublist([[_,horse,_,_,_],[_,_,kools,_,_]],Houses)),
	member([_,_,luckystrike,oj,_],Houses),
	member([japanese,_,parliaments,_,_],Houses),
	(sublist([[_,_,_,_,blue],[norwegian,_,_,_,_]],Houses);sublist([[norwegian,_,_,_,_],[_,_,_,_,blue]],Houses)),
	% ensure the houses are distinct (i.e. no two houses match on any of the five attributes
        nationalities([N1,N2,N3,N4,N5]),pets([P1,P2,P3,P4,P5]),colours([C1,C2,C3,C4,C5]),brands([B1,B2,B3,B4,B5]),drinks([D1,D2,D3,D4,D5]).
	
    
    


