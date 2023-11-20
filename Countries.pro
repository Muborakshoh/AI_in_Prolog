domains
city,country,region,continent=symbol

predicates
nondeterm f(city,country,region,continent)
nondeterm city_in_country(city,country)
nondeterm country_in_region(country,region)
nondeterm region_in_continent(region,continent)
nondeterm city_region(city,region)
nondeterm city_continent(city,continent)
nondeterm country_continent(country,continent)

clauses
f(budapest,romain,sweuropa,europa).
f(paris,france,eeuropa,europa).
f(dushanbe,tajikistan,crasia,asia).
f(newdeli,india,sasia,asia).
f(manhattan,usa,samerica,america).
f(ottava,canada,namerica,america).
f(brasilia,brasiliya,samerica,america).
f(santyago,chili,seamerica,america).
f(canberra,australia,neaustralia,australia).
f(khartoum,sudan,safrica,africa).
f(mogadisho,somali,wafrica,africa).

city_in_country(X,Y):-f(X,Y,_,_).

country_in_region(Y,Z):-f(_,Y,Z,_).

region_in_continent(Z,W):-f(_,_,Z,W). 
 
city_region(X,Z):-city_in_country(X,Y),country_in_region(Y,Z).

city_continent(X,W):-city_region(X,Z),region_in_continent(Z,W).

country_continent(Y,W):-country_in_region(Y,Z),region_in_continent(Z,W).
   
goal
%city_in_country(X,usa).
%city_region(X,namerica).
%city_continent(X,asia).
country_continent(X,asia).



