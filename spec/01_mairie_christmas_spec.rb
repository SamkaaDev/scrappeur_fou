require_relative '../lib/01_mairie_christmas'

page = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/"))

describe "the get townhall list and url method" do
  it "should return the list of townhalls and the url of there pages" do
    expect(get_townhall_urls(doc)).not_to be_nil
    expect(get_townhall_urls(doc)).to be_an_instance_of(Array)
    townhall_url.length { is_expected.to_be = 185}
  end
end

describe "the get townhall email method" do
  it "should return the email of the townhall" do
    expect(get_avernes_email(avernes_url)).to eq("mairie.ableiges95@wanadoo.fr")
  end
end

describe "the get email list method" do
  it "should return the list of towns and emails" do
    expect(townhall_mails).not_to be_nil
    expect(townhall_mails).to be_an_instance_of(Array)
    townhall_mails.size { is_expected.to_be = 185}
  end
end
