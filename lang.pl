

message(instructions, 'Hydraulik\n\nGra polega na wykonania po\u0142\u0105czenia hydraulicznego za pomoc\u0105 dost\u0119pnych fragment\u00f3w rur. Po\u0142\u0105czenie nie mo\u017ce mie\u0107 \u017cadnych otwartych zako\u0144cze\u0144. Na ka\u017cdym poziomie otrzymujesz okre\u015blon\u0105 ilo\u015b\u0107 konkretnych rodzaj\u00f3w rur. Ka\u017cdy z nich ma sw\u00f3j okre\u015blony kod (zgodny z mi\u0119dzynarodowym okre\u015bleniem kierunk\u00f3w na \u015bwiecie). Fragment\u00f3w nie mo\u017cna obraca\u0107. Po\u0142\u0105czenie mo\u017cna uzupe\u0142nia\u0107 komend\u0105 ustaw(kod, x, y). W razie pomy\u0142ki mo\u017cna zabra\u0107 fragment komend\u0105 zabierz(x,y). Nie mo\u017cna zabiera\u0107 ani przestawia\u0107 istniej\u0105cych fragment\u00f3w. Mo\u017cesz te\u017c zacz\u0105\u0107 poziom od pocz\u0105tku wpisuj\u0105c resetuj. Aby sprawdzi\u0107 po\u0142\u0105czenie i przej\u015b\u0107 do nast\u0119pnego poziomu, wpisz sprawdz.\n\nKomendy mo\u017cesz sprawdzi\u0107 wpisuj\u0105c pomoc.').
message(projectLoaded, 'Projekt za\u0142adowano.').
message(noSuchLevel, 'Taki poziom nie istnieje!').
message(noLevelLoaded, 'Nie za\u0142adowano poziomu!').
message(availableItems, 'Dost\u0119pne fragmenty:').
message(cannotReplaceFixedPipe, 'Nie mo\u017cna podmieni\u0107 pocz\u0105tkowego elementu.').
message(noItemInHotbar, 'Nie masz (ju\u017c?) fragmentu ~w.').
message(levelLoaded, 'Za\u0142adowano ~w').
message(schemaCheckFailed, 'Nieudany test struktury danych w cz\u0119\u015bci: ~w').
message(connectionBroken, 'Po\u0142\u0105czenie nieci\u0105g\u0142e pomi\u0119dzy ~w ~w a ~w ~w (elementy ~w i ~w)').
message(allConnectionsCorrect, 'Po\u0142\u0105czenie szczelne. \u0141aduj\u0119 nast\u0119pny poziom.').
message(gameOver, 'To ju\u017c by\u0142 ostatni poziom. Wygra\u0142e\u015b.').

message(help, 'ustaw(kod, x, y). - ustaw fragment na pozycji x y (wsp\u00f3\u0142rz\u0119dne zaczynaj\u0105 si\u0119 od 0, od lewego g\u00f3rnego rogu).\nzabierz(x, y). - usuwa wcze\u015bniej ustawiony fragment z pozycji x y. Nie mo\u017cna zabiera\u0107 wcze\u015bniej istniej\u0105cych fragment\u00f3w.\nsprawdz. - sprawdza po\u0142\u0105czenie i je\u017celi oka\u017ce si\u0119 poprawne, przechodzi do nast\u0119pnego poziomu\nresetuj. - przywraca poziom do stanu pocz\u0105tkowego\npomoc. - wy\u015bwietla t\u0119 pomoc').

levelName(l1, 'poziom 1 - nauka sterowania').
levelName(l2, 'poziom 2 - Kiedy nie ma co si\u0119 lubi...').
levelName(l3, 'poziom 3 - Rozwidlanie przep\u0142ywu').

ustaw(P, X, Y) :- placePipe(P,X,Y).
zabierz(X, Y) :- removePipe(X,Y).
sprawdz() :- submitLevel.
resetuj() :- resetLevel.
pomoc() :- writeMsg([fg(red)], help, []).


schemaCheck(levelName, forall(levelName(Level,_), level(Level))).