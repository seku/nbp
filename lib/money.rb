require 'rubygems'
require 'hpricot'
require 'open-uri'

module Bank

	def convert_date(date) #konwertuje daty i sprawdza czy rok nie przekroczony
		 if (%r{(\d\d\d\d)-(\d\d)-(\d\d)} =~ date)
			 if ($1.to_i < 2002) || ($1.to_i > Time.now.year) || (($1.to_i == Time.now.year) && ($2.to_i > Time.now.month)) || (($1.to_i == Time.now.year) && ($2.to_i == Time.now.month) && ($3.to_i > Time.now.day))
				 raise(ArgumentError, "Valid year is betwen 2002 - #{Time.now.year}")
			
		 else
			 date.delete! "-"
			 date[2..-1]
		 end  
		 else
				raise(ArgumentError, "Not valid format of date")
		 end
	end

	def valutes(address, shortcut)  

		v = nil
		doc = Hpricot(open("http://nbp.pl/kursy/#{address}"))
		doc.search("pozycja").each do |currency|

			if (currency/"kod_waluty").inner_html == shortcut
				return "#{(currency/"nazwa_waluty").inner_html},kurs sredni:#{(currency/"kurs_sredni").inner_html}" 
			else
			 "there's no relevant value"
			end
		end

		
	end

	def closest(value) #find there's no valid date , search for closest (decrease the date)

		month = (value / 100) % 100
		year = value / 10000
		day = value % 100

		if (month == 01) && (day == 01)
			value = (year-1) * 10000 + 1231
		elsif day == 01
			value = year * 10000 + (month - 1) * 100 + 31
		else 
			value -= 1
		end
	end


	def avaliable
		
		#puts "http://nbp.pl/kursy/#{address}"
		#doc = Hpricot(open("http://nbp.pl/kursy/kursya.html"))
		doc = Hpricot(open("http://nbp.pl/kursy/xml/a001z090102.xml"))
		puts "Avaliable currency :"
		tab = []
		doc.search("pozycja").each do |currency|
			tab << "Nazwa waluty : #{(currency/"nazwa_waluty").inner_html}  #{(currency/"kod_waluty").inner_html}"
		end
		tab
	end


	def is_there(date)
	 
		@s = @index.select {|item| item.include?(date)}
		@s.size #zwraca liczbę komórek z odpowiednim plikiem (mogą być : 4-y)
	end


	def money(date,shortcut)

		i = 0
		@index = [] #zawiera indeksy stron z walutami 
			open("http://nbp.pl/kursy/xml/dir.txt") do |line|
					while (b = line.gets)
					@index << b
					i += 1
					end
			end
		@fixed = (convert_date(date)) #zwraca date w formacie 080129 /rok miesiac dzien
		
		#print "@wartosc :",@fixed,"\n"
		@fixed = @fixed.to_i
			while (@fixed.to_i > 020101) && (is_there(@fixed.to_s) == 0)
				puts "There's no value for valid date - searching closest"
				#puts @fixed
				@fixed = closest(@fixed.to_i)
			end
		valutes("xml/#{@s[2].chop}\.xml", shortcut)  #bierzemy tylko najbardziej znane waluty (z pośród 4opcji - 2ga)
	end

	module_function:money, :avaliable, :is_there, :closest, :valutes, :convert_date
end



