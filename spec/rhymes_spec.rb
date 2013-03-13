require 'spec_helper'

describe Rhymes do
  before(:all) do
    @sample = File.join(File.dirname(__FILE__), 'sample_raw.txt')
    Rhymes.setup(:raw_dict => @sample)
  end
  
  it 'should save provided option' do
    Rhymes.setup(:compiled => '/tmp/sample').tap do |opts|
      opts.raw_dict.should == @sample
      opts.compiled.should == '/tmp/sample'
    end
  end

  it 'should save block config' do
    Rhymes.setup do |config|
      config.raw_dict = 'foo'
    end.tap do |opts|
      opts.raw_dict.should == 'foo'
    end
  end

  it 'should rhyme ruby with newby and scooby' do
    Rhymes.rhyme('ruby').should == ['NEWBY', 'SCOOBY']
    Rhymes.rhyme('Scooby').should == ['NEWBY', 'RUBY']
    Rhymes.rhyme('newby').should == ['RUBY', 'SCOOBY']
  end

  it 'should rhyme rube and cube' do
    Rhymes.rhyme('RubE').should == ['CUBE']
    Rhymes.rhyme('cUbE').should == ['RUBE']
  end

  it 'should rhyme lighter and scriptwriter' do
    Rhymes.rhyme('LIGHTER').should == ['SCRIPTWRITER']
    Rhymes.rhyme('SCRIPTWRITER').should == ['LIGHTER']
  end
  
  it 'should rhyme monterrey and usa' do
    Rhymes.rhyme('MONTERREY').should == ['USA']
    Rhymes.rhyme('USA').should == ['MONTERREY']
  end

  it 'should raise with unknown word' do
    expect {Rhymes.rhyme('dabadabadaba')}.to raise_error(Rhymes::UnknownWord)
  end

end
