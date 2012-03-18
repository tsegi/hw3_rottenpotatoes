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
  #  page.content  is the entire content of the page as a string.
  assert false, "Unimplmemented"
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  
  all_ratings = Movie.all_ratings
  if (uncheck == nil)
    check_ratings = rating_list.split ','
    uncheck_ratings = all_ratings - check_ratings
  else
    uncheck_ratings = rating_list.split ','
    check_ratings = all_ratings - uncheck_ratings
  end
  
  check_ratings.each |rating|
    When "I check \"#{rating.strip}\""
  end
  
  uncheck_ratings.each |rating|
    When "I uncheck \"#{rating.strip}\""
  end
  
end
