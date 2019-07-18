require_relative '../lib/00_dark_trader'

page = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/"))

describe "the get names method" do
  it "should return the list of crypto names" do
    expect(take_html_names(doc)).not_to be_nil
    expect(take_html_names(doc)).to be_an_instance_of(Array)
    expect(take_html_names(doc)).to include ("BTC")
  end
end

describe "the get prices method" do
  it "should return the list of crypto prices" do
    expect(take_html_values(doc)).not_to be_nil
    expect(take_html_values(doc)).to be_an_instance_of(Array)
  end
end

describe "the get final list method" do
  it "should return the list of crypto money with there prices" do
    expect(organize_hash(crypto_n, crypto_v)).to be_an_instance_of(Array)
    expect(organize_hash(crypto_n, crypto_v))[0].to be_an_instance_of(Hash)
  end
end