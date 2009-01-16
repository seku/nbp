= nbp

  
== DESCRIPTION:

  Return the course in polish zl for given currency for given date
	The date should be from range 2002-01-02  up today.

== FEATURES/PROBLEMS:

	If there's no currency for valid date , the program search the closest date by decreasing given date, example : 2009-01-10 (Saturday - no currency), the system return values from 2009-01-09


== SYNOPSIS:

	avaliable  -  return list of avaliable currency with their shortcuts

	Bank.money("year-month-day","currency_shortcut") - where year-month-day should be from
																							range (2002-01-02 up today)

	examples: 
1. money("2007-10-09","USD")
=> "dolar ameryka\361ski,kurs sredni:2,6750"
	
2. money("2006-12-30","EUR")
There's no value for valid date - searching closest
=> "euro,kurs sredni:3,8312"




