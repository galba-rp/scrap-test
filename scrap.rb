require "nokogiri"
require "open-uri"
require "pry"
require "sqlite3"

require "./lib/yacht_sanitizer"
require "./lib/yacht"

url = "https://greta-code-pizza.github.io/topsails/"
html = URI.open(url)
app = Nokogiri::HTML(html)
db = SQLite3::Database.new("yachtDB.db")

yachts = app.css('.card-boat')

yachts.each do |yacht|

  label = yacht.css("h4").children.text

  price = yacht.css(".price").children.text
  # price = price.split("€").first.tr(' ', '').to_i

  properties = yacht.css(".property")

  # year = yacht.css(".property:nth-child(3) .badge").text
  # year = properties.first.text.strip[-4..-1]
  year = properties.first.css('.badge').text

  # delete_suffix("m") meilleur que .text[0..-2]
  # ex : boa = properties.last.css('.badge').text.delete_suffix("m").to_f
  loa = properties[1].css('.badge').text
  boa = properties.last.css('.badge').text

  condition = yacht.css(".card-text")

  # condition_key = condition.children.text.split("en").last.split("état").first.strip
  condition_key = 
    ["très bon", "bon", "excellent"].find do |k| 
      condition.children.text.include?(k) 
    end



  


  # PREVIOUS DATA version :
  #
  # condition_val = Yacht::CONDITIONS[condition_key]
  #
  # data = {
  #   "label" => label,
  #   "price" => price,
  #   "year" => year,
  #   "loa" => loa,
  #   "boa" => boa,
  #   "condition" => condition_val
  # }
{}
  sanitized_data = 
    YachtSanitizer.new(
      label: label,
      price: price,
      year: year,
      loa: loa,
      boa: boa,
      condition: condition_key
    ) 
    #.to_h
  # db.execute("INSERT OR IGNORE INTO yacht VALUES (:label, :price, :year, :loa, :boa, :condition)", sanitized_data)
end 
