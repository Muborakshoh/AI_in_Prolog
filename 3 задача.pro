domains
city,country,region,continent=symbol

predicates
nondeterm city_country(city,country)
nondeterm country_region(country,region)
nondeterm region_continent(region,continent)
nondeterm find_city_country(city,country)
nondeterm find_city_region(city,region)
nondeterm find_city_continent(city,continent)
nondeterm find_country_region(country,region)
nondeterm find_country_continent(country,continent)
nondeterm find_region_continent(region,continent)

clauses
city_country(dushanbe,tajikistan).
city_country(khujand,tajikistan).
city_country(paris,france).
city_country(milan,france).
country_region(tajikistan,center_asia).
country_region(france,east_europe).
country_region(germany,center_europe).
country_region(usa,east_america).
region_continent(center_asia,asia).
region_continent(east_europe,europe).
region_continent(east_america,america).
region_continent(center_europe,europe).


find_city_country(X,Y):-city_country(X,Y).

find_city_region(X,Z):-
    city_country(X,Y),
    country_region(Y,Z).
    
find_city_continent(X,W):-
    city_country(X,Y),
    country_region(Y,Z),
    region_continent(Z,W).

find_country_region(Y,Z):-
    country_region(Y,Z).
    
find_country_continent(Y,W):-
    country_region(Y,Z),
    region_continent(Z,W).
    
find_region_continent(Z,W):-
     region_continent(Z,W).

goal
%find_city_continent(X,asia).
%find_city_region(X,center_asia).
%find_city_country(X,tajikistan).
find_country_region(Y,center_asia).
%find_country_continent(Y,asia).
%find_region_continent(Z,asia).
%find_city_continent(X,europe).
%find_city_region(X,center_europe).
%find_city_country(X,paris).
%find_country_region(Y,center_europe).
%find_country_continent(Y,europe).
%find_region_continent(Z,europe).
