# World Time

A basic demo of some standard Rails behaviors and some useful patterns.

To run should only require bundle, rake db:create db:migrate, rails s.

Things of note:

* I realized Geokit let you search with generic search terms so I allowed things like 'Buckingham Palace'

* I used a NullObject pattern for the User model but I end up not really using it. They're nice so you can do things like Welcome Guest without polluting the views with logic.

* Speaking of polluting views with logic. At STAQ we used a modified version of a gem called DisplayCase that implements a Decorator pattern as a convenient way to keep logic out of your views, but without having to dump it into the model.

* I wrapped the Wikipedia and Geokit gems into their own services even though they're not doing anything very complex - we found this was useful for future refactors if we decided to use a different gem we can just change it in a single place.

* Creation of the SearchResults is a bit slow because of the multiple wiki calls and geokit. In a real application it would be a delayed job.

