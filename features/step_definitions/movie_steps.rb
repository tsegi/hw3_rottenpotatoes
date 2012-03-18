# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    Movie.create!(movie)
    
    assert_not_nil Movie.find_by_title(movie["title"])
  end
     # assert false, "Unimplmemented"
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body  is the entire content of the page as a string.

  step %{I should see "#{e1}"}
  step %{I should see "#{e2}"}
  pos1 = page.body.index("#{e1}")
  pos2 = page.body.index("#{e2}")
  assert(pos1 < pos2)

end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  
  selected_ratings = rating_list.gsub(/\s+/, "").split ','


  selected_ratings.each do |rating|
    if (uncheck == nil)
      step %{I check "ratings[#{rating}]"}
    else
      step %{I uncheck "ratings[#{rating}]"}
    end
  end    
end

Then /I should see all of the movie/ do 
  page.all('table#movies tr').count.should == Movie.count + 1
end

Then /I should see no movie(s)?/ do |plural|
  page.all('table#movies tr').count.should == 1
end
