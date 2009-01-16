require File.join(File.dirname(__FILE__), 'spec_helper')


describe Bank do

	it 'should give correct values' do
		a = helper_method
		Bank.money("2006-10-18","#{a}").should == 'dolar amerykański,kurs sredni:3,1125'
		
	end
	it 'should give correct values' do
		lambda {
		  Bank.money("2009-10-23","EUR")
		}.should raise_error(ArgumentError)
	end
	it 'should give correct values' do
		lambda {
		Bank.money("2010-10-23","EUR")
		}.should raise_error(ArgumentError)
	end

	def helper_method
		"USD"
	end
end
